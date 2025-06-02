import 'package:flutter/material.dart';
import 'package:stylish/Components/my_textfield.dart';
import 'package:stylish/Components/mybutton.dart';
import 'package:stylish/Screens/Onboarding_Screens/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    //Dispose all controllers
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                const Text('Create an Account', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 16),
                MyTextfield(
                  controller: firstNameController,
                  hint: 'Enter your first name',
                  title: 'First Name',
                  pre: const Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  controller: secondNameController,
                  hint: 'Enter your second name',
                  title: 'Second Name',
                  pre: const Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  controller: emailController,
                  hint: 'Enter your Email Address',
                  title: 'Email Address',
                  pre: const Icon(Icons.email),
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  controller: passwordController,
                  hint: 'Enter a Password',
                  title: 'Password',
                  pre: const Icon(Icons.lock),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                //the login button
                const Mybutton(title: 'Create Account'),
                SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '- OR Continue with -',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google login
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFF83758)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset('assets/google.png')],
                      ),
                    ),
                    //apple login
                    SizedBox(width: 10),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFF83758)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset('assets/apple.png')],
                      ),
                    ),
                    SizedBox(width: 10),

                    //facebook login
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFF83758)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset('assets/facebook.png')],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an Account?',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      },
                      child: Text(
                        'Sign In',
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
