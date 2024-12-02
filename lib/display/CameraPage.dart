import 'package:camera/camera.dart';
// ignore: unnecessary_import
import 'package:image_picker/image_picker.dart';
// ignore: unused_import
import 'package:trycam/display/CameraPage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:trycam/display/check.dart';

class CameraPage extends StatefulWidget {
  final String userId;
  final String userRole;
  final String userName;

  const CameraPage({
    Key? key,
    required this.userId,
    required this.userRole,
    required this.userName,
  }) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    // تأكد من التخلص من الموارد بشكل صحيح
    if (_cameraController.value.isInitialized) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      // الحصول على قائمة الكاميرات المتوفرة
      _cameras = await availableCameras();

      // التحقق من وجود كاميرات
      if (_cameras.isEmpty) {
        print("لا توجد كاميرات متوفرة.");
        return;
      }

      // تهيئة الكاميرا الخلفية
      _cameraController = CameraController(
        _cameras[0], // الكاميرا الخلفية
        ResolutionPreset.high, // دقة الصورة
      );

      // تهيئة الكاميرا
      await _cameraController.initialize();

      // تحديث حالة الكاميرا
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      // معالجة الأخطاء أثناء التهيئة
      print("خطأ أثناء تهيئة الكاميرا: $e");
    }
  }

  Future<void> _captureImage() async {
    try {
      // التأكد من أن الكاميرا جاهزة
      if (!_cameraController.value.isInitialized) {
        print("الكاميرا غير مهيأة.");
        return;
      }

      // التقاط الصورة
      final image = await _cameraController.takePicture();

      // تحديث حالة الصورة
      setState(() {
        _capturedImage = image;
      });
    } catch (e) {
      // معالجة الأخطاء أثناء الالتقاط
      print('خطأ أثناء التقاط الصورة: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الكاميرا'),
        backgroundColor: const Color(0xFF77C0B6),
      ),
      body: _isCameraInitialized
          ? Stack(
              children: [
                // إذا لم يتم التقاط صورة، عرض بث الكاميرا
                if (_capturedImage == null) CameraPreview(_cameraController),

                // إذا تم التقاط صورة، عرضها
                if (_capturedImage != null)
                  Center(
                    child: Image.file(
                      File(_capturedImage!.path),
                      fit: BoxFit.cover,
                    ),
                  ),

                // أزرار التحكم أسفل الشاشة
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _capturedImage == null
                        ? FloatingActionButton(
                            // زر التقاط الصورة
                            onPressed: _captureImage,
                            child: const Icon(Icons.camera),
                            backgroundColor: const Color(0xFF77C0B6),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                // زر إعادة التصوير
                                onPressed: () {
                                  setState(() {
                                    _capturedImage = null;
                                  });
                                },
                                icon: const Icon(Icons.refresh),
                                label: const Text('إعادة التصوير'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                              ElevatedButton.icon(
                                // زر إرسال الصورة
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SymptomsCheckk(
                                        userImage: _capturedImage!,
                                        userId: widget.userId,
                                        userRole: widget.userRole,
                                        userName: widget.userName,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.check),
                                label: const Text('إرسال'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
