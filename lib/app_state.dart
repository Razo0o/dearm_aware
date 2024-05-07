import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _makePhoto = false;
  bool get makePhoto => _makePhoto;
  set makePhoto(bool value) {
    _makePhoto = value;
  }

  String _fileBase64 = '';
  String get fileBase64 => _fileBase64;
  set fileBase64(String value) {
    _fileBase64 = value;
  }

  int _index = 0;
  int get index => _index;
  set index(int value) {
    _index = value;
  }

  String _filePath = '';
  String get filePath => _filePath;
  set filePath(String value) {
    _filePath = value;
  }

  bool _isTake = false;
  bool get isTake => _isTake;
  set isTake(bool value) {
    _isTake = value;
  }

  bool _isBackCamera = false;
  bool get isBackCamera => _isBackCamera;
  set isBackCamera(bool value) {
    _isBackCamera = value;
  }
}
