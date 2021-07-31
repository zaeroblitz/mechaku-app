part of 'widgets.dart';

class BestSellerItem extends StatelessWidget {
  final ProductModel product;
  BestSellerItem(this.product);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    checkWishlists() {
      var test = authProvider.user.wishlist;

      if (test.contains(product.id)) {
        print('Data exists');
        return true;
      } else {
        print("Data doesn't exists " + test.toString());
        return false;
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductPage(product)));
      },
      child: Container(
        width: 215,
        height: 288,
        margin: EdgeInsets.only(
          right: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              product.gallery[0],
            ),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 215,
                height: 94,
                padding: EdgeInsets.symmetric(
                  vertical: 9,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      product.categoryId,
                      style: whiteTextStyle.copyWith(fontSize: 12),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          '(${product.grade} - ${product.size})',
                          maxLines: 1,
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: -0.5,
              bottom: 64,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: orangeTextColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: Text(
                  product.toRupiahFormat(product.price),
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: GestureDetector(
                onTap: () async {
                  await authProvider.addToWishlist(authProvider.user, product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added to Wishlist',
                        style: whiteTextStyle,
                      ),
                      backgroundColor: greenColor,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  width: 24,
                  height: 24,
                  child: CircleAvatar(
                    backgroundColor:
                        checkWishlists() ? pinkColor : secondaryColor,
                    child: Icon(
                      Icons.favorite_rounded,
                      size: 16,
                      color: checkWishlists() ? whiteFontColor : greyColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
