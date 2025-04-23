# bank_account

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
├── core/                           # Core utilities (common models, constants, services)
│   └── ...
├── features/
│   ├── bank-auth/                  # Bank authentication feature
│   │   ├── data/                   # Data layer (fake API, repositories)
│   │   │   └── repositories/
│   │   ├── domain/                 # Domain layer (entities, use cases, abstract repos)
│   │   │   ├── usecases/
│   │   │   └── repositories/
│   │   │   └── entities/
│   │   └── presentation/           # UI layer (controllers, screens, widgets)
│   │       ├── controllers/
│   │       └── screens/
│   │       └── widgets/
│   ├── home/                       # Home screen feature
│   │   └── presentation/
│   │       └── screens/
│   └── splash/                     # Splash screen feature
│       └── screens/
├── main.dart                       # Entry point with routing & DI setup


## 🧰 Tech Stack

- **Flutter** for UI
- **Dart** for logic
- **GetX** for state management and routing
- **GetIt** for dependency injection
