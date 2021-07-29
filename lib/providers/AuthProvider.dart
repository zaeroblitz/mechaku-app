part of 'providers.dart';

class AuthProvider with ChangeNotifier {
  SignInSignUpResult _result;
  UserModel _user;

  SignInSignUpResult get result => _result;

  set result(SignInSignUpResult result) {
    _result = result;
    notifyListeners();
  }

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register(
    String name,
    String username,
    String email,
    String password,
  ) async {
    try {
      SignInSignUpResult result =
          await AuthServices.signUp(email, password, name, username);

      _result = result;
      _user = _result.userModel;
      print('From SignInSignUpResult: ' + _result.userModel.name);
      print('From User: ' + _user.name);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      SignInSignUpResult result = await AuthServices.signIn(email, password);

      _result = result;
      _user = _result.userModel;
      print('From SignInSignUpResult: ' + _result.userModel.name);
      print('From User: ' + _user.name);
      return true;
    } catch (e) {
      return false;
    }
  }
}
