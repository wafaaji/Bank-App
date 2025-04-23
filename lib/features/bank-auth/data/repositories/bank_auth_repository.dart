import '../../domain/repositories/bank_auth_repository.dart';

class FakeBankAuthRepository implements BankAuthRepository {
  String _sentOtpCode = "";
  DateTime? _otpExpiration;

  // generate 4 digit OTP
  String _generateOtp() {
    final random = DateTime.now().millisecondsSinceEpoch % 10000;
    return random.toString().padLeft(4, '0');
  }

  @override
  Future<void> sendOtp(String accountNumber) async {
    _sentOtpCode = _generateOtp();
    _otpExpiration = DateTime.now().add(Duration(minutes: 1));
    print("Sending OTP to account $accountNumber: $_sentOtpCode");
  }

  @override
  Future<bool> verifyOtp(String otpCode) async {
    if (_otpExpiration != null && DateTime.now().isAfter(_otpExpiration!)) {
      print("OTP has expired");
      return false;
    }
    bool isCorrect = otpCode == _sentOtpCode;
    print("OTP correct? $isCorrect");
    return isCorrect;
  }

  @override
  Future<void> resendOtp(String accountNumber) async {
    _sentOtpCode = _generateOtp();
    _otpExpiration = DateTime.now().add(Duration(minutes: 2));
    print("Resending OTP to account $accountNumber: $_sentOtpCode");
  }
}