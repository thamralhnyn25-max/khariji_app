import 'package:flutter/material.dart';

void main() {
  runApp(const KharijiApp());
}

class KharijiApp extends StatelessWidget {
  const KharijiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'منصة طلبة الخارجي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        fontFamily: 'Cairo',
      ),
      home: const AuthScreen(),
    );
  }
}

// 1. شاشة تسجيل الدخول الإلزامية (التحقق والمحافظة)
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedProvince;

  final List<String> _provinces = [
    'بغداد', 'النجف الأشرف', 'كربلاء المقدسة', 'البصرة', 
    'الأنبار', 'بابل', 'ديالى', 'ذي قار', 'القادسية', 
    'ميسان', 'المثنى', 'صلاح الدين', 'واسط', 'كركوك', 
    'نینوى', 'أربيل', 'السليمانية', 'دهوك'
  ];

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedProvince != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userName: _nameController.text,
            userProvince: _selectedProvince!,
          ),
        ),
      );
    } else if (_selectedProvince == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار المحافظة'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.school, size: 64, color: Colors.indigo),
                    const SizedBox(height: 16),
                    const Text(
                      'منصة طلبة الخارجي',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
                    ),
                    const SizedBox(height: 8),
                    const Text('سجل بياناتك للمتابعة الرسمية', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'الاسم الثلاثي والقبيلة',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) => value!.isEmpty ? 'يرجى أدخل الاسم الثلاثي' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'رقم الهاتف (للتحقق OTP)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) => value!.length < 10 ? 'يرجى أدخل رقم هاتف صحيح' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedProvince,
                      hint: const Text('اختر المحافظة'),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      items: _provinces.map((province) {
                        return DropdownMenuItem(value: province, child: Text(province));
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedProvince = value),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                        onPressed: _submit,
                        child: const Text('دخول المنصة', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 2. الشاشة الرئيسية للتطبيق (2x2 Dashboard)
class HomeScreen extends StatelessWidget {
  final String userName;
  final String userProvince;

  const HomeScreen({super.key, required this.userName, required this.userProvince});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أهلاً بك، $userName ($userProvince)'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // العداد التنازلي للامتحانات (1 شباط 2027)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.indigo, Colors.blueAccent]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.timer, color: Colors.white, size: 30),
                  SizedBox(width: 12),
                  Text(
                    'العد التنازلي لامتحانات الخارجي: 1 شباط 2027',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // لوحة الـ 2x2 الرئيسية
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _DashboardCard(title: 'خريطة الطريق', icon: Icons.map, color: Colors.orange, onTap: () {}),
                  _DashboardCard(title: 'بنك الملازم والمصادر', icon: Icons.library_books, color: Colors.green, onTap: () {}),
                  _DashboardCard(title: 'محاكي الامتحانات', icon: Icons.quiz, color: Colors.purple, onTap: () {}),
                  _DashboardCard(title: 'المعلم الذكي (AI)', icon: Icons.psychology, color: Colors.teal, onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({required this.title, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 30, backgroundColor: color.withOpacity(0.2), child: Icon(icon, size: 32, color: color)),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
