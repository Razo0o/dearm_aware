import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:trycam/chatbox/doctorlist2.dart';
import 'package:trycam/homepage.dart';
import 'disease.dart'; // استيراد كلاس Disease

class SymptomsCheckk extends StatefulWidget {
  final XFile userImage; // الصورة التي يرفعها المستخدم
  final String userId; // رقم المستخدم
  final String userRole; // دور المستخدم: patient أو intern
  final String userName;

  const SymptomsCheckk({
    Key? key,
    required this.userImage,
    required this.userId,
    required this.userRole,
    required this.userName,
  }) : super(key: key);

  @override
  _SymptomsCheckkState createState() => _SymptomsCheckkState();
}

class _SymptomsCheckkState extends State<SymptomsCheckk> {
  String? modelPrediction; // المرض المتوقع من الموديل
  String? modelPredictionConfidence; // مستوى الثقة في التنبؤ
  bool isLoading = true; // حالة التحميل
  Disease? predictedDisease; // بيانات المرض المتوقع
  String? uploadedImageUrl; // رابط الصورة المرفوعة
  int? caseId;
  final supabase = Supabase.instance.client; // Supabase Client

  @override
  void initState() {
    super.initState();
    processImage(); // استدعاء المعالجة عند التهيئة
  }

// تحويل userId إلى int
  int get parsedUserId {
    try {
      return int.parse(widget.userId);
    } catch (e) {
      print("Error parsing userId: ${widget.userId}");
      throw Exception("Invalid userId format. It must be an integer.");
    }
  }

  // تحديد الجدول بناءً على userRole
  String get tableName {
    switch (widget.userRole) {
      case 'patient':
        return 'patient_cases';
      case 'intern':
        return 'intern_cases';
      default:
        throw Exception("Invalid role: ${widget.userRole}");
    }
  }

  // دالة لمعالجة الصورة (رفعها ثم إرسالها للتنبؤ)
  Future<void> processImage() async {
    setState(() {
      isLoading = true;
    });

    // رفع الصورة إلى Supabase Storage والحصول على الرابط
    final imageUrl =
        await uploadImageToSupabase(widget.userImage.path, widget.userId);

    if (imageUrl == null) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل في رفع الصورة!')),
      );
      return;
    }

    setState(() {
      uploadedImageUrl = imageUrl;
    });

    // طلب التنبؤ من الموديل باستخدام الصورة
    await getModelPrediction();
  }

  // دالة لرفع الصور إلى Supabase Storage
  Future<String?> uploadImageToSupabase(String filePath, String userId) async {
    try {
      final file = File(filePath);
      final fileName =
          'uploads/${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // رفع الصورة إلى الباكت (bucket) في Supabase
      final response =
          await supabase.storage.from('images').upload(fileName, file);

      if (response.isEmpty) {
        print('Error uploading image: Failed to upload file.');
        return null;
      }

      // الحصول على الرابط العام للصورة
      final publicUrl = supabase.storage.from('images').getPublicUrl(fileName);
      print('Uploaded Image URL: $publicUrl');
      return publicUrl; // إرجاع رابط الصورة المرفوعة
    } catch (e) {
      print('Error during image upload: $e');
      return null;
    }
  }

  // دالة لتحويل الصورة إلى Base64
  Future<String> encodeImageToBase64(XFile image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  // دالة للتنبؤ بالمرض باستخدام الموديل
  Future<void> getModelPrediction() async {
    final url = Uri.parse(
        'https://dermamodel-c0c9bb7a23c6.herokuapp.com/predict'); // API URL

    try {
      final encodedImage = await encodeImageToBase64(widget.userImage);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': encodedImage}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          modelPrediction = responseData['predicted_label'];
          modelPredictionConfidence = responseData['confidence'].toString();

          // البحث عن المرض المتطابق بناءً على الاستجابة
          if (modelPrediction != null && modelPrediction!.isNotEmpty) {
            predictedDisease = diseases.firstWhere(
              (disease) =>
                  disease.englishName.toLowerCase() ==
                  modelPrediction!.toLowerCase(),
              orElse: () => Disease(
                name: "عذرا, لايمكن معرفة المرض حاليا",
                englishName: "No matching disease",
                description: " ",
                symptoms: [],
              ),
            );
          }

          isLoading = false;
        });

        caseId = await saveCaseToDatabase();
        print('Case saved successfully with ID: $caseId');
      } else {
        setState(() {
          modelPrediction = "Error: ${response.body}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        modelPrediction = "Error sending data to server: $e";
        isLoading = false;
      });
    }
  }

  // دالة لحفظ الحالة في Supabase
  Future<int?> saveCaseToDatabase() async {
    try {
      if (modelPrediction == null || modelPrediction!.isEmpty) {
        throw Exception("Prediction is empty or not available.");
      }
      if (uploadedImageUrl == null || uploadedImageUrl!.isEmpty) {
        throw Exception("Image URL is empty or not available.");
      }

      final response = await supabase
          .from(tableName)
          .insert({
            'user_id': parsedUserId,
            'title': modelPrediction ?? 'غير معروف',
            'description': predictedDisease?.description ?? 'لا يوجد وصف',
            'image_url': uploadedImageUrl,
            'created_at': DateTime.now().toIso8601String(),
          })
          .select('id') // استرجاع الحقل id الخاص بالحالة
          .single();

      // ignore: unnecessary_null_comparison
      if (response != null && response['id'] != null) {
        final caseId = response['id'] as int;
        print(
            'Case saved successfully with ID: $caseId'); // طباعة الـ ID في الكونسول

        // عرض رسالة نجاح في التطبيق
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم حفظ الحالة بنجاح! رقم الحالة: $caseId')),
        );

        return caseId; // إرجاع id الخاص بالحالة
      } else {
        throw Exception("Failed to retrieve case ID after insertion.");
      }
    } catch (e) {
      print('Error saving case: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء حفظ الحالة: $e')),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF77C0B6),
        title: const Text(
          "نتيجة التشخيص",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator() // حالة التحميل
            : Card(
                elevation: 8,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
            child: SingleChildScrollView( // إضافة هذا العنصر لجعل المحتوى قابلاً للتمرير
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "نتائج التشخيص",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF40788C),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(widget.userImage.path),
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "المرض المتوقع: ${predictedDisease?.name ?? modelPrediction}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const Divider(height: 40, thickness: 1),
                      if (predictedDisease != null) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "وصف المرض",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF40788C),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                predictedDisease!.description,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "الأعراض المرتبطة",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF40788C),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...predictedDisease!.symptoms.map(
                                (symptom) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          symptom,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.teal,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      // تعديل الأزرار ووضعها في صفوف مرتبة
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                            Expanded(
                              child: ElevatedButton.icon(                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectDoctorPagee(
                                    userId: int.parse(widget.userId),
                                    userRole: widget.userRole,
                                    userName: widget.userName,
                                    caseId: caseId,
                                    caseTitle: modelPrediction,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.chat),
                                label: const Text("محادثة مع طبيب",
                                        style: TextStyle(fontSize: 14), // Smaller font size
                                      ),
                              style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF78C1A3),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          ),
                            const SizedBox(width: 10),
                            // زر العودة للصفحة الرئيسية
                            Expanded(
                              child:ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    userId: widget.userId,
                                    userRole: widget.userRole,
                                    userName: widget.userName,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.home),
                                  label: const Text(
                                        "العودة للصفحة الرئيسية",
                                        style: TextStyle(fontSize: 13), // Smaller font size
                                      ),
                              style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF78C1A3),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
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
      ),
    );
  }
}
