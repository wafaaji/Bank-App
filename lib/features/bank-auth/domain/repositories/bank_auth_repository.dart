abstract class BankAuthRepository {
  Future<void> sendOtp(String accountNumber);
  Future<bool> verifyOtp(String otpCode);
  Future<void> resendOtp(String accountNumber);
}
