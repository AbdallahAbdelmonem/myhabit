import 'package:myhabit/sqflite.dart';

class AppData {
  sqflDB db = sqflDB();

   getData() async {
    List<Map> response = await db.select("SELECT * FROM habits");
    // print("res: $response");

    return response;
  }
  setData() async {

    int response = await db.insert(
        "INSERT INTO habits (title,img) VALUES ('Simple','images/png 3.png') ");

    await db.insert(
        "INSERT INTO habits (title,img) VALUES ('Islamic','images/png 4.png') ");
    await db.insert(
        "INSERT INTO habits (title,img) VALUES ('Personal development','images/png 2.png') ");
    await db.insert(
        "INSERT INTO habits (title,img) VALUES ('Diet','images/png 1.png') ");

    // print("$response");
  }

  updateData() async {
    // int response =
    //     await db.update("UPDATE habits SET title='Simple' WHERE id=26 ");
    await db.update(
        "UPDATE habits SET title='Islamic', img='images/islamic.jpg' WHERE id=27 ");
    await db.update(
        "UPDATE habits SET title='personal development', img='images/develop.jpg' WHERE id=28 ");
    await db.update(
        "UPDATE habits SET title='Diet', img='images/diet.jpg' WHERE id=29 ");
    // print("$response");
  }

  deleteDate() async {

    await db.delete("DELETE FROM habits WHERE id>4");
  }
}
