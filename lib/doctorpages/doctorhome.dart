import 'package:flutter/material.dart';
import 'package:trycam/art/artcdisplay.dart';
import 'package:trycam/doctorpages/PatientInfoPage.dart';
import 'package:trycam/doctorpages/chats.dart';
import 'package:trycam/doctorpages/doctorprofile.dart';

class DoctorHomePage extends StatelessWidget {
  final String userId;
  final String userName;
  final String userRole;

  const DoctorHomePage({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF78C1A3),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logoW.png',
              width: 150,
              height: 60,
            ),
          ],
        ),
      ),
      drawer: buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'مرحبًا دكتور $userName',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF384e58),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'لوحة التحكم الخاصة بك',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF384e58),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  buildOptionCard(
                    icon: Icons.person,
                    title: 'معلومات المرضى',
                    onTap: () {
                      // الانتقال إلى صفحة معلومات المرضى
                      try {
                        final doctorId =
                            int.parse(userId); // تحويل userId إلى int
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientsListPage(
                              doctorUserId:
                                  doctorId, // تمرير doctorId كمعرف للطبيب
                            ),
                          ),
                        );
                      } catch (e) {
                        // التعامل مع أي خطأ في التحويل
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('رقم المستخدم غير صالح')),
                        );
                      }
                    },
                  ),
                  buildOptionCard(
                    icon: Icons.chat,
                    title: 'المحادثات',
                    onTap: () {
                      try {
                        final doctorId =
                            int.parse(userId); // تحويل userId إلى int
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectUserPage(
                              doctorId: doctorId,
                              doctorName: userName,
                            ),
                          ),
                        );
                      } catch (e) {
                        // إذا كانت القيمة غير صالحة
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('رقم المستخدم غير صالح')),
                        );
                      }
                    },
                  ),
                  buildOptionCard(
                    icon: Icons.article,
                    title: 'المقالات العلمية',
                    onTap: () {
                      // الانتقال إلى صفحة المقالات العلمية
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                  ),
                  buildOptionCard(
                    icon: Icons.logout,
                    title: 'تسجيل الخروج',
                    onTap: () {
                      // تنفيذ عملية تسجيل الخروج
                      Navigator.pop(context);
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

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF78C1A3),
            ),
            child: Center(
              child: Text(
                'القائمة الجانبية',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('العودة للصفحة الرئيسية'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('الملف الشخصي'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorProfilePage(
                    userId: userId,
                    userRole: userRole,
                  ),
                ),
              ); // الانتقال إلى صفحة الملف الشخصي
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('الإعدادات'),
            onTap: () {
              // الانتقال إلى صفحة الإعدادات
            },
          ),
        ],
      ),
    );
  }

  Widget buildOptionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Color(0xFF77C0B6)),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF384e58),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// صفحات مكانية للمريض والمحادثة والمقالات العلمية
class PatientInfoPage extends StatelessWidget {
  const PatientInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معلومات المرضى'),
      ),
      body: const Center(
        child: Text('صفحة معلومات المرضى'),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المحادثة'),
      ),
      body: const Center(
        child: Text('صفحة المحادثة'),
      ),
    );
  }
}

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المقالات العلمية'),
      ),
      body: const Center(
        child: Text('صفحة المقالات العلمية'),
      ),
    );
  }
}
