import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(content),
    ),
  );
}

Future<XFile?> pickCameraImage() {
  return ImagePicker().pickImage(
    source: ImageSource.camera,
  );
}

Future<XFile?> pickGalleryImage() {
  return ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
}

Future<File?> pickImageFile(BuildContext context, ImageSource source) async {
  File? image;

  try {
    final pickedImage = source == ImageSource.camera
        ? await pickCameraImage()
        : await pickGalleryImage();

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    if (context.mounted) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  return image;
}

Future<CroppedFile?> pickCroppedImageFile(BuildContext context) async {
  CroppedFile? image;

  try {
    final pickedImage = await pickGalleryImage();

    if (pickedImage != null) {
      // image = File(pickedImage.path);
      image = await ImageCropper().cropImage(
          sourcePath: pickedImage.path,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          cropStyle: CropStyle.circle,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 10,
          uiSettings: [
            IOSUiSettings(),
            AndroidUiSettings(),
          ]);
    }
  } catch (e) {
    if (context.mounted) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  return image;
}
