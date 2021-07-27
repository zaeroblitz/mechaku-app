part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future signUp(
      String email, String password, String name, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      result.user.convertToUser(
        name: name,
        username: username,
      );
    } catch (e) {}
  }
}
