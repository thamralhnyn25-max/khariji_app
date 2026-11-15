import 'package:flutter/material.dart';

void main() {
  runApp(const StudentsIraqApp());
}

class StudentsIraqApp extends StatelessWidget {
  const StudentsIraqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'بوابة طلبة العراق',
      theme: ThemeData(
        fontFamily: 'Cairo',
        primarySwatch: Colors.indigo,
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();

  String? _selectedProvince;
  String? _selectedCategory;
  String? _selectedSchoolGrade;
  String? _selectedKharijiStage;
  String? _selectedKharijiBranch;
  String? _selectedUniversityStage;

  final List<String> _provinces = [
    'بغداد', 'النجف الأشرف', 'كربلاء المقدسة', 'البصرة', 
    'الأنبار', 'بابل', 'ديالى', 'ذي قار', 'القادسية', 
    'ميسان', 'المثنى', 'صلاح الدين', 'واسط', 'كركوك', 
    'نينوى', 'أربيل', 'السليمانية', 'دهوك'
  ];

  final List<String> _categories = [
    'طالب مدرسة',
    'طالب خارجي',
    'طالب جامعي',
  ];

  final List<String> _schoolGrades = [
    'الأول المتوسط', 'الثاني المتوسط', 'الثالث المتوسط',
    'الرابع الاعدادي', 'الخامس الاعدادي', 'السادس الاعدادي'
  ];

  final List<String> _kharijiStages = [
    'ابتدائية', 'متوسطة', 'إعدادية'
  ];

  final List<String> _kharijiBranches = [
    'علمي', 'أدبي', 'مهني'
  ];

  final List<String> _universityStages = [
    'المرحلة الأولى', 'المرحلة الثانية', 'المرحلة الثالثة', 'المرحلة الرابعة', 'المرحلة الخامسة'
  ];

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedProvince != null && _selectedCategory != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigationScreen(
            userName: _nameController.text,
            userProvince: _selectedProvince!,
            userCategory: _selectedCategory!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إكمال الحقول واختيار الفئة والمحافظة بدقة'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF3B82F6),
                child: Icon(Icons.school_rounded, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'بوابة طلبة العراق',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 6),
              const Text(
                'منصتك التعليمية الشاملة لجميع المراحل',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('تسجيل الحساب', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 14),
                      
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'الاسم الثلاثي واللقب',
                          labelStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF3B82F6)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) => value!.isEmpty ? 'يرجى إدخال الاسم الثلاثي واللقب' : null,
                      ),
                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'رقم الهاتف',
                          labelStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.phone_android_outlined, color: Color(0xFF3B82F6)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) => value!.length < 10 ? 'يرجى إدخال رقم هاتف صحيح' : null,
                      ),
                      const SizedBox(height: 14),

                      DropdownButtonFormField<String>(
                        value: _selectedProvince,
                        dropdownColor: const Color(0xFF1E293B),
                        style: const TextStyle(color: Colors.white),
                        hint: const Text('اختر المحافظة', style: TextStyle(color: Colors.grey)),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFF3B82F6)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        items: _provinces.map((province) {
                          return DropdownMenuItem(value: province, child: Text(province));
                        }).toList(),
                        onChanged: (value) => setState(() => _selectedProvince = value),
                      ),
                      const SizedBox(height: 14),

                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        dropdownColor: const Color(0xFF1E293B),
                        style: const TextStyle(color: Colors.white),
                        hint: const Text('حدد مرحلتك الدراسية العامة', style: TextStyle(color: Colors.grey)),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF3B82F6)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        items: _categories.map((cat) {
                          return DropdownMenuItem(value: cat, child: Text(cat));
                        }).toList(),
                        onChanged: (value) => setState(() {
                          _selectedCategory = value;
                          _selectedSchoolGrade = null;
                          _selectedKharijiStage = null;
                          _selectedKharijiBranch = null;
                          _selectedUniversityStage = null;
                        }),
                      ),
                      const SizedBox(height: 14),

                      if (_selectedCategory == 'طالب مدرسة') ...[
                        DropdownButtonFormField<String>(
                          value: _selectedSchoolGrade,
                          dropdownColor: const Color(0xFF1E293B),
                          style: const TextStyle(color: Colors.white),
                          hint: const Text('اختر الصف الدراسي', style: TextStyle(color: Colors.grey)),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          items: _schoolGrades.map((grade) {
                            return DropdownMenuItem(value: grade, child: Text(grade));
                          }).toList(),
                          onChanged: (value) => setState(() => _selectedSchoolGrade = value),
                        ),
                        const SizedBox(height: 14),
                      ],

                      if (_selectedCategory == 'طالب خارجي') ...[
                        DropdownButtonFormField<String>(
                          value: _selectedKharijiStage,
                          dropdownColor: const Color(0xFF1E293B),
                          style: const TextStyle(color: Colors.white),
                          hint: const Text('اختر المرحلة (ابتدائية/متوسطة/إعدادية)', style: TextStyle(color: Colors.grey)),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          items: _kharijiStages.map((stage) {
                            return DropdownMenuItem(value: stage, child: Text(stage));
                          }).toList(),
                          onChanged: (value) => setState(() {
                            _selectedKharijiStage = value;
                            _selectedKharijiBranch = null;
                          }),
                        ),
                        const SizedBox(height: 14),
                        if (_selectedKharijiStage == 'إعدادية') ...[
                          DropdownButtonFormField<String>(
                            value: _selectedKharijiBranch,
                            dropdownColor: const Color(0xFF1E293B),
                            style: const TextStyle(color: Colors.white),
                            hint: const Text('اختر الفرع (علمي/أدبي/مهني)', style: TextStyle(color: Colors.grey)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            items: _kharijiBranches.map((branch) {
                              return DropdownMenuItem(value: branch, child: Text(branch));
                            }).toList(),
                            onChanged: (value) => setState(() => _selectedKharijiBranch = value),
                          ),
                          const SizedBox(height: 14),
                        ],
                      ],

                      if (_selectedCategory == 'طالب جامعي') ...[
                        TextFormField(
                          controller: _universityController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'اسم الجامعة والكلية / القسم',
                            labelStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (value) => value!.isEmpty ? 'يرجى كتابة اسم الجامعة والكلية' : null,
                        ),
                        const SizedBox(height: 14),
                        DropdownButtonFormField<String>(
                          value: _selectedUniversityStage,
                          dropdownColor: const Color(0xFF1E293B),
                          style: const TextStyle(color: Colors.white),
                          hint: const Text('اختر المرحلة الجامعية', style: TextStyle(color: Colors.grey)),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          items: _universityStages.map((ustage) {
                            return DropdownMenuItem(value: ustage, child: Text(ustage));
                          }).toList(),
                          onChanged: (value) => setState(() => _selectedUniversityStage = value),
                        ),
                        const SizedBox(height: 14),
                      ],

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B82F6),
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

