import '../repositories/bank_auth_repository.dart';

class SendOtpUseCase {
  final BankAuthRepository repository;

  SendOtpUseCase(this.repository);

  Future<void> call(String accountNumber) async {
    return await repository.sendOtp(accountNumber);
  }
}
