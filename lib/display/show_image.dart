import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowImage extends StatelessWidget {
  final XFile image;

  // ignore: use_super_parameters
  const ShowImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF77C0B6),
        title: Center(
          child: Image.asset(
            'assets/images/logoW.png',
            width: 150,
            height: 60,
          ),
        ),
      ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(image.path),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
