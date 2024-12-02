import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trycam/chatbox/doctorlist2.dart';

class SelectCasePagee extends StatelessWidget {
  final int userId; // معرف المستخدم كعدد صحيح
  final String userName; // اسم المستخدم
  final String userRole; // دور المستخدم (مريض، طبيب امتياز، إلخ)
  final supabase = Supabase.instance.client;

  // تعديل الـ Constructor لاستقبال المتغيرات المطلوبة كـ int و String حسب النوع
  SelectCasePagee({
    required this.userId,
    required this.userName,
    required this.userRole,
  });

  Future<List<Map<String, dynamic>>> fetchCases() async {
    // استخدام userRole لتحديد الجدول المناسب بناءً على نوع المستخدم
    final tableName = userRole == 'patient' ? 'patient_cases' : 'intern_cases';
    final response =
        await supabase.from(tableName).select().eq('user_id', userId);
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختر حالة لإرسالها إلى الطبيب'),
        backgroundColor: const Color(0xFF78C1A3),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchCases(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ أثناء جلب الحالات'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد حالات سابقة'));
          } else {
            final cases = snapshot.data!;
            return ListView.separated(
              itemCount: cases.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              itemBuilder: (context, index) {
                final caseData = cases[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: caseData['image_url'] != null
                      ? Image.network(
                          caseData['image_url'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                  title: Text(
                    caseData['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    caseData['description'] ?? 'لا يوجد وصف',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectDoctorPagee(
                          userId: userId, // هنا يمرر userId كعدد صحيح
                          userName: userName,
                          userRole: userRole,
                          caseId: caseData['id'],
                          caseTitle: caseData['title'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectDoctorPagee(
                userId: userId, // هنا يمرر userId كعدد صحيح
                userName: userName,
                userRole: userRole,
                caseId: null,
                caseTitle: null,
              ),
            ),
          );
        },
        child: const Icon(Icons.message),
        backgroundColor: const Color(0xFF78C1A3),
      ),
    );
  }
}
