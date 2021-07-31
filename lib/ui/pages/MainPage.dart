part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final whiteIconList = [
    Image.asset(
      'assets/home_white_icon.png',
      width: 20,
    ),
    Image.asset(
      'assets/chat_white_icon.png',
      width: 20,
    ),
    Image.asset(
      'assets/love_white_icon.png',
      width: 20,
    ),
    Image.asset(
      'assets/setting_white_icon.png',
      width: 20,
    ),
  ];

  final blackIconList = [
    Image.asset(
      'assets/home_black_icon.png',
      width: 20,
    ),
    Image.asset(
      'assets/chat_black_icon.png',
      width: 20,
    ),
    Image.asset(
      'assets/love_black_icon.png',
      width: 20,
    ),
    Image.asset(
      'assets/setting_black_icon.png',
      width: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget walletButton() {
      return FloatingActionButton(
        onPressed: () {},
        backgroundColor: orangeTextColor,
        child: Image.asset(
          'assets/wallet_white_icon.png',
          width: 20,
        ),
      );
    }

    Widget bottomNav() {
      return AnimatedBottomNavigationBar.builder(
          itemCount: whiteIconList.length,
          tabBuilder: (int index, bool isActive) {
            final iconColor =
                isActive ? blackIconList[index] : whiteIconList[index];

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconColor,
              ],
            );
          },
          activeIndex: pageProvider.currentIndex,
          backgroundColor: secondaryColor,
          splashColor: orangeTextColor,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          rightCornerRadius: 32,
          leftCornerRadius: 32,
          onTap: (value) {
            setState(() {
              pageProvider.currentIndex = value;
            });
          });
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return Homepage();
          break;
        case 1:
          return ChatPage();
        case 2:
          return WishlistPage();
        default:
          return Homepage();
      }
    }

    return Scaffold(
      backgroundColor: bgColor,
      floatingActionButton:
          (pageProvider.currentIndex == 1) ? SizedBox() : walletButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:
          (pageProvider.currentIndex == 1) ? SizedBox() : bottomNav(),
      body: Container(
        child: body(),
      ),
    );
  }
}
