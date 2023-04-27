import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tragoo_admin_pannel/Utilities/notificationdialog.dart';

import '../main.dart';

class NotificationServices {
  FirebaseMessaging message = FirebaseMessaging.instance;

  void requestNotificationPermission(BuildContext context) async {
    NotificationSettings settings = await message.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        provisional: true,
        sound: true,
        criticalAlert: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      message.getInitialMessage();
      // we use the FirebaseMessaging.onMessage stream to listen for
      //incoming Notificatioins while the app in the background
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        String orderid = getorderid(message.data);
        String orderamount = getorderamount(message.data);
        fetchOrderDetailsDialog(context, orderid, orderamount);
      });
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // print("User granted provisional permission");
    } else {
      // print("user denied permission");
    }
  }

  //Firebase sends notification on device id
  Future<String> getDeviceToken() async {
    String? token = await message.getToken();
    return token!;
  }

  //token can be expire for some reasons so we check this
  void isTokenRefresh() async {
    message.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

//for fetching data from notifications and then we will pass into order screens page
  String getorderid(Map<String, dynamic> message) {
    String orderid = message['order_id'];
    return orderid;
  }

  //for fetching data from notifications and then we will pass into order screens page
  String getorderamount(Map<String, dynamic> message) {
    String orderamount = message['order_amount'];
    return orderamount;
  }

  //save tokens to admins details
  //have to call on the main page because the decice token change itself on every new installation
  //so we need to update tokens everytime
  //this function will save token to admin details whenever admin open the app
  //called this function on dashboard screen
  void saveTokenToAdminDetails(String token) async {
    //current user
    User? user = FirebaseAuth.instance.currentUser;
    //check states of user
    if (user != null) {
      //user database refrence
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('admin_details').doc(user.uid);
      //updat/ upload token to user database refrence
      await userRef.update({
        'token': token,
      });
    }
  }

  //show dialog when system detect new notification with alerting song
  void fetchOrderDetailsDialog(
      BuildContext context, String orderid, orderamount) async {
    //dependec for Audio Player / refrence on the main page
    //mp3 assets location refrence
    await player.setAsset('sounds/alert.mp3');
    //play audio
    player.play();

    //show information
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => NotificationDialog(
              orderid: orderid,
              orderamount: orderamount,
            ));
  }
}
