import 'package:flutter/material.dart';

showSnackBar(String text, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}
