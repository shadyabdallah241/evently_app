# 📅 Evently

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase" />
  <img src="https://img.shields.io/badge/Hive-FFCA28?style=for-the-badge&logo=database&logoColor=black" alt="Hive" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License" />
</p>

<p align="center">
  A comprehensive Event Management app built with Flutter — allowing users to discover, create, and manage events with real-time Firebase integration and offline support.
</p>

---

## 📖 Table of Contents

- [Features](#-features)
- [Screens](#-screens)
- [Screenshots](#-screenshots)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
- [Project Structure](#-project-structure)
- [Assets](#-assets)
- [Roadmap](#-roadmap)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

| Feature              | Description                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| 🔐 **Authentication** | Secure Login and Registration using Firebase Auth (Email/Password & Google). |
| 📅 **Event Creation** | Create new events with category selection, date/time, and location.         |
| 🔍 **Event Discovery**| Browse events by categories like Sport, Birthday, Meeting, etc.             |
| 📍 **Google Maps**    | View and select event locations using Google Maps integration.              |
| 🌍 **Localization**   | Full support for Arabic and English languages using Easy Localization.      |
| 🌙 **Dark Mode**      | Dynamic theme switching (Light/Dark) to suit user preference.               |
| 💾 **Local Storage**  | Persistent user settings (language, theme) powered by Hive.                 |
| 🔥 **Real-time Sync** | Real-time event updates and storage using Cloud Firestore.                  |

## 📱 Screens

- **Splash Screen** — Animated entry point with branding.
- **Onboarding Screen** — Introduction to app features for new users.
- **Auth Screens** — Login, Register, and Forget Password for user management.
- **Home Screen** — Main dashboard featuring event tabs (All, My Events, etc.).
- **Create Event** — Dedicated form to publish new events.
- **Event Details** — Full view of event information with join functionality.

## 📸 Screenshots

| Onboarding | Home | Create Event | Event Details |
| :---: | :---: | :---: | :---: |
| <img width="200" height="400" alt="onboarding" src="https://github.com/user-attachments/assets/c3f69094-3a21-4195-8879-0925b7d3a709" /> | <img width="200" height="400" alt="home" src="https://github.com/user-attachments/assets/eeaaf2b0-a3c1-4469-a0b3-6d333c85f424" /> | <img width="200" height="400" alt="create event" src="https://github.com/user-attachments/assets/3da75d47-8299-4af0-a0f2-a5d73248e058" /> | <img width="200" height="400" alt="details" src="https://github.com/user-attachments/assets/e23a89ac-41cb-4ebd-ac5c-c1c7e88efb4f" /> |

| Login | Profile | Maps | Dark Mode |
| :---: | :---: | :---: | :---: |
| <img width="200" height="400" alt="login" src="https://github.com/user-attachments/assets/400439bb-46ea-4bdb-a774-ec7509e5ce82" /> | <img width="200" height="400" alt="profile" src="https://github.com/user-attachments/assets/d1a827e6-4a63-48b4-8e2a-1d35f3c48586" /> | <img width="200" height="400" alt="maps" src="https://github.com/user-attachments/assets/bae74cd3-f424-4685-825c-13d26870ea81" /> | <img width="200" height="400" alt="dark mode" src="https://github.com/user-attachments/assets/e681fa00-7a3b-4749-ae38-82dd52087389" /> |

## 🛠 Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **Backend:** [Firebase](https://firebase.google.com/) (Auth, Firestore, Storage)
- **Database:** [Hive](https://pub.dev/packages/hive) & [Hive Flutter](https://pub.dev/packages/hive_flutter)
- **State Management:** [Provider](https://pub.dev/packages/provider)
- **Maps:** [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)
- **Localization:** [Easy Localization](https://pub.dev/packages/easy_localization)

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Firebase project configuration (`google-services.json` for Android / `GoogleService-Info.plist` for iOS)
- A configured emulator/simulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/shadyabdallah241/evently_app.git
   cd evently
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📂 Project Structure

```
lib/
├── components/      # Reusable UI widgets
├── models/          # Data models (Event, Category, etc.)
├── providers/       # State management using Provider
├── screens/         # Main application screens
├── tabs/            # Home screen navigation tabs
├── theme/           # App colors and theme extensions
├── util/            # Helper functions and UI utilities
└── main.dart        # App entry point
```

## 🎨 Assets

- Custom event category images (Sport, Birthday, etc.).
- Multi-language translation files in `assets/translations`.
- Integrated Google Fonts (**Inter**, etc.).

## 🗺 Roadmap

- [ ] Social sharing of events
- [ ] In-app chat for event participants
- [ ] Push notifications for upcoming events
- [ ] Advanced event filtering and search

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!
Feel free to check the [issues page](https://github.com/shadyabdallah241/evently_app/issues) or submit a pull request.

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

<p align="center"><i>This project was built as part of a Flutter development course assignment.</i></p>
