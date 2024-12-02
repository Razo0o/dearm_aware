import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  final String userId; // رقم المستخدم
  final String userRole; // دور المستخدم: patient أو intern

  const ProfilePage({
    Key? key,
    required this.userId,
    required this.userRole,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final supabase = Supabase.instance.client; // Supabase Client
  Map<String, dynamic>? userData; // بيانات المستخدم
  bool isLoading = true; // حالة التحميل

  @override
  void initState() {
    super.initState();
    fetchUserData(); // جلب بيانات المستخدم عند فتح الصفحة
  }

  // جلب بيانات المستخدم
  Future<void> fetchUserData() async {
    try {
      final tableName =
          widget.userRole == 'patient' ? 'user' : 'intern'; // تحديد الجدول

      final response = await supabase
          .from(tableName)
          .select(
              'full_name, phone, email, gender, birthdate') // تجاهل id و password
          .eq('id', int.parse(widget.userId))
          .single();

      // ignore: unnecessary_null_comparison
      if (response != null) {
        setState(() {
          userData = response; // تخزين البيانات
          isLoading = false; // إيقاف مؤشر التحميل
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // التحقق من رقم الهاتف
  bool validatePhone(String? phone) {
    final phoneRegex = RegExp(r'^\d{10}$');
    if (phone == null || !phoneRegex.hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('رقم الهاتف غير صحيح، يجب أن يكون مكونًا من 10 أرقام.')),
      );
      return false;
    }
    return true;
  }

  // التحقق من كلمة المرور
  bool validatePassword(String? password) {
    // تعديل التعبير المنتظم لمنع المسافات
    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@])[A-Za-z\d@]{8,20}$');
    final spaceRegex = RegExp(r'\s'); // التحقق من وجود مسافات

    if (password == null ||
        !passwordRegex.hasMatch(password) ||
        spaceRegex.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'كلمة المرور يجب أن تكون بين 8 و20 حرفًا، تحتوي على أحرف كبيرة وصغيرة وأرقام ورمز @، وبدون مسافات.')),
      );
      return false;
    }
    return true;
  }

  // التحقق من البريد الإلكتروني
  bool validateEmail(String? email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email == null ||
        email.isEmpty ||
        email.length > 35 ||
        !emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'البريد الإلكتروني غير صحيح أو طويل جدًا (أقل من 35 حرفًا).')),
      );
      return false;
    }
    return true;
  }

  bool validateName(String? name) {
    final nameRegex = RegExp(
        r'^[a-zA-Z\u0600-\u06FF\s]+$'); // فقط الأحرف الإنجليزية والعربية والمسافات
    final arabicNumbersRegex = RegExp(r'[\u0660-\u0669]'); // الأرقام العربية

    if (name == null ||
        name.isEmpty ||
        name.length > 35 ||
        !nameRegex.hasMatch(name) ||
        arabicNumbersRegex.hasMatch(name)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'الاسم يجب أن يحتوي فقط على أحرف وأقل من 35 حرفًا بدون أرقام.')),
      );
      return false;
    }
    return true;
  }

  // تشفير كلمة المرور
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  Future<void> updateUserData(Map<String, dynamic> updatedData) async {
    try {
      final tableName =
          widget.userRole == 'patient' ? 'user' : 'intern'; // تحديد الجدول

      // التحقق إذا كان البريد الإلكتروني موجودًا مسبقًا
      if (updatedData.containsKey('email')) {
        final emailCheckResponse = await supabase
            .from('users')
            .select('id')
            .eq('email', updatedData['email'])
            .maybeSingle();

        if (emailCheckResponse != null && emailCheckResponse['id'] != null) {
          // إذا كان البريد الإلكتروني موجودًا بالفعل
          if (int.parse(widget.userId) != emailCheckResponse['id']) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('البريد الإلكتروني مستخدم بالفعل!')),
            );
            return; // أوقف عملية التحديث
          }
        }
      }

      // تنفيذ التحديث في الجدول المحدد
      await supabase
          .from(tableName)
          .update(updatedData)
          .eq('id', int.parse(widget.userId));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تحديث البيانات بنجاح!')),
      );
      fetchUserData(); // تحديث البيانات
    } catch (e) {
      print('Error updating user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل تحديث البيانات!')),
      );
    }
  }

  void showEditDataDialog() {
    final fullNameController =
        TextEditingController(text: userData!['full_name']);
    final phoneController = TextEditingController(text: userData!['phone']);
    final emailController = TextEditingController(text: userData!['email']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل البيانات الشخصية'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(labelText: 'الاسم الكامل'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'رقم الهاتف'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedData = <String, dynamic>{};

              // التحقق من الاسم
              if (fullNameController.text != userData!['full_name']) {
                if (validateName(fullNameController.text)) {
                  updatedData['full_name'] = fullNameController.text.trim();
                } else {
                  return; // إذا فشل التحقق، لا تكمل
                }
              }

              // التحقق من رقم الهاتف
              if (phoneController.text != userData!['phone']) {
                if (validatePhone(phoneController.text)) {
                  updatedData['phone'] = phoneController.text.trim();
                } else {
                  return; // إذا فشل التحقق، لا تكمل
                }
              }

              // التحقق من البريد الإلكتروني
              if (emailController.text != userData!['email']) {
                if (validateEmail(emailController.text)) {
                  updatedData['email'] = emailController.text.trim();
                } else {
                  return; // إذا فشل التحقق، لا تكمل
                }
              }

              // تنفيذ التحديث فقط إذا كان هناك تغييرات
              if (updatedData.isNotEmpty) {
                updateUserData(updatedData);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('لا توجد تغييرات للتحديث!')),
                );
              }

              Navigator.pop(context); // إغلاق الحوار
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  // تغيير كلمة المرور
  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      final passwordRegex =
          RegExp(r'^[A-Za-z\d@]+$'); // فقط الأحرف والأرقام والرمز @
      if (!passwordRegex.hasMatch(oldPassword)) {
        throw Exception(
            'كلمة المرور القديمة يجب أن تحتوي على أحرف، أرقام، ورمز @ فقط، وبدون مسافات.');
      }

      // التحقق من أن كلمة المرور القديمة لا تزيد عن 20 حرفًا
      if (oldPassword.length > 20) {
        throw Exception('كلمة المرور القديمة يجب ألا تزيد عن 20 حرفًا.');
      }

      final tableName =
          widget.userRole == 'patient' ? 'user' : 'intern'; // تحديد الجدول
      final hashedOldPassword = _hashPassword(oldPassword);

      final response = await supabase
          .from(tableName)
          .select('pass')
          .eq('id', int.parse(widget.userId))
          .maybeSingle();

      if (response == null) {
        throw Exception('فشل في جلب كلمة المرور الحالية.');
      }

      final currentPassword = response['pass'];

      if (currentPassword != hashedOldPassword) {
        throw Exception('كلمة المرور القديمة غير صحيحة.');
      }

      final hashedNewPassword = _hashPassword(newPassword);

      await supabase.from(tableName).update({'pass': hashedNewPassword}).eq(
          'id', int.parse(widget.userId));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح!')),
      );
    } catch (e) {
      print('Error changing password: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في تغيير كلمة المرور: $e')),
      );
    }
  }

  // عرض نموذج تغيير كلمة المرور
  // عرض نموذج تغيير كلمة المرور
  void showChangePasswordDialog() {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تغيير كلمة المرور'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPasswordController,
              decoration:
                  const InputDecoration(labelText: 'كلمة المرور القديمة'),
              obscureText: true,
            ),
            TextField(
              controller: newPasswordController,
              decoration:
                  const InputDecoration(labelText: 'كلمة المرور الجديدة'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(labelText: 'تأكيد كلمة المرور'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (!validatePassword(newPasswordController.text)) return;
              if (newPasswordController.text !=
                  confirmPasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('كلمات المرور غير متطابقة!')),
                );
                return;
              }
              changePassword(
                oldPasswordController.text,
                newPasswordController.text,
              ).then((_) => Navigator.pop(context));
            },
            child: const Text('تغيير'),
          ),
        ],
      ),
    );
  }

  // عرض جميع البيانات
  Widget buildUserInfo() {
    return Column(
      children: [
        buildInfoCard('الاسم الكامل', userData!['full_name'], Icons.person),
        buildInfoCard('رقم الهاتف', userData!['phone'], Icons.phone),
        buildInfoCard('البريد الإلكتروني', userData!['email'], Icons.email),
        buildInfoCard('الجنس', userData!['gender'] == 'male' ? 'ذكر' : 'أنثى',
            Icons.person_outline),
        buildInfoCard('تاريخ الميلاد', userData!['birthdate'], Icons.cake),
      ],
    );
  }

  Widget buildInfoCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.grey),
        title: Text(title),
        subtitle: Text(value),
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
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'بيانات المستخدم',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF78C1A3),
                          ),
                        ),
                        const SizedBox(height: 20),
                        buildUserInfo(),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: showEditDataDialog,
                          child: const Text('تعديل البيانات'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: showChangePasswordDialog,
                          child: const Text('تغيير كلمة المرور'),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: Text('لم يتم العثور على بيانات المستخدم.'),
                ),
    );
  }
}
