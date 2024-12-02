import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert'; // لإجراء التجزئة
import 'package:crypto/crypto.dart';
import 'package:trycam/auth/LoginScreen.dart'; // مكتبة لتجزئة كلمة المرور

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  DateTime? _selectedDate; // تاريخ الميلاد
  String? _selectedGender; // حقل الجنس
  String? _selectedRole; // حقل الدور (مريض، طبيب، طبيب امتياز)
  final supabase = Supabase.instance.client;
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // دالة لتجزئة كلمة المرور
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  // تسجيل المستخدم في الجدول المناسب
  Future<void> _registerUser() async {
    try {
      // تحديد الجدول بناءً على الدور
      String? targetTable;
      if (_selectedRole == 'مريض') {
        targetTable = 'user';
      } else if (_selectedRole == 'طبيب امتياز') {
        targetTable = 'intern';
      } else if (_selectedRole == 'طبيب') {
        targetTable = 'doctor';
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('يرجى اختيار دور صحيح')),
        );
        return;
      }

      // التحقق من أن البريد الإلكتروني غير موجود مسبقًا
      final existingUser = await supabase
          .from(targetTable)
          .select('email')
          .eq('email', _emailController.text)
          .maybeSingle();

      if (existingUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('البريد الإلكتروني مسجل مسبقًا')),
        );
        return;
      }

      // إدخال بيانات المستخدم في الجدول
      final response = await supabase.from(targetTable).insert({
        'full_name': _nameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'pass': _hashPassword(_passwordController.text),
        'gender': _selectedGender,
        'birthdate': _selectedDate?.toIso8601String(),
      }).select();

      // ignore: unnecessary_null_comparison
      if (response != null && response.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تسجيل الحساب بنجاح')),
        );
        // الانتقال إلى صفحة تسجيل الدخول
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        throw Exception('فشل تسجيل الحساب، يرجى المحاولة مرة أخرى');
      }
    } catch (e) {
      print('Error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تسجيل البيانات: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF78C1A3), // اللون الخلفي للشاشة
      appBar: AppBar(
        backgroundColor: const Color(0xFF78C1A3), // نفس لون الخلفية
        elevation: 0, // إزالة الظل
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black), // أيقونة X
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ); // العودة لصفحة تسجيل الدخول
          },
        ),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'تسجيل حساب جديد',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // حقل الاسم الكامل
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'الإسم الكامل',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال الاسم الكامل.';
                            } else if (value.length > 35) {
                              return 'الاسم يجب أن يكون أقل من 35 حرفًا.';
                            } else {
                              final nameRegex = RegExp(
                                  r'^[a-zA-Z\u0600-\u06FF\s]+$'); // الحروف فقط
                              final arabicNumbersRegex =
                                  RegExp(r'[\u0660-\u0669]'); // الأرقام العربية
                              if (!nameRegex.hasMatch(value) ||
                                  arabicNumbersRegex.hasMatch(value)) {
                                return 'الاسم يجب أن يحتوي فقط على أحرف بدون أرقام.';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        // حقل رقم الجوال
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: 'رقم الجوال',
                            prefixIcon: const Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال رقم الجوال';
                            }
                            if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                              return 'يجب أن يتكون رقم الجوال من 10 أرقام فقط';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        // حقل البريد الإلكتروني
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'البريد الإلكتروني',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال البريد الإلكتروني';
                            }
                            if (!emailRegex.hasMatch(value)) {
                              return 'يرجى إدخال بريد إلكتروني صالح';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        // حقل كلمة المرور
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور',
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال كلمة المرور';
                            }
                            if (!RegExp(
                                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@])[A-Za-z\d@]{8,}$')
                                .hasMatch(value)) {
                              return 'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل (حروف كبيرة وصغيرة، أرقام، ورمز @)';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        // حقل تأكيد كلمة المرور
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'تأكيد كلمة المرور',
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى تأكيد كلمة المرور';
                            } else if (value != _passwordController.text) {
                              return 'كلمات المرور غير متطابقة';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        // حقل الجنس
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          decoration: InputDecoration(
                            labelText: 'الجنس',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          items: ['ذكر', 'أنثى']
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'يرجى الاختيار ';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        // حقل تاريخ الميلاد
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'تاريخ الميلاد',
                            hintText: _selectedDate != null
                                ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                                : 'اختر تاريخ الميلاد',
                            prefixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            }
                          },
                          validator: (value) {
                            if (_selectedDate == null) {
                              return 'يرجى اختيار تاريخ الميلاد';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        // حقل الدور
                        DropdownButtonFormField<String>(
                          value: _selectedRole,
                          decoration: InputDecoration(
                            labelText: 'الدور',
                            prefixIcon: const Icon(Icons.work_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          items: ['مريض', 'طبيب امتياز', 'طبيب']
                              .map((role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedRole = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'يرجى اختيار الدور';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // زر تسجيل
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _registerUser();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF78C1A3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 50),
                            ),
                            child: const Text(
                              'تسجيل',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
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
