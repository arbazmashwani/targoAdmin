import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:managedashboard/screens/leftbar.dart';
import 'package:managedashboard/screens/mainpagebar.dart';
import 'package:managedashboard/screens/rightbar.dart';

class HomePageChart extends StatefulWidget {
  const HomePageChart({super.key});

  @override
  State<HomePageChart> createState() => _HomePageChartState();
}

class _HomePageChartState extends State<HomePageChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: Row(
        children: [
          const Expanded(flex: 3, child: Leftbarpage()),
          Expanded(
              flex: 14,
              child: SizedBox(
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12)),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 25, right: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Home",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.person_2_outlined),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Expanded(
                          child: Row(
                        children: [
                          Expanded(
                              flex: 7,
                              child: Padding(
                                padding: EdgeInsets.only(left: 25, right: 0),
                                child: MainPageBar(),
                              )),
                          SizedBox(width: 300, child: rightbar())
                        ],
                      ))
                    ],
                  ),
                ),
              ))
        ],
      ),
    ));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}

List<String> datetitle = ["1D", "1W", "1M", "1Y Todos"];
List<String> admindatetitle = [
  "Home",
  "Trade",
  "Transfers",
  "Learn",
  "Messages",
];

List<Widget> admindatetitleicon = [
  Image.asset("images/icon0.png"),
  Image.asset("images/icon1.png"),
  Image.asset("images/icon4.png"),
  Image.asset("images/icon2.png"),
  Image.asset("images/icon3.png")
];

class User {
  final String date;
  final String amount;

  User({required this.date, required this.amount});
}

extension IterableExtensions<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E element, int index) f) {
    var index = 0;
    return map((element) => f(element, index++));
  }
}
