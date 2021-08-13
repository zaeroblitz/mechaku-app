part of '../pages.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: 30,
          right: 30,
          bottom: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Image.asset(
                  'assets/chevron_left.png',
                  width: 12,
                ),
              ),
            ),
            Text(
              'My Wallet',
              style: titleTextStyle.copyWith(
                fontSize: 20,
                fontWeight: medium,
              ),
            ),
            SizedBox(width: 24),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          _header(),
        ],
      ),
    );
  }
}
