import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/function/navigation.dart';
import '../../core/services/local_storage.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/text_style.dart';
import '../../core/widgets/custom_button.dart';
import '../home/home_view.dart';

class UploadView extends StatefulWidget {
  const UploadView({super.key});

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  String? imagePath;

  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (name.isNotEmpty && imagePath != null) {
                AppLocalStorage.cacheData(AppLocalStorage.kUserName, name);
                AppLocalStorage.cacheData(
                    AppLocalStorage.kIsUploaded, imagePath);
                AppLocalStorage.cacheData(AppLocalStorage.kIsUploaded, true);
                // var box = Hive.box('userBox');
                // box.put('image', imagePath);
                // box.put('name', name);
                // box.put('isUploaded', true);
                pushReplacement(context, const HomeView());
              } else if (name.isEmpty && imagePath != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.redColor,
                    content: Text('Name cannot be empty'),
                  ),
                );
              } else if (name.isNotEmpty && imagePath == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.redColor,
                    content: Text('image cannot be empty'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.redColor,
                    content:
                        Text('Name cannot be empty and image cannot be empty'),
                  ),
                );
              }
            },
            child: Text(
              'Done',
              style: getBodyTextStyle(
                context,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: AppColors.primaryColor,
                  backgroundImage: imagePath != null
                      ? FileImage(File(imagePath ?? ''))
                      : const AssetImage(
                          'assets/images/user.png',
                        ),
                ),
                const Gap(20),
                CustomButton(
                  text: 'Upload From Camera',
                  onTap: () {
                    getImage(isFromCamera: true);
                  },
                ),
                const Gap(20),
                CustomButton(
                  text: 'Upload From Gallery',
                  onTap: () {
                    getImage(isFromCamera: false);
                  },
                ),
                const Gap(15),
                const Divider(),
                const Gap(15),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                      // print(name);
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter Your Name',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImage({required bool isFromCamera}) {
    ImagePicker()
        .pickImage(
      source: isFromCamera ? ImageSource.camera : ImageSource.gallery,
    )
        .then((value) {
      if (value != null) {
        setState(() {
          imagePath = value.path;
        });
      }
    });
  }
}
