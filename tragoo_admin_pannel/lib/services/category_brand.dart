import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
class categoryService{
  FirebaseFirestore _firestore =  FirebaseFirestore .instance;
  void createCategory(String name)
  {
    var id = Uuid();
    String categoryId = id.v1();
    _firestore.collection('categories').doc(categoryId).set(
      {
      'categoryName':name
      }
    );
  }
}