import 'dart:io';
import 'package:sest_senat/model/car.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  void criaTabela(db) async{
    await db.execute('''CREATE TABLE IF NOT EXISTS Car(
          id INTEGER PRIMARY KEY,
          model TEXT,
          brand TEXT,
          year INTEGER,
          price INTEGER,
          photo TEXT);''');

    await db.execute('''CREATE TABLE IF NOT EXISTS Carbkp(
          id INTEGER PRIMARY KEY,
          model TEXT,
          brand TEXT,
          year INTEGER,
          price INTEGER,
          photo TEXT);''');

  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'car_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          criaTabela(db);
        });
  }

  createCar(Car newCar) async {
    await deleteAllCars();
    final db = await database;
    print ("Inserido dados na tabela Car");
    final res = await db.insert('Car', newCar.toJson());
    return res;
  }

  createCarbkp(Car newCar) async {
    final db = await database;
    print ("Inserido dados na tabela Car");
    final res = await db.insert('Carbkp', newCar.toJson());
    return res;
  }

  Future<int> deleteAllCars() async {
    final db = await database;
    await db.rawDelete('DELETE FROM Carbkp');
    final res = await db.rawDelete('DELETE FROM Car');
    // dropTable();
    return res;
  }

  Future<int> updateCar(String updateCar, int id) async {
    final db = await database;
    final res = await db.rawUpdate('UPDATE Carbkp SET brand = ? WHERE id = ?',['${updateCar}',id]);
    return res;
  }

  Future<List<Car>> getAllCars() async {
    final db = await database;
    criaTabela(db);
    print ('Listando Dados da tabela Carbpk');
    final res = await db.rawQuery("SELECT * FROM Carbkp");
    List<Car> list =
        res.isNotEmpty ? res.map((c) => Car.fromJson(c)).toList() : [];

    return list;
  }

  Future<int> dropTable() async{
    print ('Deletando tabelas');
    final db = await database;
    await db.rawQuery("DROP TABLE IF EXISTS Car");
    await db.rawQuery("DROP TABLE IF EXISTS Carbkp");
  }

  Future<int> copyTable() async{
    final db = await database;
    final res = await db.rawInsert('INSERT INTO Carbkp SELECT * FROM Car;');
    print ("Copiando tabela Car para Carbkp");
    return res;
  }
}
