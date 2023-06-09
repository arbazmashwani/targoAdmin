import 'package:flutter/material.dart';

class rightbar extends StatelessWidget {
  const rightbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 40, left: 10),
      child: Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: 290,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Recent Streaming",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzN19k8LKM78LFAaNJAAW8VD6yaqcUwlAT7g&usqp=CAU",
                        fit: BoxFit.fill,
                      ),
                    )),
                    SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Disclaimer",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.blue),
                                    )),
                                const Icon(
                                  Icons.arrow_drop_up,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height:
                              MediaQuery.of(context).size.height / 2.5 + 100,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12)),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            size: 70,
                                            color: Colors.blue,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Upcoming Events",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 35),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const ListTile(
                                      title: Text(
                                        "June 13",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Equity Index Roll date (index)",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  decorationColor: Colors.blue,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.blue),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const ListTile(
                                      title: Text(
                                        "June  14",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            "FOMC Meeting",
                                            style: TextStyle(
                                                decorationColor: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.blue),
                                          )
                                        ],
                                      ),
                                    ),
                                    const ListTile(
                                      title: Text(
                                        "June  15",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Currency Future Rolls Date (Jun)",
                                              style: TextStyle(
                                                  decorationColor: Colors.blue,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.blue),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.blue.withOpacity(0.20),
                                            border:
                                                Border.all(color: Colors.blue)),
                                        height: 50,
                                        width: double.infinity,
                                        child: const Center(
                                          child: Text(
                                            "Var todio",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
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
}
