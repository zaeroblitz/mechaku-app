part of '../pages.dart';

class Homepage extends StatelessWidget {
  final TextEditingController query = TextEditingController(text: '');
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference categories = firestore.collection('categories');

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
              child:
                  Image.asset('assets/search_icon.png', width: 24, height: 24),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                BestSellerItem(),
                BestSellerItem(),
                BestSellerItem(),
              ],
            ),
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
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       CategoryItem(),
        //       CategoryItem(),
        //       CategoryItem(),
        //     ],
        //   ),
        // ),
        StreamBuilder<QuerySnapshot>(
          stream: categories.orderBy('name').snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: snapshot.data.docs
                      .map((doc) =>
                          CategoryItem(doc.get('name'), doc.get('bannerUrl')))
                      .toList(),
                ),
              );
            } else {
              return SizedBox();
            }
          },
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

  @override
  Widget build(BuildContext context) {
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
