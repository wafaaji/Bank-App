import '../repositories/bank_auth_repository.dart';

class VerifyOtpUseCase {
  final BankAuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<bool> call(String otpCode) async {
    return await repository.verifyOtp(otpCode);
  }
}
