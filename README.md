# Bank Account

# 🔐 Bank OTP Verification App

A Flutter app for verifying a bank account using One-Time Passwords (OTP). It includes user authentication, OTP resend logic with limitations, and a simulated back-end using a fake repository.

## 📱 Features

- Enter account number to receive OTP
- Auto-generated 4-digit OTP with expiration
- OTP verification screen
- Limit OTP resend to 5 times only
- Mocked back-end (no actual API required)
- Clean architecture (Repository & Use Case pattern)
- Dependency injection with GetIt
- State management using GetX
- Navigation using GetX routes

## 📂 Project Structure
lib/
├── core/                           
│   └── ...
├── features/
│   ├── bank-auth/                  
│   │   ├── data/                   
│   │   │   └── repositories/
│   │   ├── domain/                
│   │   │   ├── usecases/
│   │   │   └── repositories/
│   │   │   └── entities/
│   │   └── presentation/          
│   │       ├── controllers/
│   │       └── screens/
│   │       └── widgets/
│   ├── home/                      
│   │   └── presentation/
│   │       └── screens/
│   └── splash/                     
│       └── screens/
├── main.dart                      


## 🧰 Tech Stack

- **Flutter** for UI
- **Dart** for logic
- **GetX** for state management and routing
- **GetIt** for dependency injection
