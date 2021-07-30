part of '../pages.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget header() {
      return Container(
        width: double.infinity,
        height: 90,
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                pageProvider.currentIndex = 0;
              },
              child: Image.asset(
                'assets/chevron_left.png',
                width: 24,
              ),
            ),
            SizedBox(width: 16),
            Image.asset(
              'assets/logo_landscape.png',
              width: 112,
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
        ],
      ),
    );
  }
}
