import 'package:myhabit/sqflite.dart';

class PersonalData {
  sqflDB db = sqflDB();

  getData() async {
    List<Map> response = await db.select("SELECT * FROM personal");
    print("res: $response");

    return response;
  }

  setData() async {
    int response = await db.insert(
        "INSERT INTO personal (title) VALUES ('Reading') ");        
        await db.insert(
        "INSERT INTO personal (title) VALUES ('Learning') ");
        await db.insert(
        "INSERT INTO personal (title) VALUES ('Journaling') ");
    print("$response");
  }

  updateData() async {
    // int response =
    //     await db.update("UPDATE habits SET title='Simple' WHERE id=26 ");
    await db.update(
        "UPDATE personal SET title='Islamic', img='images/islamic.jpg' WHERE id=27 ");
    await db.update(
        "UPDATE personal SET title='personal development', img='images/develop.jpg' WHERE id=28 ");
    await db.update(
        "UPDATE personal SET title='Diet', img='images/diet.jpg' WHERE id=29 ");
    // print("$response");
  }

  deleteDate() async {
    await db.delete("DELETE FROM personal WHERE id>3");

    // await db.delete("DELETE FROM habits WHERE id=15");
    // await db.delete("DELETE FROM habits WHERE id=16");
  }
}
