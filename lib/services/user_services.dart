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

    users.doc(userModel.id).set({
      'email': userModel.email,
      'name': userModel.name,
      'username': userModel.username,
      'profilePicture': userModel.profilePicture ?? "",
      'role': userModel.role,
      'balance': userModel.balance,
      'wishlists': userModel.wishlist,
    });
  }

  static Future<UserModel> getUser(String id) async {
    var userData = users.doc(id).get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        return UserModel(
          id,
          snapshot.get('email'),
          name: snapshot.get('name'),
          username: snapshot.get('username'),
          profilePicture: snapshot.get('profilePicture'),
          role: snapshot.get('role'),
          balance: snapshot.get('balance'),
          wishlist: (snapshot.get('wishlists') as List)
              .map((e) => e.toString())
              .toList(),
        );
      } else {
        print('Document does not exist on the database');
      }
    });

    return userData;
  }

  static Future<void> addWishlist(UserModel user, ProductModel product) async {
    await users.doc(user.id).update({
      'wishlists': FieldValue.arrayUnion([product.id])
    });
  }

  static Future<void> deleteWishlist(
      UserModel user, ProductModel product) async {
    await users.doc(user.id).update({
      'wislists': FieldValue.arrayRemove([product.id])
    });
  }
}
