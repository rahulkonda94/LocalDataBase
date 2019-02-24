import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import './../model/OfferDetail.dart';
import 'package:http/http.dart' as http;

class OffersDatabaseHelper {
  static OffersDatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String offerTable = 'offer_table';
  String colId = 'id';
  String colTitle = 'title';
  String colstartDate = 'start_date';
  String colterms = 'terms';
  String colofferImage = 'offer_image';
  String colDescription = 'description';
  String colbrandName = 'brand_name';
  String colexpiryDate = 'expiry_date';

  OffersDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory OffersDatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = OffersDatabaseHelper
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
    String path = directory.path + 'offer.db';

    // Open/create the database at a given path
    var offerDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return offerDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $offerTable($colId INTEGER PRIMARY KEY, $colTitle TEXT, $colstartDate INTEGER, $colterms TEXT, $colofferImage TEXT,$colDescription TEXT, $colbrandName TEXT, $colexpiryDate INTEGER)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getOfferMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(offerTable);
    return result;
  }

  // Insert Operation: Insert a OfferDetail object to database
  Future<int> insertOfferDetail(OfferDetail offer) async {
    Database db = await this.database;
    http.Response response = await http.get(
      offer.offerImage,
    );
    offer.offerImage = base64.encode(response.bodyBytes);

    var result = await db.insert(offerTable, offer.toMap());
    return result;
  }

  // Update Operation: Update a OfferDetail object and save it to database
  Future<int> updateNote(OfferDetail offer) async {
    var db = await this.database;
    var result = await db.update(offerTable, offer.toMap(),
        where: '$colId = ?', whereArgs: [offer.id]);
    return result;
  }

  // Delete Operation: Delete a Offer object from database
  Future<int> deleteOffer(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $offerTable WHERE $colId = $id');
    return result;
  }

  // Get number of Offer objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $offerTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<OfferDetail>> getOfferList() async {
    var offerMapList = await getOfferMapList();
    int count =
        offerMapList.length; // Count the number of map entries in db table

    List<OfferDetail> offerList = List<OfferDetail>();
    // For loop to create a 'offerList' from a 'Map List'
    for (int i = 0; i < count; i++) {
      offerList.add(OfferDetail.fromMapObject(offerMapList[i]));
      print(i);
    }

    return offerList;
  }
}
