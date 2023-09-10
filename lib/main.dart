import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myhabit/addnew.dart';
import 'package:myhabit/habitdoneData.dart';
import 'package:myhabit/habits_classes/diet.dart';
import 'package:myhabit/habits_classes/islamic.dart';
import 'package:myhabit/habits_classes/personal.dart';
import 'package:myhabit/habits_classes/simple.dart';
import 'package:myhabit/home_Page.dart';
import 'package:myhabit/notify.dart';
import 'package:myhabit/ratingpage.dart';
import 'package:myhabit/selectedhabit.dart';
import 'package:myhabit/splashScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appdata.dart';
import 'backServices.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) async {
    if (value) {
      Permission.notification.request();
      localnotification().initlize();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('autoStart', false);
    }
  });

  await initializeService();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        "Main": (context) => MyWidget(),
        "homePage": (context) => Home_page(),
        "addnew": (context) => AddNew(),
      },
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int selectedIndex = 0;
  List<Widget> wig = [Home_page(), AddNew(), MyRating()];
  @override
  SelectedHabitData sh = SelectedHabitData();
  HabitsDoneData hd = HabitsDoneData();
  AppData ad = AppData();
  SimpleData s = SimpleData();
  PersonalData p = PersonalData();
  DietData d = DietData();
  IslamicData i = IslamicData();
  saveData() async {
    await ad.setData();
    await ad.deleteDate();
    await ad.getData();

    await s.setData();
    await s.deleteDate();
    await s.getData();

    await i.setData();
    await i.deleteDate();
    await i.getData();

    await p.setData();
    await p.deleteDate();
    await p.getData();

    await d.setData();
    await d.deleteDate();
    await d.getData();

    await sh.getData();
    await hd.getData();
  }

  @override
  void initState() {
    initAutoStart();
    saveData();
    super.initState();
  }

  initAutoStart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('autoStart') == false) {
      getAutoStartPermission();
      await prefs.setBool('autoStart', true);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 27, 38, 51),
        color: Color.fromARGB(255, 42, 53, 65),
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.add,
            color: Colors.white,
          ),
          Icon(
            Icons.star,
            color: Colors.white,
          ),
        ],
      ),
      body: wig.elementAt(selectedIndex),
    );
  }
}
