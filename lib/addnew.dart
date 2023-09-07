import 'package:flutter/material.dart';
import 'package:myhabit/sqflite.dart';

import 'addNewHabit.dart';
import 'appdata.dart';
import 'habitpage.dart';
import 'habits_classes/simple.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key});
  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  sqflDB db = sqflDB();
  AppData ad = AppData();
  SimpleData s = SimpleData();
  List<Map> data = [];
  saveData() async {
    List<Map> response = await db.select("SELECT * FROM habits");
    // print("res: $response");
    setState(() {
      data.addAll(response);
    });
    // print("data: ${data}");
  }

  @override
  void initState() {
    ad.setData();
    ad.deleteDate();
    s.getData();

    saveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 27, 38, 51),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 27, 38, 51),
          title: Text(
            "New Habit",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewHabit(),
                      ));
                },
                icon: Icon(Icons.add_box_rounded)),
          ],
          centerTitle: true,
        ),
        body: Container(
          height: height * 0.90,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HabitPage(
                            index: index,
                            title: data[index]['title'],
                            img: data[index]['img']),
                      ));
                },
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 350,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromARGB(255, 42, 53, 65),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 135,
                            child: Text(
                              data[index]['title'],
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Image.asset(
                          "${data[index]['img']}",
                          // height: 450,
                        ),
                      ],
                      // )
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
