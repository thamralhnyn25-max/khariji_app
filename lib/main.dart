import 'dart:async';
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
      ),
      home: const AuthScreen(),
    );
  }
}

// ================= شاشة المصادقة الإلزامية (تسجيل / تحقق) =================
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true; // true = تسجيل دخول، false = حساب جديد
  bool _isOtpStage = false; // مرحلة إدخال رمز التحقق

  final _identifierController = TextEditingController(); // بريد أو هاتف
  final _fullNameController = TextEditingController(); // الاسم الرباعي
  final _provinceController = TextEditingController(); // المحافظة
  final _passwordController = TextEditingController(); // كلمة المرور
  final _otpController = TextEditingController(); // رمز التحقق

  bool _isLoading = false;

  void _submitAuth() {
    // التحقق من الحقول
    if (_identifierController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى ملء كافة الحقول الإجبارية')),
      );
      return;
    }

    if (!_isLogin && (_fullNameController.text.isEmpty || _provinceController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال الاسم الرباعي والمحافظة بدقة')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // محاكاة إرسال رسالة التحقق عبر البريد أو الهاتف
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _isOtpStage = true; // الانتقال لخطوة إدخال الرمز المرسل
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال رمز التحقق إلى بريدك/رقمك (تجريبي: اكتب أي 4 أرقام)')),
      );
    });
  }

  void _verifyOtp() {
    if (_otpController.text.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال رمز التحقق المكون من 4 أرقام')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // تأكيد الحساب والانتقال للرئيسية
    Future.delayed(const Duration(seconds: 15), () {
      setState(() {
        _isLoading = false;
      });

      // التحقق إذا كان المستخدم هو المطور (مثال: بريد خاص بك أو كلمة سر مطور)
      bool isAdmin = _identifierController.text.trim() == 'admin@khariji.com';

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userEmailOrPhone: _identifierController.text,
            fullName: _fullNameController.text.isNotEmpty ? _fullNameController.text : 'طالب خارجي',
            province: _provinceController.text.isNotEmpty ? _provinceController.text : 'غير محدد',
            isAdmin: isAdmin,
          ),
        ),
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
              const Text(
                'طلبة الخارجي',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 8),
              Text(
                _isOtpStage
                    ? 'أدخل رمز التحقق المرسل إليك لتأكيد حسابك'
                    : (_isLogin ? 'تسجيل الدخول إلى حسابك الخاص' : 'إنشاء حساب جديد وموثق'),
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              if (!_isOtpStage) ...[
                if (!_isLogin) ...[
                  TextField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'الاسم الرباعي واللقب',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _provinceController,
                    decoration: InputDecoration(
                      labelText: 'المحافظة (مثال: النجف الأشرف)',
                      prefixIcon: const Icon(Icons.location_city),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                TextField(
                  controller: _identifierController,
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني أو رقم الهاتف الإلزامي',
                    prefixIcon: const Icon(Icons.contact_mail),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    prefixIcon: const Icon(Icons.lock),
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
                        : Text(_isLogin ? 'تسجيل الدخول وإرسال الرمز' : 'إنشاء حساب جديد', style: const TextStyle(fontSize: 18)),
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
                    _isLogin ? 'ليس لديك حساب؟ أنشئ حساباً جديداً الآن' : 'لديك حساب بالفعل؟ سجل دخولك',
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ] else ...[
                // مرحلة التحقق من الرمز
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: InputDecoration(
                    labelText: 'رمز التحقق المكون من 4 أرقام',
                    prefixIcon: const Icon(Icons.security),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _isLoading ? null : _verifyOtp,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('تأكيد الحساب والدخول', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ================= الواجهة الرئيسية (مع لوحة تحكم المطور) =================
class HomeScreen extends StatelessWidget {
  final String userEmailOrPhone;
  final String fullName;
  final String province;
  final bool isAdmin; // تحديد هل المستخدم هو المطور أم لا

  const HomeScreen({
    super.key,
    required this.userEmailOrPhone,
    required this.fullName,
    required this.province,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isAdmin ? 'لوحة تحكم المطور (الرئيسية)' : 'منصة طلبة الخارجي'),
        centerTitle: true,
        actions: [
          // زر خاص يظهر فقط للمطور لإرسال رسائل جماعية للطلاب
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.campaign, color: Colors.amber, size: 28),
              tooltip: 'إرسال رسالة جماعية لجميع الطلاب',
              onPressed: () {
                _showBroadcastDialog(context);
              },
            ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ترحيب بمعلومات الطالب أو المطور
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isAdmin ? Colors.amber.shade100 : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isAdmin ? Colors.amber : Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(isAdmin ? Icons.admin_panel_settings : Icons.person, color: isAdmin ? Colors.amber.shade900 : Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(isAdmin ? 'أهلاً بك يا مطور التطبيق 👨‍💻' : 'أهلاً بك، $fullName', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 2),
                        Text(isAdmin ? 'صلاحيات كاملة للمراسلة والإدارة' : 'المحافظة: $province | الحساب مثبت وثابت', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // شبكة المربعات 2x2 للمميزات
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.95,
                children: [
                  // 1. العداد الحي والتقديم
                  const CountdownGridCard(),

                  // 2. الخريطة الإدارية
                  _buildDashboardCard(
                    context,
                    title: 'الخريطة الإدارية',
                    icon: Icons.map,
                    color: Colors.teal,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RoadmapScreen()));
                    },
                  ),

                  // 3. الملازم والكتب
                  _buildDashboardCard(
                    context,
                    title: 'الملازم والكتب',
                    icon: Icons.menu_book,
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MaterialsScreen()));
                    },
                  ),

                  // 4. الامتحانات التجريبية
                  _buildDashboardCard(
                    context,
                    title: 'الامتحانات التجريبية',
                    icon: Icons.quiz,
                    color: Colors.indigo,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MockExamsScreen()));
                    },
                  ),

                  // 5. المساعد الذكي
                  _buildDashboardCard(
                    context,
                    title: 'المساعد الذكي',
                    icon: Icons.smart_toy,
                    color: Colors.amber.shade800,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AiTutorScreen()));
                    },
                  ),

                  // 6. البث المباشر
                  _buildDashboardCard(
                    context,
                    title: 'البث والمنظمين',
                    icon: Icons.live_tv,
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminLiveScreen()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, {required String title, required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, size: 30, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // نافذة إرسال رسالة جماعية (خاصة بالمطور)
  void _showBroadcastDialog(BuildContext context) {
    final messageController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('📢 إرسال رسالة جماعية لجميع الطلاب'),
        content: TextField(
          controller: messageController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'اكتب نص الإعلان أو الرسالة لتصل لجميع هواتف الطلاب...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade800, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إرسال الرسالة بنجاح إلى جميع الأجهزة المحملة للتطبيق!')),
              );
            },
            child: const Text('إرسال للجميع'),
          ),
        ],
      ),
    );
  }
}

