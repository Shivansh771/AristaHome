import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {

  // adds or updates an existing entry (missing fields will be deleted on update!), document will be created if needed
  static Future addOrUpdateWithId(
      String email, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .set(data);
  }

  // deletes the entry with the given document id
  static Future deleteEntry(String collection, String documentId) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .delete();
  }
}