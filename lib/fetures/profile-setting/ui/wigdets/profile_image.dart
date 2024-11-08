
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../generated/assets.dart';

class ProfileImage extends StatelessWidget {
  final String? imageUrl;
  final ValueChanged<String> onImagePicked;

  const ProfileImage({
    super.key,
    required this.imageUrl,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: _buildImageProvider(),
            backgroundColor: Colors.grey,
          ),
          GestureDetector(
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile = await picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 50,
                requestFullMetadata: false,
                maxHeight: 1920,
                maxWidth: 1080,
              );

              if (pickedFile != null) {
                onImagePicked(pickedFile.path);
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider _buildImageProvider() {
    if (imageUrl != null) {
      return imageUrl!.startsWith('http')
          ? NetworkImage(imageUrl!)
          : FileImage(File(imageUrl!));
    } else {
      return const AssetImage(Assets.imagesLogo);
    }
  }
}
