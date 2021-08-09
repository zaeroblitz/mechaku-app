part of 'providers.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products;
  Stream<List<ProductModel>> _productsStream;

  List<ProductModel> get products => _products;

  Stream<List<ProductModel>> get productsStream => _productsStream;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  set productsStream(Stream<List<ProductModel>> products) {
    _productsStream = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductServices.getProducts();

      _products = products;
      // print(_products.map((e) => e.name.toString()));
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<void> getProductsByStream() async* {
    try {
      Stream<List<ProductModel>> products =
          ProductServices.getProductsWithStream();

      _productsStream = products;
      print(
          _products.map((e) => 'Get Products By Stream: ' + e.name.toString()));
    } catch (e) {
      print('Get Product By Stream: ' + e.toString());
    }
  }

  Future<void> getBestSellerProducts() async {
    try {
      List<ProductModel> products =
          await ProductServices.getBestSellerProducts();

      _products = products;
      // print(_products.map((e) => 'Best Seller: ' + e.name.toString()));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getNewArrivalProducts() async {
    try {
      List<ProductModel> products =
          await ProductServices.getNewArrivalProducts();

      _products = products;
      // print(_products.map((e) => 'New Arrival Product: ' + e.name.toString()));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getProductsByCategory(String categoryId) async {
    try {
      List<ProductModel> products =
          await ProductServices.getProductsByCategory(categoryId);

      _products = products;
      // print(_products.map((e) => 'New Arrival Product: ' + e.name.toString()));
    } catch (e) {
      print(e.toString());
    }
  }
}