// ================= مربع العداد التنازلي التفاعلي الحي =================
class CountdownGridCard extends StatefulWidget {
  const CountdownGridCard({super.key});

  @override
  State<CountdownGridCard> createState() => _CountdownGridCardState();
}

class _CountdownGridCardState extends State<CountdownGridCard> {
  late Timer _timer;
  Duration _timeLeft = Duration.zero;
  final DateTime _examDate = DateTime(2027, 2, 1, 8, 0, 0);

  @override
  void initState() {
    super.initState();
    _updateTimeLeft();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTimeLeft();
    });
  }

  void _updateTimeLeft() {
    final now = DateTime.now();
    if (_examDate.isAfter(now)) {
      setState(() {
        _timeLeft = _examDate.difference(now);
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _timeLeft.inDays;
    final hours = _timeLeft.inHours % 24;
    final minutes = _timeLeft.inMinutes % 60;
    final seconds = _timeLeft.inSeconds % 60;

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('موعد التقديم والامتحان'),
            content: Text(
              '⏳ الوقت المتبقي للامتحان التمهيدي (1 شباط 2027):\n\n'
              '$days يوماً و $hours ساعة و $minutes دقيقة و $seconds ثانية\n\n'
              '📅 موعد فتح التقديم الرسمي: 20 تشرين الثاني 2026',
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً'))
            ],
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.orange.withOpacity(0.3), width: 1.5),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.timer, size: 26, color: Colors.orange),
            const SizedBox(height: 4),
            const Text(
              'الامتحان والتقديم',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTimeUnit(seconds.toString(), 'ث'),
                const Text(':', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 11)),
                _buildTimeUnit(minutes.toString(), 'د'),
                const Text(':', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 11)),
                _buildTimeUnit(hours.toString(), 'س'),
                const Text(':', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 11)),
                _buildTimeUnit(days.toString(), 'يوم'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeUnit(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        children: [
          Text(
            value.padLeft(2, '0'),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 8, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// ================= الشاشات الفرعية الأخرى =================
class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  final List> _steps = [
    {'title': '1. متابعة موعد فتح التقديم (20 تشرين الثاني)', 'done': false},
    {'title': '2. جلب تأييد السكن والوثائق المطلوبة', 'done': false},
    {'title': '3. إتمام الفحص الطبي الرسمي', 'done': false},
    {'title': '4. تسليم الملف والدرجة الامتحانية في مديرية التربية', 'done': false},
    {'title': '5. استلام الرقم الامتحاني وبدء المراجعة', 'done': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الخريطة الإدارية لطلبة الخارجي'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _steps.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: CheckboxListTile(
              title: Text(_steps[index]['title'], style: TextStyle(fontWeight: FontWeight.bold, decoration: _steps[index]['done'] ? TextDecoration.lineThrough : null)),
              value: _steps[index]['done'],
              onChanged: (val) {
                setState(() {
                  _steps[index]['done'] = val!;
                });
              },
            ),
          );
        },
      ),
    );
  }
}

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملازم والكتب الدراسية'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCategory(context, 'الكتب المنهجية الرسمية', Icons.book, Colors.green),
          _buildCategory(context, 'الملازم الوزارية الشاملة', Icons.verified, Colors.blue),
          _buildCategory(context, 'ملازم المراجعات المركزة', Icons.local_fire_department, Colors.red),
        ],
      ),
    );
  }

  Widget _buildCategory(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        trailing: const Icon(Icons.download, color: Colors.grey),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('جاري تحميل قسم: $title')),
          );
        },
      ),
    );
  }
}

