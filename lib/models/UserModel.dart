part of 'models.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String username;
  final String profilePicture;
  final int balance;
  final List<String> wishlist;

  UserModel(
    this.id,
    this.email, {
    this.name,
    this.username,
    this.profilePicture,
    this.balance,
    this.wishlist,
  });

  @override
  String toString() {
    return '[id]: $id \n[email]: $email \n[name]: $name';
  }
}
