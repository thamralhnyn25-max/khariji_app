import 'package:flutter/material.dart';

void main() {
  runApp(const AlamAkadimiApp());
}

class AlamAkadimiApp extends StatelessWidget {
  const AlamAkadimiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'عالم أكاديمي',
      theme: ThemeData(
        fontFamily: 'Cairo',
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const RegistrationScreen(),
    );
  }
}

// 1. شاشة التسجيل الذكية والمتفرعة
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
            subDetail: _selectedCategory == 'طالب مدرسة' ? _selectedSchoolGrade ?? '' :
                       _selectedCategory == 'طالب خارجي' ? '$_selectedKharijiStage ${_selectedKharijiBranch ?? ''}' :
                       _universityController.text,
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
                'عالم أكاديمي',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 6),
              const Text(
                'بوابة طلبة العراق الشاملة',
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
                          return DropdownMenuItem<String>(value: province, child: Text(province));
                        }).toList(),
                        onChanged: (value) => setState(() => _selectedProvince = value),
                      ),
                      const SizedBox(height: 14),

                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        dropdownColor: const Color(0xFF1E293B),
                        style: const TextStyle(color: Colors.white),
                        hint: const Text('حدد فئتك الدراسية العامة', style: TextStyle(color: Colors.grey)),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.category_outlined, color: Color(0xFF3B82F6)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        items: _categories.map((cat) {
                          return DropdownMenuItem<String>(value: cat, child: Text(cat));
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
                            return DropdownMenuItem<String>(value: grade, child: Text(grade));
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
                            return DropdownMenuItem<String>(value: stage, child: Text(stage));
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
                              return DropdownMenuItem<String>(value: branch, child: Text(branch));
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
                          validator: (value) => value!.isEmpty ? 'يرجى كتابة اسم الجامعة' : null,
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
                            return DropdownMenuItem<String>(value: ustage, child: Text(ustage));
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

// 2. التنقل السفلي الاحترافي
class MainNavigationScreen extends StatefulWidget {
  final String userName;
  final String userProvince;
  final String userCategory;
  final String subDetail;

  const MainNavigationScreen({
    super.key,
    required this.userName,
    required this.userProvince,
    required this.userCategory,
    required this.subDetail,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens = [
    HomeScreen(userName: widget.userName, userProvince: widget.userProvince, userCategory: widget.userCategory),
    const BooksScreen(),
    const QuizzesScreen(),
    const NewsScreen(),
    ProfileScreen(userName: widget.userName, userProvince: widget.userProvince, userCategory: widget.userCategory, subDetail: widget.subDetail),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFFACC15),
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

// 3. الشاشة الرئيسية المطابقة لتطبيق صديقك مع زر الرسائل والدردشة
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
            icon: const Icon(Icons.send_rounded, color: Color(0xFF1E293B)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MessagesScreen()));
            },
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
                        const Text('أهلاً بك في بوابة طلبة العراق', style: TextStyle(color: Colors.white70, fontSize: 12)),
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
                    Text('82 يوم', style: TextStyle(color: Color(0xFFFACC15), fontSize: 36, fontWeight: FontWeight.bold)),
                    Text('07 : 22 : 59', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('حتى 2027/02/05', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            const Text('الأدوات والخدمات الدراسية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.5,
              children: const [
                _ToolCard(title: 'حاسبة المعدل', subtitle: 'احسب معدلك بدقة', icon: Icons.calculate_outlined),
                _ToolCard(title: 'مكتبة الملازم', subtitle: 'جميع المراحل والكتب', icon: Icons.menu_book_rounded),
                _ToolCard(title: 'الامتحانات الذكية', subtitle: 'اختبر نفسك اليوم', icon: Icons.quiz_outlined),
                _ToolCard(title: 'تواصل ودعم', subtitle: 'دردشة ومراسلة الأعضاء', icon: Icons.forum_outlined),
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
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B))),
              Icon(icon, color: const Color(0xFF3B82F6), size: 20),
            ],
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }
}

// 4. قسم الكتب والملازم
class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> subjects = ['التربية الإسلامية', 'اللغة العربية', 'اللغة الإنجليزية', 'الرياضيات', 'الكيمياء', 'الفيزياء', 'الأحياء'];
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('كتب وملازم المراحل الدراسية', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.between,
              children: [
                Row(
                  children: [
                    const Icon(Icons.menu_book, color: Color(0xFF38BDF8), size: 24),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subjects[index], style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        const Text('الكتب والملازم والأسئلة الوزارية', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('متاحة', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// 5. قسم الاختبارات
class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('الامتحانات والاختبارات الذكية', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('اختبر فهمك للمحاضرة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('اختر المادة وابدأ اختبار المحاكي الوزاري بثواني.', style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 6. قسم الأخبار
class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('الأخبار والمواعيد الوزارية', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('أ. بسام • منشور مبيت 📌', style: TextStyle(color: Color(0xFF38BDF8), fontSize: 12, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('دورات لطلاب الثالث المتوسط والسادس الإعدادي تبدأ من الصفر للتمهيدي!', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('إذا أنت طالب ثالث متوسط أو سادس إعدادي، تابع معنا التفاصيل أولاً باول.', style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 7. شاشة الرسائل والدردشة الجماعية
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('الرسائل', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFFACC15),
                  child: Icon(Icons.forum, color: Color(0xFF0F172A)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('الدردشة الجماعية', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 2),
                      Text('كل الطلاب في مكان واحد', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  child: const Text('9+', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 8. شاشة الحساب الشخصي
class ProfileScreen extends StatelessWidget {
  final String userName;
  final String userProvince;
  final String userCategory;
  final String subDetail;

  const ProfileScreen({
    super.key,
    required this.userName,
    required this.userProvince,
    required this.userCategory,
    required this.subDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('الملف الشخصي والحساب', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: const Color(0xFF38BDF8),
              child: Text(userName.isNotEmpty ? userName[0] : 'ط', style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            Text(userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            const Text('@student_iraq', style: TextStyle(color: Color(0xFF38BDF8), fontSize: 14, fontWeight: FontWeight.w600)),
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
                children: [
                  const Text('المحافظة', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(userProvince, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  const Divider(color: Colors.white12, height: 24),
                  const Text('الفئة الدراسية', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(userCategory, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  const Divider(color: Colors.white12, height: 24),
                  const Text('التفاصيل / المرحلة', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(subDetail, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  const Divider(color: Colors.white12, height: 24),
                  const Text('حالة الحساب', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const Text('طالب رسمي (حساب موثق)', style: TextStyle(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
