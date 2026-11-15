import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IraqStudentsApp());
}

class IraqStudentsApp extends StatelessWidget {
  const IraqStudentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'بوابة العراق',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF12345A),
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

