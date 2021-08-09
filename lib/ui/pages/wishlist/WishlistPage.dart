part of '../pages.dart';

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    user.wishlist.forEach((element) {
      print(element);
    });

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference products = firestore.collection('products');

    // getWishlistData() {
    //   for (var item in user.wishlist) {
    //     return products.where('id', isEqualTo: item).snapshots();
    //   }
    // }

    Widget wishlistItems() {
      // return StreamBuilder<QuerySnapshot>(
      //     stream: getWishlistData(),
      //     builder: (context, snapshot) {
      //       return SingleChildScrollView(
      //         scrollDirection: Axis.vertical,
      //         child: Container(
      //           margin: EdgeInsets.all(30),
      //           child: Column(
      //             children: snapshot.data.docs
      //                 .map((doc) => WishlistItem(doc.get('gallery')[0],
      //                     doc.get('name'), doc.get('price')))
      //                 .toList(),
      //           ),
      //         ),
      //       );
      //     });

      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            children: user.wishlist
                .map((e) => FutureBuilder<QuerySnapshot>(
                    future: products.where('id', isEqualTo: e).get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data.docs
                              .map((doc) => WishlistItem(doc.get('gallery')[0],
                                  doc.get('name'), doc.get('price')))
                              .toList(),
                        );
                      } else {
                        return SpinKitWave(
                          size: 20,
                          color: iconColor,
                        );
                      }
                    }))
                .toList(),
          ),
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
