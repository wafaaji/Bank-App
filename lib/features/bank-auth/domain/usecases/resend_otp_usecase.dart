import '../repositories/bank_auth_repository.dart';

class ResendOtpUseCase {
  final BankAuthRepository repository;

  ResendOtpUseCase(this.repository);

  Future<void> call(String accountNumber) async {
    return await repository.resendOtp(accountNumber);
  }
}
