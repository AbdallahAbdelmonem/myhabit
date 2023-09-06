import 'package:myhabit/sqflite.dart';

class HabitsDoneData {
  sqflDB db = sqflDB();

  getData() async {
    List<Map> response = await db.select("SELECT * FROM habitdone");
    // print("res: $response");

    return response;
  }

  setData(String title, String time) async {
    int response = await db.insert(
        "INSERT INTO habitdone (title,time) VALUES ('${title}','${time}') ");
    // print("$response");
  }

  updateData(String time, int id) async {
    int response =
        await db.update("UPDATE habitdone SET time='$time' WHERE id='$id' ");

    // print("$response");
  }

  deleteDate(int id) async {
    await db.delete("DELETE FROM habitdone WHERE id='$id'");
  }
}
