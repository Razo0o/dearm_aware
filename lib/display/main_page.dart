import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trycam/WelcomeScreen.dart';
import 'package:trycam/art/artcdisplay.dart';
import 'package:trycam/display/CameraPage.dart';
import 'package:trycam/display/check.dart';
import 'package:trycam/display/show_image.dart';
import 'package:trycam/homepage.dart';
import 'package:trycam/profile/profile.dart'; // استيراد صفحة HomePage
import 'package:trycam/utils/constrants.dart';

class MainPage extends StatefulWidget {
  final String userId; // استقبال userId
  final String userRole; // استقبال userRole
  final String userName;

  const MainPage({
    Key? key,
    required this.userId,
    required this.userRole,
    required this.userName,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ImagePicker picker = ImagePicker();
  XFile? selectedImage;

  // فتح الكاميرا لالتقاط صورة
  Future<void> captureImage() async {
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      cameraStatus = await Permission.camera.request();
    }

    if (cameraStatus.isGranted) {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          selectedImage = image;
        });
        // الانتقال إلى صفحة فحص الأعراض
        navigateToSymptomsCheck(image);
      } else {
        print("لم يتم التقاط صورة");
      }
    } else {
      print("إذن الكاميرا غير ممنوح");
    }
  }

  // اختيار صورة من المعرض
  Future<void> pickImage() async {
    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      await Permission.storage.request();
    }
    if (storageStatus.isGranted) {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          selectedImage = image;
        });
        // الانتقال إلى صفحة فحص الأعراض
        navigateToSymptomsCheck(image);
      }
    }
  }

  // دالة تسجيل الخروج
  void logout(BuildContext context) async {
    await supabase.auth.signOut(); // تسجيل الخروج من Supabase
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    ); // الانتقال إلى شاشة الترحيب
  }

  // الانتقال إلى شاشة عرض الصورة
  void navigateToShowImage(XFile image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowImage(image: image),
      ),
    );
  }

  // الانتقال إلى صفحة فحص الأعراض
  void navigateToSymptomsCheck(XFile image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SymptomsCheckk(
            userImage: image,
            userId: widget.userId, // تمرير userId
            userRole: widget.userRole,
            userName: widget.userName // تمرير userRole
            ),
      ),
    );
  }

  // إنشاء Drawer جانبي
  Widget buildDrawer() {
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    userId: widget.userId,
                    userRole: widget.userRole,
                    userName: widget.userName, // أضف اسم المستخدم هنا
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('البيانات الشخصية'),
            onTap: () {
              // الانتقال إلى صفحة البيانات الشخصية
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    userId: widget.userId,
                    userRole: widget.userRole,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.article),
            title: const Text('المقالات العلمية'),
            onTap: () {
              // الانتقال إلى صفحة المقالات العلمية
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(), // صفحة المقالات العلمية
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('تسجيل الخروج'),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: buildDrawer(), // إضافة Drawer
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            // إضافة الصورة
            Image.asset(
              'assets/images/skin.png', // استبدل بمسار الصورة
              width: 300,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'إضافة حالة جديدة',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xF04f67b3),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'سنساعدك في الحصول على تشخيص باستخدام الذكاء الاصطناعي المدرب لدينا',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xF04f67b3),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraPage(
                      userId: widget.userId,
                      userRole: widget.userRole,
                      userName: widget.userName,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              label: const Text('أخذ صورة للحالة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF78C1A3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '------------ أو ------------',
              style: TextStyle(color: Color(0xF04f67b3)),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: const Icon(Icons.photo_library, color: Colors.white),
              label: const Text('إدراج صورة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF78C1A3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
