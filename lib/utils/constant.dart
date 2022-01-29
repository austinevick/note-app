import 'package:flutter/material.dart';

final titleStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
final contentStyle = TextStyle(fontSize: 17);
final defaultColor = const Color(0xff0f044c);
final formColor = const Color(0xff003cc0);

final note = 'note';
final notes = 'notes';

void pushNavigation(BuildContext context, Widget child) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => child));
