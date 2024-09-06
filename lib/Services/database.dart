import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  Future addBookDetails(Map<String, dynamic> bookInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Books")
        .doc(id)
        .set(bookInfoMap);
  }
}
