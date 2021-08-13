part of '../pages.dart';

class CategoryPage extends StatelessWidget {
  final String categoryId;
  final String bannerUrl;
  CategoryPage(this.categoryId, this.bannerUrl);

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget _header() {
      return Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 90,
        margin: EdgeInsets.only(
          top: 10,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: <Color>[
              blackColor,
              blackColor.withOpacity(0.22),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          image: DecorationImage(
            image: NetworkImage(
              bannerUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: <Color>[
                    blackColor,
                    blackColor.withOpacity(0.22),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.asset(
                        'assets/chevron_left.png',
                        width: 12,
                        height: 12,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      categoryId + ' Products',
                      style: whiteTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
              _header(),
              _products(),
            ],
          ),
        ),
      ),
    );
  }
}
