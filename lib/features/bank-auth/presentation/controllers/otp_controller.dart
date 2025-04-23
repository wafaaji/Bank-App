import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:bank_account/features/bank-auth/domain/usecases/send_otp_usecase.dart';
import 'package:bank_account/features/bank-auth/domain/usecases/verify_otp_usecase.dart';
import 'package:bank_account/features/bank-auth/domain/usecases/resend_otp_usecase.dart';

class OtpController extends GetxController {
  // Dependency injection using GetIt to retrieve use cases
  final SendOtpUseCase sendOtpUseCase = GetIt.instance<SendOtpUseCase>();
  final VerifyOtpUseCase verifyOtpUseCase = GetIt.instance<VerifyOtpUseCase>();
  final ResendOtpUseCase resendOtpUseCase = GetIt.instance<ResendOtpUseCase>();

  var otpCode = "".obs;               // Stores the current OTP code
  var accountNumber = "".obs;         // Stores the account number being used for OTP
  var message = "".obs;               // General-purpose message for user feedback

  var isOtpSent = false.obs;          // True if OTP has been successfully sent
  var isVerifying = false.obs;        // True while the OTP is being verified
  var isExpired = false.obs;          // True if the OTP has expired
  var timerKey = 0.obs;               // Used to trigger a rebuild of the OTP timer widget

  // Add a counter for resend attempts
  final int maxResendAttempts = 5;
  var resendAttempts = 0.obs;

  // Sends an OTP to the provided account
  Future<void> sendOtp(String account) async {
    try {
      accountNumber.value = account;
      resendAttempts.value = 0; // Reset on first send
      await sendOtpUseCase.call(account);
      isOtpSent.value = true;
      isExpired.value = false;
      message.value = "OTP Sent.";
      print("OTP has been sent to account: $account");
    } catch (e) {
      message.value = "Failed to send OTP. Please try again.";
      Get.snackbar("Error", message.value,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError);
    }
  }

  // Verifies the OTP entered by the user
  Future<void> verifyOtp(String enteredOtp) async {
    if (isExpired.value) {
      message.value = "OTP has expired. Please request a new one.";
      Get.snackbar("Expired", message.value,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError);
      return;
    }

    try {
      isVerifying.value = true;
      bool isVerified = await verifyOtpUseCase.call(enteredOtp);

      if (isVerified) {
        message.value = "OTP Verified Successfully!";
        Get.snackbar("Success", message.value,
            backgroundColor: Get.theme.colorScheme.primary,
            colorText: Get.theme.colorScheme.onPrimary);
        Get.offAllNamed('/home');
      } else {
        message.value = "Invalid OTP. Please try again.";
        Get.snackbar("Invalid", message.value,
            backgroundColor: Get.theme.colorScheme.error,
            colorText: Get.theme.colorScheme.onError);
      }
    } catch (e) {
      message.value = "Verification failed. Try again.";
      Get.snackbar("Error", message.value,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError);
    } finally {
      isVerifying.value = false;
    }
  }

  // Resends the OTP and resets the timer
  Future<void> resendOtp() async {
    if (resendAttempts.value >= maxResendAttempts) {
      message.value = "You have reached the maximum number of resend attempts.";
      Get.snackbar("Too Many Attempts", message.value,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError);
      return;
    }

    try {
      await resendOtpUseCase.call(accountNumber.value);
      resendAttempts.value++;
      isExpired.value = false;
      isOtpSent.value = true;
      timerKey.value++; // trigger timer rebuild
      message.value = "OTP has been resent (${resendAttempts.value}/$maxResendAttempts).";
      print("OTP has been resent to account: ${accountNumber.value}");
      Get.snackbar("Resent", message.value,
          backgroundColor: Get.theme.colorScheme.secondary,
          colorText: Get.theme.colorScheme.onSecondary);
    } catch (e) {
      message.value = "Failed to resend OTP. Try again later.";
      Get.snackbar("Error", message.value,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError);
    }
  }

  // Called by the OTP timer widget when the time runs out
  void markOtpAsExpired() {
    isExpired.value = true;
    print("OTP expired for account: ${accountNumber.value}");
  }

  // Validates the format of the account number
  String? validateAccount(String account) {
    if (account.isEmpty) {
      return "Account number cannot be empty";
    }
    if (!RegExp(r'^\d{10}$').hasMatch(account)) {
      return "Invalid account number. It should be 10 digits.";
    }
    return null;
  }
}