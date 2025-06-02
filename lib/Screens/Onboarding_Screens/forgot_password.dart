import 'package:flutter/material.dart';
import 'package:stylish/Components/my_textfield.dart';
import 'package:stylish/Components/mybutton.dart';
import 'package:stylish/Screens/Onboarding_Screens/sign_up_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    //Dispose all controllers

    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.asset('assets/logo.png', width: 200)],
                ),
                SizedBox(height: 16),
                const Text('Reset Password', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 16),

                MyTextfield(
                  controller: emailController,
                  hint: 'Enter your Email Address',
                  title: 'Email Address',
                  pre: const Icon(Icons.email),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '*',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'We will send you a message to set or reset\n your new password',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                //the login button
                const Mybutton(title: 'Submit'),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an Account?',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF83758),
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
    );
  }
}
