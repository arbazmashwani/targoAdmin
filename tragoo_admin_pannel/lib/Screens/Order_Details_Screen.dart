import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/TitleText.dart';

class OrdersDetails extends StatefulWidget {
  final List OrderDetails;
  final int index;
  const OrdersDetails(
      {Key? key, required this.OrderDetails, required this.index})
      : super(key: key);

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  void markorderread() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Orders')
        .where('OrderNumber',
            isEqualTo:
                widget.OrderDetails[widget.index]['OrderNumber'].toString())
        .get();

    final DocumentSnapshot userDoc = querySnapshot.docs.first;
    final DocumentReference userRef = userDoc.reference;

    await userRef.update({'readorder': "true"});
  }

  @override
  void initState() {
    markorderread();
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
              Row(
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
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleText(
                            text: "Order",
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          TitleText(
                            text: "#" +
                                widget.OrderDetails[widget.index]
                                    ['OrderNumber'],
                            color: Colors.blue,
                            fontSize: 28,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DetailCard(),
                      const SizedBox(
                        height: 10,
                      ),
                      const TitleText(
                        text: "Delivery To ",
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                      ),
                      TitleText(
                        text: widget.OrderDetails[widget.index]
                            ['CheckoutDetails']['address'],
                        fontWeight: FontWeight.w700,
                      ),
                      Row(
                        children: [
                          TitleText(
                            text: widget.OrderDetails[widget.index]
                                ['CheckoutDetails']['city'],
                            fontWeight: FontWeight.w700,
                          ),
                          TitleText(
                            text:
                                ", ${widget.OrderDetails[widget.index]['CheckoutDetails']['country ']}",
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      TitleText(
                        // ignore: prefer_interpolation_to_compose_strings
                        text: "Postal Code: " +
                            widget.OrderDetails[widget.index]['CheckoutDetails']
                                ['postalCode'],
                        fontWeight: FontWeight.w700,
                      ),
                      const Divider(
                        thickness: 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const TitleText(
                        text: "Client Info ",
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                      ),
                      Row(
                        children: [
                          const TitleText(
                            text: "Name: ",
                            fontWeight: FontWeight.normal,
                          ),
                          TitleText(
                            text: widget.OrderDetails[widget.index]
                                    ['CheckoutDetails']['firstName'] +
                                " " +
                                widget.OrderDetails[widget.index]
                                    ['CheckoutDetails']['lastName'],
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const TitleText(
                            text: "Phone Number: ",
                            fontWeight: FontWeight.normal,
                          ),
                          TitleText(
                            text: widget.OrderDetails[widget.index]
                                ['CheckoutDetails']['phoneNumber'],
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const TitleText(
                            text: "Email: ",
                            fontWeight: FontWeight.normal,
                          ),
                          TitleText(
                            text: widget.OrderDetails[widget.index]
                                ['Client Email'],
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const TitleText(
                        text: "For Rider ",
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                      ),
                      Row(
                        children: [
                          const TitleText(
                            text: "Total Orders: ",
                            fontWeight: FontWeight.normal,
                          ),
                          TitleText(
                            text: widget
                                .OrderDetails[widget.index]['OrderList'].length
                                .toString(),
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const TitleText(
                            text: "Message for Rider: ",
                            fontWeight: FontWeight.normal,
                          ),
                          TitleText(
                            text: widget.OrderDetails[widget.index]
                                ['MessageForRider'],
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const TitleText(
                            text: "PhoneNumber for Rider: ",
                            fontWeight: FontWeight.normal,
                          ),
                          TitleText(
                            text: widget.OrderDetails[widget.index]
                                ['phoneNumberForRider'],
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const TitleText(
                            text: "Payment Method: ",
                            fontWeight: FontWeight.normal,
                          ),
                          TitleText(
                            text: widget.OrderDetails[widget.index]
                                ['PaymentMethod'],
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
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
                  text: 'Order Details',
                  fontSize: 29,
                  fontWeight: FontWeight.w800,
                ),
              ],
            ),
          ],
        ));
  }

  Widget DetailCard() {
    return Container(
      decoration: BoxDecoration(color: Colors.blue.shade50),
      child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                TitleText(text: "Product"),
                TitleText(text: "Qty"),
                TitleText(text: "Total")
              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: ListView.builder(
                itemCount:
                    widget.OrderDetails[widget.index]['OrderList'].length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            ConstrainedBox(
                                constraints: const BoxConstraints.expand(
                                    height: 60, width: 60),
                                child: Image.network(
                                    widget.OrderDetails[widget.index]
                                        ['OrderList'][index]['Images']) //,
                                ),
                            TitleText(
                              text: widget.OrderDetails[widget.index]
                                  ['OrderList'][index]['Title'],
                              fontWeight: FontWeight.normal,
                            ),
                            TitleText(
                              text: widget.OrderDetails[widget.index]
                                      ['OrderList'][index]['Quantity']
                                  .toString(),
                              fontWeight: FontWeight.normal,
                            ),
                            TitleText(
                              text: widget.OrderDetails[widget.index]
                                      ['OrderList'][index]['Price']
                                  .toString(),
                              fontWeight: FontWeight.normal,
                            )
                          ])
                        ],
                      ));
                }),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.red.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const TitleText(
                  text: "Total = ",
                  fontWeight: FontWeight.normal,
                ),
                TitleText(
                  text: "\$${widget.OrderDetails[widget.index]['TotalPrice']}",
                  fontSize: 30,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
* Row(
                  children: [
                    ConstrainedBox(
                        constraints: BoxConstraints.expand(height: 60, width:60),
                        child: Image.network(widget.OrderDetails[widget.index]['OrderList'][index]['Images']) //,
                    ),
                    TitleText(text: widget.OrderDetails[widget.index]['OrderList'][index]['Title'],fontWeight: FontWeight.normal,),
                    TitleText(text: widget.OrderDetails[widget.index]['OrderList'][index]['Quantity'].toString(),fontWeight: FontWeight.normal,),
                    TitleText(text: widget.OrderDetails[widget.index]['OrderList'][index]['Price'].toString(),fontWeight: FontWeight.normal,)
                  ],
                )*/