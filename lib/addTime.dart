import 'package:flutter/material.dart';
import 'package:myhabit/habitdoneData.dart';
import 'package:myhabit/habitpage.dart';
import 'package:myhabit/habitsdone.dart';
import 'package:myhabit/home_Page.dart';
import 'package:myhabit/main.dart';
import 'package:myhabit/notify.dart';
import 'package:myhabit/selectedhabit.dart';

import 'backServices.dart';

class Add_time extends StatefulWidget {
  Add_time(
      {super.key, required this.title, required this.page, required this.id});
  final int id;
  final String title;
  final String page;

  @override
  State<Add_time> createState() => _Add_timeState();
}

class _Add_timeState extends State<Add_time> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  String? tim1;

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
        tim1 = _timeOfDay.toString();
      });
    });
  }

  SelectedHabitData sh = SelectedHabitData();
  HabitsDoneData hd = HabitsDoneData();

  late final localnotification service;

  @override
  void initState() {
    service = localnotification();
    service.initlize();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 38, 51),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 290,
                    height: 200,
                    child: Image.asset("images/clock.jpg", fit: BoxFit.fill),
                    // child: Image.asset("images/man.gif", fit: BoxFit.fill),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      width: 250,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.cyanAccent,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(_timeOfDay.format(context).toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5, left: 40),
                            child: IconButton(
                              onPressed: () {
                                _showTimePicker();
                              },
                              icon: Icon(Icons.access_time, size: 40),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                //page
                // print("object");
                // Navigator.pop(context);
                if (widget.page == "HabitPage") {
                  Navigator.pop(context);
                } else if (widget.page == "HomePage") {
                  // print("Updated ${widget.id}");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWidget(),
                      ));
                }
              },
              child: Text(
                "Cancle",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              color: Color.fromARGB(255, 38, 38, 39),
            ),
            SizedBox(
              width: 80,
            ),
            MaterialButton(
              onPressed: () async {
                //page
                // check();
                // print("object");
                if (widget.page == "HabitPage") {
                  setState(() {
                    print("tim1: $tim1");
                    if (tim1 != null) {
                      sh.setData("${widget.title}", "${tim1}");
                    } else {
                      sh.setData("${widget.title}", "${_timeOfDay.toString()}");
                    }
                    sh.getData();
                  });
      
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWidget(),
                      ));
                } else if (widget.page == "HomePage") {
                  if (tim1 != null) {
                    sh.updateData("${tim1}", widget.id);
                    hd.updateData("${tim1}", widget.id);
                  } else {
                    sh.updateData("${_timeOfDay.toString()}", widget.id);
                    hd.updateData("${_timeOfDay.toString()}", widget.id);
                  }
                  // print("Updated ${widget.id}");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWidget(),
                      ));
                }
      
                await initializeService();
                // print("Notify");
                // await service.showNotification(
                //     id: 1, title: "HIIIIIIIII", body: "55555555555", second: 1);
                // FlutterBackgroundService().invoke('setAsForeground');
              },
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Color.fromARGB(255, 38, 38, 39),
            ),
          ],
          backgroundColor: Color.fromARGB(255, 42, 53, 65),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Text("Chosse Time",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
