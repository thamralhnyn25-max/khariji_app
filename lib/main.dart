import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // خلفية كحلي داكنة فخمة
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // الصورة الشخصية مع الحرف الأول
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFF38BDF8),
              child: Text(
                'ث',
                style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'ثامر عبدالله',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            const Text(
              '@thamer_313',
              style: TextStyle(color: Color(0xFF38BDF8), fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),

            // أزرار التحكم السريع (تعيين صورة، تعديل البيانات، الإعدادات)
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

            // بطاقة المعلومات الشخصية
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('نبذة عن نفسك', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 4),
                  const Text('طالب خارجي طموح أسعى لتحقيق أعلى المعدلات.', style: TextStyle(color: Colors.white, fontSize: 14)),
                  const Divider(color: Colors.white12, height: 24),
                  
                  const Text('اسم المستخدم (المعرف)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 4),
                  const Text('@thamer_313', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  const Divider(color: Colors.white12, height: 24),

                  const Text('الصف الدراسي', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 4),
                  const Text('السادس الإعدادي (خارجي)', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
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
  final String title;
  final IconData icon;
  final VoidCallback onTap;

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
              Icon(icon, color: Color(0xFF38BDF8), size: 22),
              const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
