import 'package:flutter/material.dart';
import 'package:trycam/WelcomeScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trycam/auth/LoginScreen.dart';
import 'package:trycam/auth/SignUpScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://asqxknjtzfongrkdkope.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFzcXhrbmp0emZvbmdya2Rrb3BlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3ODQ1NTgsImV4cCI6MjA0NzM2MDU1OH0.iuhd_jWGOhnkmsnT2aOW637ZgjS_NuNn4Eq-67g_tDY',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DermAware',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: WelcomeScreen(), // شاشة البداية التي قمنا بإنشائها
      routes: {
        '/signup': (context) => SignUpScreen(), // تعريف مسار شاشة التسجيل
        '/login': (context) => LoginScreen(), // تعريف مسار شاشة تسجيل الدخول
      },
    );
  }
}
