import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myhabit/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => MyWidget()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 38, 51),
      body: Center(
        child: Image.asset("images/habits.jpg"),
      ),
    );
  }
}
