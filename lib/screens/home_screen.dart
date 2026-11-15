
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  static const Color primaryColor = Color(0xFF12345A);
  static const Color backgroundColor = Color(0xFFF4F7FB);

  final List<Map<String, dynamic>> services = [
    {
      'title': 'الكتب المدرسية',
      'icon': Icons.menu_book,
      'color': Colors.blue,
    },
    {
      'title': 'الملازم التعليمية',
      'icon': Icons.library_books,
      'color': Colors.orange,
    },
    {
      'title': 'المراحل الدراسية',
      'icon': Icons.school,
      'color': Colors.green,
    },
    {
      'title': 'الأسئلة الوزارية',
      'icon': Icons.quiz,
      'color': Colors.purple,
    },
    {
      'title': 'الامتحانات',
      'icon': Icons.assignment,
      'color': Colors.red,
    },
    {
      'title': 'النتائج',
      'icon': Icons.fact_check,
      'color': Colors.teal,
    },
    {
      'title': 'الأخبار والقرارات',
      'icon': Icons.newspaper,
      'color': Colors.indigo,
    },
    {
      'title': 'جدول الدراسة',
      'icon': Icons.calendar_month,
      'color': Colors.brown,
    },
    {
      'title': 'المفضلة',
      'icon': Icons.favorite,
      'color': Colors.pink,
    },
    {
      'title': 'الدعم الفني',
      'icon': Icons.support_agent,
      'color': Colors.cyan,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'بوابة طلبة العراق',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'منصتك التعليمية المتكاملة',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                _showMessage('الإشعارات');
              },
              icon: const Icon(Icons.notifications_none),
            ),
          ],
        ),

        body: IndexedStack(
          index: selectedIndex,
          children: [
            _buildHome(),
            _buildSimplePage(
              'المكتبة التعليمية',
              Icons.local_library,
            ),
            _buildSimplePage(
              'الإشعارات',
              Icons.notifications,
            ),
            _buildSimplePage(
              'حسابي',
              Icons.person,
            ),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'المكتبة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: 'الإشعارات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF12345A),
                  Color(0xFF2878B9),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أهلاً بك في بوابة طلبة العراق',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'كل ما تحتاجه في رحلتك الدراسية تجده هنا',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'تعلم اليوم لتصنع مستقبلك غداً',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'البحث في المكتبة التعليمية',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'ابحث عن كتاب أو ملزمة...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'الخدمات التعليمية',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
            ),
            itemBuilder: (context, index) {
              final item = services[index];

              return InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  _showMessage(
                    'قسم ${item['title']} قيد التجهيز',
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        color: item['color'] as Color,
                        size: 34,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item['title'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 25),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'آخر الأخبار والإعلانات',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'تابع آخر أخبار وزارة التربية والتعليمات والقرارات الرسمية.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSimplePage(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 65,
            color: primaryColor,
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'سيتم تجهيز هذا القسم في المرحلة القادمة',
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
