import 'package:flutter/material.dart';
import 'package:trycam/auth/LoginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // الشريط العلوي ليكون شبيهًا بـ AppBar
              Container(
                height:
                    MediaQuery.of(context).size.height * 0.25, // 25% من الشاشة
                decoration: const BoxDecoration(
                  color: Color(0xFF78C1A3), // لون الشريط العلوي
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logoW.png', // تأكد من مسار الصورة
                    height: 120, // حجم الصورة داخل الشريط العلوي
                  ),
                ),
              ),
              // محتوى الشاشة
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/open.png', // تأكد من وجود الصورة في المسار المحدد
                      height: MediaQuery.of(context).size.height *
                          0.3, // 30% من الشاشة
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'شخص بشرتك بدقة وسهولة مع إمكانية التواصل المباشر مع طبيب مختص لمتابعة حالتك بكل احترافية',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF78C1A3), // لون الزر
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        // التنقل إلى LoginScreen عند الضغط على زر "ابدأ"
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 10.0),
                        child: Text(
                          'ابدأ',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
