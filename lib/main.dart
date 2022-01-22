import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fox_note_app/provider/theme_provider.dart';

import 'screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final theme = watch.watch(themeProvider);
        return MaterialApp(
          color: Color(0x0ff2c2b4b),
          debugShowCheckedModeBanner: false,
          title: 'Note App',
          theme: theme.darkMode ? lightDark : darkMode,
          home: LandingScreen(),
        );
      },
    );
  }
}
