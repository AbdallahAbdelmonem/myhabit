import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myhabit/home_Page.dart';
import 'package:myhabit/main.dart';
import 'package:myhabit/selectedhabit.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'habitdoneData.dart';

class HabitsDone extends StatefulWidget {
  const HabitsDone({super.key});
  @override
  State<HabitsDone> createState() => _HabitsDoneState();
}

class _HabitsDoneState extends State<HabitsDone> {
  @override
  HabitsDoneData hd = HabitsDoneData();
  SelectedHabitData sh = SelectedHabitData();
  List<Map> data2 = [];
  List times = [];

  saveData() async {
    List<Map> response = await hd.getData();
    // print("res2: $response");
    setState(() {
      data2.addAll(response);
    });
    // print(hd.getData());
    // print("data: ${data2}");
    saveTime();
  }

  saveTime() {
    for (int i = 0; i < data2.length; i++) {
      if (data2[i]['time'] != "null") {
        times.add(data2[i]['time'].toString().substring(10, 15));
      } else {
        times.add("No time selected");
      }
    }
    // print("Times: $times");
  }

  @override
  void initState() {
    saveData();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 27, 38, 51),
        appBar: AppBar(
          title: Text("Habits done"),
          backgroundColor: Color.fromARGB(255, 27, 38, 51),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyWidget(index: 0),
                    ));
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
            // child: Container(
            //     width: width,
            //     height: height * 0.98,
            child: ListView.builder(
          itemCount: data2.length,
          itemBuilder: (context, index) {
            return Slidable(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      // height: height * 0.85,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          child: Row(
                            children: [
                              Image(
                                  image: AssetImage("images/habit-icon.jpg"),
                                  height: 100),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data2[index]['title']}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Container(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${times[index]}",
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Done",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ],
                                  ),
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
                    ),
                  ],
                ),
                endActionPane: ActionPane(motion: DrawerMotion(), children: [
                  SlidableAction(
                    onPressed: (context) => {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: "Removed",
                        text: 'habit has been removed',
                      ),
                      // print("id: ${data2[index]['id']}"),
                      hd.deleteDate(data2[index]['id']),
                      data2.clear(),
                      times.clear(),

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
                          type: QuickAlertType.loading,
                          title: "Undo",
                          text: "Undo"),
                      // print("id: ${data2[index]['id']}"),
                      hd.deleteDate(data2[index]['id']),
                      sh.setData(data2[index]['title'], data2[index]['time']),
                      data2.clear(),
                      times.clear(),
                      saveData(),
                    },
                    borderRadius: BorderRadius.circular(20),
                    backgroundColor: Colors.blue,
                    flex: 1,
                    icon: Icons.undo,
                    label: "Undo",
                  ),
                ]));
          },
          //       )),
          // )
        )));
  }
}
