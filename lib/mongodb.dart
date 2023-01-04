import 'dart:developer';

import 'package:malzemetkp/main.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'connection.dart';

const MONGO_DB_CON =
    "mongodb+srv://faruk:12345@cluster0.5gimg8a.mongodb.net/mydatabase?retryWrites=true&w=majority";
const user_collection = "mycollection";

class Mongo123 {

  static var db, userCollection;
  static Future<List<Map<String, dynamic>>> getQueryData() {
    final data = userCollection.find().toList();
    return data;
  }

  static connect() async {
    db = await Db.create(MONGO_DB_CON);
    await db.open();
    inspect(db);
    userCollection = db.collection(user_collection);
  }

  static ekle(int kk, int tt) {
    userCollection.updateOne(
        where.eq('Adet', kk), ModifierBuilder().inc('Adet', tt));
  }
}
