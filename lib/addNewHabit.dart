import 'package:flutter/material.dart';
import 'package:myhabit/selectedhabit.dart';

import 'backServices.dart';
import 'main.dart';
import 'notify.dart';

class AddNewHabit extends StatefulWidget {
  const AddNewHabit({super.key});
// final int id;
//   final String title;
//   final String page;
  @override
  State<AddNewHabit> createState() => _AddNewHabit();
}

class _AddNewHabit extends State<AddNewHabit> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  String? tim1;
  TextEditingController txt = TextEditingController();

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
      body: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: txt,
                  style: TextStyle(
                    height: 2,
                  ),
                  decoration: InputDecoration(
                      hintText: 'habit name',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: 242,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.cyanAccent),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(_timeOfDay.format(context).toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, left: 70),
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
              Navigator.pop(context);
            },
            child: Text("Cancel",
                style: TextStyle(
                  color: Colors.white,
                )),
            color: Color.fromARGB(255, 38, 38, 39),
          ),
          SizedBox(
            width: 100,
          ),
          MaterialButton(
            onPressed: () async {
              //page
              setState(() {
                if (tim1 != null) {
                  sh.setData("${txt.text}", "${tim1}");
                  
                }
                else{
                  sh.setData("${txt.text}", "${_timeOfDay.toString()}");

                }
                sh.getData();
              });

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyWidget(),
                  ));

              await initializeService();
            },
            child: Text("Save",
                style: TextStyle(
                  color: Colors.white,
                )),
            color: Color.fromARGB(255, 38, 38, 39),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 42, 53, 65),
        title: Text(" Create New Habit ",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            )),
      ),
    );
  }
}
