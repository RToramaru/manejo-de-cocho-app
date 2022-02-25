import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:path_provider/path_provider.dart';
import 'package:leitura_cocho/models/registro.dart';

class DatabaseHelper {
  static late DatabaseHelper _databaseHelper;
  static late Database _database;

  String registroTable = 'registro';
  String colAluno = 'aluno';
  String colCocho = 'cocho';
  String colQuantInicial = 'quant_inicial';
  String colQuantFinal = 'quant_final';
  String colPorcentagem = 'porcentagem';
  String colData = 'data';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper = DatabaseHelper._createInstance();
    return _databaseHelper;
  }

  Future<Database> get database async {
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'registro.db';

    var registrosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return registrosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $registroTable($colAluno TEXT, $colCocho TEXT, $colData TEXT, $colQuantInicial TEXT, $colQuantFinal TEXT, $colPorcentagem TEXT, PRIMARY KEY($colAluno, $colCocho, $colData, $colQuantInicial, $colQuantFinal, $colPorcentagem) );');
  }

  Future<int> insertRegistro(Registro registro) async {
    try {
      Database db = await database;
      var result = await db.insert(registroTable, registro.toMap());
      return result;
      // ignore: empty_catches
    } catch (e) {}
    return 0;
  }

  Future<Registro?> getRegistro(String cocho) async {
    Database db = await database;

    List<Map> maps = await db.query(registroTable,
        columns: [
          colAluno,
          colCocho,
          colQuantInicial,
          colQuantFinal,
          colPorcentagem,
          colData,
        ],
        where: "$colCocho = ?",
        whereArgs: [cocho]);

    if (maps.isNotEmpty) {
      return Registro.fromMap(maps.first as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<List<Registro>> getRegistros() async {
    Database db = await database;
    var result = await db.query('$registroTable ORDER BY $colData DESC;');

    List<Registro> lista = result.isNotEmpty
        ? result.map((e) => Registro.fromMap(e)).toList()
        : [];
    return lista;
  }

  Future<List<Registro>> getRegistrosCocho(String cocho) async {
    Database db = await database;
    try {
      var result = await db.query(
          '$registroTable WHERE $colCocho = $cocho ORDER BY $colData DESC;');

      List<Registro> lista = result.isNotEmpty
          ? result.map((e) => Registro.fromMap(e)).toList()
          : [];
      return lista;
    } catch (e) {
      false;
    }
    List<Registro> lista = [];
    return lista;
  }

  Future<List<Registro>> getRegistrosAluno(String aluno) async {
    Database db = await database;
    try {
      var result = await db.query(
          '$registroTable WHERE $colAluno = "$aluno" ORDER BY $colData DESC;');

      List<Registro> lista = result.isNotEmpty
          ? result.map((e) => Registro.fromMap(e)).toList()
          : [];
      return lista;
    } catch (e) {
      false;
    }
    List<Registro> lista = [];
    return lista;
  }

  Future<List<Registro>> getRegistrosData(String now, String before) async {
    Database db = await database;
    var result = await db.query(
        '$registroTable WHERE $colData <= "$now%" AND $colData >= "$before" ORDER BY $colData DESC;');
    List<Registro> lista = result.isNotEmpty
        ? result.map((e) => Registro.fromMap(e)).toList()
        : [];
    return lista;
  }

  Future<int> updateRegistro(Registro registro) async {
    var db = await database;
    var result = await db.update(registroTable, registro.toMap(),
        where: '$colCocho = ?', whereArgs: [registro.cocho]);
    return result;
  }

  Future<int> deleteRegistro(String cocho) async {
    var db = await database;

    int result = await db
        .delete(registroTable, where: "$colCocho = ?", whereArgs: [cocho]);

    return result;
  }

  Future<int> deleteRegistros() async {
    var db = await database;

    int result = await db.delete(registroTable, where: "1=1");

    return result;
  }

  Future<int?> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $registroTable');

    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future close() async {
    Database db = await database;
    db.close();
  }
}
