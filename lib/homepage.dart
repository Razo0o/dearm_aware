import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trycam/WelcomeScreen.dart';
import 'package:trycam/art/artcdisplay.dart';
import 'package:trycam/chatbox/selectcase2.dart';
import 'package:trycam/display/main_page.dart'; // استيراد صفحة الفحص المباشر
import 'package:trycam/profile/profile.dart'; // استيراد صفحة البروفايل

class HomePage extends StatefulWidget {
  final String userName; // اسم المستخدم الكامل
  final String userId; // رقم المستخدم
  final String userRole; // دور المستخدم (مريض أو طبيب)

  const HomePage({
    Key? key,
    required this.userName,
    required this.userId,
    required this.userRole,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> cases = [];
  bool isLoading = true;

  // تحويل userId إلى int
  int get parsedUserId {
    try {
      return int.parse(widget.userId);
    } catch (e) {
      print("Error parsing userId: ${widget.userId}");
      throw Exception("Invalid userId format. It must be an integer.");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCases();
  }

  // استخراج الاسم الأول من الاسم الكامل
  String getFirstName(String fullName) {
    return fullName.split(' ')[0]; // يفترض أن الاسم الأول هو أول كلمة
  }

  // جلب الحالات السابقة من قاعدة البيانات
  Future<void> fetchCases() async {
    try {
      final tableName =
          widget.userRole == 'patient' ? 'patient_cases' : 'intern_cases';

      // جلب البيانات من الجدول الخاص بالدور
      final List<dynamic>? response = await supabase
          .from(tableName)
          .select(
              'id, title, description, image_url, created_at') // إضافة image_url لجلب الصور
          .eq('user_id', parsedUserId);

      // التحقق من وجود بيانات
      if (response != null && response.isNotEmpty) {
        setState(() {
          cases = List<Map<String, dynamic>>.from(response);
          isLoading = false;
        });
      } else {
        print('No cases found for user_id: $parsedUserId');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching cases: $e');
      setState(() {
        isLoading = false;
      });
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

  @override
  Widget build(BuildContext context) {
    final String firstName = getFirstName(widget.userName);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF78C1A3),
        elevation: 0,
        title: Text(
          'أهلاً, $firstName',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF78C1A3)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      firstName[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF78C1A3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('الملف الشخصي'),
              onTap: () {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('تسجيل الخروج'),
              onTap: () => logout(context),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الخدمات
                    const SizedBox(height: 20),
                    Text(
                      'اختر نوع الخدمة',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainPage(
                                  userId: widget.userId,
                                  userRole: widget.userRole,
                                  userName: widget.userName,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.health_and_safety),
                          label: const Text('الفحص المباشر'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF78C1A3),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectCasePagee(
                                  userId: int.parse(widget.userId),
                                  userRole: widget.userRole,
                                  userName: widget.userName,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.chat),
                          label: const Text('تواصل مع طبيب'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF78C1A3),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // الحالات السابقة
                    const SizedBox(height: 20),
                    Text(
                      'الحالات السابقة',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 10),
                    cases.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cases.length,
                            itemBuilder: (context, index) {
                              final caseItem = cases[index];
                              return Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (caseItem['image_url'] != null &&
                                          caseItem['image_url'].isNotEmpty)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            caseItem['image_url'],
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              caseItem['title'] ?? 'بدون عنوان',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              caseItem['description'] ??
                                                  'بدون وصف',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'لا توجد حالات سابقة حالياً.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
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
