import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/routes/app_routes.dart';
import 'package:flutter_widgets/controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8E3FF), Color(0xFFFFE8F4), Color(0xFFE3F2FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.person_add_alt_1_rounded,
                    size: 80,
                    color: Color(0xFF7B61FF),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Register a new admin account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Name Field
                  _buildTextField(
                    hint: "Full Name",
                    icon: Icons.person_outline_rounded,
                    textController: controller.signUpNameController,
                  ),
                  const SizedBox(height: 16),
                  
                  // Email Field
                  _buildTextField(
                    hint: "Email address",
                    icon: Icons.email_outlined,
                    textController: controller.signUpEmailController,
                  ),
                  const SizedBox(height: 16),
                  
                  // Password Field
                  _buildTextField(
                    hint: "Password",
                    icon: Icons.lock_outline_rounded,
                    isPassword: true,
                    textController: controller.signUpPasswordController,
                  ),
                  const SizedBox(height: 32),
                  
                  Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value ? null : () {
                      controller.register();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B61FF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFF7B61FF).withOpacity(0.5),
                    ),
                    child: controller.isLoading.value 
                      ? const SizedBox(
                          height: 20, width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'Inter',
                          ),
                        ),
                  )),
                  
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Inter',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color(0xFF7B61FF),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
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
    required String hint,
    required IconData icon,
    bool isPassword = false,
    required TextEditingController textController,
  }) {
    return TextFormField(
      controller: textController,
      obscureText: isPassword,
      style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontFamily: 'Inter'),
        prefixIcon: Icon(icon, color: Colors.grey.shade500, size: 20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF7B61FF), width: 1.5),
        ),
      ),
    );
  }
}
