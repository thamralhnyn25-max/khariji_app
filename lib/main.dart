import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'طلبة الخارجي',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StudentsScreen(),
    );
  }
}

class StudentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طلبة الخارجي - العراق'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ في تحميل البيانات'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data;
          if (data == null || data.docs.isEmpty) {
            return Center(child: Text('لا توجد بيانات طلاب حالياً'));
          }

          return ListView(
            children: data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> studentData = document.data() as Map<String, dynamic>;
              return ListTile(
                leading: Icon(Icons.person, color: Colors.blue),
                title: Text(studentData['name'] ?? 'بدون اسم'),
                subtitle: Text('رقم المعرف: ${document.id}'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
