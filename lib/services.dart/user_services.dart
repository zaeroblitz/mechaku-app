part of 'services.dart';

class UserServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference users = firestore.collection('users');

  static Future<void> addUser(UserModel userModel) async {
    // String wishlists = '';

    // for (var wishlist in userModel.wishlist) {
    //   wishlists +=
    //       wishlist + ((wishlist != userModel.wishlist.last) ? ',' : '');
    // }

    users.add({
      'email': userModel.email,
      'name': userModel.name,
      'username': userModel.username,
      'profilePicture': userModel.profilePicture ?? "",
      'balance': userModel.balance,
      'wishlists': userModel.wishlist,
    });
  }
}
