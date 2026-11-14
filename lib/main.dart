import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp().timeout(const Duration(seconds: 3));
  } catch (e) {
    debugPrint('Firebase init error: $e');
  }
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .snapshots()
            .timeout(
              const Duration(seconds: 4),
              onTimeout: (sink) {
                // في حال تأخر الاتصال، يتم تجاوز المهلة وعرض واجهة الطوارئ المحلية لتجنب الشاشة الرمادية
                throw Exception("offline");
              },
            ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.person, color: Colors.blue),
                  title: Text('أحمد (طالب تجريبي)'),
                  subtitle: Text('رقم القيد: 313 - وضع عدم الاتصال'),
                ),
              ],
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data;
          if (data == null || data.docs.isEmpty) {
            return const Center(child: Text('لا توجد بيانات حالياً'));
          }

          return ListView(
            children: data.docs.map((document) {
              Map<String, dynamic> studentData = document.data() as Map<String, dynamic>;
              return ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: Text(studentData['name'] ?? 'بدون اسم'),
                subtitle: Text('رقم القيد: ${document.id}'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
