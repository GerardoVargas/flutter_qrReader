import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qr_reader/src/models/scan_model.dart';
export 'package:qr_reader/src/models/scan_model.dart'; //opcional

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if( _database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async{
    // Path donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    //Crear BD
    return await openDatabase(
      path,
      version: 1, //si hacemos cambios estructurales debemos incrementar la version
      onOpen: (db) {},
      onCreate: ( Database db, int version) async {

        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          );
        ''');
      }
    );
  }
  
  //manera comun de hacer query
  Future<int> nuevoScanRaw( ScanModel nuevoScan) async {
    
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    //verificar la db
    final db = await database;
    
    
    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
        VALUES( $id, '$tipo, '$valor')
    '''); 

    return res;
  }

  //manera "sencilla" de Fernando
  Future<int> nuevoScan(ScanModel nuevoScan) async {

    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    print('res >>> $res');

    // Este res es el ID del ultimo registro insertado
    return res;
  }

  Future<ScanModel?> getScanById(int id) async{
    
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty
            ? ScanModel.fromJson(res.first)
            : null;

  }

  Future<List<ScanModel?>> getAllScans() async {
    
    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty 
            ? res.map((scan) => ScanModel.fromJson(scan)).toList() 
            : [];
    
    return list;

  }

   Future<List<ScanModel?>> getScansByType(String type) async {
    
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$type'    
    ''');

    List<ScanModel> list = res.isNotEmpty 
            ? res.map((e) => ScanModel.fromJson(e)).toList() 
            : [];
    
    return list;

  }

  Future<int> updateScan( ScanModel newScan ) async {
    final db = await database;
    final res = await db.update('Scans', newScan.toJson(), where: 'id = ?', whereArgs: [newScan.id]);
    return res;
  }

  Future<int> deleteScan( int id ) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }
}