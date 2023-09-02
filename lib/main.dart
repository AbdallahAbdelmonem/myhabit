import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myhabit/addnew.dart';
import 'package:myhabit/home_Page.dart';
import 'package:myhabit/notify.dart';
import 'package:myhabit/ratingpage.dart';
import 'package:myhabit/splashScreen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'backServices.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
      localnotification().initlize();
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
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 27, 38, 51),
        color: Color.fromARGB(255, 42, 53, 65),
        animationDuration: Duration(milliseconds: 300),
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
