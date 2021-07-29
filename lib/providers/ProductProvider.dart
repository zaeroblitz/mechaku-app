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
}
