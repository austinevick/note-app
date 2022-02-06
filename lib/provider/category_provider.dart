import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fox_note_app/model/category.dart';
import 'package:fox_note_app/utils/constant.dart';

import 'auth_provider.dart';

class CategoryProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final categoryCollection = _firestore
      .collection(category)
      .doc(AuthProvider.user!.uid)
      .collection(categories);

  static Future<void> addCategory(Category category) async {
    await categoryCollection.doc().set(category.toMap());
  }

  static Stream<QuerySnapshot> getCategoryStream() {
    return categoryCollection.snapshots();
  }

  static Future<void> deleteCategory(String id) async {
    await categoryCollection.doc(id).delete();
  }

  static Future<void> updateCategory(Category category, String id) async {
    await categoryCollection.doc(id).update(category.toMap());
  }
}
