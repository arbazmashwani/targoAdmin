import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tragoo_admin_pannel/Screens/dashBoard_Screen.dart';
import 'package:tragoo_admin_pannel/Screens/orders_screen.dart';

class NotificationRoute extends StatefulWidget {
  const NotificationRoute({super.key});

  @override
  _NotificationRouteState createState() => _NotificationRouteState();
}

class _NotificationRouteState extends State<NotificationRoute> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void _doSomethingOnStart() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _navigatorKey.currentState!.pushNamed('/notificationRoute');
      orderid = message.notification!.body.toString();
    });
  }

  @override
  void initState() {
    _doSomethingOnStart();
    // TODO: implement initState
    super.initState();
  }

  String orderid = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => const dashBoardScreen());
            case '/notificationRoute':
              return MaterialPageRoute(
                  builder: (_) => Orders_Screen(
                        orderList: const [],
                        searchOrder: orderid,
                      ));
            default:
              return null;
          }
        },
      ),
    );
  }
}
