import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/otp_controller.dart';
import '../screens/otp_screen.dart';

class SendOtpButton extends StatelessWidget {
  final TextEditingController accountController;

  const SendOtpButton({super.key, required this.accountController});

  @override
  Widget build(BuildContext context) {
    final otpController = Get.find<OtpController>();

    return ElevatedButton.icon(
      onPressed: () {
        final account = accountController.text.trim();

        final validationError = otpController.validateAccount(account);
        if (validationError != null) {
          Get.snackbar(
            "Error",
            validationError,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
          return;
        }

        Get.snackbar(
          "Sending OTP",
          "Please wait while we send the OTP...",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blueAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        otpController.sendOtp(account);

        Future.delayed(const Duration(milliseconds: 300), () {
          Get.to(() => const OtpScreen());
        });
      },
      icon: const Icon(Icons.send),
      label: const Text('Send OTP'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}