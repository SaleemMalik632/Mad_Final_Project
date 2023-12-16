import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbManager {
  Database? _database = null;

  Future openDb() async {
    _database = await openDatabase(
        join(await getDatabasesPath(), "sqliteExample.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE Product (id INTEGER PRIMARY KEY autoincrement, ProductName TEXT, Price TEXT, Description TEXT, Image TEXT)",
      );
    });
    return _database;
  } // openDb

  Future<int?> insertData(Model model) async {
    await openDb();
    int? a = await _database?.insert('Product', model.toJson());
    return a;
  }
} 


class Model {
  int? id;
  String? ProdectName;
  String? Description;
  String? Price;
  String? Image;

  Model({this.id, this.ProdectName, this.Description, this.Price, this.Image});
  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ProdectName = json['ProdectName'];
    Description = json['Description'];
    Price = json['Price'];
    Image = json['Image'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ProdectName': ProdectName,
      'Description': Description,
      'Price': Price,
      'Image': Image
    };
  }
}
