import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trycam/doctorpages/PatientDetailsPage.dart';

class PatientsListPage extends StatefulWidget {
  final int doctorUserId; // معرف الطبيب في جدول users

  const PatientsListPage({Key? key, required this.doctorUserId})
      : super(key: key);

  @override
  _PatientsListPageState createState() => _PatientsListPageState();
}

class _PatientsListPageState extends State<PatientsListPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> patients = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    try {
      // استرجاع البريد الإلكتروني للطبيب من الجدول الفرعي
      final doctorEmailResponse = await supabase
          .from('doctor') // الجدول الفرعي
          .select('email')
          .eq('id', widget.doctorUserId)
          .maybeSingle();

      if (doctorEmailResponse == null || doctorEmailResponse['email'] == null) {
        print('Error: No email found for doctor.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      final doctorEmail = doctorEmailResponse['email'];
      print('Doctor Email: $doctorEmail');

      // استرجاع id للطبيب من جدول users باستخدام البريد الإلكتروني
      final doctorUserIdResponse = await supabase
          .from('users') // الجدول الرئيسي
          .select('id')
          .eq('email', doctorEmail)
          .maybeSingle();

      if (doctorUserIdResponse == null || doctorUserIdResponse['id'] == null) {
        print('Error: No user ID found for doctor email.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      final doctorUserId = doctorUserIdResponse['id'];
      print('Doctor User ID from users table: $doctorUserId');

      // استرجاع الرسائل التي أرسلها الطبيب إلى المستخدمين (patients)
      final messagesResponse = await supabase
          .from('messages')
          .select('receiver_id')
          .eq('sender_id', doctorUserId) // استخدام الـ ID المستخرج من users
          .eq('receiver_type', 'user');

      print('Messages response: $messagesResponse');

      // ignore: unnecessary_null_comparison
      if (messagesResponse == null || (messagesResponse as List).isEmpty) {
        // ignore: avoid_print
        print('No messages found for this doctor.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      // استخراج جميع receiver_id بدون تكرار
      final uniqueReceiverIds = (messagesResponse as List<dynamic>)
          .map((message) => message['receiver_id'])
          .toSet()
          .toList();

      print('Unique Receiver IDs: $uniqueReceiverIds');

      // التحقق من أن القائمة ليست فارغة
      if (uniqueReceiverIds.isEmpty) {
        print('No patients found.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      // جلب جميع المستخدمين ثم تصفية البيانات يدويًا
      final usersResponse = await supabase
          .from('users')
          .select('id, full_name, email, birthdate');

      print('Users response: $usersResponse');

      // ignore: unnecessary_null_comparison
      if (usersResponse == null || (usersResponse as List).isEmpty) {
        print('Error: No data returned for users.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      // تصفية المستخدمين يدويًا بناءً على uniqueReceiverIds
      final filteredUsers = (usersResponse as List<dynamic>).where((user) {
        return uniqueReceiverIds.contains(user['id']);
      }).toList();

      setState(() {
        patients = List<Map<String, dynamic>>.from(filteredUsers);
        isLoading = false;
      });

      print('Filtered Patients: $patients');
    } catch (e) {
      print('Error fetching patients: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المرضى'),
        backgroundColor: const Color(0xFF78C1A3),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                return ListTile(
                  title: Text(patient['full_name']),
                  subtitle: Text(patient['email']),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // الانتقال إلى صفحة تفاصيل المريض
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientDetailsPage(
                          email: patient['email'],
                          name: patient['full_name'],
                          birthDate: patient['birthdate'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
