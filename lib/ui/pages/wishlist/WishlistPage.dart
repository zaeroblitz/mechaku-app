part of '../pages.dart';

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

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

    Widget wishlistItems() {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            children: [
              WishlistItem(),
              WishlistItem(),
              WishlistItem(),
              WishlistItem(),
              WishlistItem(),
            ],
          ),
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
