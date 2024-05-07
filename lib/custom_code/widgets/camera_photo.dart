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

class CameraPhoto extends StatefulWidget {
  const CameraPhoto({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _CameraPhotoState createState() => _CameraPhotoState();
}

class _CameraPhotoState extends State<CameraPhoto> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    CameraDescription? targetCamera;
    for (final camera in _cameras) {
      if (FFAppState().isBackCamera) {
        if (camera.lensDirection == CameraLensDirection.back) {
          targetCamera = camera;
          break;
        }
      } else {
        if (camera.lensDirection == CameraLensDirection.front) {
          targetCamera = camera;
          break;
        }
      }
    }
    if (targetCamera != null) {
      _controller = CameraController(
        targetCamera,
        ResolutionPreset.max,
      );
      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    } else {
      // Handle case when the target camera is not found
      print("Target camera not found.");
    }
  }

  @override
  void didUpdateWidget(covariant CameraPhoto oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
              );
            } else if (_controller.value.isInitialized) {
              if (FFAppState().makePhoto) {
                _controller.takePicture().then((file) async {
                  Uint8List fileAsBytes = await file.readAsBytes();
                  final base64 = base64Encode(fileAsBytes!);

                  FFAppState().update(() {
                    FFAppState().fileBase64 = base64;
                    FFAppState().makePhoto = false;
                    FFAppState().isTake = true;
                  });
                }).catchError((error) {});
              }
              return _controller.value.isInitialized
                  ? MaterialApp(
                      home: CameraPreview(_controller),
                    )
                  : Container();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
