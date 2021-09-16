import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key key,
    this.text,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 60,
      alignment: Alignment.center,
      child: TextField(
        cursorWidth: 1,
        autofocus: true,
        controller: controller,
        decoration: InputDecoration(
            icon: IconButton(
                icon: Icon(Icons.keyboard_backspace,
                    color: Colors.black, size: 28),
                onPressed: () => Navigator.of(context).pop()),
            suffixIcon: widget.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.close, color: style.color),
                    onPressed: () {
                      controller.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: style,
            border: InputBorder.none,
            focusedBorder: InputBorder.none),
        style: TextStyle(color: Colors.black, fontSize: 20),
        onChanged: widget.onChanged,
      ),
    );
  }
}
