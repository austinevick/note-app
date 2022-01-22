import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData? icon;
  final String? labelText;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  const CustomTextField(
      {Key? key,
      this.icon,
      this.labelText,
      this.controller,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorWidth: 1,
        controller: controller,
        textCapitalization: textCapitalization!,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
            prefixIcon: Icon(icon)),
      ),
    );
  }
}
