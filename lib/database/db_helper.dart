//dbhelper ini dibuat untuk
//membuat database, membuat tabel, proses insert, read, update dan delete
        
        
import 'package:Audisi/model/audisi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
        
class DbHelper {
    static final DbHelper _instance = DbHelper._internal();
    static Database? _database;
   
    final String tableName = 'tableAudisi';
    final String columnId = 'id';
    final String columnNamaAsli = 'nama_asli';
    final String columnNamaPanggung = 'nama_panggung';
    final String columnNoTelepon = 'no_telepon';
    final String columnPosisi = 'posisi';
    final String columnEntertainment = 'entertaiment';
        
    DbHelper._internal();
    factory DbHelper() => _instance;
        
    //cek apakah database ada
    Future<Database?> get _db  async {
        if (_database != null) {
            return _database;
        }
        _database = await _initDb();
        return _database;
    }
        
    Future<Database?> _initDb() async {
        String databasePath = await getDatabasesPath();
        String path = join(databasePath, 'audisi.db');
        
        return await openDatabase(path, version: 1, onCreate: _onCreate);
    }
        
    //membuat tabel dan field-fieldnya
    Future<void> _onCreate(Database db, int version) async {
        var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
            "$columnNamaAsli TEXT,"
            "$columnNamaPanggung TEXT,"
            "$columnNoTelepon TEXT,"
            "$columnPosisi TEXT,"
            "$columnEntertainment TEXT)";
             await db.execute(sql);
    }
        
    //insert ke database
    Future<int?> saveAudisi(Audisi audisi) async {
        var dbClient = await _db;
        return await dbClient!.insert(tableName, audisi.toMap());
    }
        
    //read database
    Future<List?> getAllAudisi() async {
        var dbClient = await _db;
        var result = await dbClient!.query(tableName, columns: [
            columnId,
            columnNamaAsli,
            columnNamaPanggung,
            columnNoTelepon,
            columnPosisi,
            columnEntertainment
        ]);
        
        return result.toList();
    }
        
    //update database
    Future<int?> updateAudisi(Audisi audisi) async {
        var dbClient = await _db;
        return await dbClient!.update(tableName, audisi.toMap(), where: '$columnId = ?', whereArgs: [audisi.id]);
    }
        
    //hapus database
    Future<int?> deleteAudisi(int id) async {
        var dbClient = await _db;
        return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
    }
}