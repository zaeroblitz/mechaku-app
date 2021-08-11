part of '../pages.dart';

class ProductPage extends StatelessWidget {
  final ProductModel product;
  ProductPage(this.product);
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    IndicatorProvider indicatorP = Provider.of<IndicatorProvider>(context);
    String selectedEmail = authProvider.user.email;

    CollectionReference products =
        FirebaseFirestore.instance.collection('products');

    CollectionReference user = FirebaseFirestore.instance.collection('users');

    // Widget indicator(index) {
    //   return Container(
    //     margin: EdgeInsets.symmetric(
    //       horizontal: 2,
    //     ),
    //     decoration: BoxDecoration(
    //       color: indicatorP.index == index ? orangeTextColor : secondaryColor,
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     width: indicatorP.index == index ? 16 : 4,
    //     height: 4,
    //   );
    // }

    Widget background() {
      return Container(
        height: 360,
        child: Stack(
          children: [
            Container(
              height: 360,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    product.gallery[0],
                  ),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
              child: Container(
                color: Colors.black12,
              ),
            ),
          ],
        ),
      );
    }

    Widget productImage() {
      int index = -1;
      return Container(
        height: 330,
        width: double.infinity,
        child: Stack(
          children: [
            // CarouselSlider(
            //   items: product.gallery
            //       .map(
            //         (e) => Container(
            //           height: 330,
            //           width: double.infinity,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(12),
            //             image: DecorationImage(
            //               image: NetworkImage(e),
            //               fit: BoxFit.cover,
            //               scale: 3.0,
            //             ),
            //           ),
            //         ),
            //       )
            //       .toList(),
            //   options: CarouselOptions(
            //       height: 320,
            //       enlargeCenterPage: true,
            //       enableInfiniteScroll: true,
            //       initialPage: 0,
            //       onPageChanged: (index, reason) {
            //         indicatorP.set(index);
            //       }),
            // ),
            Swiper(
              itemCount: product.gallery.length,
              viewportFraction: 0.75,
              scale: 0.8,
              pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                  color: secondaryColor,
                  activeColor: orangeTextColor,
                  size: 8,
                  activeSize: 12,
                ),
              ),
              itemBuilder: (context, index) {
                return Container(
                  height: 330,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(product.gallery[index]),
                      fit: BoxFit.cover,
                      scale: 3.0,
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/button_back.png',
                        width: 24,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/button_cart.png',
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: product.gallery.map((e) {
            //       index++;
            //       return indicator(index);
            //     }).toList(),
            //   ),
            // )
          ],
        ),
      );
    }

    Widget productHeader() {
      return Container(
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '(${product.grade} - ${product.size})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    product.categoryId,
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: user.where('email', isEqualTo: selectedEmail).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer(
                    color: greyColor,
                    child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  );
                } else {
                  List<String> userWishlists =
                      List.from(snapshot.data.docs.first.get('wishlists'));

                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            (userWishlists.contains(product.id))
                                ? 'Removed from Wishlists'
                                : 'Added to Wishlist',
                            style: whiteTextStyle,
                          ),
                          backgroundColor: (userWishlists.contains(product.id))
                              ? pinkColor
                              : greenColor,
                          duration: Duration(milliseconds: 750),
                        ),
                      );

                      if (userWishlists.contains(product.id)) {
                        user.doc(authProvider.user.id).update({
                          'wishlists': FieldValue.arrayRemove([product.id])
                        });
                      } else {
                        user.doc(authProvider.user.id).update({
                          'wishlists': FieldValue.arrayUnion([product.id])
                        });
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: (userWishlists.contains(product.id))
                          ? pinkColor
                          : secondaryColor,
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 24,
                        color: (userWishlists.contains(product.id))
                            ? whiteFontColor
                            : greyColor2,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    }

    Widget productPrice() {
      return Container(
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Price start from',
              style: greyTextStyle,
            ),
            Text(
              product.toRupiahFormat(product.price),
              style: orangeTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    Widget productDescription() {
      return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
            Text(
              product.description,
              textAlign: TextAlign.justify,
              style: greyTextStyle.copyWith(
                fontWeight: light,
              ),
            ),
            // Text(
            //   widget.product.description,
            //   textAlign: TextAlign.justify,
            //   style: greyTextStyle.copyWith(
            //     fontWeight: light,
            //   ),
            // ),
          ],
        ),
      );
    }

    Widget fimiliarMechas() {
      int index = -1;

      return Container(
        margin: EdgeInsets.only(
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fimiliar Mechas',
              style: titleTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 12),
            StreamBuilder<QuerySnapshot>(
                stream: products.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer(
                      color: greyColor,
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data.docs.map((doc) {
                          index++;
                          ProductModel product =
                              ProductModel.fromJson(doc.data());
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductPage(product)));
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                  left: (index == 0) ? 0 : 16,
                                  right:
                                      (index == snapshot.data.docs.length - 1)
                                          ? 30
                                          : 0,
                                ),
                                child: Container(
                                  width: 54,
                                  height: 54,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                        image: NetworkImage(product.gallery[0]),
                                        fit: BoxFit.cover,
                                      )),
                                )),
                          );
                        }).toList(),
                      ),
                    );
                  }
                }),
          ],
        ),
      );
    }

    Widget button() {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 54,
                height: 54,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: greyColor2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  'assets/chat_white_icon.png',
                  width: 23,
                  height: 22,
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 76,
                ),
                backgroundColor: iconColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Add to Cart',
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget productInformation() {
      return Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: whiteFontColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productHeader(),
            productPrice(),
            productDescription(),
            fimiliarMechas(),
            button(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: blackColor,
      body: ListView(
        children: [
          Stack(
            children: [
              background(),
              productImage(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 335),
                  productInformation(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
