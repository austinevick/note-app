import 'package:flutter/material.dart';
import 'package:fox_note_app/utils/constant.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  const CustomButton({Key? key, this.onPressed, this.text, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        height: 50,
        minWidth: double.infinity,
        color: formColor,
        onPressed: onPressed,
        shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        child: child == null
            ? Text(
                text!,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              )
            : child,
      ),
    );
  }
}
