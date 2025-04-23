import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/otp_controller.dart';
import '../widgets/otp_input_field.dart';
import '../widgets/otp_timer.dart';
import '../widgets/otp_action_buttons.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpTextController = TextEditingController();
  final OtpController otpController = Get.find<OtpController>();

  void _onConfirmPressed() {
    final code = otpTextController.text.trim();
    if (code.length == 4 && RegExp(r'^\d{4}$').hasMatch(code)) {
      otpController.verifyOtp(code);
    } else {
      Get.snackbar("Error", "Please enter a valid 4-digit code",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        title: const Text("Verification Code", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Text("Enter the 4-digit OTP sent to your account"),
            const SizedBox(height: 32),
            OtpInputField(controller: otpTextController),
            const SizedBox(height: 12),
            Obx(() {
              if (!otpController.isOtpSent.value) return const SizedBox();
              return OtpTimer(
                key: ValueKey(otpController.timerKey.value),
                onExpire: () {
                  Get.snackbar("Expired", "OTP has expired, please request again",
                      backgroundColor: Colors.red, colorText: Colors.white);
                },
              );
            }),
            const Spacer(),
            OtpActionButtons(
              otpController: otpController,
              otpTextController: otpTextController,
              onConfirmPressed: _onConfirmPressed,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}