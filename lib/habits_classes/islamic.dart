import 'package:myhabit/sqflite.dart';

class IslamicData {
  sqflDB db = sqflDB();

  getData() async {
    List<Map> response = await db.select("SELECT * FROM islamic");
    print("res: $response");

    return response;
  }

  setData() async {
    int response = await db.insert(
        "INSERT INTO islamic (title) VALUES ('Morning azkar') ");        
        await db.insert(
        "INSERT INTO islamic (title) VALUES ('Evining azkar') ");
        await db.insert(
        "INSERT INTO islamic (title) VALUES ('Prayer') ");
    print("$response");
  }

  updateData() async {
    // int response =
    //     await db.update("UPDATE habits SET title='Simple' WHERE id=26 ");
    await db.update(
        "UPDATE islamic SET title='Islamic', img='images/islamic.jpg' WHERE id=27 ");
    await db.update(
        "UPDATE islamic SET title='personal development', img='images/develop.jpg' WHERE id=28 ");
    await db.update(
        "UPDATE islamic SET title='Diet', img='images/diet.jpg' WHERE id=29 ");
    // print("$response");
  }

  deleteDate() async {
    await db.delete("DELETE FROM islamic WHERE id=4");
    await db.delete("DELETE FROM islamic WHERE id=5");
    await db.delete("DELETE FROM islamic WHERE id=6");

    // await db.delete("DELETE FROM habits WHERE id=15");
    // await db.delete("DELETE FROM habits WHERE id=16");
  }
}
