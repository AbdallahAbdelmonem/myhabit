import 'package:myhabit/sqflite.dart';

class SelectedHabitData {
  sqflDB db = sqflDB();

  getData() async {
    List<Map> response = await db.select("SELECT * FROM selecthabit");
    print("res: $response");

    return response;
  }

  setData(String title, String time) async {
    int response = await db.insert(
        "INSERT INTO selecthabit (title,time) VALUES ('${title}','${time}') ");
    print("$response");
  }

  updateData(String time, int id) async {
    int response =
        await db.update("UPDATE selecthabit SET time='$time' WHERE id='$id' ");

    print("$response");
  }

  deleteDate(int id) async {
    await db.delete("DELETE FROM selecthabit WHERE id='$id'");
  }
}
