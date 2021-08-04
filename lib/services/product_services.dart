part of 'services.dart';

class ProductServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference products = firestore.collection('products');

  static Future<List<ProductModel>> getProducts() async {
    QuerySnapshot snapshot = await products.get();
    List<ProductModel> listProduct = [];

    snapshot.docs.forEach((doc) {
      List<String> gallery = List.from(doc.get('gallery'));

      var dataProduct = ProductModel(
        doc.get('id'),
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

    return listProduct;
  }

  // static Stream<List<ProductModel>> getProductsWithStream() {
  //   return products
  //       .snapshots()
  //       .map((QuerySnapshot querySnapshot) => querySnapshot.docs
  //           .map((DocumentSnapshot documentSnapshot) => ProductModel(
  //                 documentSnapshot.get('id'),
  //                 documentSnapshot.get('name'),
  //                 documentSnapshot.get('categoryId'),
  //                 documentSnapshot.get('color'),
  //                 documentSnapshot.get('description'),
  //                 documentSnapshot.get('grade'),
  //                 documentSnapshot.get('size'),
  //                 documentSnapshot.get('gallery'),
  //                 documentSnapshot.get('price'),
  //                 documentSnapshot.get('isBestSeller'),
  //               ))
  //           .toList());
  // }

  static Stream<List<ProductModel>> getProductsWithStream() {
    return products.snapshots().map(_firebaseProductFromSnapshot);
  }

  static List<ProductModel> _firebaseProductFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      List<String> gallery = List.from(doc.get('gallery'));

      return ProductModel(
        doc.get('id'),
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
    }).toList();
  }

  static Future<List<ProductModel>> getBestSellerProducts() async {
    QuerySnapshot snapshot =
        await products.where('isBestSeller', isEqualTo: true).get();
    List<ProductModel> listBestSeller = [];

    snapshot.docs.forEach((doc) {
      List<String> gallery = List.from(doc.get('gallery'));

      var dataProduct = ProductModel(
        doc.get('id'),
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

    return listBestSeller;
  }

  static Future<List<ProductModel>> getNewArrivalProducts() async {
    QuerySnapshot snapshot = await products.orderBy('createdAt').limit(5).get();
    List<ProductModel> listProduct = [];

    snapshot.docs.forEach((doc) {
      List<String> gallery = List.from(doc.get('gallery'));

      var dataProduct = ProductModel(
        doc.get('id'),
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

    return listProduct;
  }
}
