import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phone_book/resources/firestore_methods.dart';
import 'package:phone_book/widgets/custom_button.dart';
import 'package:phone_book/widgets/custom_textfield.dart';

class AddEmployeeScreen extends StatefulWidget {
  final bool isEditMode;
  final QueryDocumentSnapshot<Map<String, dynamic>>? employee;
  const AddEmployeeScreen({
    Key? key,
    required this.isEditMode,
    required this.employee,
  }) : super(key: key);

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

    if (widget.isEditMode) {
      await FirestoreMethods().edit(
        _fullNameController.text,
        _phoneNumberController.text,
        _emailController.text,
        _positionController.text,
        widget.employee!['docId'],
      );
    } else {
      await FirestoreMethods().add(
        _fullNameController.text,
        _phoneNumberController.text,
        _emailController.text,
        _positionController.text,
      );
    }

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
    final isEditMode = widget.isEditMode;
    final employee = widget.employee;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text(
          isEditMode ? 'Update' : 'New',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: widget.isEditMode
                ? [
                    Image.asset(
                      'assets/edit.png',
                      width: 180,
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                    CustomTextField(
                      placeholder: 'Full Name',
                      controller: _fullNameController
                        ..text = employee?['fullName'],
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      placeholder: 'Phone Number',
                      controller: _phoneNumberController
                        ..text = employee?['phoneNumber'],
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      placeholder: 'Email',
                      controller: _emailController..text = employee?['email'],
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      placeholder: 'Position',
                      controller: _positionController
                        ..text = employee?['position'],
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'SAVE',
                      onTap: addEmployee,
                      isLoading: _isLoading,
                    ),
                  ]
                : [
                    Image.asset(
                      'assets/add.png',
                      width: 180,
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                    CustomTextField(
                      placeholder: 'Full Name',
                      controller: _fullNameController,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      placeholder: 'Phone Number',
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      placeholder: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      placeholder: 'Position',
                      controller: _positionController,
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
