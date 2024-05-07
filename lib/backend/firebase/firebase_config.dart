import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBQ41lc3mTPOafBYTdhvGu2yeL9x2gGgAg",
            authDomain: "camera-app-mp7903.firebaseapp.com",
            projectId: "camera-app-mp7903",
            storageBucket: "camera-app-mp7903.appspot.com",
            messagingSenderId: "692450515539",
            appId: "1:692450515539:web:99f6edc426612a4b9904a6"));
  } else {
    await Firebase.initializeApp();
  }
}
