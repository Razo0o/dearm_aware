import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: unused_import
import 'package:trycam/doctorpages/doctorhome.dart';
import 'package:trycam/doctorpages/doctorchat.dart';

class SelectUserPage extends StatefulWidget {
  final int doctorId;
  final String doctorName;
  const SelectUserPage({
    super.key,
    required this.doctorId,
    required this.doctorName,
  });

  @override
  _SelectUserPageState createState() => _SelectUserPageState();
}

class _SelectUserPageState extends State<SelectUserPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      // جلب المرضى وأطباء الامتياز
      final patientsResponse =
          await supabase.from('user').select('id, full_name');
      final internsResponse =
          await supabase.from('intern').select('id, full_name');

      setState(() {
        users = [
          ...patientsResponse.map((e) => {...e, 'role': 'patient'}),
          ...internsResponse.map((e) => {...e, 'role': 'intern'}),
        ];
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching users: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر مستخدمًا للمحادثة'),
        backgroundColor: const Color(0xFF78C1A3),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        user['role'] == 'patient'
                            ? Icons.person
                            : Icons.medical_services,
                        color: const Color(0xFF78C1A3),
                      ),
                      title: Text(user['full_name']),
                      subtitle:
                          Text(user['role'] == 'patient' ? 'user' : 'intern '),
                      onTap: () {
                        // الانتقال إلى صفحة المحادثة
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorChatPage(
                              doctorId: widget.doctorId,
                              doctorName: widget.doctorName,
                              userId: user['id'],
                              userName: user['full_name'],
                              userRole: user['role'],
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(), // Add the divider here
                  ],
                );
              },
            ),
    );
  }
}
