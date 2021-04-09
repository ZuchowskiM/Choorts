import 'song.dart';
import 'dart:async';
import 'databaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class QueryCtr {


  DatabaseHelper con = new DatabaseHelper();



  Future<List<Song>> getAllSongs() async {
    //var dbClient = await con.db;
   


    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "data_flutter.db");
    
    // Only copy if the database doesn't exist
    //if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('data', 'songs.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    //}
    
    var db = await openDatabase(path);


    var res = await db.query("songs");
    
    List<Song> list =
        res.isNotEmpty ? res.map((c) => Song.fromMap(c)).toList() : <Song>[];
    return list;
  }


  void insertSong(Song song) async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "data_flutter.db");
    
    
    ByteData data = await rootBundle.load(join('data', 'songs.db'));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
     
    await new File(path).writeAsBytes(bytes);


    var db = await openDatabase(path);
    
    int id = await db.insert("songs", song.toMap());

    print(await db.query("songs"));
    
  }



}