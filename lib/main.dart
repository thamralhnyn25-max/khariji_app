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

// ================= شاشة المصادقة (جلسة ثابتة) =================
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
              const Text(
                'طلبة الخارجي',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
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

// ================= الواجهة الرئيسية (ترتيب مربعات 2x2) =================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلبة الخارجي - الرئيسية'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // عمودين (مربعين في كل صف)
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.95,
          children: [
            // المربع 1: العداد التنازلي الحي وموعد التقديم
            const CountdownGridCard(),

            // المربع 2: اختيار المرحلة الدراسية
            _buildDashboardCard(
              context,
              title: 'المرحلة الدراسية',
              icon: Icons.school,
              color: Colors.blue,
              onTap: () => _showStageDialog(context),
            ),

            // المربع 3: الملازم والكتب الدراسية
            _buildDashboardCard(
              context,
              title: 'الملازم والكتب',
              icon: Icons.menu_book,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MaterialsScreen()),
                );
              },
            ),

            // المربع 4: البث المباشر والمنظمين
            _buildDashboardCard(
              context,
              title: 'البث المباشر',
              icon: Icons.live_tv,
              color: Colors.purple,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('سيتم تفعيل البث المباشر قريباً')),
                );
              },
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
              radius: 30,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showStageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اختر مرحلتك الدراسية'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('المرحلة الابتدائية'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text('المرحلة المتوسطة'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text('المرحلة الإعدادية (علمي/أدبي/مهني)'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= مربع العداد التنازلي الحي (يعمل بالثانية والأيام والساعات) =================
class CountdownGridCard extends StatefulWidget {
  const CountdownGridCard({super.key});

  @override
  State<CountdownGridCard> createState() => _CountdownGridCardState();
}

class _CountdownGridCardState extends State<CountdownGridCard> {
  late Timer _timer;
  Duration _timeLeft = Duration.zero;
  final DateTime _examDate = DateTime(2027, 2, 1, 8, 0, 0); // موعد الامتحان التمهيدي

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
            // عداد حي بالأيام والساعات والدقائق والثواني
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

// ================= شاشة الملازم والكتب الدراسية =================
class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملازم والكتب الدراسية'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMaterialCategory(
            context,
            title: 'الكتب المنهجية الرسمية',
            subtitle: 'تنزيل المناهج المقررة لجميع المراحل',
            icon: Icons.book,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildMaterialCategory(
            context,
            title: 'الملازم الوزارية',
            subtitle: 'أفضل الملازم المعتمدة والشاملة',
            icon: Icons.verified,
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildMaterialCategory(
            context,
            title: 'ملازم المراجعات المركزة',
            subtitle: 'ملخصات ومهمات لضمان التفوق',
            icon: Icons.local_fire_department,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialCategory(BuildContext context, {required String title, required String subtitle, required IconData icon, required Color color}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('جاري فتح قسم: $title')),
          );
        },
      ),
    );
  }
}
