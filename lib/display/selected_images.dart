import 'package:image_picker/image_picker.dart';

class SelectedImages {
  static final SelectedImages _instance = SelectedImages._internal();
  factory SelectedImages() => _instance;
  SelectedImages._internal();

  List<XFile> pickedImage = [];
}
