import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tragoo_admin_pannel/Screens/category_screen.dart';
import 'package:tragoo_admin_pannel/Screens/products_screen.dart';
import 'package:tragoo_admin_pannel/constants/TitleText.dart';

import 'Users_Screen.dart';
import 'orders_screen.dart';

class dashboardWidget extends StatefulWidget {
  const dashboardWidget({Key? key}) : super(key: key);

  @override
  State<dashboardWidget> createState() => _dashboardWidgetState();
}

class _dashboardWidgetState extends State<dashboardWidget> {
  int totalUsers = 0;
  int totalCategories = 0;
  int totalProducts = 0;
  int totalOrders = 0;
  var filterordersList = [];
  List userDoc = [];
  List OrdersList = [];
  List categoryList = [];
  List productList = [];
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      shrinkWrap: true,
      childAspectRatio: 0.8,
      padding: const EdgeInsets.symmetric(vertical: 30),
      children: <Widget>[
        StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('user_details').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.active) {
              userDoc = streamSnapshot.data!.docs.toList();
              totalUsers = userDoc.length;
              print("*****************************************");
              print(totalUsers);
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: dashboardCard(
                Title: 'Users',
                SubTitle: totalUsers.toString(),
                icon: Icons.people_alt_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UsersScreen(
                              usersList: userDoc,
                            )),
                  );
                },
              ),
            );
          },
        ),
        StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('categories').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.active) {
              categoryList = streamSnapshot.data!.docs.toList();
              totalCategories = categoryList.length;
              print("*****************************************");
              print(totalCategories);
              print(categoryList);
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: dashboardCard(
                Title: "Categories",
                SubTitle: totalCategories.toString(),
                icon: Icons.category,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryScreen(
                              categoryList: categoryList,
                            )),
                  );
                },
              ),
            );
          },
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('products_details')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.active) {
              productList = streamSnapshot.data!.docs.toList();
              totalProducts = productList.length;
              print("*****************************************");
              print(totalCategories);
              print(categoryList);
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: dashboardCard(
                Title: "Products",
                SubTitle: totalProducts.toString(),
                icon: Icons.track_changes,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(
                              productsList: productList,
                            )),
                  );
                },
              ),
            );
          },
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.active) {
              OrdersList = streamSnapshot.data!.docs.toList();

              totalOrders = OrdersList.length;

              filterordersList = OrdersList.where(
                      (element) => element["readorder"].toString() == "false")
                  .toList();

              // OrdersList.forEach((element) {
              //   if (element["readorder"].toString() != "null") {
              //     if (element["readorder"].toString() == "false") {
              //       filterordersList.add(element);
              //     }
              //   }
              // });
            }
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                //Color(0XFFFFFFFF),

                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 15,
                      spreadRadius: 10),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ListTile(
                        title: TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Orders_Screen(
                                          orderList: OrdersList,
                                          searchOrder: "",
                                        )),
                              );
                            },
                            icon: const Icon(Icons.shopping_cart),
                            label: const TitleText(
                              text: "Orders",
                              fontWeight: FontWeight.w400,
                            )),
                        subtitle: Text(
                          totalOrders.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.mulish(
                              fontSize: 60, color: Colors.blue),
                        )),
                  ),
                  filterordersList.length != 0
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${filterordersList.length.toString()} New Unread Orders",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.mulish(
                                    fontSize: 13, color: Colors.blue),
                              ),
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: dashboardCard(
            Title: "Sold",
            SubTitle: '13',
            icon: Icons.tag_faces,
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: dashboardCard(
            Title: "Return",
            SubTitle: '0',
            icon: Icons.close,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class dashboardCard extends StatelessWidget {
  final String Title;
  final String SubTitle;
  final IconData icon;
  final VoidCallback onPressed;
  const dashboardCard({
    Key? key,
    required this.Title,
    required this.SubTitle,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        //Color(0XFFFFFFFF),

        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListTile(
            title: TextButton.icon(
                onPressed: onPressed,
                icon: Icon(icon),
                label: TitleText(
                  text: Title,
                  fontWeight: FontWeight.w400,
                )),
            subtitle: Text(
              SubTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(fontSize: 60, color: Colors.blue),
            )),
      ),
    );
  }
}
