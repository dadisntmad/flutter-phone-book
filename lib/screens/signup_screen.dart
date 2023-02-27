import 'package:flutter/material.dart';
import 'package:phone_book/screens/signin_screen.dart';
import 'package:phone_book/widgets/custom_button.dart';
import 'package:phone_book/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Image.asset(
                  'assets/signup.png',
                  width: 185,
                  height: 185,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  placeholder: 'Email',
                  controller: _emailController,
                  isPassword: false,
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
                  onTap: () {},
                  text: 'Sign Up',
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SignInScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Already have an account? Sign In",
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
