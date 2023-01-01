// // ignore_for_file: avoid_print, override_on_non_overriding_member, no_leading_underscores_for_local_identifiers, use_rethrow_when_possible

// import 'package:path/path.dart';
// import 'package:rasd/models/auth_models.dart';
// import 'package:rasd/models/constants.dart';
// import 'package:sqflite/sqflite.dart';

// class LocalDataBaseHelper {
//   const LocalDataBaseHelper._instance();
//   static const LocalDataBaseHelper _localDataBaseHelper =
//       LocalDataBaseHelper._instance();
//   factory LocalDataBaseHelper() => _localDataBaseHelper;

//   static Database? _database;
//   // to return the database value

//   Future<Database>? get dataBase async {
//     if (_database != null) return _database!;

//     _database = await initDB();
//     return _database!;
//   }

// // create the database

//   Future<Database> initDB() async {
//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'userPhoneNumber.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         // When creating the db, create the table
//         await db.execute(
//             'CREATE TABLE ${Constants.user} (id INTEGER PRIMARY KEY, ${Constants.name} TEXT, ${Constants.email} TEXT, ${Constants.phoneNumber} TEXT, ${Constants.nationalId} TEXT, ${Constants.uid} TEXT)');
//       },
//     );
//   }

//   @override
//   Future<int> insertData(AuthModels data) async {
//     try {
//       var _db = await dataBase;

//       return await _db!.insert(Constants.user, data.toJson());
//     } catch (e) {
//       print(e.toString());
//       throw (e);
//     }
//   }

//   @override
//   Future<int> deleteAllData() async {
//     var _db = await dataBase;
//     try {
//       return _db!.delete(Constants.user);
//     } catch (e) {
//       print(e);
//       throw (e);
//     }
//   }

//   Future<AuthModels> getUserData() async {
//     var _db = await dataBase;
//     try {
//       List<Map<String, dynamic>> userMap = await _db!.query(Constants.user);
//       // print(userMap);
//       List<AuthModels> userData = [];
//       userMap.isNotEmpty
//           ? userData = userMap.map((e) => AuthModels.fromJson(e)).toList()
//           // ignore: unnecessary_statements
//           : [];
//       // print(userData.last);
//       return userData.last;
//     } catch (e) {
//       print(e.toString());
//       throw (e);
//     }
//   }

//   @override
//   Future<int> updateData(AuthModels user) async {
//     var _db = await dataBase;
//     return _db!.update(Constants.user, user.toJson(),
//         where: 'nationalId = ?', whereArgs: [user.nationalId]);
//   }
// }
