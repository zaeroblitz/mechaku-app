part of 'widgets.dart';

class WishlistItem extends StatelessWidget {
  final ProductModel product;

  WishlistItem(this.product);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    String userEmail = authProvider.user.email;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductPage(product),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: primaryFontColor.withOpacity(0.15),
              blurRadius: 4,
              offset: Offset(4, 8),
            )
          ],
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: users.where('email', isEqualTo: userEmail).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer(
                  color: greyColor,
                  direction: ShimmerDirection.fromLeftToRight(),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 88,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              } else {
                List<String> userWishlists =
                    List.from(snapshot.data.docs.first.get('wishlists'));

                return Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(product.gallery[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: primaryTextStyle.copyWith(
                              fontWeight: semiBold,
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'ID',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(product.price),
                            style: orangeTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (userWishlists.contains(product.id)) {
                          users.doc(authProvider.user.id).update({
                            'wishlists': FieldValue.arrayRemove([product.id]),
                          });
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: pinkColor,
                        child: Icon(
                          Icons.favorite_rounded,
                          size: 16,
                          color: whiteFontColor,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
