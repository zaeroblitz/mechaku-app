part of 'widgets.dart';

class BestSellerItem extends StatelessWidget {
  final ProductModel product;
  BestSellerItem(this.product);
  static CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    String currentUserId = authProvider.user.id;

    bool isWishlist = authProvider.user.wishlist.contains(product.id);

    Widget _shimmer() {
      return Shimmer(
        color: iconColor,
        direction: ShimmerDirection.fromLeftToRight(),
        child: Container(
          width: 215,
          height: 288,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }

    return StreamBuilder<Object>(
        stream: user.doc(currentUserId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _shimmer();
            } else {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPage(product)));
                },
                child: CachedNetworkImage(
                  imageUrl: product.gallery[0],
                  placeholder: (context, url) => _shimmer(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => Container(
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    (authProvider.user.wishlist
                                            .contains(product.id))
                                        ? 'Removed form Wishlists'
                                        : 'Added to Wishlists',
                                    style: whiteTextStyle,
                                  ),
                                  backgroundColor: (authProvider.user.wishlist
                                          .contains(product.id))
                                      ? pinkColor
                                      : greenColor,
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              await authProvider.addToWishlist(
                                  authProvider.user, product);
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              child: CircleAvatar(
                                backgroundColor:
                                    isWishlist ? pinkColor : secondaryColor,
                                child: Icon(
                                  Icons.favorite_rounded,
                                  size: 16,
                                  color:
                                      isWishlist ? whiteFontColor : greyColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return _shimmer();
          }
        });
  }
}
