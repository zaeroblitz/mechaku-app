part of '../pages.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInit();
    getStreamInit();
    super.initState();
  }

  getStreamInit() async* {
    Provider.of<ProductProvider>(context, listen: false).getProductsByStream();
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    await Provider.of<ProductProvider>(context, listen: false)
        .getBestSellerProducts();
    await Provider.of<ProductProvider>(context, listen: false)
        .getNewArrivalProducts();
    await Provider.of<CategoryProvider>(context, listen: false).getCategories();
    Navigator.pushNamedAndRemoveUntil(context, 'sign-in', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Image.asset(
          'assets/logo_full.png',
          width: 350,
          height: 350,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
