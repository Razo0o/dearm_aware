import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PatientDetailsPage extends StatefulWidget {
  final String email;
  final String name;
  final String birthDate;

  const PatientDetailsPage({
    Key? key,
    required this.email,
    required this.name,
    required this.birthDate,
  }) : super(key: key);

  @override
  _PatientDetailsPageState createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> cases = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPatientCases();
  }

  Future<void> fetchPatientCases() async {
    try {
      // جلب id للمريض من جدول user الفرعي باستخدام email
      final userResponse = await supabase
          .from('user')
          .select('id')
          .eq('email', widget.email)
          .maybeSingle();

      if (userResponse == null || userResponse['id'] == null) {
        print('Error fetching user ID for email: ${widget.email}');
        setState(() {
          isLoading = false;
        });
        return;
      }

      final userId = userResponse['id'];

      // جلب الحالات من جدول patient_cases باستخدام id
      final casesResponse = await supabase
          .from('patient_cases')
          .select('title, description, image_url')
          .eq('user_id', userId);

      // التحقق من أن الاستجابة ليست null
      // ignore: unnecessary_null_comparison
      if (casesResponse == null) {
        print('Error: No data returned for patient cases.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      // تحديث قائمة الحالات
      setState(() {
        cases = List<Map<String, dynamic>>.from(casesResponse as List<dynamic>);
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching patient cases: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return date; // إذا حدث خطأ، يعرض التاريخ كما هو
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المريض: ${widget.name}'),
        backgroundColor: const Color(0xFF78C1A3),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('الاسم: ${widget.name}',
                          style: const TextStyle(fontSize: 18)),
                      Text('البريد الإلكتروني: ${widget.email}',
                          style: const TextStyle(fontSize: 18)),
                      Text('تاريخ الميلاد: ${formatDate(widget.birthDate)}',
                          style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: cases.length,
                    itemBuilder: (context, index) {
                      final caseData = cases[index];
                      return ListTile(
                        title: Text(caseData['title'] ?? 'No Title'),
                        subtitle:
                            Text(caseData['description'] ?? 'No Description'),
                        trailing: caseData['image_url'] != null &&
                                caseData['image_url']!.isNotEmpty
                            ? Image.network(
                                caseData['image_url'],
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Text('Invalid Image');
                                },
                              )
                            : const Text('No Image'),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
