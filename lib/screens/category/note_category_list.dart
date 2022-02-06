import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fox_note_app/model/category.dart';
import 'package:fox_note_app/screens/category/edit_category_dialog.dart';

class NoteCategoryList extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot>? snapshot;

  const NoteCategoryList({Key? key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      childrenDelegate: SliverChildBuilderDelegate((context, i) {
        var map = snapshot!.data!.docs[i].data() as Map<String, dynamic>;
        final category = Category.fromMap(map);
        String id = snapshot!.data!.docs[i].id;

        return InkWell(
          onTap: () => showDialog(
              context: context,
              builder: (ctx) => EditCategoryDialog(category: category, id: id)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(category.name!),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withOpacity(.8)),
            ),
          ),
        );
      }, childCount: snapshot!.data!.docs.length),
    );
  }
}
