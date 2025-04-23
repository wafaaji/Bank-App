import 'package:bank_account/features/bank-auth/domain/repositories/bank_auth_repository.dart';
import 'package:bank_account/features/bank-auth/presentation/screens/bank_account_screen.dart';
import 'package:bank_account/features/bank-auth/presentation/screens/otp_screen.dart';
import 'package:bank_account/features/home/presentation/screens/home_screen.dart';
import 'package:bank_account/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:bank_account/features/bank-auth/domain/usecases/send_otp_usecase.dart';
import 'package:bank_account/features/bank-auth/domain/usecases/verify_otp_usecase.dart';
import 'package:bank_account/features/bank-auth/domain/usecases/resend_otp_usecase.dart';
import 'package:bank_account/features/bank-auth/data/repositories/bank_auth_repository.dart';

final sl = GetIt.instance;

void init() {
  // Register the repository and use cases in GetIt
  sl.registerLazySingleton<BankAuthRepository>(() => FakeBankAuthRepository());
  sl.registerLazySingleton(() => SendOtpUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResendOtpUseCase(sl()));
}

void main() {
  init(); // Initialize GetIt dependencies

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bank Account App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      // home: BankAccountScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/bankAccount', page: () => BankAccountScreen()),
        GetPage(name: '/otp', page: () => const OtpScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
      ],
    );
  }
}