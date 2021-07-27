part of 'extensions.dart';

extension UserExtension on User {
  UserModel convertToUser({
    String name = 'No Name',
    String username = 'No Username',
    String profilePicture = '',
    int balance = 0,
    List<String> wishlist = const [],
  }) =>
      UserModel(
        this.uid,
        this.email,
        name: name,
        username: username,
        profilePicture: profilePicture,
        balance: balance,
        wishlist: wishlist,
      );
}
