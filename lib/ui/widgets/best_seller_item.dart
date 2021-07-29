part of 'widgets.dart';

class BestSellerItem extends StatelessWidget {
  final String category;
  final String name;
  final String grade;
  final String size;
  final String gallery;
  final int price;

  BestSellerItem(this.category, this.name, this.grade, this.size, this.gallery,
      this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 215,
      height: 278,
      margin: EdgeInsets.only(
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            gallery,
          ),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 215,
              height: 84,
              padding: EdgeInsets.symmetric(
                vertical: 9,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: whiteTextStyle.copyWith(fontSize: 12),
                  ),
                  Column(
                    children: [
                      Text(
                        '$name',
                        maxLines: 1,
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        '($grade - $size)',
                        maxLines: 1,
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: -0.5,
            bottom: 54,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: orangeTextColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Text(
                price.toString(),
                style: whiteTextStyle.copyWith(
                  fontWeight: medium,
                ),
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.asset(
                'assets/love_white_icon.png',
                width: 12,
                height: 12,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
