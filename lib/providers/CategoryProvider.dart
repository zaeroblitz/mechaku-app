part of 'providers.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _categories;

  List<CategoryModel> get categories => _categories;

  set categories(List<CategoryModel> categories) {
    _categories = categories;
    notifyListeners();
  }

  Future<void> getCategories() async {
    try {
      List<CategoryModel> categories = await CategoryServices.getCategory();

      _categories = categories;
    } catch (e) {
      print(e.toString());
    }
  }
}
