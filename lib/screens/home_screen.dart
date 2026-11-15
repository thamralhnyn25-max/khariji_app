
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final Color primaryColor = const Color(0xFF12345A);

  final List<Map<String, dynamic>> services = [
    {'title': 'الكتب المدرسية', 'icon': Icons.menu_book, 'color': Colors.blue},
    {'title': 'الملازم التعليمية', 'icon': Icons.library_books, 'color': Colors.orange},
    {'title': 'المراحل الدراسية', 'icon': Icons.school, 'color': Colors.green},
    {'title': 'الأسئلة الوزارية', 'icon': Icons.quiz, 'color': Colors.purple},
    {'title': 'الامتحانات', 'icon': Icons.assignment, 'color': Colors.red},
    {'title': 'النتائج', 'icon': Icons.fact_check, 'color': Colors.teal},
    {'title': 'الأخبار والقرارات', 'icon': Icons.newspaper, 'color': Colors.indigo},
    {'title': 'جدول الدراسة', 'icon': Icons.calendar_month, 'color': Colors.brown},
    {'title': 'المفضلة', 'icon': Icons.favorite, 'color': Colors.pink},
    {'title': 'الدعم الفني', 'icon': Icons.support_agent, 'color': Colors.cyan},
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7FB),
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
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle_outlined),
            ),
          ],
        ),

        body: IndexedStack(
          index: selectedIndex,
          children: [
            _buildHome(),
            _buildSimplePage('المكتبة التعليمية', Icons.local_library),
            _buildSimplePage('الإشعارات', Icons.notifications),
            _buildSimplePage('حسابي', Icons.person),
          ],
        ),

        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              label: 'المكتبة',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined),
              label: 'الإشعارات',
            ),
            NavigationDestination(
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
                colors: [Color(0xFF12345A), Color(0xFF2878B9)],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أهلاً بك في بوابة طلبة العراق 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'كل ما تحتاجه في رحلتك الدراسية تجده هنا',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 15),
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

          const SizedBox(height: 22),

          const Text(
            'ابحث عن كتاب أو ملزمة',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          TextField(
            decoration: InputDecoration(
              hintText: 'اكتب اسم المادة أو الكتاب...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'الخدمات التعليمية',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.45,
            ),
            itemBuilder: (context, index) {
              final item = services[index];

              return InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('قسم ${item['title']} قيد التجهيز'),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item['icon'],
                        color: item['color'],
                        size: 32,
                      ),
                      const SizedBox(height: 9),
                      Text(
                        item['title'],
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

          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📢 آخر الأخبار والإعلانات',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'تابع آخر أخبار وزارة التربية والتعليمات والقرارات الرسمية.',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimplePage(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 65, color: primaryColor),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('سيتم تجهيز هذا القسم في المرحلة القادمة'),
        ],
      ),
    );
  }
}
