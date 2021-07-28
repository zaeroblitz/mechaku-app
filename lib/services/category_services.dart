part of 'services.dart';

class CategoryServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference categories = firestore.collection('categories');

  static Future<List<CategoryModel>> getCategory() async {
    QuerySnapshot snapshot = await categories.get();
    List<CategoryModel> listCategory = [];

    snapshot.docs.forEach((document) {
      var dataCategory =
          CategoryModel(document.get('name'), document.get('bannerUrl'));

      listCategory.add(dataCategory);
    });

    return listCategory;
  }
}
