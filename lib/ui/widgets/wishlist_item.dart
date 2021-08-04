part of 'widgets.dart';

class WishlistItem extends StatelessWidget {
  final String url;
  final String name;
  final int price;

  WishlistItem(this.url, this.name, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryFontColor.withOpacity(0.15),
            blurRadius: 4,
            offset: Offset(4, 8),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: NetworkImage(url)),
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
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  'Rp $price',
                  style: orangeTextStyle,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 4,
          ),
          GestureDetector(
            child: CircleAvatar(
              backgroundColor: pinkColor,
              child: Icon(
                Icons.favorite_rounded,
                size: 16,
                color: whiteFontColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
