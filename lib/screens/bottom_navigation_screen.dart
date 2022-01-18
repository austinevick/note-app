import 'package:flutter/material.dart';
import 'package:fox_note_app/screens/note_list_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final screens = [const NoteListScreen(), const Scaffold()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.all(
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
          child: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (value) =>
                setState(() => currentIndex = value),
            destinations: [
              NavigationDestination(
                  selectedIcon: Icon(Icons.notes_outlined),
                  icon: Icon(Icons.notes),
                  label: 'Note'),
              NavigationDestination(
                  selectedIcon: Icon(Icons.add_task_outlined),
                  icon: Icon(Icons.add_task),
                  label: 'Task'),
            ],
          ),
        ),
      ),
    );
  }
}