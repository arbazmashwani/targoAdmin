import 'package:flutter/material.dart';

import '../constants/TitleText.dart';

class CategoryScreen extends StatefulWidget {
  final List categoryList;
  const CategoryScreen({Key? key, required this.categoryList}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
                  itemCount: widget.categoryList.length,
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
                          title: TitleText(text:widget.categoryList[index]['categoryName'],fontWeight: FontWeight.w600,fontSize: 20,color: Colors.black,),
                        ),
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
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
                  text:  'Product',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text:  'Categories',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),

          ],
        ));
  }
}
