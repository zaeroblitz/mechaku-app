part of 'services.dart';

class ProductServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference products = firestore.collection('products');

  static Future<List<ProductModel>> getProducts() async {
    QuerySnapshot snapshot = await products.get();
    List<ProductModel> listProduct = [];

    snapshot.docs.forEach((doc) {
      // var galleries = products.doc(doc.id).collection('gallery').get();
      // var galleriesData = await galleries.then((value) =>
      //     value.docs.map((e) => e.get('gallery').toString()).toList());

      var dataProduct = ProductModel(
        doc.get('name'),
        doc.get('categoryId'),
        doc.get('color'),
        doc.get('description'),
        doc.get('grade'),
        doc.get('size'),
        // galleriesData,
        doc.get('price'),
        doc.get('isBestSeller'),
      );

      listProduct.add(dataProduct);
    });

    print(listProduct);
    return listProduct;
  }
}
