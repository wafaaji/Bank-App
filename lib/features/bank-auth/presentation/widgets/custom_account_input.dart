import 'package:flutter/material.dart';

class CustomAccountInput extends StatelessWidget {
  final TextEditingController controller;

  const CustomAccountInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Bank Account Number',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.account_balance),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
    );
  }
}
