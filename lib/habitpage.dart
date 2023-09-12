import 'package:flutter/material.dart';
import 'package:myhabit/addTime.dart';
import 'package:myhabit/addnew.dart';
import 'package:myhabit/habits_classes/diet.dart';
import 'package:myhabit/habits_classes/islamic.dart';
import 'package:myhabit/habits_classes/personal.dart';
import 'package:myhabit/habits_classes/simple.dart';
import 'package:myhabit/main.dart';

class HabitPage extends StatefulWidget {
  HabitPage(
      {super.key, required this.index, required this.title, required this.img});
  final int index;
  final String title;
  final String img;

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  List<Map> data = [];
  // SelectedHabitData sh = SelectedHabitData();
  saveData() async {
    if (widget.title == 'Simple') {
      SimpleData s = SimpleData();
      s.setData();
      s.deleteDate();
      List<Map> response = await s.getData();
      setState(() {
        data.addAll(response);
      });
    } else if (widget.title == 'Islamic') {
      IslamicData s = IslamicData();
      s.setData();
      s.deleteDate();
      List<Map> response = await s.getData();
      setState(() {
        data.addAll(response);
      });
    } else if (widget.title == 'Personal development') {
      PersonalData s = PersonalData();
      s.setData();
      s.deleteDate();
      List<Map> response = await s.getData();
      setState(() {
        data.addAll(response);
      });
    } else if (widget.title == 'Diet') {
      DietData s = DietData();
      s.setData();
      s.deleteDate();
      List<Map> response = await s.getData();
      setState(() {
        data.addAll(response);
      });
    }

    // print("dd ${data}");
  }

  @override
  void initState() {
    saveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 27, 38, 51),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 27, 38, 51),
          centerTitle: true,
          title: Text("${widget.title} Habit",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyWidget(index: 1),
                    ));
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView(
          children: [
            SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      width: 255,
                      // height: 155,
                      height: height * .20,
                      child: Image.asset(
                        "${widget.img}",
                      ),
                    ),
                    //   ],
                    // ),
                    Text(
                      "Sustained effort is what makes the real difference",
                      style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      height: height * 0.63,
                      // color: Colors.red,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              // setState(() {
                              //   sh.setData("${data[index]['title']}");
                              // });
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => MyWidget(),
                              //     ));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Add_time(
                                        id: data[index]['id'],
                                        title: "${data[index]['title']}",
                                        page: "HabitPage"),
                                  ));
                            },
                            title: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 45),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 42, 53, 65),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Icon(
                                          Icons.bolt,
                                          color: Colors.yellow,
                                        ),
                                        Text(
                                          "${data[index]['title']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
