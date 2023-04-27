import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'current_user.dart';

class DatabaseServices{

  FirebaseFirestore fireStoreInstance=FirebaseFirestore.instance;

   Future<void> addNewQuestion(String quizID,dynamic quizData,) async{
    await fireStoreInstance.collection("questions").doc(quizID).set(quizData).catchError((e){
      debugPrint(e);
    });


   }

  static getCollection({@required collection}) async{
    CollectionReference<Map<String, dynamic>> docRef=  FirebaseFirestore.instance.collection(collection);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await docRef.get();
    return querySnapshot;

  }

  static updateData(String key,dynamic value){
    var collection = FirebaseFirestore.instance.collection('user_details');
    collection.doc(CurrentUserDetails.getUID())
        .update({key : value});
  }


}
