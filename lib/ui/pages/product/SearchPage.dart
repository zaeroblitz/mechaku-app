part of '../pages.dart';

class SearchPage extends StatelessWidget {
  final String query;
  SearchPage(this.query);

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');

    Widget _products() {
      return Container(
        margin: EdgeInsets.all(30),
        child: StreamBuilder<QuerySnapshot>(
            stream: products
                .where('name', isGreaterThanOrEqualTo: query)
                .where('name', isLessThanOrEqualTo: query + 'z')
                .snapshots(),
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
                if (snapshot.data.docs.isNotEmpty) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      childAspectRatio: (148 / 192),
                      children: snapshot.data.docs.map((data) {
                        ProductModel product =
                            ProductModel.fromJson(data.data());

                        return ProductTile(product);
                      }).toList(),
                    ),
                  );
                } else {
                  return Text(
                    'Ooops, no product found',
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: bold,
                    ),
                    textAlign: TextAlign.center,
                  );
                }
              }
            }),
      );
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            BasicHeader('Search Page'),
            _products(),
          ],
        ),
      )),
    );
  }
}
