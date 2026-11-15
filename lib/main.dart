
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_balance,
                  size: 75,
                  color: Color(0xFF12345A),
                ),
                const SizedBox(height: 20),
                const Text(
                  'بوابة العراق',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF12345A),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('مرحباً بك'),
                const SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'اسم الحساب أو الهاتف أو البريد',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('تسجيل الدخول'),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {},
                  child: const Text('إنشاء حساب جديد'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
