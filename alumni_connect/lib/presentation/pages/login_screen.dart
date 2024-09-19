import 'package:alumni_connect/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:alumni_connect/presentation/pages/navigator_screen.dart';
import 'package:alumni_connect/presentation/pages/reg1.dart';
import 'package:alumni_connect/presentation/widgets/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              child: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      NavigatorScreen.getRoute(state.user),
                      (route) => false,
                    );
                  } else if (state is LoginFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.error),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return SizedBox(
                      height: size.height,
                      width: size.width,
                      child: const Center(
                        child: SpinKitCircle(
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    );
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.05),
                        Image.asset(
                          'assets/images/image_logo.png',
                          width: 200,
                        ),
                        SizedBox(height: size.height * 0.02),
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
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          isEmail: true,
                        ),
                        SizedBox(height: size.height * 0.02),
                        _buildTextField(
                          label: 'Password',
                          icon: Icons.lock_outline,
                          obscureText: true,
                          isPassword: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
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
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        ElevatedButton(
                          onPressed: _isChecked
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(
                                          LoginRequested(
                                            _emailController.text,
                                            _passwordController.text,
                                          ),
                                        );
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(double.infinity, size.height * 0.07),
                            backgroundColor: _isChecked
                                ? Colors.white
                                : const Color(0xFF676767),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Log in',
                            style: TextStyle(
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
                  );
                },
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
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool isEmail = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? !_isPasswordVisible : obscureText,
      style: const TextStyle(color: Colors.white),
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
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
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