class MockExamsScreen extends StatelessWidget {
  const MockExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الامتحانات التجريبية الوزارية'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.quiz, size: 70, color: Colors.indigo),
              const SizedBox(height: 16),
              const Text('اختبر نفسك بأسئلة وزارية حقيقية', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('اختر المادة وابدأ الامتحان بوقت وتصحيح فوري.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                icon: const Icon(Icons.play_arrow),
                label: const Text('ابدأ امتحان تجريبي الآن'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AiTutorScreen extends StatelessWidget {
  const AiTutorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المساعد الذكي للمنهج العراقي'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ChatBubble(text: 'أهلاً بك! أنا مساعدك الذكي الخاص بمنهج طلبة الخارجي. اسألني عن أي مادة أو قاعدة وسأشرحها لك فوراً.', isAi: true),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'اكتب سؤالك هنا...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isAi;
  const ChatBubble({super.key, required this.text, required this.isAi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: isAi ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isAIColor(isAi),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(text, style: const TextStyle(fontSize: 15)),
        ),
      ),
    );
  }
  Color isAIColor(bool ai) => ai ? Colors.blue.shade50 : Colors.grey.shade200;
}

class AdminLiveScreen extends StatelessWidget {
  const AdminLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('البث المباشر والمنظمين'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.live_tv, size: 70, color: Colors.purple),
              const SizedBox(height: 16),
              const Text('بث مباشر عالي الجودة للدروس والإرشادات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white),
                icon: const Icon(Icons.video_call),
                label: const Text('دخول غرفة البث المباشر'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
