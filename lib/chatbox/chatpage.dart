import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trycam/homepage.dart';

class ChatPage extends StatefulWidget {
  final int doctorId;
  final int? caseId;
  final String? caseTitle;
  final int userId;
  final String userRole; // يجب أن يكون واحد من: 'user', 'doctor', 'intern'
  final String userName;
  final String doctorName;

  const ChatPage({
    Key? key,
    required this.doctorId,
    required this.doctorName,
    required this.userId,
    required this.userRole,
    required this.userName,
    this.caseId,
    this.caseTitle,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  bool isLoading = true;
  int? senderId;
  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    try {
      // جلب الإيميل الخاص بالمستخدم الحالي من الجدول الفردي
      final userEmail = await getUserEmail(widget.userId, widget.userRole);

      if (userEmail == null) {
        print('Error fetching user email: No email found');
        setState(() {
          isLoading = false;
        });
        return;
      }

      // جلب الـ id من جدول users باستخدام الإيميل
      final userIdResponse = await supabase
          .from('users')
          .select('id')
          .eq('email', userEmail)
          .maybeSingle();

      if (userIdResponse == null || userIdResponse['id'] == null) {
        print('Error fetching user ID: No ID found in users table');
        setState(() {
          isLoading = false;
        });
        return;
      }

      final userId = userIdResponse['id'];
      setState(() {
        senderId = userId;
      });

      print('Fetched senderId: $senderId');
      // جلب الرسائل المرتبطة بالمستخدم
      final patientMessages = await supabase
          .from('messages')
          .select(
              'message_text, sender_id, receiver_id, timestamp, image_title, image_desc, image_url') // جلب الحقول المطلوبة
          .or('sender_id.eq.$userId,receiver_id.eq.$userId')
          .order('timestamp', ascending: true);

      // ignore: unnecessary_null_comparison
      if (patientMessages != null && patientMessages.isNotEmpty) {
        // تصفية الرسائل لتخص الطبيب المحدد فقط
        final filteredMessages = patientMessages.where((message) {
          return (message['sender_id'] == widget.doctorId ||
              message['receiver_id'] == widget.doctorId);
        }).toList();

        setState(() {
          messages = List<Map<String, dynamic>>.from(filteredMessages);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          print('Error fetching messages: No data found');
        });
      }
    } catch (e) {
      print('Error fetching messages: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String?> getUserEmail(int userId, String userRole) async {
    try {
      String tableName;
      String idColumn;

      // تحديد الجدول وعمود id بناءً على دور المستخدم
      if (userRole == 'patient') {
        tableName = 'user';
        idColumn = 'id';
      } else if (userRole == 'intern') {
        tableName = 'intern';
        idColumn = 'id';
      } else if (userRole == 'doctor') {
        tableName = 'doctor';
        idColumn = 'id';
      } else {
        print('Error: Invalid user role');
        return null;
      }

      // جلب الإيميل من الجدول المناسب
      final response = await supabase
          .from(tableName)
          .select('email')
          .eq(idColumn, userId)
          .maybeSingle();

      return response?['email'];
    } catch (e) {
      print('Error fetching user email: $e');
      return null;
    }
  }

  Future<void> sendMessage(String messageText) async {
    if (messageText.trim().isEmpty) {
      return;
    }

    try {
      // استرجاع البريد الإلكتروني للمستخدم الحالي
      final userEmail = await getUserEmail(widget.userId, widget.userRole);
      if (userEmail == null) {
        print('Error: No email found for user.');
        return;
      }

      // استرجاع الـ id من جدول users باستخدام البريد الإلكتروني
      final userIdResponse = await supabase
          .from('users')
          .select('id')
          .eq('email', userEmail)
          .maybeSingle();

      if (userIdResponse == null || userIdResponse['id'] == null) {
        print('Error: No ID found in users table for email $userEmail.');
        return;
      }

      final senderId = userIdResponse['id'];

      // طباعة الـ id في الكونسول
      print('User ID from users table: $senderId');

      // التأكد من قيمة sender_type
      var senderType = widget.userRole.toLowerCase();
      if (senderType == 'patient') {
        senderType = 'user';
      }

      if (!['user', 'intern', 'doctor'].contains(senderType)) {
        print('Error: Invalid sender_type value.');
        return;
      }

      // جلب تفاصيل الحالة إذا كانت موجودة
      Map<String, String>? caseDetails = await getCaseDetails(widget.caseId);
      if (caseDetails == null) {
        print('No case details found.');
      } else {
        print('Case details fetched: $caseDetails');
      }
      // إعداد النص الكامل للرسالة
      String fullMessageText = messageText.trim();

      // إعداد الرسالة الجديدة
      final newMessage = {
        'case_id': widget.caseId,
        'sender_id': senderId,
        'sender_type': senderType,
        'receiver_id': widget.doctorId,
        'receiver_type': 'doctor',
        'message_text': fullMessageText,
        'timestamp': DateTime.now().toIso8601String(),
        'image_title': caseDetails?['title'] ?? null,
        'image_desc': caseDetails?['description'] ?? null,
        'image_url': caseDetails?['image_url'] ?? '',
      };

      print('New Message: $newMessage');

      final response = await supabase.from('messages').insert(newMessage);

      if (response != null && response.isNotEmpty) {
        setState(() {
          messages.add(Map<String, dynamic>.from(response[0]));
        });
      } else {
        print('Message sent but response is empty. Fetching messages again.');
        await fetchMessages();
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Future<Map<String, String>?> getCaseDetails(int? caseId) async {
    if (caseId == null) {
      return null; // لا توجد حالة محددة
    }

    try {
      // تحديد الجدول المناسب بناءً على userRole
      String tableName =
          widget.userRole == 'patient' ? 'patient_cases' : 'intern_cases';

      // جلب بيانات الحالة من الجدول المناسب
      final response = await supabase
          .from(tableName)
          .select('title, description, image_url') // جلب الحقول المطلوبة
          .eq('id', caseId)
          .maybeSingle();

      if (response != null) {
        return {
          'title': response['title'] ?? '',
          'description': response['description'] ?? '',
          'image_url': response['image_url'] ?? '',
        };
      } else {
        return null; // لا توجد بيانات للحالة
      }
    } catch (e) {
      print('Error fetching case details: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الدردشة مع الطبيب: ${widget.doctorName}'),
        backgroundColor: const Color(0xFF78C1A3),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: messages.isNotEmpty
                      ? ListView.builder(
                          itemCount: messages.length, // عدد الرسائل
                          itemBuilder: (context, index) {
                            final message = messages[index];

                            // التحقق إذا كانت الرسالة مرسلة من المستخدم الحالي
                            final isMe = message['sender_id'] == senderId;

                            // تحديد اسم المرسل
                            final senderName =
                                isMe ? widget.userName : widget.doctorName;
                            final imageTitle = message['image_title'];
                            final imageDesc = message['image_desc'];
                            final imageUrl = message['image_url'];
                            return Align(
                              alignment: isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isMe
                                      ? Colors.blue[100]
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // عرض نص الرسالة
                                    Text(
                                      message['message_text'] ?? '',
                                      style: TextStyle(
                                        color: isMe
                                            ? const Color.fromARGB(
                                                255, 7, 54, 92)
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    // عرض عنوان الحالة
                                    if (imageTitle != null &&
                                        imageTitle.isNotEmpty)
                                      Text(
                                        'العنوان: $imageTitle',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                    // عرض وصف الحالة
                                    if (imageDesc != null &&
                                        imageDesc.isNotEmpty)
                                      Text(
                                        'الوصف: $imageDesc',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                        ),
                                      ),

                                    // عرض صورة الحالة
                                    if (imageUrl != null && imageUrl.isNotEmpty)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.network(
                                          imageUrl,
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    // عرض اسم المرسل
                                    Text(
                                      senderName,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('لا توجد رسائل سابقة'),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'أدخل الرسالة...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        color: const Color(0xFF78C1A3),
                        onPressed: () {
                          sendMessage(_messageController.text);
                          _messageController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Color(0xFF78C1A3)),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      userId: widget.userId.toString(),
                      userRole: widget.userRole,
                      userName: widget.userName, // أضف اسم المستخدم هنا
                    ),
                  ),
                ); // الرجوع إلى الصفحة الرئيسية
              },
            ),
          ],
        ),
      ),
    );
  }
}
