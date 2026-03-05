# 🌍 Countries App (Flutter)

A Flutter mobile application that displays information about countries using the public REST Countries API.  
The project was built following **clean architecture principles**, **feature-based folder structure**, and **BLoC state management** to demonstrate scalable Flutter application development.

This project was developed as part of a **technical assessment**, focusing on code organization, maintainability, and good engineering practices.

---

# 📱 Features

- 🌍 Browse a list of countries
- 🔎 Search countries by name
- ⭐ Mark and manage favorite countries
- 🌙 Dark mode / Light mode toggle
- 🔤 Sort countries alphabetically
- 📄 View detailed information about each country
- 💾 Local persistence for favorites
- ⚡ Efficient state management using BLoC

---

# 🧠 Architecture

The project follows **Clean Architecture** combined with a **Feature-first structure**.


### Layers Overview

**Presentation Layer**
- UI widgets
- BLoC state management
- Handles user interaction

**Domain Layer**
- Business logic
- Use cases
- Entities

**Data Layer**
- API calls
- Models
- Repository implementations

**Core**
- Shared utilities
- Network configuration
- Dependency injection

---

# 🧰 Technologies Used

- **Flutter**
- **Dart**
- **BLoC (flutter_bloc)**
- **Dio** for networking
- **REST Countries API**
- **SharedPreferences** for local storage
- **Service Locator / Dependency Injection**

---

# 🌐 API

This application uses the public REST Countries API.

Base URL:
`` https://restcountries.com/v3.1/

### Example Endpoint
`` /all

### Sample Request
`` https://restcountries.com/v3.1/all


This API provides country data including:

- Country name
- Capital
- Population
- Region
- Flag
- Languages
- Currency

No authentication or API key is required.

---

# 📁 Project Structure
lib/
│
├── core/
│ ├── di/
│ │ └── service_locator.dart
│ │
│ └── network/
│ └── api_client.dart
│
├── features/
│ ├── countries/
│ │
│ │ ├── data/
│ │ │ ├── models/
│ │ │ └── repositories/
│ │ │
│ │ ├── domain/
│ │ │ ├── entities/
│ │ │ └── repositories/
│ │ │
│ │ └── presentation/
│ │ ├── bloc/
│ │ │ ├── countries_bloc.dart
│ │ │ ├── countries_event.dart
│ │ │ └── countries_state.dart
│ │ │
│ │ ├── pages/
│ │ └── widgets/
│
└── main.dart

---

# ⚙️ Installation

### 1. Clone the repository
`` git clone https://github.com/semhalestifanos/Countries_app_flutter.git


### 2. Navigate to the project directory
`` cd Countries_app_flutter


### 3. Install dependencies
`` flutter pub get


---

# ▶️ Running the Application

Run the application using:

`` flutter run

To run on Chrome:

`` flutter run -d chrome

To run on an Android emulator or connected device:

`` flutter run

---

# 🧪 Development Highlights

Key engineering practices demonstrated in this project:

- Clean Architecture separation
- Feature-based modular structure
- BLoC state management pattern
- Repository pattern for data abstraction
- Dependency injection with service locator
- Local persistence using SharedPreferences
- Scalable and maintainable code organization

---

# 🔒 Security Notes

- No API keys or sensitive credentials are included in this repository.
- The project uses a **public API** that does not require authentication.
- `.env` files and other sensitive configuration files are excluded via `.gitignore`.

---

# 🚀 Future Improvements

Potential enhancements for production-level applications:

- Pagination for large country lists
- Offline caching with a local database (Hive / SQLite)
- Unit and widget testing
- Error handling and retry mechanisms
- Performance optimizations for large datasets

---

# 👨‍💻 Author

**Semhal Estifanos**

Flutter Developer

GitHub  
https://github.com/semhalestifanos

---

# 📄 License

This project is created for educational and assessment purposes.





