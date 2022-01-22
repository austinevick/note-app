import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData? icon;
  final String? labelText;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final bool? obscureText;

  const CustomTextField(
      {Key? key,
      this.icon,
      this.labelText,
      this.obscureText = false,
      this.controller,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType,
      this.validator,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: obscureText!,
        cursorWidth: 1,
        controller: controller,
        textCapitalization: textCapitalization!,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
            labelText: labelText,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(),
            prefixIcon: Icon(icon)),
      ),
    );
  }
}
