import 'dart:async';
import 'dart:io';
import 'package:leitura_cocho/models/fazenda.dart';
import 'package:leitura_cocho/models/usuario.dart';
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
  String colFazendaCodigo = 'fazendaCodigo';

  String loginTable = 'login';
  String colUsuario = 'usuario';
  String colSenha = 'senha';
  String colNome = 'nome';
  String colFazenda = 'fazenda';

  String fazendaTable = 'fazenda';
  String colFazendaNome = 'nome';
  String colCodigo = 'codigo';


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
        'CREATE TABLE IF NOT EXISTS $registroTable($colAluno TEXT, $colCocho TEXT, $colData TEXT, $colQuantInicial TEXT, $colQuantFinal TEXT, $colPorcentagem TEXT, $colFazenda TEXT, $colUsuario TEXT, $colFazendaCodigo TEXT, PRIMARY KEY($colAluno, $colCocho, $colData, $colQuantInicial, $colQuantFinal, $colPorcentagem) );');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $loginTable($colUsuario TEXT, $colSenha TEXT, $colNome TEXT, PRIMARY KEY($colUsuario) );');
        await db.execute(
        'CREATE TABLE IF NOT EXISTS $fazendaTable($colFazendaNome TEXT, $colCodigo TEXT, $colUsuario TEXT, PRIMARY KEY($colFazendaNome, $colCodigo, $colUsuario) );');
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

  Future<int> insertUsuario(Usuario usuario) async {
    try {
      Database db = await database;
      var result = await db.insert(loginTable, usuario.toMap());
      return result;
      // ignore: empty_catches
    } catch (e) {}
    return 0;
  }

    Future<int> insertFazenda(Fazenda fazenda) async {
    try {
      Database db = await database;
      var result = await db.insert(fazendaTable, fazenda.toMap());
      return result;
      // ignore: empty_catches
    } catch (e) {}
    return 0;
  }

  Future<Usuario?> getUsuario(String login, String senha) async {
    Database db = await database;

    List<Map> maps = await db.query(loginTable,
        columns: [
          colUsuario,
          colSenha,
          colNome,
        ],
        where: "$colUsuario = ? and $colSenha = ?",
        whereArgs: [login, senha]);

    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first as Map<String, dynamic>);
    } else {
      return null;
    }
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
          colFazenda,
          colUsuario,
          colFazendaCodigo,
        ],
        where: "$colCocho = ?",
        whereArgs: [cocho]);

    if (maps.isNotEmpty) {
      return Registro.fromMap(maps.first as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<List<Fazenda>> getFazendaUsuario(String usuario) async {
    Database db = await database;
    var result = await db.query(fazendaTable,
        columns: [
          colFazendaNome,
          colCodigo,
          colUsuario,
        ],
        where: "$colUsuario = ?",
        whereArgs: [usuario]);

    List<Fazenda> lista = result.isNotEmpty
        ? result.map((e) => Fazenda.fromMap(e)).toList()
        : [];
    return lista;
  }

  Future<List<Registro>> getRegistros() async {
    Database db = await database;
    var result = await db.query('$registroTable ORDER BY $colData DESC;');

    List<Registro> lista = result.isNotEmpty
        ? result.map((e) => Registro.fromMap(e)).toList()
        : [];
    return lista;
  }

    Future<List<Registro>> getRegistrosUsuarios(String fazendaNome, String fazendaCodigo) async {
    Database db = await database;
    var result = await db.query('$registroTable WHERE $colFazenda = "$fazendaNome" AND $colFazendaCodigo = "$fazendaCodigo" ORDER BY $colData DESC;');

    List<Registro> lista = result.isNotEmpty
        ? result.map((e) => Registro.fromMap(e)).toList()
        : [];
    return lista;
  }

    Future<List<Usuario>> getUsuarios() async {
    Database db = await database;
    var result = await db.query('$loginTable;');

    List<Usuario> lista = result.isNotEmpty
        ? result.map((e) => Usuario.fromMap(e)).toList()
        : [];
    return lista;
  }

    Future<List<Fazenda>> getFazendas() async {
    Database db = await database;
    var result = await db.query('$fazendaTable;');

    List<Fazenda> lista = result.isNotEmpty
        ? result.map((e) => Fazenda.fromMap(e)).toList()
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

  Future<List<Registro>> getRegistrosData(String now, String before, String fazendaNome, String fazendaCodigo) async {
    Database db = await database;
    var result = await db.query(
        '$registroTable WHERE $colData <= "$now%" AND $colData >= "$before" AND $colFazenda = "$fazendaNome" AND $colFazendaCodigo = "$fazendaCodigo" ORDER BY $colData DESC;');
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
