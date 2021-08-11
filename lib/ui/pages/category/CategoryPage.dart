part of '../pages.dart';

class CategoryPage extends StatelessWidget {
  final String categoryId;
  CategoryPage(this.categoryId);

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget _products() {
      return Container(
        margin: EdgeInsets.all(30),
        child: FutureBuilder(
            future: productProvider.getProductsByCategory(categoryId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinkitLoading();
              } else {
                if (productProvider.products.isNotEmpty) {
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 30,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                    childAspectRatio: (148 / 192),
                    children: productProvider.products
                        .map((product) => ProductTile(product))
                        .toList(),
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
              BasicHeader('$categoryId Product'),
              _products(),
            ],
          ),
        ),
      ),
    );
  }
}
