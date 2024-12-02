import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorChatPage extends StatefulWidget {
  final int doctorId; // الطبيب الذي يدخل الدردشة
  final String doctorName; // اسم الطبيب
  final String userName; // اسم المستخدم (المريض/المتدرب)
  final int userId; // معرف المستخدم
  final String userRole; // دور المستخدم: 'patient' أو 'intern'

  const DoctorChatPage({
    Key? key,
    required this.doctorId,
    required this.doctorName,
    required this.userName,
    required this.userId,
    required this.userRole,
  }) : super(key: key);

  @override
  _DoctorChatPageState createState() => _DoctorChatPageState();
}

class _DoctorChatPageState extends State<DoctorChatPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  bool isLoading = true;
  int? senderId;
  int? doctorUserId;

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    try {
      // استرجاع البريد الإلكتروني للطبيب
      final doctorEmail = await getDoctorEmail(widget.doctorId);
      if (doctorEmail == null) {
        print('Error: No email found for doctor.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      // استرجاع الـ id للطبيب من جدول users باستخدام البريد الإلكتروني
      final doctorIdFromUsers = await getUserIdByEmail(doctorEmail);
      if (doctorIdFromUsers == null) {
        print('Error: No ID found in users table for email $doctorEmail.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      setState(() {
        doctorUserId = doctorIdFromUsers; // تعيين doctorUserId للطبيب
      });

      print('Doctor User ID: $doctorUserId');

      // استرجاع البريد الإلكتروني للمستخدم الحالي
      final userEmail = await getUserEmail(widget.userId, widget.userRole);
      if (userEmail == null) {
        print('Error: No email found for user.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      // استرجاع الـ id من جدول users باستخدام البريد الإلكتروني
      final senderIdFromUsers = await getUserIdByEmail(userEmail);
      if (senderIdFromUsers == null) {
        print('Error: No ID found in users table for email $userEmail.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      setState(() {
        senderId = senderIdFromUsers; // تعيين senderId للمستخدم
      });

      print('User ID from users table: $senderId');

      // جلب الرسائل المرتبطة بالطبيب والمستخدم
      final messagesResponse = await supabase
          .from('messages')
          .select(
              'message_text, sender_id, receiver_id, timestamp, image_title, image_desc, image_url')
          .or('and(sender_id.eq.$senderId,receiver_id.eq.$doctorUserId),'
              'and(sender_id.eq.$doctorUserId,receiver_id.eq.$senderId)')
          .order('timestamp', ascending: true);

      // ignore: unnecessary_null_comparison
      if (messagesResponse != null && messagesResponse.isNotEmpty) {
        setState(() {
          messages = List<Map<String, dynamic>>.from(messagesResponse);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          print('No messages found for the user.');
        });
      }
    } catch (e) {
      print('Error fetching messages: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String?> getDoctorEmail(int doctorId) async {
    try {
      final response = await supabase
          .from('doctor')
          .select('email') // الحقل الذي يحتوي على البريد الإلكتروني
          .eq('id', doctorId)
          .maybeSingle();

      return response?['email'];
    } catch (e) {
      print('Error fetching doctor email: $e');
      return null;
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

  Future<int?> getUserIdByEmail(String email) async {
    try {
      // جلب الـ id من جدول users باستخدام البريد الإلكتروني
      final response = await supabase
          .from('users')
          .select('id')
          .eq('email', email)
          .maybeSingle();

      return response?['id'];
    } catch (e) {
      print('Error fetching user ID by email: $e');
      return null;
    }
  }

  Future<void> sendMessage(String messageText) async {
    if (messageText.trim().isEmpty) {
      return;
    }

    try {
      // إعداد الرسالة الجديدة
      final newMessage = {
        'sender_id': doctorUserId,
        'sender_type': 'doctor',
        'receiver_id': senderId,
        'receiver_type': widget.userRole.toLowerCase() == 'patient'
            ? 'user'
            : widget.userRole.toLowerCase(),
        'message_text': messageText.trim(),
        'timestamp': DateTime.now().toIso8601String(),
      };

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الدردشة مع ${widget.userName}'),
        backgroundColor: const Color(0xFF78C1A3),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: messages.isNotEmpty
                      ? ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final isMe = doctorUserId != null &&
                                message['sender_id'] == doctorUserId;

                            final senderName =
                                isMe ? widget.doctorName : widget.userName;
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
    );
  }
}
