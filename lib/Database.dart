
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Mydatabase {
  Future<Database> createdatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'create table my_data (id integer primary key autoincrement,Name text,Number Text,Email Text,Password Text)');

      await db.execute(
          'create table my_data2 (id integer primary key autoincrement,User text,Name text,Number text)');
    });

    return database;
  }

  Future<bool> insertdata(String name, String pass, String email, String number,
      Database database) async {
    String select =
        "select * from my_data where Email = '$email' or Name =  '$name'";

    List<Map> listt = await database.rawQuery(select);

    if (listt.length > 0) {
      return false;
    } else {
      String insertqry =
          "insert into my_data  (Name,Number,Email,Password)  values ('$name','$number','$email','$pass')";

      int aa = await database.rawInsert(insertqry);

      return true;
    }
  }

  Future<List<Map>> logindata(
      String email, String pass, Database database) async {
    String select =
        "select * from my_data where Email = '$email' and Password = '$pass'";

    List<Map> lisssst = await database.rawQuery(select);

    print("listtttt====${lisssst}");

    return lisssst;
  }

  Future<int> insertcontactdata(
      String name, String number, String user, Database database) async {
    String insertqry =
        "insert into my_data2 (User,Name,Number) values ('$user','$name','$number')";

    int aa = await database.rawInsert(insertqry);

    print("user==============${user}");

    print(aa);

    return aa;
  }

  Future<List<Map>> selectcontact(String value, Database database) async {

    String select = "select * from my_data2 where User = '$value'";

    List<Map> mydata = await database.rawQuery(select);

    return mydata;


  }

  Future<void> updateContact(String name, String number, int id, Database database) async {
    String sql = "UPDATE my_data2 SET Name = '$name', Number = '$number' WHERE id = '$id'";
    await database.rawUpdate(sql);
  }

  Future<void> deleteContact(int id, Database database) async {
    String sql = "DELETE FROM my_data2 WHERE id = '$id'";
    await database.rawDelete(sql);
  }
}

//create====== 'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)'

//SELECT =======  "select * from Userdata where Email = '$email' or Name = '$name'";

//INSERT =======   "insert into my_data  (Name,Number,Email,Password)  values ('$name','$number','$email','$pass')";
