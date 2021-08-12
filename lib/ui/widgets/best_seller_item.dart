part of 'widgets.dart';

class BestSellerItem extends StatelessWidget {
  final ProductModel product;
  BestSellerItem(this.product);
  static CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    String currentEmail = authProvider.user.email;

    Widget _shimmer() {
      return Shimmer(
        color: greyColor,
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

    return StreamBuilder<QuerySnapshot>(
        stream: user.where('email', isEqualTo: currentEmail).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _shimmer();
            } else {
              List<String> userWishlists =
                  List.from(snapshot.data.docs.first.get('wishlists'));

              //NOTE: OnTap
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPage(product)));
                },
                //NOTE: Product Image
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
                    //NOTE: Product Information
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
                                // Product Category
                                Text(
                                  product.categoryId,
                                  style: whiteTextStyle.copyWith(fontSize: 12),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Name
                                    Text(
                                      product.name,
                                      maxLines: 1,
                                      style: whiteTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: semiBold,
                                      ),
                                    ),
                                    // Product Grade & Size
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
                        // Product Price
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
                        // Wishlist Icon
                        Positioned(
                          right: 8,
                          top: 8,
                          child: GestureDetector(
                            onTap: () {
                              if (userWishlists.contains(product.id)) {
                                user.doc(authProvider.user.id).update({
                                  'wishlists':
                                      FieldValue.arrayRemove([product.id])
                                });
                              } else {
                                user.doc(authProvider.user.id).update({
                                  'wishlists':
                                      FieldValue.arrayUnion([product.id])
                                });
                              }
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              child: CircleAvatar(
                                backgroundColor:
                                    userWishlists.contains(product.id)
                                        ? pinkColor
                                        : secondaryColor,
                                child: Icon(
                                  Icons.favorite_rounded,
                                  size: 16,
                                  color: userWishlists.contains(product.id)
                                      ? whiteFontColor
                                      : greyColor,
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
