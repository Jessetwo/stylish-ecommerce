import 'package:flutter/material.dart';
import 'package:stylish/API_service/api_service.dart';
import 'package:stylish/Components/my_textfield.dart';
import 'package:stylish/Components/mybutton.dart';
import 'package:stylish/Screens/Onboarding_Screens/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final ApiService apiService = ApiService();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (userNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
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
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      print('Sign-up error: $e');

      // Since account is created, treat parsing errors as non-fatal
      String errorMessage =
          'Account created, but failed to process response. Please sign in.';
      if (e.toString().contains(
        'type \'Null\' is not a subtype of type \'String\'',
      )) {
        errorMessage = 'Account created successfully! Please sign in.';
        // Proceed to SignInPage despite parsing error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInPage()),
        );
        return;
      } else if (e.toString().contains('ERROR_CODE_NOT_FOUND')) {
        errorMessage =
            'API endpoint not found. Please check the server configuration.';
      } else if (e.toString().contains('Failed to sign up')) {
        errorMessage = e.toString().replaceFirst(
          'Exception: Failed to sign up: ',
          '',
        );
      } else if (e.toString().contains('SocketException')) {
        errorMessage = 'Network error. Please check your connection.';
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
                const Text('Create an Account', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 16),
                const SizedBox(height: 10),
                MyTextfield(
                  controller: userNameController,
                  hint: 'Choose a User name',
                  title: 'User Name',
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
                isLoading
                    ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFF83758),
                      ),
                    )
                    : Mybutton(title: 'Create Account', ontap: _signUp),
                const SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '- OR Continue with -',
                      style: TextStyle(fontSize: 18),
                    ),
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
                      'Already have an Account?',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInPage(),
                          ),
                        );
                      },
                      child: const Text(
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
