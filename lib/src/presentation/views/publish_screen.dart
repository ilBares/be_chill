import 'dart:io';

import 'package:be_chill/src/utils/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PublishScreen extends StatefulWidget {
  const PublishScreen({super.key, required this.onPickerClosed});

  final VoidCallback onPickerClosed;

  @override
  State<PublishScreen> createState() => PublishScreenState();
}

class PublishScreenState extends State<PublishScreen> {
  void _onPickerClosed(File? imageFile) async {
    if (imageFile != null) {
      _uploadImage(imageFile);
    }
    widget.onPickerClosed();
  }

  void _uploadImage(File imageFile) async {}

  @override
  Widget build(BuildContext context) {
    // InstaAssetPicker.pickAssets(
    //   cropDelegate: const InstaAssetCropDelegate(
    //     cropRatios: [18 / 9],
    //   ),
    //   context,
    //   maxAssets: 1,
    //   onCompleted: (assets) {},
    // );

    pickImageFile(context, ImageSource.camera).then(_onPickerClosed);

    return const Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
