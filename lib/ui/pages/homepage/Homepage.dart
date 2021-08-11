part of '../pages.dart';

class Homepage extends StatelessWidget {
  final TextEditingController query = TextEditingController(text: '');
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference products = firestore.collection('products');
  static CollectionReference categories = firestore.collection('categories');

  @override
  Widget build(BuildContext context) {
    // CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    // ProductProvider productProvider = Provider.of<ProductProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          bottom: 30,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            authProvider.result.userModel.profilePicture == '' ||
                    authProvider.result.userModel.profilePicture == null
                ? Image.asset(
                    'assets/user_pic.png',
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                  )
                : Image.network(authProvider.result.userModel.profilePicture),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authProvider.user.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    authProvider.user.toRupiahFormat(authProvider.user.balance),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: orangeTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Image.asset(
                'assets/cart_white_icon.png',
                width: 24,
              ),
              onTap: () {},
            ),
          ],
        ),
      );
    }

    Widget searchField() {
      return Container(
        margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: TextFormField(
                    controller: query,
                    cursorColor: orangeTextColor,
                    autofocus: false,
                    style: primaryTextStyle,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Find your own hobby',
                      hintStyle: subtitleTextStyle,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 13,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset('assets/search_icon.png',
                    width: 24, height: 24),
              ),
            )
          ],
        ),
      );
    }

    // Widget bestSeller() {
    //   int index = -1;
    //   return Container(
    //     margin: EdgeInsets.only(
    //       left: 30,
    //       bottom: 30,
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Best Seller',
    //           style: titleTextStyle.copyWith(
    //             fontSize: 22,
    //             fontWeight: semiBold,
    //           ),
    //         ),
    //         SizedBox(
    //           height: 14,
    //         ),
    //         FutureBuilder(
    //             future: productProvider.getBestSellerProducts(),
    //             builder: (context, snapshot) {
    //               if (snapshot.connectionState == ConnectionState.waiting) {
    //                 return SpinkitLoading();
    //               } else {
    //                 return SingleChildScrollView(
    //                   scrollDirection: Axis.horizontal,
    //                   child: Row(
    //                     children: productProvider.products.map(
    //                       (product) {
    //                         index++;
    //                         return Container(
    //                           margin: EdgeInsets.only(
    //                             left: (index == 0) ? 0 : 16,
    //                             right:
    //                                 (index == productProvider.products.length)
    //                                     ? 30
    //                                     : 0,
    //                           ),
    //                           child: BestSellerItem(product),
    //                         );
    //                       },
    //                     ).toList(),
    //                   ),
    //                 );
    //               }
    //             }),
    //       ],
    //     ),
    //   );
    // }

    Widget bestSellerStream() {
      int index = -1;

      return Container(
        margin: EdgeInsets.only(
          left: 30,
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Best Seller',
              style: titleTextStyle.copyWith(
                fontSize: 22,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  products.where('isBestSeller', isEqualTo: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinkitLoading();
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data.docs.map((product) {
                          index++;
                          ProductModel productModel =
                              ProductModel.fromJson(product.data());
                          return Container(
                            margin: EdgeInsets.only(
                              left: (index == 0) ? 0 : 12,
                              right: (index == snapshot.data.docs.length - 1)
                                  ? 10
                                  : 0,
                            ),
                            child: BestSellerItem(productModel),
                          );
                        }).toList(),
                      ),
                    );
                  }
                } else {
                  return SizedBox(
                    child: Text('No Data'),
                  );
                }
              },
            ),
          ],
        ),
      );
    }

    Widget categoriesWidget() {
      return Container(
        margin: EdgeInsets.only(
          left: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: titleTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: semiBold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'See more',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),

            // // NOTE: Get Data with Provider
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: categoryProvider.categories.map((category) {
            //       index++;
            //       return Container(
            //           margin: EdgeInsets.only(
            //             left: (index == 0) ? 0 : 20,
            //             right:
            //                 (index == productProvider.products.length) ? 30 : 0,
            //           ),
            //           child: CategoryItem(category.name, category.bannerUrl));
            //     }).toList(),
            //   ),
            // ),

            // NOTE: Get data through StreamBuilder
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder<QuerySnapshot>(
                stream: categories.snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SpinkitLoading();
                    } else {
                      return Row(
                          children: snapshot.data.docs.map((doc) {
                        CategoryModel categoryModel =
                            CategoryModel.fromJson(doc.data());

                        return Container(
                          margin: EdgeInsets.only(
                            right: 20,
                          ),
                          child: CategoryItem(
                              categoryModel.name, categoryModel.bannerUrl),
                        );
                      }).toList());
                    }
                  } else {
                    return Text('No data');
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    }

    Widget newArrival() {
      return Container(
        margin: EdgeInsets.only(
          bottom: 30,
          left: 30,
          right: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Arrival',
              style: titleTextStyle.copyWith(
                fontSize: 22,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 14,
            ),

            //NOTE: Get data through StreamBuilder
            StreamBuilder<QuerySnapshot>(
              stream: products
                  .orderBy('createdAt', descending: true)
                  .limit(5)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinkitLoading();
                  } else {
                    return Column(
                      children: snapshot.data.docs.map((doc) {
                        ProductModel product =
                            ProductModel.fromJson(doc.data());
                        return NewArrivalItem(product);
                      }).toList(),
                    );
                  }
                } else {
                  return Text('No data');
                }
              },
            ),

            //NOTE: Get data with Provider => Future
            // FutureBuilder(
            //     future: productProvider.getNewArrivalProducts(),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return SpinkitLoading();
            //       } else {
            //         return Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: productProvider.products
            //               .map((product) => NewArrivalItem(product))
            //               .toList(),
            //         );
            //       }
            //     }),
          ],
        ),
      );
    }

    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          header(),
          searchField(),
          // bestSeller(),
          bestSellerStream(),
          categoriesWidget(),
          newArrival(),
        ],
      ),
    );
  }
}
