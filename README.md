# AuroraO

The next generation Concierge.

---

## 📱 Android App Setup Guide

Welcome!  
Follow the steps below to set up and run the project on your local machine.

---

## 🚀 Prerequisites

Ensure you have the following installed:

- **Flutter SDK** (latest stable recommended)
- **Dart SDK** (comes with Flutter)
- **Android Studio** (used to build and run the app)
- **Git**

---

## 📥 1. Clone the Repository

```bash
$ git clone https://github.com/bayatechllc/aurora_app.git
$ cd <PROJECT_FOLDER>
```

---

## 📦 2. Install Dependencies

```bash
$ flutter pub get
```

---

## 🏗️ 3. Generate Auto-Generated Files

This project uses tools like Chopper, Freezed, and other code generators.
Run the build runner command to generate all required files.

Build Runner Command:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

To automatically rebuild on file changes:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## ▶️ 4. Run the App

### Using Android Studio

1. Open the project in Android Studio

2. Select a device/emulator

3. Press Run ▶️

### Or via CLI:

```bash
$ flutter run
```

---

## 🧭 Project Structure (Optional)

```
lib/
 ├─ core/
 ├─ data/
 │   ├─ models/        # Freezed data classes
 │   ├─ service/       # Chopper API clients
 ├─ di/
 ├─ ui/

 ```

---

## 🛠️ Troubleshooting

Missing generated files?
Run:

```bash

flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Build issues?

#### Try:

```bash
flutter clean
flutter pub get
```
