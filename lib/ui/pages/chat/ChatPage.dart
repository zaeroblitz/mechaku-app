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

    Widget emptyState() {
      return Container(
        margin: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/headset_icon.png',
              width: 80,
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Oops no message yet',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                Text(
                  'You have never done a chat',
                  style: greyTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                pageProvider.currentIndex = 0;
              },
              style: TextButton.styleFrom(
                backgroundColor: iconColor,
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Explore Store',
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget inputChat() {
      return Container(
        margin: EdgeInsets.all(30),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  autofocus: false,
                  cursorColor: orangeTextColor,
                  style: primaryTextStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Type here to start chat',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/send_button.png',
                width: 45,
                height: 45,
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          header(),
          emptyState(),
          inputChat(),
        ],
      ),
    );
  }
}
