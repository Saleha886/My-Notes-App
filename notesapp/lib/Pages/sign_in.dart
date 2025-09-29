import 'package:flutter/material.dart';
import 'package:notesapp/Widget/custom_text_field.dart';
import 'package:notesapp/Pages/home_page.dart';
import 'package:notesapp/Pages/sign_up.dart';
import 'package:notesapp/services/user_store.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In',
            style: TextStyle(
                color: Color.fromARGB(255, 232, 229, 233),
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 88, 16, 70),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hintText: 'Email/Phone',
              controller: emailController,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
            ),
            CustomTextField(
              hintText: 'Password',
              controller: passwordController,
              maxLines: 1,
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final emailOrPhone = emailController.text.trim();
                final password = passwordController.text.trim();
                if (emailOrPhone.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All fields are required!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                if (UserStore().validateUser(emailOrPhone: emailOrPhone, password: password)) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(title: 'Notes App'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User does not exist. Redirecting to Sign Up...'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  Future.delayed(const Duration(seconds: 2), () {
                    if (!mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 88, 16, 70),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                );
              },
              child: const Text(
                "Don't have an account? Sign Up",
                style: TextStyle(color: Color.fromARGB(255, 88, 16, 70)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
