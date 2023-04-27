
import 'package:flutter/material.dart';

import '../constants/TitleText.dart';

class ProductScreen extends StatefulWidget {
  final List productsList;
  const ProductScreen({Key? key, required this.productsList}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [

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
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.productsList.length,
                      shrinkWrap: true,
                      itemBuilder: (context , index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(

                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.blue
                                ),
                                borderRadius: BorderRadius.circular(20)
                            ),

                            color: Colors.white,
                            child: ListTile(
                              leading:  ConstrainedBox(
                                  constraints: BoxConstraints.expand(height: 60, width:60),
                                  child: Image.network(widget.productsList[index]['ImageList'][0]) //,
                              ),
                              title: TitleText(text:widget.productsList[index]['Title'],fontWeight: FontWeight.w600,fontSize: 20,color: Colors.black,),
                              trailing: TitleText(text:"\$"+widget.productsList[index]['Price'].toString(),fontWeight: FontWeight.w400,fontSize: 16,color: Colors.red,),
                            ),
                          ),
                        );
                      }
                  ),
                ]

            ),
          ),
        )
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
                  text:  'Our',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text:  'Products',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),

          ],
        ));
  }
}
