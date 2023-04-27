import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
class ProductService{
  FirebaseFirestore _firestore =  FirebaseFirestore .instance;
  void createProduct(String productTitle, double price, String description,String category,String pack,List<String> ImageList)
  {
    print("object++++++++++++++++++++++++++++");
    var id = Uuid();
    String productId = id.v1();
    _firestore.collection('products_details').doc(productId).set(
        {
          'Title':productTitle,
          'Price':price,
          'description':description,
          'category': category,
          'pack':pack,
          'ImageList':ImageList,
          'productId': productId,
          'search_string': productTitle.toLowerCase()
        }
    );
  }
}

