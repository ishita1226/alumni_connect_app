import 'package:flutter/material.dart';
import 'package:alumni_connect/presentation/widgets/gradient_background.dart';

import 'package:alumni_connect/presentation/widgets/icon_profile.dart'; // Import the new ProfileIcon widget
import 'dart:io'; // For File

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user});

  final Map<String, dynamic> user;

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage; // Store selected image

  // Function to handle the image selected from ProfileIcon
  void _onImagePicked(File image) {
    setState(() {
      _profileImage = image; // Store selected image
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    String languages = widget.user['languages'].toString().substring(1);
    languages = languages.substring(0, languages.length - 1);

    return Scaffold(
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            children: [
              // SizedBox(height: 5), // Reduced space for safe area

              // Back Button and Title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                  height:
                      10), // Reduced space between title and profile picture

              // Profile Picture and Upload Button
              Align(
                alignment:
                    Alignment.center, // Move the profile image to the left
                child: ProfileIcon(
                  profileImage: _profileImage,
                  onImagePicked: _onImagePicked, // Handle the image picked
                ),
              ),
              const SizedBox(
                  height:
                      10), // Reduced space between profile picture and blocks

              // Profile Info Blocks
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: screenWidth *
                          0.04, // Dynamic spacing based on screen width
                      runSpacing: 16,
                      children: [
                        buildProfileBlock(
                            "First Name", widget.user['first name'] ?? ''),
                        buildProfileBlock(
                            "Last Name", widget.user['last name'] ?? ''),
                        buildProfileBlock("Email", widget.user['email'] ?? ''),
                        buildProfileBlock(
                            "College", widget.user['college name'] ?? ''),
                        buildProfileBlock("Language Known", languages),
                        buildProfileBlock(
                            "Tech Stack", widget.user['techs'] ?? ''),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Rating and Status row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildRatingBlock(),
                        buildStatusBlock(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable profile block widget
  Widget buildProfileBlock(String title, String content) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 77,
      width: size.width * 0.42,
      decoration: BoxDecoration(
        color: const Color(0xFF666D73),
        borderRadius: BorderRadius.circular(10), // Slightly rounded corners
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            blurStyle: BlurStyle.solid,
            color: Color(0x4000FFFF),
            spreadRadius: 3,
          ),
          BoxShadow(
            blurRadius: 5,
            blurStyle: BlurStyle.solid,
            color: Color(0xFF00FFFF),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Container(
            height: 31,
            width: size.width * 0.25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Text(
              content,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable widget for Rating and Status blocks
  Widget buildRatingBlock() {
    return buildReusableBlock('Connections', '148', const Color(0xFF0FA867));
  }

  Widget buildStatusBlock() {
    return InkWell(
      child: buildReusableBlock(
          'Upgrade to Alumni', 'Click Here', const Color(0xFF1D1D1D)),
      onTap: () {},
    );
  }

  // Helper function to build reusable block widget for Rating and Status
  Widget buildReusableBlock(String title, String content, Color color) {
    return Container(
      height: 77,
      width: MediaQuery.of(context).size.width * 0.42,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            blurStyle: BlurStyle.solid,
            color: Color(0x4000FFFF),
            spreadRadius: 3,
          ),
          BoxShadow(
            blurRadius: 5,
            blurStyle: BlurStyle.solid,
            color: Color(0xFF00FFFF),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
