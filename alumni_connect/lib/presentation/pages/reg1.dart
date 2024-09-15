import 'package:alumni_connect/presentation/pages/login_screen.dart';
import 'package:alumni_connect/presentation/pages/reg2.dart';
import 'package:alumni_connect/presentation/widgets/gradient_background.dart';
import 'package:alumni_connect/presentation/widgets/states.dart';
import 'package:flutter/material.dart';

class BasicInformationPage extends StatefulWidget {
  const BasicInformationPage({super.key});

  @override
  BasicInformationPageState createState() => BasicInformationPageState();
}

class BasicInformationPageState extends State<BasicInformationPage> {
  String? _selectedState;
  final _mobileController = TextEditingController();
  bool _isMobileValid = true; // Variable to track if mobile is valid or not

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final maxHeight = constraints.maxHeight;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.08),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: maxHeight * 0.03),
                        const Text(
                          "Basic Information",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        _buildStepIndicator(step: 1),
                        SizedBox(height: maxHeight * 0.04),
                        _buildTextField(
                          label: 'Username',
                          icon: Icons.person_outline,
                          maxWidth: maxWidth,
                        ),
                        SizedBox(height: maxHeight * 0.02),
                        _buildTextField(
                          label: 'Email ID',
                          icon: Icons.email_outlined,
                          maxWidth: maxWidth,
                        ),
                        SizedBox(height: maxHeight * 0.02),
                        _buildStateDropdown(maxWidth), // State dropdown only
                        SizedBox(height: maxHeight * 0.02),

                        // Mobile text field with validation
                        _buildTextField(
                          label: 'Mobile no',
                          icon: Icons.phone_android_outlined,
                          keyboardType: TextInputType.phone,
                          controller: _mobileController,
                          maxLength: 10,
                          maxWidth: maxWidth,
                          isValid: _isMobileValid, // Passing validation status
                        ),
                        // Display the error message if mobile is invalid
                        if (!_isMobileValid) ...[
                          const SizedBox(height: 8),
                          const Text(
                            "Please enter a valid 10-digit mobile number.",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ],
                        SizedBox(height: maxHeight * 0.04),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const StudentLoginPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.blueAccent,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isMobileValid =
                                        _validateMobile(_mobileController.text);
                                  });

                                  if (_isMobileValid) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EducationInformationPage(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize:
                                      Size(maxWidth * 0.3, maxHeight * 0.07),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator({required int step}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
            color: step == 1 ? Colors.white : Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Step 1",
            style: TextStyle(
              color: step == 1 ? Colors.black : Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 2,
          width: 100,
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
            color: step == 2 ? Colors.white : Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Step 2",
            style: TextStyle(
              color: step == 2 ? Colors.black : Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    int? maxLength,
    required double maxWidth,
    bool isValid = true, // Added isValid parameter to control the border color
  }) {
    return SizedBox(
      width: maxWidth,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isValid ? Colors.white70 : Colors.red), // Border color
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isValid ? Colors.white : Colors.red), // Border color
            borderRadius: BorderRadius.circular(10),
          ),
          counterText: '', // Hide the character counter
        ),
      ),
    );
  }

  Widget _buildStateDropdown(double maxWidth) {
    return SizedBox(
      width: maxWidth,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: _selectedState,
        onChanged: (String? newValue) {
          setState(() {
            _selectedState = newValue;
          });
        },
        decoration: InputDecoration(
          labelText: 'Select College State',
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon:
              const Icon(Icons.location_on_outlined, color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white70),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        dropdownColor: Colors.black87,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
        items: indianStates.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }

  bool _validateMobile(String mobile) {
    final RegExp mobileRegExp = RegExp(r'^[0-9]{10}$');
    return mobileRegExp.hasMatch(mobile);
  }
}
