// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> base64Upload(String base64image) async {
  //  upload base64 image to firebase storeage
  try {
    // Decode the base64 image
    final bytes = base64.decode(base64image);

    // Generate a random file name
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';

    // Upload the image to Firebase Storage
    final ref = FirebaseStorage.instance.ref().child(fileName);
    final uploadTask = ref.putData(bytes);
    final snapshot = await uploadTask.whenComplete(() {});

    // Get the download URL of the uploaded image
    final downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  } catch (e) {}
}
