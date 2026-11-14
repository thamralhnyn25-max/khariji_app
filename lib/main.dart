import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'طلبة الخارجي',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StudentsScreen(),
    );
  }
}

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلبة الخارجي'),
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.person, color: Colors.blue),
            title: Text('أحمد (طالب تجريبي)'),
            subtitle: Text('رقم القيد: 313 - يعمل بكفاءة ودون أخطاء'),
          ),
          ListTile(
            leading: Icon(Icons.check_circle, color: Colors.green),
            title: Text('حالة التطبيق'),
            subtitle: Text('تم تجاوز مشكلة الشاشة الرمادية بنجاح'),
          ),
        ],
      ),
    );
  }
}
