// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:camera/camera.dart';
import '../../auth/firebase_auth/auth_util.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CameraPhotoBase extends StatefulWidget {
  const CameraPhotoBase({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _CameraPhotoState createState() => _CameraPhotoState();
}

class _CameraPhotoState extends State<CameraPhotoBase> {
  CameraController? controller;
  late Future<List<CameraDescription>> _cameras;

  @override
  void initState() {
    super.initState();
    _cameras = availableCameras();
  }

  @override
  void didUpdateWidget(covariant CameraPhotoBase oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (FFAppState().makePhoto) {
      controller!.takePicture().then((file) async {
        Uint8List fileAsBytes = await file.readAsBytes();
        final base64 = base64Encode(fileAsBytes!);

        FFAppState().update(() {
          FFAppState().fileBase64 = base64;
        });
        FFAppState().update(() {
          FFAppState().makePhoto = false;
        });
        FFAppState().update(() {
          FFAppState().isTake = true;
        });
      }).catchError((error) {});
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
      future: _cameras,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            if (controller == null) {
              controller =
                  CameraController(snapshot.data![0], ResolutionPreset.max);
              controller!.initialize().then((_) {
                if (!mounted) {
                  return;
                }
                setState(() {});
              });
            }
            return controller!.value.isInitialized
                ? MaterialApp(
                    home: CameraPreview(controller!),
                  )
                : Container();
          } else {
            return Center(child: Text('No cameras available.'));
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
