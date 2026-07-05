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
| 📅 **Event Creation** | Create new events with category selection, date/time, and description.      |
| 🔍 **Event Discovery**| Browse events by categories like Sport, Birthday, Book club, Meeting, etc.  |
| 🌍 **Localization**   | Full support for Arabic and English languages using Easy Localization.      |
| 🌙 **Dark Mode**      | Dynamic theme switching (Light/Dark) to suit user preference.               |
| 💾 **Local Storage**  | Persistent user settings (language, theme) powered by Hive.                 |
| 🔥 **Real-time Sync** | Real-time event updates and storage using Cloud Firestore.                  |

## 📱 Screens

- **Splash Screen** — Animated entry point with branding.
- **Onboarding Screen** — Introduction to app features for new users.
- **Auth Screens** — Login and Register screens for user management.
- **Home Screen** — Main dashboard featuring event categories (All, Sport, Book club, Birthday, Meeting, Exhibition).
- **Create Event** — Dedicated form to publish new events with category-specific headers.
- **Profile Screen** — User settings for theme, language, and logout.

## 📸 Screenshots

| Splash | Onboarding | Login | Register |
| :---: | :---: | :---: | :---: |
| <img width="200" height="400" alt="splash" src="https://github.com/shadyabdallah241/evently_app/blob/main/screenshots/splash.png?raw=true" /> | <img width="200" height="400" alt="onboarding" src="https://github.com/shadyabdallah241/evently_app/blob/main/screenshots/onboarding.png?raw=true" /> | <img width="200" height="400" alt="login" src="https://github.com/shadyabdallah241/evently_app/blob/main/screenshots/login.png?raw=true" /> | <img width="200" height="400" alt="register" src="https://github.com/shadyabdallah241/evently_app/blob/main/screenshots/register.png?raw=true" /> |

| Home | Create Event | Favorites | Profile |
| :---: | :---: | :---: | :---: |
| <img width="200" height="400" alt="home" src="https://github.com/shadyabdallah241/evently_app/blob/main/screenshots/home.png?raw=true" /> | <img width="200" height="400" alt="create event" src="https://github.com/shadyabdallah241/evently_app/blob/main/screenshots/create_event.png?raw=true" /> | <img width="200" height="400" alt="favorites" src="https://github.com/shadyabdallah241/evently_app/blob/main/screenshots/favorites.png?raw=true" /> | <img width="200" height="400" alt="profile" src="https://github.com/shadyabdallah241/evently_app/blob/main/screenshots/profile.png?raw=true" /> |

## 🛠 Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **Backend:** [Firebase](https://firebase.google.com/) (Auth, Firestore)
- **Database:** [Hive](https://pub.dev/packages/hive) & [Hive Flutter](https://pub.dev/packages/hive_flutter)
- **State Management:** [Provider](https://pub.dev/packages/provider)
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

- Custom event category images (Sport, Birthday, Book club, Meeting, Exhibition).
- Multi-language translation files in `assets/translations`.
- Integrated Google Fonts (**Inter**, etc.).

## 🗺 Roadmap

- [ ] Google Maps integration for event locations
- [ ] Social sharing of events
- [ ] In-app chat for event participants
- [ ] Push notifications for upcoming events

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!
Feel free to check the [issues page](https://github.com/shadyabdallah241/evently_app/issues) or submit a pull request.

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

<p align="center"><i>This project was built as part of a Flutter development course assignment.</i></p>
