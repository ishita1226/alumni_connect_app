import 'package:alumni_connect/presentation/pages/navigator_screen.dart';
import 'package:alumni_connect/presentation/pages/reg1.dart';
import 'package:alumni_connect/presentation/widgets/gradient_background.dart';
import 'package:flutter/material.dart';

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({super.key});

  static Route getRoute() {
    return MaterialPageRoute(
      builder: (context) => const StudentLoginPage(),
    );
  }

  @override
  StudentLoginScreenState createState() => StudentLoginScreenState();
}

class StudentLoginScreenState extends State<StudentLoginPage> {
  bool _isPasswordVisible = false;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.05),
                  Image.asset('assets/images/image.png',
                      width: size.width * 0.4),
                  SizedBox(height: size.height * 0.05),
                  const Text(
                    "Welcome!",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Login to Alumni Connect",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  _buildTextField(
                    label: 'Email',
                    icon: Icons.person_outline,
                  ),
                  SizedBox(height: size.height * 0.02),
                  _buildTextField(
                    label: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: true,
                    isPassword: true,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                      ),
                      const Text(
                        'I agree to terms and privacy policy',
                        style: TextStyle(
                          color: Colors.white70,
                          // fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  ElevatedButton(
                    onPressed: _isChecked
                        ? () {
                            // Implement login action
                            Navigator.pushAndRemoveUntil(
                              context,
                              NavigatorScreen.getRoute(),
                              (route) => false,
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, size.height * 0.07),
                      backgroundColor: _isChecked
                          ? Colors.white
                          : const Color(
                              0xFF676767), // Changes color based on state
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        // fontFamily: 'Poppins',
                        color: _isChecked ? Colors.black87 : Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const BasicInformationPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Register here',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    bool obscureText = false,
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword ? !_isPasswordVisible : obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
