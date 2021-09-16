import 'package:flutter/material.dart';
import 'package:fox_note_app/provider/note_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, value, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Settings')),
          body: Column(
            children: [
              ListTile(
                leading: Icon(Icons.vibration),
                title: Text(
                  'Vibrate on tap',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
