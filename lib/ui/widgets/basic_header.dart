part of 'widgets.dart';

class BasicHeader extends StatelessWidget {
  final String title;
  BasicHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: primaryTextStyle.copyWith(
          fontSize: 18,
          fontWeight: semiBold,
        ),
      ),
    );
  }
}
