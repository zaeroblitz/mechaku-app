part of 'widgets.dart';

class NewArrivalItem extends StatelessWidget {
  final ProductModel product;
  NewArrivalItem(this.product);

  @override
  Widget build(BuildContext context) {
    Widget _shimmer() {
      return Shimmer(
        color: iconColor,
        direction: ShimmerDirection.fromLeftToRight(),
        child: Container(
          width: 215,
          height: 288,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductPage(product)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: product.gallery[0],
              placeholder: (context, url) => _shimmer(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(product.gallery[0]),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.categoryId,
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    product.name,
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.toRupiahFormat(product.price),
                    style: orangeTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
