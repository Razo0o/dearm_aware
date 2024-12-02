import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:trycam/auth/SignUpScreen.dart';
import 'package:trycam/doctorpages/doctorhome.dart';
import 'package:trycam/homepage.dart'; // استيراد الصفحة الرئيسية
// ignore: duplicate_import

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedRole = 0; // 0: مريض, 1: طبيب الامتياز, 2: طبيب
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final supabase = Supabase.instance.client;
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // تشفير كلمة المرور
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  // تسجيل الدخول
  Future<void> _loginUser() async {
    try {
      // تحديد الجدول بناءً على الدور
      String? targetTable;
      if (selectedRole == 0) {
        targetTable = 'user'; // جدول المرضى
      } else if (selectedRole == 1) {
        targetTable = 'intern'; // جدول أطباء الامتياز
      } else if (selectedRole == 2) {
        targetTable = 'doctor'; // جدول الأطباء
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('يرجى اختيار دور صحيح')),
        );
        return;
      }

      // تشفير كلمة المرور المدخلة
      final hashedPassword = _hashPassword(_passwordController.text);

      // التحقق من البريد الإلكتروني وكلمة المرور في الجدول المناسب
      final response = await supabase
          .from(targetTable)
          .select()
          .eq('email', _emailController.text)
          .eq('pass', hashedPassword)
          .maybeSingle();

      if (response == null) {
        // فشل تسجيل الدخول
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('البريد الإلكتروني أو كلمة المرور غير صحيحة')),
        );
      } else {
        // نجاح تسجيل الدخول
        final userId = response['id'].toString(); // تحويل id إلى String
        final userName = response['full_name']; // جلب اسم المستخدم

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
        );

        // التوجيه إلى الصفحة الرئيسية مع تمرير بيانات المستخدم
// التوجيه إلى الصفحة الرئيسية مع تمرير بيانات المستخدم
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => selectedRole == 2
                ? DoctorHomePage(
                    // إذا كان الدور هو Doctor
                    userId: userId,

                    userName: userName,
                    userRole: 'doctor',
                  )
                : HomePage(
                    // للأدوار الأخرى
                    userId: userId,
                    userRole: selectedRole == 0 ? 'patient' : 'intern',
                    userName: userName,
                  ),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ غير متوقع')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF78C1A3),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logoW.png',
                        height: 150,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(221, 234, 232, 232),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // حقل البريد الإلكتروني
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFF78C1A3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFF78C1A3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال البريد الإلكتروني';
                          }
                          if (!RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                              .hasMatch(value)) {
                            return 'يرجى إدخال بريد إلكتروني صالح';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // حقل كلمة المرور
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال كلمة المرور';
                          }
                          if (!RegExp(
                                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@])[A-Za-z\d@]+$')
                              .hasMatch(value)) {
                            return 'يجب أن تحتوي كلمة المرور على حروف كبيرة وصغيرة، أرقام، ورمز @ فقط';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // اختيار الدور
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ChoiceChip(
                            label: const Text('مريض'),
                            selected: selectedRole == 0,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedRole = 0;
                              });
                            },
                            selectedColor: const Color(0xFF78C1A3),
                            backgroundColor: Colors.grey[300],
                            labelStyle: TextStyle(
                              color: selectedRole == 0
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          ChoiceChip(
                            label: const Text('طبيب الامتياز'),
                            selected: selectedRole == 1,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedRole = 1;
                              });
                            },
                            selectedColor: const Color(0xFF78C1A3),
                            backgroundColor: Colors.grey[300],
                            labelStyle: TextStyle(
                              color: selectedRole == 1
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          ChoiceChip(
                            label: const Text('طبيب'),
                            selected: selectedRole == 2,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedRole = 2;
                              });
                            },
                            selectedColor: const Color(0xFF78C1A3),
                            backgroundColor: Colors.grey[300],
                            labelStyle: TextStyle(
                              color: selectedRole == 2
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // زر تسجيل الدخول
                      ElevatedButton(
                        onPressed: _loginUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF78C1A3),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'تسجيل الدخول',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // خيار تسجيل حساب جديد
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SignUpScreen(), // شاشة التسجيل
                            ),
                          );
                        },
                        child: const Text(
                          'ليس لدي حساب؟ إنشاء حساب جديد',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
