import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileIcon extends StatefulWidget {
  final Function(File) onImagePicked; // Callback to return selected image
  final File? profileImage;

  const ProfileIcon(
      {super.key, required this.onImagePicked, this.profileImage});

  @override
  ProfileIconState createState() => ProfileIconState();
}

class ProfileIconState extends State<ProfileIcon> {
  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      widget.onImagePicked(File(pickedFile.path)); // Return the selected image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: widget.profileImage != null
              ? FileImage(widget.profileImage!)
              : const AssetImage('assets/images/add_a_photo.png')
                  as ImageProvider, // Placeholder if no image
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _pickImage, // On click, trigger image picker
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, size: 20, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
