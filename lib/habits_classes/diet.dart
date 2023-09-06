import 'package:myhabit/sqflite.dart';

class DietData {
  sqflDB db = sqflDB();

  getData() async {
    List<Map> response = await db.select("SELECT * FROM diet");
    // print("res: $response");

    return response;
  }

  setData() async {
    int response = await db.insert(
        "INSERT INTO diet (title) VALUES ('Walking') ");        
        await db.insert(
        "INSERT INTO diet (title) VALUES ('Eat fruits') ");
        await db.insert(
        "INSERT INTO diet (title) VALUES ('No junk food') ");
    // print("$response");
  }

  updateData() async {
    // int response =
    //     await db.update("UPDATE habits SET title='Simple' WHERE id=26 ");
    await db.update(
        "UPDATE diet SET title='Islamic', img='images/islamic.jpg' WHERE id=27 ");
    await db.update(
        "UPDATE diet SET title='personal development', img='images/develop.jpg' WHERE id=28 ");
    await db.update(
        "UPDATE diet SET title='Diet', img='images/diet.jpg' WHERE id=29 ");
    // print("$response");
  }

  deleteDate() async {
    await db.delete("DELETE FROM diet WHERE id>3");

    // await db.delete("DELETE FROM habits WHERE id=15");
    // await db.delete("DELETE FROM habits WHERE id=16");
  }
}
