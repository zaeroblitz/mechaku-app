part of 'widgets.dart';

class BestSellerItem extends StatefulWidget {
  final ProductModel product;
  BestSellerItem(this.product);

  @override
  _BestSellerItemState createState() => _BestSellerItemState();
}

class _BestSellerItemState extends State<BestSellerItem> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    bool isWishlist = authProvider.user.wishlist.contains(widget.product.id);

    // checkWishlists() {
    //   if (authProvider.user.wishlist.contains(widget.product.id)) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(widget.product)));
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
              widget.product.gallery[0],
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
                      widget.product.categoryId,
                      style: whiteTextStyle.copyWith(fontSize: 12),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          maxLines: 1,
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          '(${widget.product.grade} - ${widget.product.size})',
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
                  widget.product.toRupiahFormat(widget.product.price),
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
                  setState(() {
                    print('isWishlist: $isWishlist');
                    isWishlist = !isWishlist;
                    print('isWishlist: $isWishlist');
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        (authProvider.user.wishlist.contains(widget.product.id))
                            ? 'Removed form Wishlists'
                            : 'Added to Wishlists',
                        style: whiteTextStyle,
                      ),
                      backgroundColor: (authProvider.user.wishlist
                              .contains(widget.product.id))
                          ? pinkColor
                          : greenColor,
                      duration: Duration(seconds: 2),
                    ),
                  );

                  await authProvider.addToWishlist(
                      authProvider.user, widget.product);
                },
                child: Container(
                  width: 24,
                  height: 24,
                  child: CircleAvatar(
                    backgroundColor: isWishlist ? pinkColor : secondaryColor,
                    child: Icon(
                      Icons.favorite_rounded,
                      size: 16,
                      color: isWishlist ? whiteFontColor : greyColor,
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
