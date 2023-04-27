import 'package:flutter/material.dart';
import 'package:tragoo_admin_pannel/Screens/orders_screen.dart';
import 'package:tragoo_admin_pannel/main.dart';

class NotificationDialog extends StatelessWidget {
  String orderid;
  String orderamount;
  NotificationDialog({
    super.key,
    required this.orderamount,
    required this.orderid,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              'images/trago.png',
              width: 100,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'NEW ORDER REQUEST',
              style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 18),
            ),
            const SizedBox(height: 8),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: ListTile(
                  subtitle: Text(orderid),
                  title: const Text(
                    "Order Number",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: ListTile(
                  subtitle: Text(orderamount),
                  title: const Text(
                    "Order Amount",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: outlinebusttonOrders(
                      title: 'CANCEL',
                      color: Colors.red,
                      onPressed: () async {
                        player.stop();

                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    child: outlinebusttonOrders(
                      title: 'Check Out',
                      color: Colors.green,
                      onPressed: () async {
                        player.stop();

                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Orders_Screen(
                                    orderList: const [],
                                    searchOrder: orderid,
                                  )),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class outlinebusttonOrders extends StatelessWidget {
  final String title;
  final Color color;
  final Function() onPressed;

  const outlinebusttonOrders(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          side: BorderSide(color: color),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
        ),
        onPressed: onPressed,
        child: SizedBox(
          height: 50.0,
          child: Center(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Brand-Bold',
                    color: Colors.white)),
          ),
        ));
  }
}
