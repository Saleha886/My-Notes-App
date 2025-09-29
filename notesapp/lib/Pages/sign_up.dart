import 'package:flutter/material.dart';
import 'package:notesapp/Widget/custom_text_field.dart';
import 'package:notesapp/Pages/sign_in.dart';
import 'package:notesapp/services/user_store.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up',
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
              hintText: 'Name',
              controller: nameController,
              maxLines: 1,
              keyboardType: TextInputType.text,
            ),
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
                final name = nameController.text.trim();
                final emailOrPhone = emailController.text.trim();
                final password = passwordController.text.trim();
                if (name.isEmpty || emailOrPhone.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All fields are required!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                UserStore().saveUser(name: name, emailOrPhone: emailOrPhone, password: password);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 88, 16, 70),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
