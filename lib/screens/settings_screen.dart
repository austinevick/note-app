import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/provider/category_provider.dart';

import 'category/edit_category_dialog.dart';
import 'category/note_category_list.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        children: [
          const SizedBox(height: 12),
          ListTile(
            leading: Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            trailing: TextButton(
              onPressed: () => showDialog(
                  context: context, builder: (ctx) => EditCategoryDialog()),
              child: Text('Manage'),
            ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: CategoryProvider.getCategoryStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return snapshot.data!.docs.isEmpty
                  ? Container()
                  : NoteCategoryList(snapshot: snapshot);
            },
          ))
        ],
      ),
    );
  }
}
