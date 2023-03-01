import 'package:flutter/material.dart';
import 'package:phone_book/resources/auth_methods.dart';
import 'package:phone_book/screens/home_screen.dart';
import 'package:phone_book/screens/signup_screen.dart';
import 'package:phone_book/utils/show_snackbar.dart';
import 'package:phone_book/widgets/custom_button.dart';
import 'package:phone_book/widgets/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void login() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signIn(
      _emailController.text,
      _passwordController.text,
    );

    if (res == 'Success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } else {
      showSnackBar(res, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Image.asset(
                  'assets/signin.png',
                  width: 185,
                  height: 185,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  placeholder: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  placeholder: 'Password',
                  controller: _passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 14),
                CustomButton(
                  onTap: login,
                  text: 'Sign In',
                  isLoading: _isLoading,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
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
