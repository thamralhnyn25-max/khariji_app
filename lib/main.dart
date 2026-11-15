import 'package:flutter/material.dart';

void main() {
  runApp(const KharijiApp());
}

class KharijiApp extends StatelessWidget {
  const KharijiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'منصة عالم أكاديمي',
      theme: ThemeData(
        fontFamily: 'Cairo',
        primarySwatch: Colors.indigo,
      ),
      home: const AuthScreen(),
    );
  }
}

// 1. شاشة تسجيل الدخول
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
    'نينوى', 'أربيل', 'السليمانية', 'دهوك'
  ];

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedProvince != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainNavigationScreen(),
        ),
      );
    } else if (_selectedProvince == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى اختيار المحافظة للمتابعة'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF3F51B5),
                child: Icon(Icons.school_rounded, size: 45, color: Colors.amberAccent),
              ),
              const SizedBox(height: 16),
              const Text(
                'منصة عالم أكاديمي',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 6),
              const Text(
                'بوابة طلبة الخارجي الرسمية',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8)),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('تسجيل الدخول', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1E2C))),
                      const SizedBox(height: 4),
                      const Text('يرجى إدخال بياناتك بدقة للمتابعة', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'الاسم الثلاثي والقبيلة',
                          prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF3F51B5)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) => value!.isEmpty ? 'يرجى إدخال الاسم الثلاثي' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'رقم الهاتف',
                          prefixIcon: const Icon(Icons.phone_android_outlined, color: Color(0xFF3F51B5)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) => value!.length < 10 ? 'يرجى إدخال رقم هاتف صحيح' : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedProvince,
                        hint: const Text('اختر المحافظة'),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFF3F51B5)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3F51B5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _submit,
                          child: const Text('دخول المنصة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. التنقل السفلي والشاشات
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text('قسم الكتب والملازم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    const Center(child: Text('قسم الاختبارات والامتحانات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    const Center(child: Text('قسم الأخبار والتبليغات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF1E293B),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'الكتب'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in_rounded), label: 'اختبارات'),
          BottomNavigationBarItem(icon: Icon(Icons.info_rounded), label: 'الأخبار'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'حسابي'),
        ],
      ),
    );
  }
}

// 3. الشاشة الرئيسية المطابقة لتصميم صديقك
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.send_rounded, color: Color(0xFF1E293B)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('أهلاً بك 👋', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            const Text('خلّينا نكمل خطة اليوم', style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('تابع معاملتك الخارجية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  const SizedBox(height: 6),
                  const Text('نراقب قوائم مديريتك يومياً. إذا ظهر اسمك في قائمة نواقص أو قبول، يوصلك إشعار فوراً.', style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4)),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {},
                      child: const Text('سجّل اسمك', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6))],
              ),
              child: Column(
                children: [
                  const Text('باقي على الامتحانات التمهيدية', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('83', style: TextStyle(color: Color(0xFFFACC15), fontSize: 48, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Text('يوم', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text('10 : 42 : 40', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('حتى 2027/02/05', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('أدواتك', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.5,
              children: const [
                _ToolCard(title: 'حاسبة المعدل', subtitle: 'اعرف معدلك بثواني', icon: Icons.calculate_outlined),
                _ToolCard(title: 'سنوات التقديم', subtitle: 'متى تكدر تقدّم', icon: Icons.hourglass_top_rounded),
                _ToolCard(title: 'أدوات الدراسة', subtitle: 'تركيز • أحفظ', icon: Icons.menu_book_rounded),
                _ToolCard(title: 'امتحان', subtitle: 'امتحان من محاكي...', icon: Icons.quiz_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _ToolCard({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.06), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1E293B))),
              Icon(icon, color: const Color(0xFF3B82F6), size: 22),
            ],
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }
}

// 4. شاشة الحساب والملف الشخصي
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFF38BDF8),
              child: Text('ث', style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            const Text('ثامر عبدالله', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 4),
            const Text('@thamer_313', style: TextStyle(color: Color(0xFF38BDF8), fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ProfileActionCard(title: 'تعيين صورة', icon: Icons.camera_alt_outlined, onTap: () {}),
                const SizedBox(width: 10),
                _ProfileActionCard(title: 'تعديل البيانات', icon: Icons.edit_outlined, onTap: () {}),
                const SizedBox(width: 10),
                _ProfileActionCard(title: 'الإعدادات', icon: Icons.settings_outlined, onTap: () {}),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('نبذة عن نفسك', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(height: 4),
                  Text('طالب خارجي طموح أسعى لتحقيق أعلى المعدلات.', style: TextStyle(color: Colors.white, fontSize: 14)),
                  Divider(color: Colors.white12, height: 24),
                  Text('اسم المستخدم (المعرف)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(height: 4),
                  Text('@thamer_313', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  Divider(color: Colors.white12, height: 24),
                  Text('الصف الدراسي', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(height: 4),
                  Text('السادس الإعدادي (خارجي)', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileActionCard extends StatelessWidget {
  final title, icon, onTap;
  const _ProfileActionCard({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Color(0xFF38BDF8), size: 22), // simplified icon
              const SizedBox(height: 6),
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
