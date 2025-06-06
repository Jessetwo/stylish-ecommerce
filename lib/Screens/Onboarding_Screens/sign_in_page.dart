import 'package:flutter/material.dart';
import 'package:stylish/API_service/api_service.dart';
import 'package:stylish/Components/my_textfield.dart';
import 'package:stylish/Components/mybutton.dart';
import 'package:stylish/Models/user_model.dart';
import 'package:stylish/Screens/Onboarding_Screens/forgot_password.dart';
import 'package:stylish/Screens/Onboarding_Screens/sign_up_page.dart';
// Placeholder for home screen
import 'package:flutter/widgets.dart';
import 'package:stylish/Screens/main_Screens/Home_page.dart'; // Replace with actual home page import

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final ApiService apiService = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final user = await apiService.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged in successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to home page (replace with your actual home page)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      print('Login error: $e');

      String errorMessage = 'Failed to login. Please try again.';
      if (e.toString().contains('Method not allowed')) {
        errorMessage = 'Invalid API configuration. Please contact support.';
      } else if (e.toString().contains('Invalid email or password')) {
        errorMessage = 'Invalid email or password. Please try again.';
      } else if (e.toString().contains('SocketException')) {
        errorMessage = 'Network error. Please check your connection.';
      } else if (e.toString().contains('Failed to login')) {
        errorMessage = e.toString().replaceFirst(
          'Exception: Failed to login: ',
          '',
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    }
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
                const SizedBox(height: 16),
                const Text('Login to Account', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 16),
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFF83758),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                isLoading
                    ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFF83758),
                      ),
                    )
                    : Mybutton(title: 'Login', ontap: _login),
                const SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('- OR Login with -', style: TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFF83758)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset('assets/google.png')],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFF83758)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset('assets/apple.png')],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFF83758)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset('assets/facebook.png')],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an Account?',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
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
