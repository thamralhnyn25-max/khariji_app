import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KharijiApp());
}

class KharijiApp extends StatelessWidget {
  const KharijiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'طلبة الخارجي',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: 'Cairo', // أو الخط الافتراضي
      ),
      home: const AuthScreen(),
    );
  }
}

// ================= شاشة المصادقة (تسجيل الدخول / إنشاء حساب) =================
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _submitAuth() {
    setState(() {
      _isLoading = true;
    });

    // محاكاة تسجيل الدخول أو إنشاء حساب (جلسة ثابتة)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 80, color: Colors.blue),
              const SizedBox(height: 16),
              Text(
                _isLogin ? 'تسجيل الدخول' : 'إنشاء حساب جديد',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _isLogin 
                    ? 'أهلاً بك مجدداً، أدخل بريدك أو رقم هاتفك للمتابعة' 
                    : 'أنشئ حساباً خاصاً وثابتاً لك في التطبيق',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _identifierController,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني أو رقم الهاتف',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _isLoading ? null : _submitAuth,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(_isLogin ? 'تسجيل الدخول' : 'إنشاء الحساب', style: const TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                child: Text(
                  _isLogin ? 'ليس لديك حساب؟ اضغط هنا لإنشاء حساب جديد' : 'لديك حساب بالفعل؟ سجل دخولك من هنا',
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= الواجهة الرئيسية وتحتوي الخانات الأربع =================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // متغيرات لاختيار المرحلة الدراسية
  String? selectedStage;
  String? selectedBranch;

  final Map<String, List<String>> stagesData = {
    'الابتدائية': ['خارجي ابتدائي'],
    'المتوسطة': ['خارجي متوسطة'],
    'الاعدادية': ['علمي (إحيائي/تطبيقي/حاسبات)', 'أدبي', 'مهني (صناعي/حاسوب/إداري)'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بوابة طلبة الخارجي'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'تسجيل الخروج',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // ================= الخانة 1: عداد موعد الامتحان التمهيدي ومواعيد التقديم =================
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.timer, color: Colors.orange, size: 28),
                      SizedBox(width: 8),
                      Text('الامتحان التمهيدي ومواعيد التقديم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(height: 20),
                  const Text('⏳ الوقت المتبقي للتمهيدي: جارٍ تحديث العداد...', style: TextStyle(fontSize: 14, color: Colors.black87)),
                  const SizedBox(height: 8),
                  const Text('📅 موعد التقديم الرسمي: يُعلن عنه قريباً عبر الوزارة', style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ================= الخانة 2: اختيار المرحلة الدراسية =================
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.school, color: Colors.blue, size: 28),
                      SizedBox(width: 8),
                      Text('اختر المرحلة الدراسية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'اختر المرحلة',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    value: selectedStage,
                    items: stagesData.keys.map((stage) {
                      return DropdownMenuItem(value: stage, child: Text(stage));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStage = value;
                        selectedBranch = null; // إعادة تعيين الفرع عند تغير المرحلة
                      });
                    },
                  ),
                  if (selectedStage == 'الاعدادية') ...[
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'اختر الفرع',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      value: selectedBranch,
                      items: stagesData['الاعدادية']!.map((branch) {
                        return DropdownMenuItem(value: branch, child: Text(branch));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedBranch = value;
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ================= الخانة 3: الملازم الدراسية =================
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.menu_book, color: Colors.green, size: 28),
                      SizedBox(width: 8),
                      Text('الملازم والكتب الدراسية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(height: 20),
                  ListTile(
                    leading: const Icon(Icons.book, color: Colors.green),
                    title: const Text('الكتب المنهجية الرسمية'),
                    subtitle: const Text('تنزيل المناهج المقررة لجميع المراحل'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // إجراء النقل لاحقاً
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.verified, color: Colors.blue),
                    title: const Text('الملازم الوزارية'),
                    subtitle: const Text('أفضل الملازم المعتمدة والشاملة'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_fire_department, color: Colors.red),
                    title: const Text('ملازم المراجعات المركزة'),
                    subtitle: const Text('ملخصات ومهمات لضمان النجاح'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ================= الخانة 4: البث المباشر ولوحة التحكم للمنظمين =================
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.live_tv, color: Colors.purple, size: 28),
                      SizedBox(width: 8),
                      Text('البث المباشر ولوحة المنظمين', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(height: 20),
                  const Text('تابع المحاضرات الإرشادية والدروس الحية بجودة عالية ودون تقطيع.', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.play_circle_fill),
                      label: const Text('دخول البث المباشر / لوحة التحكم'),
                      onPressed: () {
                        // الانتقال للبث أو لوحة التحكم لاحقاً
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
