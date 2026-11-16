
import 'package:flutter/material.dart';
import 'screens/auth/register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IraqStudentsApp());
}

class IraqStudentsApp extends StatelessWidget {
  const IraqStudentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'بوابة طلبة العراق',
      theme: AppTheme.lightTheme,
      home: const RegisterScreen(),
    );
  }
}

class AppColors {
  static const Color primary = Color(0xFF087F5B);
  static const Color primaryDark = Color(0xFF075B43);
  static const Color secondary = Color(0xFFD6A84B);

  static const Color background = Color(0xFFF5F8F7);
  static const Color surface = Colors.white;
  static const Color textDark = Color(0xFF172B26);
  static const Color textMuted = Color(0xFF82918B);

  static const Color success = Color(0xFF219653);
  static const Color error = Color(0xFFD64545);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Cairo',
      scaffoldBackgroundColor: AppColors.background,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
        centerTitle: true,
        elevation: 0,
      ),

      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE4ECE8),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE4ECE8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
