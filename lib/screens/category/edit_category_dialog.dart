import 'package:flutter/material.dart';
import 'package:fox_note_app/components/custom_button.dart';
import 'package:fox_note_app/model/category.dart';
import 'package:fox_note_app/provider/category_provider.dart';

class EditCategoryDialog extends StatefulWidget {
  final Category? category;
  final String? id;
  const EditCategoryDialog({Key? key, this.category, this.id})
      : super(key: key);

  @override
  _EditCategoryDialogState createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  final controller = TextEditingController();
  String id = '';
  @override
  void initState() {
    if (widget.category!.name != null) {
      controller.text = widget.category!.name!;
      id = widget.id!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(id);
    return AlertDialog(
      title: Text('Edit category'),
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Create new category'),
            ),
            widget.category == null
                ? Container()
                : CustomButton(
                    text: 'Delete',
                    onPressed: () {
                      Navigator.of(context).pop();
                      CategoryProvider.deleteCategory(id);
                    },
                  )
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              final category = Category(name: controller.text);
              if (widget.category!.name != null) {
                CategoryProvider.updateCategory(category, id);
              }
              CategoryProvider.addCategory(category);
            },
            child: const Text('Done'))
      ],
    );
  }
}
