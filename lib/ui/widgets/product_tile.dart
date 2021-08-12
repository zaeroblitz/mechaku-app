part of 'widgets.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    String userEmail = authProvider.user.email;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(product),
            ));
      },
      child: Container(
        width: 156,
        height: 192,
        child: StreamBuilder<QuerySnapshot>(
            stream: users.where('email', isEqualTo: userEmail).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer(
                  color: iconColor,
                  direction: ShimmerDirection.fromLeftToRight(),
                  child: Container(
                    width: 156,
                    height: 192,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                );
              } else {
                List<String> userWishlists =
                    List.from(snapshot.data.docs.first.get('wishlists'));
                return Stack(
                  children: [
                    Container(
                      width: 156,
                      height: 152,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: NetworkImage(product.gallery[0]),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                            color: primaryFontColor.withOpacity(0.15),
                            blurRadius: 4,
                            offset: Offset(4, 8),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 148,
                        height: 72,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: primaryFontColor.withOpacity(0.15),
                              blurRadius: 4,
                              offset: Offset(4, 8),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.name,
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 10,
                                      fontWeight: semiBold,
                                    ),
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (userWishlists.contains(product.id)) {
                                      users.doc(authProvider.user.id).update({
                                        'wishlists':
                                            FieldValue.arrayRemove([product.id])
                                      });
                                    } else {
                                      users.doc(authProvider.user.id).update({
                                        'wishlists':
                                            FieldValue.arrayUnion([product.id])
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          userWishlists.contains(product.id)
                                              ? pinkColor
                                              : secondaryColor,
                                      child: Icon(
                                        Icons.favorite_rounded,
                                        size: 8,
                                        color:
                                            userWishlists.contains(product.id)
                                                ? whiteFontColor
                                                : greyColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              product.categoryId,
                              style: greyTextStyle.copyWith(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  NumberFormat.currency(
                                    locale: 'ID',
                                    symbol: 'Rp ',
                                    decimalDigits: 0,
                                  ).format(product.price),
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 10,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 56,
                                    height: 24,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: orangeTextColor,
                                    ),
                                    child: Text(
                                      'Buy Now',
                                      style: whiteTextStyle.copyWith(
                                        fontSize: 8,
                                        fontWeight: medium,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }
}
