import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
class brandService{
  FirebaseFirestore _firestore =  FirebaseFirestore .instance;
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('brands');
  String ref = 'brands';

  void createBrand(String name)
  {
    var id = Uuid();
    String brandId = id.v1();
    _firestore.collection('brands').doc(brandId).set(
        {
          'brandName':name
        }
    );
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
  }
}