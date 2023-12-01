import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

Future<Database> openMyDatabase() async {
  final directory = await getDatabasesPath();
  final path = join(directory, 'my_db.db');
  return databaseFactoryFfi.openDatabase(path);
}

Future<void> createDb() async {
  final db = await openMyDatabase();

  // テーブル作成（すでに存在する場合はスキップ）
  await db.execute('''
    CREATE TABLE IF NOT EXISTS sample(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      word TEXT,
      meaning TEXT,
      partOfSpeech TEXT,
      pronunciation TEXT,
      level TEXT,
      collocation TEXT,
      example TEXT,
      derivatives TEXT,
      origin TEXT,
      memorizedType INTEGER
    )
  ''');
}

Future<int> insertDb(
  String word,
  String meaning,
  String partOfSpeech,
  String pronunciation,
  String level,
  String collocation,
  String example,
  String derivatives,
  String origin,
  int memorizedType,
) async {
  final db = await openMyDatabase();
  return await db.transaction((txn) async {
    return await txn.rawInsert('''
      INSERT INTO sample(
        word,
        meaning,
        partOfSpeech,
        pronunciation,
        level,
        collocation,
        example,
        derivatives,
        origin,
        memorizedType
      ) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      word,
      meaning,
      partOfSpeech,
      pronunciation,
      level,
      collocation,
      example,
      derivatives,
      origin,
      memorizedType
    ]);
  });
}

Future<int> updateMemorizedType(int idKey, int memorizedType) async {
  final db = await openMyDatabase();
  return await db.update(
    'sample', // あなたのテーブル名をここに置きます
    {'memorizedType': memorizedType},
    where: 'id = ?',
    whereArgs: [idKey],
  );
}

Future<void> deleteDbCard(int idKey) async {
  final db = await openMyDatabase();

  await db.delete(
    'sample', // あなたのテーブル名をここに置きます
    where: 'id = ?',
    whereArgs: [idKey],
  );
}

Future<List<Map<String, dynamic>>> getAllDatabaseEntries() async {
  final db = await openMyDatabase();

  final List<Map<String, dynamic>> maps =
      await db.query('sample'); // テーブル名を'sample'に設定
  return maps;
}

Future<bool> wordExistsSqflite(String word) async {
  final db = await openMyDatabase(); // 既存のデータベース接続を使用

  // 'sample' テーブルから指定された単語を検索
  final List<Map<String, dynamic>> queryResult = await db.query(
    'sample',
    where: 'word = ?',
    whereArgs: [word],
  );

  // 検索結果が空でない場合、単語が存在する
  return queryResult.isNotEmpty;
}
