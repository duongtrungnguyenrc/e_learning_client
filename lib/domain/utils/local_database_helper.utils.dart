import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabaseHelper {
  static final LocalDatabaseHelper _instance = LocalDatabaseHelper._internal();
  factory LocalDatabaseHelper() => _instance;

  static Database? _db;

  LocalDatabaseHelper._internal();

  Future<Database> getInstance() async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "local_data.db");

    var ourDb = await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onConfigure: (db) {
        db.execute('PRAGMA foreign_keys = ON');
      },
    );
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
    CREATE TABLE user(
      id TEXT PRIMARY KEY,
      email TEXT,
      name TEXT,
      phone TEXT,
      avatar TEXT,
      role TEXT
    )
  ''');

    await db.execute('''
      CREATE TABLE folder(
        id TEXT PRIMARY KEY,
        name TEXT,
        authorId TEXT,
        rootId TEXT NULL,
        FOREIGN KEY (authorId) REFERENCES user(id),
        FOREIGN KEY (rootId) REFERENCES folder(id)
      )
    ''');

    await db.execute('''
    CREATE TABLE topic(
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      visibility INTEGER,
      thumbnail TEXT,
      createdTime TEXT,
      authorId TEXT,
      folderId TEXT NULL,
      FOREIGN KEY (authorId) REFERENCES user(id),
      FOREIGN KEY (folderId) REFERENCES folder(id)
    )
  ''');

    await db.execute('''
    CREATE TABLE vocabulary(
      id TEXT PRIMARY KEY,
      word TEXT,
      meaning TEXT,
      description TEXT,
      imgDescription TEXT,
      createdTime TEXT,
      topicId TEXT,
      FOREIGN KEY (topicId) REFERENCES topic(id)
    )
  ''');

    await db.execute('''
    CREATE TABLE multiple_choice_answer(
      id TEXT PRIMARY KEY,
      content TEXT,
      isTrue INTEGER,
      vocabularyId TEXT,
      FOREIGN KEY (vocabularyId) REFERENCES vocabulary(id)
    )
  ''');
  }

  Future<String> insert(String table, Map<String, dynamic> row) async {
    Database dbClient = await getInstance();
    final existingData = await dbClient.query(
      table,
      where: 'id = ?',
      whereArgs: [row['id']],
    );
    if (existingData.isEmpty) {
      await dbClient.insert(table, row);
      return row['id'].toString();
    }
    return existingData[0]['id'].toString();
  }

  Query query(String table) {
    return Query(table);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database dbClient = await getInstance();
    return await dbClient.update('your_table', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    Database dbClient = await getInstance();
    return await dbClient.delete('your_table', where: 'id = ?', whereArgs: [id]);
  }
}

class Query {
  final String table;
  List<String> queries = [];

  Query(this.table);

  Query select(List<String> keys) {
    queries.add("SELECT ${keys.isNotEmpty ? keys.join(", ") : '*'} FROM $table");
    return this;
  }

  Query where(Map<String, dynamic> conditions) {
    if (conditions.isNotEmpty) {
      queries.add("WHERE ${_buildWhereClause(conditions)}");
    }
    return this;
  }

  Query join(String joinTable, String referenceKey) {
    queries.add("JOIN $joinTable ON $joinTable.id = $table.$referenceKey");
    return this;
  }

  Future<List<Map<String, Object?>>> execute() async {
    Database dbClient = await LocalDatabaseHelper().getInstance();
    String sqlQuery = queries.join(" ");
    return await dbClient.rawQuery(sqlQuery);
  }

  String _buildWhereClause(Map<String, dynamic> conditions) {
    List<String> clauses = [];
    conditions.forEach((key, value) {
      if (value is List) {
        clauses.add("$key IN (${value.map((e) => "'$e'").join(", ")})");
      } else {
        clauses.add("$key = '$value'");
      }
    });
    return clauses.join(" AND ");
  }
}
