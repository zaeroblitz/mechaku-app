part of 'services.dart';

class CategoryServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference categories = firestore.collection('categories');
}
