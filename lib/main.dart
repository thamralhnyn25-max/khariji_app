// نموذج بيانات الكتاب أو الملزمة
class BookModel {
  final String title;
  final String subject;
  final String stage;
  final String pdfUrl; // رابط ملف الـ PDF (مثل رابط جوجل درايف)

  BookModel({
    required this.title,
    required this.subject,
    required this.stage,
    required this.pdfUrl,
  });
}

// شاشة الكتب والملازم المحدثة
class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  // 📚 قائمة الكتب والملازم (هنا يمكنك إضافة وتعديل الكتب براحتك)
  final List<BookModel> booksList = const [
    BookModel(
      title: 'ملزمة الاحياء الشاملة - الفصل الأول',
      subject: 'الأحياء',
      stage: 'السادس الإعدادي',
      pdfUrl: 'https://www.example.com/biology_ch1.pdf', // ضع رابط الـ PDF هنا
    ),
    BookModel(
      title: 'قواعد اللغة العربية - الجزء الأول',
      subject: 'اللغة العربية',
      stage: 'السادس الإعدادي',
      pdfUrl: 'https://www.example.com/arabic_grammar.pdf',
    ),
    BookModel(
      title: 'أسئلة الوزاري لمرشحات الرياضيات',
      subject: 'الرياضيات',
      stage: 'الثالث المتوسط',
      pdfUrl: 'https://www.example.com/math_questions.pdf',
    ),
    BookModel(
      title: 'ملخص الكيمياء العضوية',
      subject: 'الكيمياء',
      stage: 'السادس الإعدادي',
      pdfUrl: 'https://www.example.com/chemistry.pdf',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('مكتبة الكتب والملازم', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: booksList.length,
        itemBuilder: (context, index) {
          final book = booksList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.between,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.menu_book_rounded, color: Color(0xFF38BDF8), size: 26),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${book.subject} • ${book.stage}',
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ).wrap(
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      // هنا سيتم فتح الرابط أو تحميل الملزمة للطالب
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('جاري فتح الملزمة: ${book.title}'),
                          backgroundColor: Colors.indigo,
                        ),
                      );
                    },
                    child: const Text('تحميل / عرض', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
