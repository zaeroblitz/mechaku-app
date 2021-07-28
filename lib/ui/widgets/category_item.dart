part of 'widgets.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final String url;

  CategoryItem(this.name, this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: 288,
      height: 82,
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
            url,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: 288,
            height: 82,
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
                Expanded(
                  child: Text(
                    name,
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset(
                    'assets/chevron_right.png',
                    width: 12,
                    height: 12,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
