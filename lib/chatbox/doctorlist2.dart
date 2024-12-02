import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'chatpage.dart';

class SelectDoctorPagee extends StatelessWidget {
  final int userId; // رقم المستخدم (الاستقبال كـ String)
  final String userRole; // دور المستخدم: patient أو intern
  final String userName;
  final int? caseId;
  final String? caseTitle;
  final SupabaseClient supabase = Supabase.instance.client;

  SelectDoctorPagee({
    super.key,
    required this.userId,
    required this.userRole,
    required this.userName,
    this.caseId,
    this.caseTitle,
  });

  Future<List<Map<String, dynamic>>> fetchDoctors() async {
    final response =
        await supabase.from('users').select().eq('user_role', 'doctor');
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر طبيب للتواصل'),
        backgroundColor: const Color(0xFF78C1A3),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchDoctors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ أثناء جلب الأطباء'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا يوجد أطباء متاحين'));
          } else {
            final doctors = snapshot.data!;
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.local_hospital, // Doctor icon
                        color: const Color(0xFF78C1A3),
                      ),
                      title: Text(doctor['full_name']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              doctorId: doctor['id'],
                              doctorName: doctor['full_name'],
                              userId: userId, // هنا يمرر userId كعدد صحيح
                              userName: userName,
                              userRole: userRole,
                              caseId: caseId ?? null,
                              caseTitle: caseTitle ?? null,
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(), // Add the divider here
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
