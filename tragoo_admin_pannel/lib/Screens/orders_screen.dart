import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants/TitleText.dart';
import 'Order_Details_Screen.dart';

class Orders_Screen extends StatefulWidget {
  final List orderList;
  String searchOrder;
  Orders_Screen({Key? key, required this.orderList, required this.searchOrder})
      : super(key: key);

  @override
  State<Orders_Screen> createState() => _Orders_ScreenState();
}

class _Orders_ScreenState extends State<Orders_Screen> {
  String searchOrderDetails = "";
  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    if (widget.searchOrder == null) {
      widget.searchOrder = "";
      setState(() {});
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      color: Colors.transparent,
                    ),
                    height: 50,
                    width: 50,
                    child: const Center(
                        child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    )),
                  ),
                ),
              ),

              _title(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchcontroller,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.searchOrder = searchcontroller.text;
                          });
                        },
                        icon: const Icon(Icons.search)),
                    hintText: "Search Order",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Orders').snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.connectionState ==
                      ConnectionState.active) {
                    OrdersList = streamSnapshot.data!.docs.toList();
                    filterordersList = OrdersList;
                    if (widget.searchOrder.isNotEmpty) {
                      filterordersList = OrdersList.where((element) =>
                              (element["OrderNumber"]
                                      .toString()
                                      .toLowerCase()
                                      .trim() ==
                                  widget.searchOrder.toLowerCase().trim()))
                          .toList();
                    }
                  }
                  return filterordersList.isEmpty
                      ? Container(
                          child: const Center(
                            child: Text(
                              "No Order Found, Invalid Order Number",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.searchOrder.isEmpty
                              ? OrdersList.length
                              : filterordersList.length,
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context, index) {
                            /*   Timestamp date = widget.orderList[index]['Time'];
                    var finalDate = DateTime.parse(date.toDate().toString());
                    print(finalDate);*/

                            return InkWell(
                              onTap: () {
                                print(index);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrdersDetails(
                                            OrderDetails:
                                                widget.searchOrder.isEmpty
                                                    ? OrdersList
                                                    : filterordersList,
                                            index: index,
                                          )),
                                );
                              },
                              hoverColor: Colors.blue,
                              splashColor: Colors.blue,
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.white,
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      const TitleText(
                                        text: "Order #",
                                        color: Colors.blue,
                                        fontSize: 22,
                                      ),
                                      TitleText(
                                        text: widget.searchOrder.isEmpty
                                            ? OrdersList[index]['OrderNumber']
                                            : filterordersList[index]
                                                ["OrderNumber"],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.blue.shade900,
                                        size: 22,
                                      ),
                                      TitleText(
                                        text: widget.searchOrder.isEmpty
                                            ? OrdersList[index]['Time']
                                            : filterordersList[index]["Time"],
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  trailing: TitleText(
                                    text:
                                        '\$${widget.searchOrder.isEmpty ? OrdersList[index]['TotalPrice'] : filterordersList[index]['TotalPrice']}',
                                  ),
                                ),
                              ),
                            );
                          });
                },
              ),
              // widget.orderList.isEmpty
              //     ? Container()
              //     : ListView.builder(
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemCount: widget.orderList.length,
              //         shrinkWrap: true,
              //         reverse: true,
              //         itemBuilder: (context, index) {
              //           /*   Timestamp date = widget.orderList[index]['Time'];
              //       var finalDate = DateTime.parse(date.toDate().toString());
              //       print(finalDate);*/

              //           return InkWell(
              //             onTap: () {
              //               print(index);
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => OrdersDetails(
              //                           OrderDetails: widget.orderList,
              //                           index: index,
              //                         )),
              //               );
              //             },
              //             hoverColor: Colors.blue,
              //             splashColor: Colors.blue,
              //             child: Card(
              //               elevation: 3,
              //               shape: RoundedRectangleBorder(
              //                   side: const BorderSide(color: Colors.blue),
              //                   borderRadius: BorderRadius.circular(10)),
              //               color: Colors.white,
              //               child: ListTile(
              //                 title: Row(
              //                   children: [
              //                     const TitleText(
              //                       text: "Order #",
              //                       color: Colors.blue,
              //                       fontSize: 22,
              //                     ),
              //                     TitleText(
              //                       text: widget.orderList[index]
              //                           ['OrderNumber'],
              //                       fontWeight: FontWeight.w600,
              //                       fontSize: 22,
              //                       color: Colors.blue,
              //                     ),
              //                   ],
              //                 ),
              //                 subtitle: Row(
              //                   children: [
              //                     Icon(
              //                       Icons.access_time,
              //                       color: Colors.blue.shade900,
              //                       size: 22,
              //                     ),
              //                     TitleText(
              //                       text: widget.orderList[index]['Time'],
              //                       fontWeight: FontWeight.w400,
              //                       fontSize: 18,
              //                       color: Colors.black,
              //                     ),
              //                   ],
              //                 ),
              //                 trailing: TitleText(
              //                   text:
              //                       '\$${widget.orderList[index]['TotalPrice']}',
              //                 ),
              //               ),
              //             ),
              //           );
              //         }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                TitleText(
                  text: 'Orders',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text: 'List',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ));
  }

  List OrdersList = [];
  List filterordersList = [];
}
