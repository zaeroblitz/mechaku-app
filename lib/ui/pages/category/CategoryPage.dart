part of '../pages.dart';

class CategoryPage extends StatelessWidget {
  final String categoryId;
  CategoryPage(this.categoryId);

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget _title() {
      return Container(
        margin: EdgeInsets.all(30),
        child: Text(
          'Result for $categoryId products',
          style: titleTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      );
    }

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
                  return Column(
                    children: productProvider.products
                        .map(
                          (product) => WishlistItem(product),
                        )
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BasicHeader('$categoryId Product'),
            _title(),
            _products(),
          ],
        ),
      ),
    );
  }
}
