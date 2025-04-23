import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/otp_controller.dart';
import '../widgets/custom_account_input.dart';
import '../widgets/send_otp_button.dart';

class BankAccountScreen extends StatelessWidget {
  final controller = Get.put(OtpController());
  final TextEditingController accountController = TextEditingController();

  BankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Bank Account Login",
            style: TextStyle(color: Colors.white,),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Enter your bank account number',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            CustomAccountInput(controller: accountController),
            const SizedBox(height: 24),
            SendOtpButton(accountController: accountController),
          ],
        ),
      ),
    );
  }
}