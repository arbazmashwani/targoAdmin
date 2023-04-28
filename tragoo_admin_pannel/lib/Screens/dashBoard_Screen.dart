import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tragoo_admin_pannel/constants/TitleText.dart';
import 'package:tragoo_admin_pannel/services/add_products.dart';
import '../Services/auth_service.dart';
import '../services/current_user.dart';
import '../services/database_services.dart';
import '../services/brand.dart';
import '../services/category_brand.dart';
import 'package:tragoo_admin_pannel/Utilities/constants/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/notification_services.dart';
import 'DashboardWidget.dart';

class dashBoardScreen extends StatefulWidget {
  const dashBoardScreen({Key? key}) : super(key: key);
  @override
  State<dashBoardScreen> createState() => _dashBoardScreenState();
}

enum Page { dashboard, manage }

class _dashBoardScreenState extends State<dashBoardScreen> {
  List<dynamic> brands = [];
  double revenue = 0;
  String currentUserName = "";
  String url = '';
  brandService brand = brandService();
  categoryService category = categoryService();
  final Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.blue;
  MaterialColor notActive = Colors.grey;
  final GlobalKey<FormState> _categoryFormKey = GlobalKey();
  final GlobalKey<FormState> _brandFormKey = GlobalKey();
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  NotificationServices notificationServices = NotificationServices();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  getImage() async {
    var imageName = CurrentUserDetails.getUID();
    String url1 = await FirebaseStorage.instance
        .ref()
        .child('profile_photo/$imageName')
        .getDownloadURL();
    setState(() {
      url = url1;
    });
    print('_______________________________');
    print(url);
  }

  getUserDetails() async {
    print("inFUnction_______");
    var userDetails =
        await DatabaseServices.getCollection(collection: "admin_details");
    for (var queryDocumentSnapshot in userDetails.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (CurrentUserDetails.getEmail() == data['email']) {
        setState(() {
          currentUserName = data['name'];
        });
      }
    }
    print(currentUserName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission(context);
    notificationServices.getDeviceToken().then((value) {
      notificationServices.saveTokenToAdminDetails(value.toString());
    });
    notificationServices.isTokenRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final authServices = AuthServices();
    return Scaffold(
      body: ListView(children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    color: Color(0XFFFFFFFF),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xfff8f8f8),
                          blurRadius: 10,
                          spreadRadius: 15),
                    ]),
                child: IconButton(
                  icon: const Icon(Icons.sort, size: 30, color: Colors.black),
                  onPressed: () {},
                ),
              ),

              Image.asset(
                'images/trago.png',
                width: 70,
                height: 70,
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    color: Color(0XFFFFFFFF),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xfff8f8f8),
                          blurRadius: 10,
                          spreadRadius: 15),
                    ]),
                child: IconButton(
                  icon: const Icon(Icons.manage_accounts,
                      size: 30, color: Colors.black),
                  onPressed: () {},
                ),
              ),
              // Text(" TRAGO ",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.blue[900]),),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15),
          child: TitleText(
            text: "DASHBOARD",
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
              height: 150,
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.red[100],
                //Color(0XFFFFFFFF),

                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 15,
                      spreadRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TitleText(
                      text: "REVENUE",
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Orders')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.connectionState ==
                              ConnectionState.active) {
                            List OrdersList =
                                streamSnapshot.data!.docs.toList();
                            int totalOrders = OrdersList.length;
                            revenue = 0;
                            for (int i = 0; i < totalOrders; i++) {
                              revenue = revenue + OrdersList[i]['TotalPrice'];
                            }
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TitleText(
                                text: "\$ ",
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                                fontSize: 50,
                              ),
                              TitleText(
                                text: revenue.toString(),
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                                fontSize: 50,
                              ),
                            ],
                          );
                        })
                  ],
                ),
              )),
        ),
        const dashboardWidget(),
      ]),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/img.png',
                    ),
                    fit: BoxFit.cover,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    currentUserName == '' ? 'Guest' : currentUserName,
                    style: TextStyle(
                      color: AppColors.kPrimaryClr,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, top: 1),
                    child: Text(
                      CurrentUserDetails.getEmail() ??
                          'You are using whiskey as a guest:-)',
                      style: const TextStyle(
                        color: Colors.cyan,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.cyan,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                  color: AppColors.kPrimaryClr,
                  fontFamily: 'Helvetica LTStd',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.contacts,
                color: AppColors.kPrimaryClr,
              ),
              title: Text(
                "Contact Us",
                style: TextStyle(
                  color: AppColors.kPrimaryClr,
                ),
              ),
              onTap: () {
                // Utilities.launchEmail();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: AppColors.kPrimaryClr,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  color: AppColors.kPrimaryClr,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.check,
                color: AppColors.kPrimaryClr,
              ),
              title: Text(
                "Add Product",
                style: TextStyle(
                  color: AppColors.kPrimaryClr,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: AppColors.kRedClr,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  color: AppColors.kRedClr,
                ),
              ),
              onTap: () async {
                showGeneralDialog(
                    context: context,
                    barrierLabel: "Barrier",
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionDuration: const Duration(milliseconds: 700),
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        contentPadding: const EdgeInsets.only(
                            top: 20.0, left: 15.0, right: 15.0),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: AppColors.kPrimaryClr,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "Are you sure you want to logout?",
                                  style: TextStyle(
                                    color: AppColors.kPrimaryClr,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        authServices.signOut(context);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 75.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.cyan,
                                            border: Border.all(
                                              color: Colors.cyan,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4))),
                                        child: const Text(
                                          "Logout",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 75.0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.white10,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4))),
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: Colors.cyan,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return const dashboardWidget();
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Add product"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddProducts()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.change_history),
              title: const Text("Products list"),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text("Add category"),
              onTap: () {
                _categoryAlert();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text("Category list"),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text("Add brand"),
              onTap: () {
                _brandAlert();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.library_books),
              title: const Text("brand list"),
              onTap: () {},
            ),
            const Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _categoryAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          decoration: const InputDecoration(
              hintText: "Add Category",
              hintStyle: TextStyle(color: Colors.black45)),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Category cannot be empty';
            }
            return null;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              category.createCategory(categoryController.text);
              Fluttertoast.showToast(msg: "Category Created");
            },
            child: const Text("ADD")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("CANCEL"))
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _brandAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "ADD BRAND",
              hintStyle: TextStyle(color: Colors.black45)),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Brand cannot be empty';
            }
            return null;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              brand.createBrand(brandController.text);
              Fluttertoast.showToast(msg: "Brand is Created");
            },
            child: const Text("ADD")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("CANCEL"))
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
}

class GridCard extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  final Icon icon;
  String subTitleText;
  GridCard(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.text,
      required this.subTitleText});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: TextButton.icon(
              onPressed: onPressed, icon: icon, label: Text(text)),
          subtitle: const Text(
            '7',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue, fontSize: 60.0),
          )),
    );
  }
}
