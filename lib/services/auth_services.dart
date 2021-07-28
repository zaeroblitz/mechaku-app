part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(
      String email, String password, String name, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel user = result.user.convertToUser(
        name: name,
        username: username,
      );

      await UserServices.addUser(user);

      return SignInSignUpResult(userModel: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split('')[1]);
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModel user = await result.user.fromFirestore();

      return SignInSignUpResult(userModel: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1]);
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }
}

class SignInSignUpResult {
  final UserModel userModel;
  final String message;

  SignInSignUpResult({this.userModel, this.message});
}
