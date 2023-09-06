import 'package:myhabit/sqflite.dart';

class SimpleData {
  sqflDB db = sqflDB();

  getData() async {
    List<Map> response = await db.select("SELECT * FROM simple");
    // print("res: $response");

    return response;
  }

  setData() async {
    int response = await db.insert(
        "INSERT INTO simple (title) VALUES ('Wake up early') ");        
        await db.insert(
        "INSERT INTO simple (title) VALUES ('Drink water') ");
        await db.insert(
        "INSERT INTO simple (title) VALUES ('Walk') ");
        await db.insert(
        "INSERT INTO simple (title) VALUES ('Reading') ");
        await db.insert(
        "INSERT INTO simple (title) VALUES ('Workout') ");
    // print("$response");
  }

  updateData() async {
    // int response =
    //     await db.update("UPDATE habits SET title='Simple' WHERE id=26 ");
    await db.update(
        "UPDATE simple SET title='Islamic', img='images/islamic.jpg' WHERE id=27 ");
    await db.update(
        "UPDATE simple SET title='personal development', img='images/develop.jpg' WHERE id=28 ");
    await db.update(
        "UPDATE simple SET title='Diet', img='images/diet.jpg' WHERE id=29 ");
    // print("$response");
  }

  deleteDate() async {
    await db.delete("DELETE FROM simple WHERE id>5");
    // await db.delete("DELETE FROM simple WHERE id=12");
    // await db.delete("DELETE FROM simple WHERE id=13");
    // await db.delete("DELETE FROM simple WHERE id=14");
    // await db.delete("DELETE FROM simple WHERE id=15");

    // await db.delete("DELETE FROM habits WHERE id=15");
    // await db.delete("DELETE FROM habits WHERE id=16");
  }
}
