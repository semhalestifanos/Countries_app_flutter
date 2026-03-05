# 📱 Countries App – Flutter Mobile Application

## 📌 Project Overview

The Countries App is a mobile application built using Flutter that allows users to browse, search, and learn about countries around the world.

The application integrates with a public REST API to fetch country data and demonstrates modern mobile engineering practices including state management, clean architecture principles, local persistence, and responsive UI handling.

This project was developed as part of a technical assessment focusing on real-world production-level mobile development skills.

---

## 🚀 Key Features Implemented

### 🌍 Country Listing
- Displays a scrollable list of countries.
- Shows:
  - Country flag
  - Country name
  - Population (formatted display)

### 🔍 Search Functionality
- Real-time search filtering.
- Debounced search input to improve performance.

### 📄 Country Detail View
- Fetches detailed country data using country code identifier.
- Displays:
  - Large flag banner
  - Key statistics (Area, Population, Region, Subregion)
  - Timezones list
- Includes loading and error states.

### ❤️ Favorites Management
- Users can mark countries as favorites.
- Favorite countries are stored locally.
- Favorites persist after app restart.

### 🔄 State Handling
- Loading states
- Error handling with retry functionality
- Empty state UI feedback

---

## 🏗 Architecture & Design Approach

The project follows a **feature-based clean architecture structure**.

The codebase is organized into:

- Presentation Layer (UI + Bloc)
- Business Logic Layer (Bloc events and states)
- Data Layer (Repository + API Client)
- Local Storage Layer (Persistence)

### State Management

The application uses **Bloc (Business Logic Component)** pattern.

Advantages of Bloc usage:

- Separation of UI and business logic
- Predictable state transitions
- Easier debugging
- Scalability for future features

## 🌗 Additional Features

### 🌑 Dark Mode Support
- The application supports theme switching between light and dark modes.
- Improves usability in different lighting environments.

### 🔀 Sorting Functionality
- Users can sort country lists.
- Sorting can be done based on:
  - Country name
  - Population
- Enhances data browsing experience.

---

## 🌐 API Integration

The app uses the public REST Countries API:

Two-step data fetching strategy was implemented:

1. Fetch minimal data for country lists for performance optimization.
2. Fetch detailed country data only when a country is selected.

Network communication is handled using the Dio HTTP client.

---

## 💾 Local Storage

Favorites are stored using `SharedPreferences`.

Persistence ensures:
- User favorite selections remain after app restart.

---

## 🎨 User Experience Enhancements

- Pull-to-refresh support.
- Loading indicators.
- Error retry buttons.
- Responsive layout design.

Optional enhancement:
- Hero animation for flag transitions.

---

## 📦 Technologies Used

- Flutter SDK
- Dart Programming Language
- Bloc State Management
- Dio HTTP Client
- SharedPreferences
- Clean Architecture Principles

---

## ⚙️ Setup Instructions

### Prerequisites

- Flutter SDK installed
- Git installed
- Internet connection

### Clone Repository

```bash
git clone https://github.com/semhalestifanos/Countries_app_flutter.git
cd countries_app

**### Install Dependencies**

```flutter pub get

**### Run Application**

```flutter run -d chrome
```

## 🔒 Security Notes

- No sensitive API keys were exposed.

- Public REST API was used.

## ⭐ Future Improvements 

- Caching optimization

- Pagination support

- Advanced animations

## 👩‍💻 Author

Developed as a technical assessment project by **Semhal Estifanos Abera**.
