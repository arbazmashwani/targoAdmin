import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:managedashboard/dialogs/alertdialog.dart';
import 'package:managedashboard/screens/homepage.dart';
import 'package:managedashboard/screens/leftbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainPageBar extends StatefulWidget {
  const MainPageBar({super.key});

  @override
  State<MainPageBar> createState() => _MainPageBarState();
}

class _MainPageBarState extends State<MainPageBar> {
  List<User> userList = [];
  bool showalertbox = true;

  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  List<ChartData> chartData = [];

  void fetchData() {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('expenses');
    databaseReference.once().then((DatabaseEvent snapshot) {
      userList.clear();
      chartData.clear();
      Map<dynamic, dynamic> values = snapshot.snapshot.value as dynamic;
      values.forEach((key, data) {
        userList.add(User(
            date: data['date'].toString(), amount: data['amount'].toString()));
      });
      List<String> timelist =
          List.generate(userList.length, (index) => "202$index").toList();
      chartData = userList
          .mapIndexed((e, index) => ChartData(
              int.parse(timelist[index].toString()),
              double.parse(e.amount.toString())))
          .toList();
      setState(() {}); // Refresh the UI after fetching data
    });
  }

  @override
  Widget build(BuildContext context) {
    return chartData.isEmpty
        ? Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 0, right: 5),
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    showalertbox != false
                        ? Container()
                        : const SizedBox(
                            height: 30,
                          ),
                    showalertbox != false
                        ? Container()
                        : Container(
                            height: 120,
                            width: double.infinity,
                            color: const Color(0xffFFF4F0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 27, right: 20),
                              child: Row(
                                children: [
                                  Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: themecolor)),
                                      child: Center(
                                          child: Icon(
                                        Icons.ac_unit_outlined,
                                        color: themecolor,
                                        size: 30,
                                      ))),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Start Live Trading",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1,
                                                  fontSize: 35,
                                                  color: themecolor),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Text(
                                              "Create your live trading account.",
                                              style: TextStyle(
                                                  height: 2,
                                                  letterSpacing: 0.2,
                                                  fontFamily: 'Arial',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black38),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 32, bottom: 32),
                                        child: MaterialButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const CustomAlertDialog();
                                              },
                                            ).then((value) async {
                                              fetchData();
                                            });
                                          },
                                          child: Container(
                                            color: themecolor,
                                            child: const Center(
                                              child: Text(
                                                "Start Application",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Color.fromARGB(
                                                      255, 58, 5, 2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showalertbox = false;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.cancel_presentation_outlined,
                                        color: themecolor,
                                      ))
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 57,
                          width: 350,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey[300] as Color)),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 135,
                                    child: MaterialButton(
                                      onPressed: () {},
                                      child: Container(
                                        height: 34,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffFBA27D),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            "Live",
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffE1673C),
                                                fontSize: 19),
                                          ),
                                        ),
                                      ),
                                    )),
                                const Text("277495"),
                                Expanded(child: Container()),
                                const Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 1000,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      height: 70,
                                      child: Image.asset("images/amount.png")),
                                  Icon(
                                    Icons.restart_alt,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: Text(
                                      "Balance",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 170,
                                    child: ListView.builder(
                                        padding: const EdgeInsets.all(0),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 4,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              datetitle[index],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: index == 0
                                                      ? Colors.blue
                                                      : Colors.black),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Container(
                                      child: SfCartesianChart(
                                          borderColor: Colors.white,
                                          borderWidth: 0,
                                          primaryXAxis: NumericAxis(
                                            //Hide the gridlines of x-axis
                                            majorGridLines:
                                                const MajorGridLines(width: 0),
                                            //Hide the axis line of x-axis
                                            axisLine: const AxisLine(width: 0),
                                          ),
                                          primaryYAxis: NumericAxis(
                                              //Hide the gridlines of y-axis
                                              majorGridLines:
                                                  const MajorGridLines(
                                                      width: 0),
                                              //Hide the axis line of y-axis
                                              axisLine:
                                                  const AxisLine(width: 0)),
                                          series: <ChartSeries>[
                                        // Renders spline chart
                                        SplineSeries<ChartData, int>(
                                            animationDelay: -0,
                                            dataSource: chartData,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y)
                                      ])),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              color: Colors.white,
                              child: Container(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      height: 100,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "luquidt neza",
                                                style: TextStyle(
                                                  fontFamily: "Aerial",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "\$346.42",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          )),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "G/P",
                                                style: TextStyle(
                                                    fontFamily: "Aerial",
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "\$0",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          )),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "PNL",
                                                style: TextStyle(
                                                    fontFamily: "Aerial",
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "\$0",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          )),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Margin Disponible",
                                                style: TextStyle(
                                                    fontFamily: "Aerial",
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "\$346.42",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Tus posisiones",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "simbolo",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: "Aerial",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "direction",
                                                style: TextStyle(
                                                    fontFamily: "Aerial",
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Position",
                                                style: TextStyle(
                                                    fontFamily: "Aerial",
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "G/P",
                                                style: TextStyle(
                                                    fontFamily: "Aerial",
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.grey[200],
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              height: 200,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 130,
                                                    child: Image.asset(
                                                      "images/clip.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Tus puestos abiertos aperecerian aqui",
                                                    style: TextStyle(
                                                        height: 2,
                                                        letterSpacing: 0.2,
                                                        fontFamily: 'Arial',
                                                        fontSize: 16,
                                                        color: Colors.grey[500],
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 880,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20, top: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Logros",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: ["", "", ""]
                                      .map((e) => Container(
                                            height: 250,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    550) /
                                                3.5,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 130,
                                                  child: Image.asset(
                                                      "images/lock.png"),
                                                ),
                                                Text(
                                                  "First Profit Month",
                                                  style: TextStyle(
                                                      height: 2,
                                                      letterSpacing: 0.2,
                                                      fontFamily: 'Arial',
                                                      fontSize: 16,
                                                      color: Colors.grey[500],
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "finish a month with non zero realized profit\n (including fees and collection)",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          height: 2,
                                                          letterSpacing: 0.2,
                                                          fontFamily: 'Arial',
                                                          fontSize: 11,
                                                          color:
                                                              Colors.grey[500],
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
