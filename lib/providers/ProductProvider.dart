part of 'providers.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products;

  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductServices.getProducts();

      _products = products;
      print(_products.map((e) => e.name.toString()));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getBestSellerProducts() async {
    try {
      List<ProductModel> products =
          await ProductServices.getBestSellerProducts();

      _products = products;
      print(_products.map((e) => 'Best Seller' + e.name.toString()));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getNewArrivalProducts() async {
    try {
      List<ProductModel> products =
          await ProductServices.getNewArrivalProducts();

      _products = products;
      print(_products.map((e) => 'Best Seller' + e.name.toString()));
    } catch (e) {
      print(e.toString());
    }
  }
}
