import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import './../model/SignUpDetail.dart';

class SignUpDatabaseHelper {
  static SignUpDatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database
  String registrationTable = 'registration_table';

  String colName = 'name';
  String colUsername = 'username';
  String colEmail = 'email';
  String colPassword = 'password';
  String colLocation = 'location';
  String colShippingAddress = 'shippingAddress';
  String colMobile = 'mobile';
  String colDob = 'dob';
  String colPrivacyPolicy = 'privacyPolicy';

  SignUpDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory SignUpDatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = SignUpDatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'members.db';

    // Open/create the database at a given path
    var membersDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return membersDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    try {
      await db.execute(
          'CREATE TABLE $registrationTable( $colName TEXT, $colUsername TEXT, $colEmail TEXT PRIMARY KEY, $colPassword TEXT, $colLocation TEXT, $colShippingAddress TEXT, $colDob INTEGER,$colMobile INTEGER,$colPrivacyPolicy INTEGER)');
    } catch (e) {
      print(e);
    }
  }

  // Fetch Operation: Get all member objects from database
  Future<List<Map<String, dynamic>>> getMembersMapList() async {
    Database db = await this.database;

    var result = await db.query(registrationTable);
    return result;
  }

  // Insert Operation: Insert a member object to database
  Future<int> insertMember(SignUpDetail signUpDetails) async {
    Database db = await this.database;
    var result = await db.insert(registrationTable, signUpDetails.toMap());
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'member List' [ List<member> ]
  Future<List<SignUpDetail>> getMembersList() async {
    var membersMapList =
        await getMembersMapList(); // Get 'Map List' from database
    int count =
        membersMapList.length; // Count the number of map entries in db table
        print(count);


    List<SignUpDetail> membersList = List<SignUpDetail>();
    // For loop to create a 'member List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      membersList.add(SignUpDetail.fromMapObject(membersMapList[i]));
    }

    return membersList;
  }
}
