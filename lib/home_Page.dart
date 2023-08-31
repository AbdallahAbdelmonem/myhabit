import 'package:flutter/material.dart';
import 'package:myhabit/addTime.dart';
import 'package:myhabit/selectedhabit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quickalert/quickalert.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  Widget? page;
  SelectedHabitData sh = SelectedHabitData();
  List<Map> data2 = [];

  saveData() async {
    List<Map> response = await sh.getData();
    print("res2: $response");
    setState(() {
      data2.addAll(response);
    });
    print(sh.getData());
    print("data: ${data2}");
  }

  // savePref() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("save", "HELLO");
  //   print("--------------Success--------");
  // }

  @override
  void initState() {
    saveData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color.fromARGB(255, 27, 38, 51),
          body: Container(
            width: width,
            height: height,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  width: width,
                  height: height * 0.98,
                  // color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(top: 20),
                        width: double.infinity,
                        height: height * 0.85,
                        // color: Colors.red,
                        child: ListView.builder(
                          itemCount: data2.length,
                          itemBuilder: (context, index) {
                            return Slidable(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "images/habit-icon.jpg"),
                                          height: 100),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${data2[index]['title']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          Container(height: 10),
                                          Text(
                                            "Go for it",
                                            style: TextStyle(
                                                color: Colors.blueGrey),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 42, 53, 65),
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 120,
                                ),
                              ),
                              endActionPane:
                                  ActionPane(motion: DrawerMotion(), children: [
                                SlidableAction(
                                  onPressed: (context) => {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: "Removed",
                                      text: 'habit has been removed',
                                    ),
                                    print("id: ${data2[index]['id']}"),
                                    sh.deleteDate(data2[index]['id']),
                                    data2.clear(),
                                    saveData(),
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  backgroundColor: Colors.red,
                                  flex: 1,
                                  icon: Icons.delete,
                                  label: "Delete",
                                ),
                                SlidableAction(
                                  onPressed: (context) => {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      title: "congratulations!",
                                      text:
                                          'Sustained effort is what makes the real difference',
                                    ),
                                    print("id: ${data2[index]['id']}"),
                                    sh.deleteDate(data2[index]['id']),
                                    data2.clear(),
                                    saveData(),
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  icon: Icons.check_circle,
                                  backgroundColor: Colors.green,
                                  label: "Done",
                                ),
                              ]),
                              startActionPane:
                                  ActionPane(motion: DrawerMotion(), children: [
                                SlidableAction(
                                  onPressed: (context) => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Add_time(
                                            id: data2[index]['id'],
                                            title: "${data2[index]['title']}",
                                            page: "HomePage",
                                          ),
                                        )),
                                    print("id: ${data2[index]['id']}"),
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  backgroundColor: Colors.blue,
                                  flex: 1,
                                  icon: Icons.update,
                                  label: "Update",
                                ),
                              ]),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
