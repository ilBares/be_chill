import 'dart:io';

import 'package:be_chill/src/utils/resources/utils.dart';
import 'package:be_chill/src/presentation/shared/bechill_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';

class UploadProfileImageScreen extends StatefulWidget {
  const UploadProfileImageScreen({super.key, required this.onConfirm});

  final Function(File?) onConfirm;

  @override
  State<UploadProfileImageScreen> createState() =>
      UploadProfileImageScreenState();
}

class UploadProfileImageScreenState extends State<UploadProfileImageScreen> {
  CroppedFile? imageCroppedFile;

  void _onConfirm() async {
    imageCroppedFile = await pickCroppedImageFile(context);
    widget.onConfirm(
        imageCroppedFile != null ? File(imageCroppedFile!.path) : null);
  }

  @override
  Widget build(BuildContext context) {
    return BeChillForm(
      onBtnPressed: _onConfirm,
      centered: true,
      buttonText: "Carica Foto Profilo",
      children: const [
        Padding(
          padding: EdgeInsets.all(4.0),
          child: BeChillQuestion(
            text: "Solo i tuoi amici potranno vedere la tua foto profilo",
          ),
        ),
      ],
    );
  }
}
