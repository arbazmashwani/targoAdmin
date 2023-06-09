import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:managedashboard/screens/homepage.dart';

class Leftbarpage extends StatefulWidget {
  const Leftbarpage({super.key});

  @override
  State<Leftbarpage> createState() => _LeftbarpageState();
}

class _LeftbarpageState extends State<Leftbarpage> {
  List<bool> boollist = List.generate(5, (index) => false);
  @override
  void initState() {
    boollist[0] = true;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.black12)),
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.network(
                  "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA1NzAuMiA3MiIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNTcwLjIgNzIiIHhtbDpzcGFjZT0icHJlc2VydmUiPjxwYXRoIGZpbGw9IiNGRjQyMDAiIGQ9Ik02Ny4yIDBINzl2NTQuOUg2Ny4yVjB6TTEzNCA0Mi4zIDExMi4zIDBIOTUuN3Y1NC45aDExLjhWMTIuNmwyMS44IDQyLjNoMTYuNVYwSDEzNHY0Mi4zem0tOTUuNyAwTDE2LjUgMEgwdjU0LjloMTEuOFYxMi42bDIxLjggNDIuM2gxNi41VjBIMzguM3Y0Mi4zek0xNjAuNiA3MmwxMi4yLTdWMGgtMTIuMnY3MnptNDIuMy03MmgxNC44bDIwLjQgNTQuOWgtMTIuNUwyMTggMzQuNGwtNS41IDkuNWgtMTMuOUwxOTQuNCA1NWgtMTIuNWwyMS01NXptMTUgMzMuOC03LjctMjEuNC03LjggMjEuNGgxNS41ek0zNjYuNyAwaDE0LjhsMjAuNCA1NC45aC0xMi41bC03LjctMjAuNi01LjUgOS41aC0xMy45bC00LjIgMTEuMWgtMTIuNUwzNjYuNyAwem0xNSAzMy44TDM3NCAxMi40bC03LjggMjEuNGgxNS41ek0yMzcuNSAwdjEwaDE2Ljl2NDQuOWgxMS44VjEwSDI4M1YwaC00NS41em0yMjYuNiAyNy40YzAgMTUuNy0xMy4xIDI3LjUtMzIgMjcuNUg0MTBWMGgyMi4xYzE4LjkgMCAzMiAxMS43IDMyIDI3LjR6bS0xMiAwYzAtMTAuNC03LjctMTcuMy0yMC0xNy4zaC0xMC4zdjM0LjhoMTAuM2MxMi4zIDAgMjAtNy4yIDIwLTE3LjV6bTMzLjIgMTcuNVYzMS42aDI1LjZ2LTkuOWgtMjUuNlYxMGgyNi44VjBoLTM4LjZ2NTQuOWgzOS4xdi0xMGgtMjcuM3ptNTguMS0xMC41aC01LjNWNTVoLTExLjhWMGgyNC4yYzEzLjMgMCAxOS40IDcuMyAxOS40IDE3LjEgMCA4LjItNS40IDE0LjItMTQuMiAxNi40bDE0LjUgMjEuNGgtMTMuNmwtMTMuMi0yMC41em0tNS4zLTkuM2gxMS4zYzUgMCA4LjctMy41IDguNy04LjFzLTMuNy03LjctOC43LTcuN2gtMTEuM3YxNS44em0tMjI3LjIgOS4zaC01LjNWNTVoLTExLjhWMEgzMThjMTMuMyAwIDE5LjQgNy4zIDE5LjQgMTcuMSAwIDguMi01LjQgMTQuMi0xNC4yIDE2LjRsMTQuNSAyMS40aC0xMy42bC0xMy4yLTIwLjV6bS01LjMtOS4zaDExLjNjNSAwIDguNy0zLjUgOC43LTguMXMtMy43LTcuNy04LjctNy43aC0xMS4zdjE1Ljh6Ii8+PC9zdmc+"),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 20),
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                    itemCount: admindatetitle.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {},
                          onHover: (ishovering) {
                            setState(() {
                              boollist[index] = ishovering;
                            });
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: admindatetitleicon[index]),
                              // Icon(
                              //   admindatetitleicon[index],
                              //   color: boollist[index] == true
                              //       ? Colors.blue
                              //       : Colors.black,
                              //   size: 30,
                              // ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                admindatetitle[index],
                                style: TextStyle(
                                    height: 2,
                                    letterSpacing: 0.2,
                                    fontFamily: 'Arial',
                                    fontSize: 16,
                                    color: boollist[index] == true
                                        ? Colors.blue
                                        : const Color(0xff000000),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                color: Colors.grey.withOpacity(0.20),
                height: 180,
                child: Column(
                  children: [
                    const Text(
                      "NINJATRADER",
                      style: TextStyle(
                          color: Color(0xffFF703B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 16),
                      child: Text(
                        "Download our award-winning desktop platform for free.",
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            color: Color.fromARGB(255, 58, 5, 2),
                            fontSize: 15,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 18),
                      child: MaterialButton(
                        onPressed: () {},
                        child: Container(
                          height: 35,
                          color: const Color(0xffFF4200),
                          child: const Center(
                            child: Text(
                              "Download",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Color.fromARGB(255, 58, 5, 2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 8),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Collapse Slidebar",
                    style: TextStyle(
                        letterSpacing: 1, color: Colors.blue, fontSize: 16),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

Color themecolor = const Color(0xffFF4200);
