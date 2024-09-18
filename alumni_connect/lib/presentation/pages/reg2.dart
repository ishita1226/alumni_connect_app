import 'package:alumni_connect/presentation/pages/navigator_screen.dart';
import 'package:alumni_connect/presentation/widgets/gradient_background.dart';
import 'package:alumni_connect/presentation/widgets/tech_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EducationInformationPage extends StatefulWidget {
  const EducationInformationPage({super.key});

  @override
  EducationInformationPageState createState() =>
      EducationInformationPageState();
}

class EducationInformationPageState extends State<EducationInformationPage> {
  TextEditingController graduationYearController = TextEditingController();
  TextEditingController otherCourseController =
      TextEditingController(); // Controller for 'Other' course input
  String? selectedCourse;
  bool showOtherCourseField = false; // Boolean to toggle 'Other' field

  @override
  void dispose() {
    graduationYearController.dispose();
    otherCourseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: GradientBackground(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          "Education Information",
                          style: TextStyle(
                            // fontFamily: 'Poppins',
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        _buildStepIndicator(step: 2),
                        SizedBox(height: size.height * 0.05),
                        _buildCourseDropdown(),
                        if (showOtherCourseField) ...[
                          SizedBox(height: size.height * 0.02),
                          _buildTextField(
                            label: 'Other',
                            controller: otherCourseController,
                            icon: Icons.edit_outlined,
                          ),
                        ],
                        SizedBox(height: size.height * 0.03),
                        _buildTextField(
                          label: 'Enter College/University Name',
                          icon: Icons.school_outlined,
                        ),
                        SizedBox(height: size.height * 0.03),
                        _buildGraduationYearField(
                            context, graduationYearController),
                        SizedBox(height: size.height * 0.03),
                        _buildTextField(
                          label: 'Github / LinkedIn Profile Link',
                          icon: Icons.code_outlined,
                        ),
                        SizedBox(height: size.height * 0.04),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Add registration logic here
                              Navigator.pushAndRemoveUntil(
                                context,
                                NavigatorScreen.getRoute({}),
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize:
                                  Size(double.infinity, size.height * 0.07),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Register Now',
                              style: TextStyle(
                                // fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
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
            color: step == 1 ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Step 1",
            style: TextStyle(
              color: step == 1 ? Colors.white : Colors.black,
              // fontFamily: 'Poppins',
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
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
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

  Widget _buildGraduationYearField(
      BuildContext context, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
        );

        if (pickedDate != null) {
          setState(() {
            controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
          });
        }
      },
      decoration: InputDecoration(
        labelText: 'Graduation Year',
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon:
            const Icon(Icons.calendar_today_outlined, color: Colors.white70),
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

  Widget _buildCourseDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCourse,
      items: selectCourses.map((course) {
        return DropdownMenuItem(
          value: course,
          child: Text(course),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCourse = value;
          showOtherCourseField = value == 'Other'; // Toggle 'Other' field
        });
      },
      decoration: InputDecoration(
        labelText: 'Select your field',
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.book_outlined, color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      dropdownColor: Colors.grey[800],
      style: const TextStyle(color: Colors.white),
    );
  }
}
