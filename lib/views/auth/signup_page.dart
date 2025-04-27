import 'package:flutter/material.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _signupUser() async {
    // Check passwords before any async operation
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match!")));
      return;
    }

    // Store route name before async operation
    const String targetRoute = '/home';

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After async operation, only use context if still mounted
      if (!mounted) return;

      // Direct navigation without helper method
      Navigator.pushNamed(context, targetRoute);
    } catch (e) {
      // After async operation, only use context if still mounted
      if (!mounted) return;

      // Direct SnackBar without helper method
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Signup failed: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Text(
              "Create an Account",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            CustomTextField(hint: "Email", controller: emailController),
            const SizedBox(height: 16),
            CustomTextField(
              hint: "Password",
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hint: "Confirm Password",
              controller: confirmPasswordController,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            CustomButton(text: "Sign Up", onPressed: _signupUser),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
