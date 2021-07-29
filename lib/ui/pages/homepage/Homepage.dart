part of '../pages.dart';

class Homepage extends StatelessWidget {
  final TextEditingController query = TextEditingController(text: '');
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference products = firestore.collection('products');

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
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
                    'Rp. ' + authProvider.user.balance.toString(),
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

    Widget bestSeller() {
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
            // StreamBuilder<QuerySnapshot>(
            //   stream:
            //       products.where('isBestSeller', isEqualTo: true).snapshots(),
            //   builder: (_, snapshot) {
            //     if (snapshot.hasData) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return SpinkitLoading();
            //       } else {
            //         return SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: Row(
            //             children: productProvider.products
            //                 .map(
            //                   (e) => BestSellerItem(
            //                     e.categoryId,
            //                     e.name,
            //                     e.grade,
            //                     e.size,
            //                     e.gallery[0],
            //                     e.price,
            //                   ),
            //                 )
            //                 .toList(),
            //           ),
            //         );
            //       }
            //     } else {
            //       return SizedBox();
            //     }
            //   },
            // ),
            FutureBuilder(
                future: productProvider.getBestSellerProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinkitLoading();
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: productProvider.products
                            .map(
                              (product) => BestSellerItem(product),
                            )
                            .toList(),
                      ),
                    );
                  }
                }),
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
            Text(
              'Categories',
              style: titleTextStyle.copyWith(
                fontSize: 22,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoryProvider.categories
                    .map((category) =>
                        CategoryItem(category.name, category.bannerUrl))
                    .toList(),
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
            FutureBuilder(
                future: productProvider.getNewArrivalProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinkitLoading();
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: productProvider.products
                          .map((product) => NewArrivalItem(product))
                          .toList(),
                    );
                  }
                }),
          ],
        ),
      );
    }

    return ListView(
      children: [
        header(),
        searchField(),
        bestSeller(),
        categoriesWidget(),
        newArrival(),
      ],
    );
  }
}
