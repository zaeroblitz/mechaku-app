part of '../pages.dart';

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference products = firestore.collection('products');
    CollectionReference users = firestore.collection('users');

    Widget wishlistItems() {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(30),
          child: StreamBuilder<QuerySnapshot>(
              stream: users.where('email', isEqualTo: user.email).snapshots(),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.waiting) {
                  return SpinKitWave(
                    size: 30,
                    color: iconColor,
                  );
                } else {
                  List<String> userWishlists =
                      List.from(snapshot1.data.docs.first.get('wishlists'));

                  return Column(
                    children: userWishlists.map((wishlist) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: products
                              .where('id', isEqualTo: wishlist)
                              .snapshots(),
                          builder: (context, snapshot2) {
                            if (snapshot2.hasData) {
                              return Column(
                                children: snapshot2.data.docs.map((doc) {
                                  ProductModel product =
                                      ProductModel.fromJson(doc.data());

                                  return WishlistItem(product);
                                }).toList(),
                              );
                            } else {
                              return SpinKitWave(
                                size: 20,
                                color: iconColor,
                              );
                            }
                          });
                    }).toList(),
                  );
                }
              }),
        ),
      );
    }

    Widget emptyState() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          children: [
            Image.asset(
              'assets/love_orange_icon.png',
              width: 74,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  " You don't have dream shoes?",
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Let's find your favorite shoes",
                  style: greyTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                pageProvider.currentIndex = 0;
              },
              style: TextButton.styleFrom(
                  backgroundColor: iconColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              child: Text(
                'Explore Store',
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: user.wishlist.isNotEmpty
          ? ListView(
              children: [
                BasicHeader('Favorite Mechas'),
                wishlistItems(),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BasicHeader('Favorite Mechas'),
                emptyState(),
                SizedBox(),
              ],
            ),
    );
  }
}
