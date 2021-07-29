part of 'services.dart';

class ProductServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference products = firestore.collection('products');

  static Future<List<ProductModel>> getBestSellerProduct() async {
    QuerySnapshot snapshot =
        await products.where('isBestSeller', isEqualTo: true).get();
    List<ProductModel> listBestSeller = [];

    snapshot.docs.forEach((doc) {
      List<String> gallery = List.from(doc.get('gallery'));

      var dataProduct = ProductModel(
        doc.get('name'),
        doc.get('categoryId'),
        doc.get('color'),
        doc.get('description'),
        doc.get('grade'),
        doc.get('size'),
        gallery,
        doc.get('price'),
        doc.get('isBestSeller'),
      );

      listBestSeller.add(dataProduct);
    });

    print(listBestSeller);
    return listBestSeller;
  }

  static Future<List<ProductModel>> getProducts() async {
    QuerySnapshot snapshot = await products.get();
    List<ProductModel> listProduct = [];

    snapshot.docs.forEach((doc) {
      List<String> gallery = List.from(doc.get('gallery'));

      var dataProduct = ProductModel(
        doc.get('name'),
        doc.get('categoryId'),
        doc.get('color'),
        doc.get('description'),
        doc.get('grade'),
        doc.get('size'),
        gallery,
        doc.get('price'),
        doc.get('isBestSeller'),
      );

      listProduct.add(dataProduct);
    });

    print(listProduct);
    return listProduct;
  }
}
