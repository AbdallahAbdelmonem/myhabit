import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class MyRating extends StatefulWidget {
  const MyRating({super.key});

  @override
  State<MyRating> createState() => _MyRatingState();
}

class _MyRatingState extends State<MyRating> {
  List<String> ratingData = [
    "Simply presenting data.",
    "Clear,organized content.",
    "User-friendly.",
    "Consistent colors and design standards."
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 38, 51),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 27, 38, 51),
        centerTitle: true,
        title: Text("Rating Our App",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
                width: 400,
                height: 550,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: ratingData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${index + 1}.${ratingData[index]}",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: RatingBar.builder(
                              initialRating: 0,
                              minRating: .5,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              glowColor: Colors.white,
                              unratedColor: Colors.white,
                              itemBuilder: (context, index) {
                                return Icon(Icons.star, color: Colors.yellow);
                              },
                              onRatingUpdate: (rating) {
                                // print("rating");
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Divider(
                            height: 25,
                            thickness: 2,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      // color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        maxLines: 6,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: "Enter Your Comment",
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                    ),
                    Container(
                      child: MaterialButton(
                        onPressed: () {
                          QuickAlert.show(
                            context: context,
                            title: "🥰",
                            type: QuickAlertType.success,
                            text: 'Thank You For Your interest',
                            // autoCloseDuration: const Duration(seconds: 2),
                            confirmBtnTextStyle: TextStyle(color: Colors.white),
                            // onConfirmBtnTap: () => Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MyWidget())),
                            onConfirmBtnTap: () =>
                                Navigator.pushNamed(context, "Main"),
                            customAsset: "images/giphy.gif",
                          );
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
