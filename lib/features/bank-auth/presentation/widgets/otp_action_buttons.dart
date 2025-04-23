import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/otp_controller.dart';

class OtpActionButtons extends StatelessWidget {
  final OtpController otpController;
  final TextEditingController otpTextController;
  final VoidCallback onConfirmPressed;

  const OtpActionButtons({
    super.key,
    required this.otpController,
    required this.otpTextController,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(() => OutlinedButton(
          onPressed: otpController.resendAttempts.value >= otpController.maxResendAttempts
              ? null
              : () async {
            await otpController.resendOtp();
            otpTextController.clear();
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blueAccent,
            side: const BorderSide(color: Colors.blueAccent),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            otpController.resendAttempts.value >= otpController.maxResendAttempts
                ? "MAX RESENDS"
                : "RESEND",
          ),
        )),
        Obx(() => ElevatedButton(
          onPressed: otpController.isVerifying.value ? null : onConfirmPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text("CONFIRM"),
        )),
      ],
    );
  }
}