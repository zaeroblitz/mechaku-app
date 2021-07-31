part of 'extensions.dart';

extension UserExtension on User {
  UserModel convertToUser({
    String name = 'No Name',
    String username = 'No Username',
    String profilePicture = '',
    String role = 'USER',
    int balance = 0,
    List<String> wishlist = const [],
  }) =>
      UserModel(
        this.uid,
        this.email,
        name: name,
        username: username,
        profilePicture: profilePicture,
        role: role,
        balance: balance,
        wishlist: wishlist,
      );

  Future<UserModel> fromFirestore() async =>
      await UserServices.getUser(this.uid);
}
