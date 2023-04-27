import 'package:flutter/material.dart';

import '../constants/TitleText.dart';

class OrdersDetails extends StatefulWidget {
  final List OrderDetails;
  final int index;
  const OrdersDetails({Key? key, required this.OrderDetails, required this.index}) : super(key: key);
   
  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  @override
  Widget build(BuildContext context) {
   print(widget.OrderDetails[widget.index]['OrderNumber']);
   print(widget.OrderDetails[widget.index]['OrderList'].length);
    return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                          color:
                          Colors.transparent ,

                        ),
                        height: 50,
                        width: 50,

                        child: Center(
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
                          TitleText(text: "Order",color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400,),
                          TitleText(text:"#"+ widget.OrderDetails[widget.index]['OrderNumber'],color: Colors.blue,fontSize: 28,),
                        ],
                      ),
                      SizedBox(height: 20,),
                      DetailCard(),
                      SizedBox(height: 10,),
                      TitleText(text: "Delivery To ",fontSize: 22,fontWeight: FontWeight.w300,),
                      TitleText(text: widget.OrderDetails[widget.index]['CheckoutDetails']['address'],fontWeight: FontWeight.w700,),
                      Row(
                        children: [
                          TitleText(text: widget.OrderDetails[widget.index]['CheckoutDetails']['city'],fontWeight: FontWeight.w700,),
                          TitleText(text:", " + widget.OrderDetails[widget.index]['CheckoutDetails']['country '],fontWeight: FontWeight.w700,),
                        ],
                      ),
                      TitleText(text:"Postal Code: " + widget.OrderDetails[widget.index]['CheckoutDetails']['postalCode'],fontWeight: FontWeight.w700,),
                      Divider(thickness: 5,),
                      SizedBox(height: 10,),
                      TitleText(text: "Client Info ",fontSize: 22,fontWeight: FontWeight.w300,),
                      Row(
                        children: [
                          TitleText(text: "Name: ",fontWeight: FontWeight.normal,),
                          TitleText(text: widget.OrderDetails[widget.index]['CheckoutDetails']['firstName']+" "+widget.OrderDetails[widget.index]['CheckoutDetails']['lastName'],fontWeight: FontWeight.w700,),
                        ],
                      ),
                      Row(
                        children: [
                          TitleText(text: "Phone Number: ",fontWeight: FontWeight.normal,),
                          TitleText(text:widget.OrderDetails[widget.index]['CheckoutDetails']['phoneNumber'],fontWeight: FontWeight.w700,),
                        ],
                      ),
                      Row(
                        children: [
                          TitleText(text: "Email: ",fontWeight: FontWeight.normal,),
                          TitleText(text:widget.OrderDetails[widget.index]['Client Email'],fontWeight: FontWeight.w700,),
                        ],
                      ),
                      Divider(thickness: 5,),
                      SizedBox(height: 10,),
                      TitleText(text: "For Rider ",fontSize: 22,fontWeight: FontWeight.w300,),
                      Row(
                        children: [
                          TitleText(text: "Total Orders: ",fontWeight: FontWeight.normal,),
                          TitleText(text:widget.OrderDetails[widget.index]['OrderList'].length.toString(),fontWeight: FontWeight.w700,color: Colors.black,),
                        ],
                      ),
                      Row(
                        children: [
                          TitleText(text: "Message for Rider: ",fontWeight: FontWeight.normal,),
                          TitleText(text:widget.OrderDetails[widget.index]['MessageForRider'],fontWeight: FontWeight.w700,color: Colors.black,),
                        ],
                      ),
                      Row(
                        children: [
                          TitleText(text: "PhoneNumber for Rider: ",fontWeight: FontWeight.normal,),
                          TitleText(text:widget.OrderDetails[widget.index]['phoneNumberForRider'],fontWeight: FontWeight.w700,color: Colors.black,),
                        ],
                      ),
                      Row(
                        children: [
                          TitleText(text: "Payment Method: ",fontWeight: FontWeight.normal,),
                          TitleText(text:widget.OrderDetails[widget.index]['PaymentMethod'],fontWeight: FontWeight.w700,color: Colors.black,),
                        ],
                      ),



                    ],
                  ),
                ),
              )

            ],
          ),
        ) ,
      ),
    );
  }
  Widget _title() {
    return Container(
        margin:  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text:  'Order Details',
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
      decoration: BoxDecoration(
        color: Colors.blue.shade50
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TitleText(text: "Product"),
                TitleText(text: "Qty"),
                TitleText(text: "Total")
              ],
            ),
          ),
          SizedBox(
          height: 400,
          child: ListView.builder(

              itemCount: widget.OrderDetails[widget.index]['OrderList'].length,
              shrinkWrap:true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          ConstrainedBox(
                              constraints: BoxConstraints.expand(height: 60, width:60),
                              child: Image.network(widget.OrderDetails[widget.index]['OrderList'][index]['Images']) //,
                          ),
                          TitleText(text: widget.OrderDetails[widget.index]['OrderList'][index]['Title'],fontWeight: FontWeight.normal,),
                          TitleText(text: widget.OrderDetails[widget.index]['OrderList'][index]['Quantity'].toString(),fontWeight: FontWeight.normal,),
                          TitleText(text: widget.OrderDetails[widget.index]['OrderList'][index]['Price'].toString(),fontWeight: FontWeight.normal,)
                        ]
                      )
                    ],
                  )

                );
              }),
        ),
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.red.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TitleText(text: "Total = ",fontWeight: FontWeight.normal,),
                TitleText(text: "\$"+ widget.OrderDetails[widget.index]['TotalPrice'].toString(),fontSize:30,)
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