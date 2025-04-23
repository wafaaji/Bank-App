import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;

  const OtpInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      controller: controller,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 60,
        fieldWidth: 50,
        activeColor: Colors.blueAccent,
        selectedColor: Colors.blue,
        inactiveColor: Colors.blue[100]!,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: false,
      keyboardType: TextInputType.number,
      onChanged: (_) {},
    );
  }
}
