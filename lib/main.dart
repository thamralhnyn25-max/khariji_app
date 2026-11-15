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

// شاشة التسجيل الذكية والمتفرعة حسب المرحلة
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
  String? _selectedCategory; // طالب مدرسة، طالب خارجي، طالب جامعي
  String? _selectedSchoolGrade; // صف طالب المدرسة
  String? _selectedKharijiStage; // ابتدائية، متوسطة، إعدادية
  String? _selectedKharijiBranch; // علمي، أدبي، مهني (للإعدادية)
  String? _selectedUniversityStage; // المرحلة الجامعية

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
    'علمي (حيوي/تطبيقي/ریاضیات)', 'أدبي', 'مهني'
  ];

  final List<String> _universityStages = [
    'المرحلة الأولى', 'المرحلة الثانية', 'المرحلة الثالثة', 'المرحلة الرابعة', 'المرحلة الخامسة'
  ];

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedProvince != null && _selectedCategory != null) {
      // الانتقال للرئيسية مع تمرير البيانات
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
                      
                      // الاسم الثلاثي
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

                      // رقم الهاتف
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

                      // المحافظة
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

                      // فئة الطالب (مدرسة، خارجي، جامعي)
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

                      // تفرع 1: طالب مدرسة
                      if (_selectedCategory ==
