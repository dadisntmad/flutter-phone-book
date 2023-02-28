import 'package:flutter/material.dart';
import 'package:phone_book/resources/firestore_methods.dart';
import 'package:phone_book/widgets/custom_button.dart';
import 'package:phone_book/widgets/custom_textfield.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  bool _isLoading = false;

  void addEmployee() async {
    setState(() {
      _isLoading = true;
    });

    await FirestoreMethods().add(
      _fullNameController.text,
      _phoneNumberController.text,
      _emailController.text,
      _positionController.text,
    );

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'New',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Image.asset(
                'assets/add.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
              CustomTextField(
                placeholder: 'Full Name',
                controller: _fullNameController,
                isPassword: false,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                placeholder: 'Phone Number',
                controller: _phoneNumberController,
                isPassword: false,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                placeholder: 'Email',
                controller: _emailController,
                isPassword: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                placeholder: 'Position',
                controller: _positionController,
                isPassword: false,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'ADD',
                onTap: addEmployee,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
