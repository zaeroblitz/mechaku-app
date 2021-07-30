part of '../pages.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;
  ProductPage(this.product);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    Widget indicator(index) {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          color: currentIndex == index ? orangeTextColor : secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: currentIndex == index ? 16 : 4,
        height: 4,
      );
    }

    Widget productImage() {
      int index = -1;
      return Container(
        height: 225,
        width: double.infinity,
        child: Stack(
          children: [
            CarouselSlider(
              items: widget.product.gallery
                  .map(
                    (e) => Image.network(
                      e,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  }),
            ),
            // Container(
            //   height: 330,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: NetworkImage(
            //         widget.product.gallery[0],
            //       ),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
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
            Container(
              margin: EdgeInsets.only(
                top: 190,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.product.gallery.map((e) {
                  index++;
                  return indicator(index);
                }).toList(),
              ),
            )
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
                    widget.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    widget.product.categoryId,
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                child: Icon(
                  Icons.favorite_rounded,
                  size: 24,
                  color: greyColor2,
                ),
              ),
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
              'Rp. ' + widget.product.price.toString(),
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
            Text(
              'Description',
              style: titleTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              widget.product.description,
              textAlign: TextAlign.justify,
              style: greyTextStyle.copyWith(
                fontWeight: light,
              ),
            ),
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
            SingleChildScrollView(
              child: Row(
                children: productProvider.products.map((product) {
                  index++;
                  return Container(
                      margin: EdgeInsets.only(
                        left: (index == 0) ? 0 : 16,
                        right:
                            (index == productProvider.products.length) ? 30 : 0,
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
                      ));
                }).toList(),
              ),
            ),
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
                  borderRadius: BorderRadius.circular(12),
                  color: secondaryColor,
                ),
                child: Image.asset(
                  'assets/chat_black_icon.png',
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
                  fontWeight: semiBold,
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
      backgroundColor: bgColor,
      body: ListView(
        children: [
          Stack(
            children: [
              productImage(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 200),
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
