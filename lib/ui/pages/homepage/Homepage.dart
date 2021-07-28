part of '../pages.dart';

class Homepage extends StatelessWidget {
  final TextEditingController query = TextEditingController(text: '');
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference products = firestore.collection('products');

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          bottom: 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo_landscape.png',
              width: 154,
            ),
            GestureDetector(
                child: Image.asset(
                  'assets/cart_white_icon.png',
                  width: 24,
                ),
                onTap: () {}),
          ],
        ),
      );
    }

    Widget searchField() {
      return Container(
        margin: EdgeInsets.only(
          bottom: 30,
        ),
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
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       BestSellerItem(),
            //       BestSellerItem(),
            //       BestSellerItem(),
            //     ],
            //   ),
            // ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  products.where('isBestSeller', isEqualTo: true).snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinkitLoading();
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: snapshot.data.docs
                              .map((doc) => BestSellerItem(
                                  doc.get('categoryId'),
                                  doc.get('name'),
                                  doc.get('grade'),
                                  doc.get('size'),
                                  'https://firebasestorage.googleapis.com/v0/b/mechaku-26a87.appspot.com/o/Gundam%20Wing%20RG%2Frg_wing_gundam.jpg?alt=media&token=70f2ff59-6056-4f36-8efd-5365035815a2',
                                  doc.get('price')))
                              .toList()),
                    );
                  }
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      );
    }

    Widget categoriesWidget() {
      return Column(
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
      );
    }

    Widget newArrival() {
      return Container(
        margin: EdgeInsets.only(bottom: 30),
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
            NewArrivalItem(),
            NewArrivalItem(),
            NewArrivalItem(),
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