class MainNavigationScreen extends StatefulWidget {
  final String userName;
  final String userProvince;
  final String userCategory;

  const MainNavigationScreen({
    super.key,
    required this.userName,
    required this.userProvince,
    required this.userCategory,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens = [
    HomeScreen(userName: widget.userName, userProvince: widget.userProvince, userCategory: widget.userCategory),
    const Center(child: Text('قسم الكتب والملازم الشاملة', style: TextStyle(color: Colors.white, fontSize: 18))),
    const Center(child: Text('قسم الاختبارات والامتحانات', style: TextStyle(color: Colors.white, fontSize: 18))),
    const Center(child: Text('الأخبار والتبليغات الوزارية', style: TextStyle(color: Colors.white, fontSize: 18))),
    ProfileScreen(userName: widget.userName, userProvince: widget.userProvince, userCategory: widget.userCategory),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF3B82F6),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF0F172A),
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

class HomeScreen extends StatelessWidget {
  final String userName;
  final String userProvince;
  final String userCategory;

  const HomeScreen({
    super.key,
    required this.userName,
    required this.userProvince,
    required this.userCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('أهلاً، $userName', style: const TextStyle(color: Color(0xFF1E293B), fontSize: 16, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined, color: Color(0xFF1E293B)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_user, color: Color(0xFF38BDF8), size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('مرحباً بك في بوابة طلبة العراق', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 2),
                        Text('$userCategory - محافظة $userProvince', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            if (userCategory == 'طالب خارجي') ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: const [
                    Text('العد التنازلي للامتحانات التمهيدية (خاص بطلبة الخارجي)', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    SizedBox(height: 8),
                    Text('83 يوم', style: TextStyle(color: Color(0xFFFACC15), fontSize: 36
