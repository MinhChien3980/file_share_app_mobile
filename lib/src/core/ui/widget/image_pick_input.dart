import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickInput extends FormField<String> {
  final ImagePickInputController controller;

  ImagePickInput({
    super.key,
    required this.controller,
    super.onSaved,
    super.validator,
    String? initialValue,
    bool autovalidate = false,
  }) : super(
          initialValue: initialValue,
          autovalidateMode: autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          builder: (FormFieldState<String> state) {
            controller.addListener(() {
              if (controller.value != state.value) {
                state.didChange(controller.value);
              }
            });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      _showImagePicker(context, controller);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        shape: BoxShape.circle,
                      ),
                      height: 150,
                      width: double.infinity,
                      child: state.value != null
                          ? controller.value!.startsWith('http')
                              ? Image.network(controller.value!, fit: BoxFit.cover)
                              : Image.file(
                                  File(controller.value!),
                                  fit: BoxFit.cover,
                                  scale: 1,
                                )
                          : Icon(Icons.add_a_photo, color: Colors.grey[700]),
                    ),
                  );
                }),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      state.errorText ?? '',
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            );
          },
        ) {
    controller.value = initialValue;
  }

  static void _showImagePicker(BuildContext context, ImagePickInputController controller) {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    minTileHeight: 52,
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Take a photo'),
                    onTap: () async {
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        controller.setImage(pickedFile.path);
                      }
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  ListTile(
                    minTileHeight: 52,
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Choose from gallery'),
                    onTap: () async {
                      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        controller.setImage(pickedFile.path);
                      }
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  ListTile(
                    minTileHeight: 52,
                    leading: const Icon(Icons.clear),
                    title: const Text('Clear image'),
                    onTap: () {
                      controller.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ImagePickInputController extends ValueNotifier<String?> {
  ImagePickInputController(super._value);

  void setImage(String? imageUrl) {
    value = imageUrl;
  }

  void clear() {
    value = null;
  }
}
