import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EmployeeDetailedScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> employee;

  const EmployeeDetailedScreen({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Employee',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 75,
                child: Text(
                  employee['fullName'][0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                employee['fullName'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 14),
              _CustomField(
                title: 'Full Name',
                subtitle: employee['fullName'],
              ),
              const SizedBox(height: 14),
              _CustomField(
                title: 'Phone Number',
                subtitle: employee['phoneNumber'],
              ),
              const SizedBox(height: 14),
              _CustomField(
                title: 'Email',
                subtitle: employee['email'],
              ),
              const SizedBox(height: 14),
              _CustomField(
                title: 'Position',
                subtitle: employee['position'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomField extends StatelessWidget {
  final String title;
  final String subtitle;

  const _CustomField({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
