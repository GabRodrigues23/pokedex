# 📱 Pokédex

A Pokédex app built with **Flutter** that allows users to browse,
search, and filter Pokémon with a fast and simple interface.

<p align="center">
  <img src="https://imgur.com/mu2YahD.png" width="150"/>
  <img src="https://imgur.com/n6w4VpK.png" width="150"/>
  <img src="https://imgur.com/xOvqTAz.png" width="150"/>
  <img src="https://imgur.com/QCFBmKq.png" width="150"/>
</p>

------------------------------------------------------------------------

## 🚀 Features (Version 1)

-   📋 Pokémon list with dynamic cards
-   🔍 Search by name or ID
-   🏷️ Filter by Pokémon type
-   🎨 Cards colored according to Pokémon type
-   ⚡ Local cache for faster loading
-   🟡 Splash screen with preload

------------------------------------------------------------------------

## 🛠️ Tech Stack

-   **Flutter**
-   **Dart**
-   **PokeAPI**

------------------------------------------------------------------------

## 📦 Architecture

The project follows a simple MVVM pattern:

-   **View** → UI (screens and widgets)
-   **ViewModel** → State and business logic
-   **Repository** → Data handling (API + cache)
-   **Service** → API communication and Local persistence using SharedPreferences

------------------------------------------------------------------------

## 📲 How It Works

1.  On app start, a splash screen is shown
2.  Pokémon data is loaded and cached
3.  The home screen displays Pokémon cards
4.  Users can:
    -   Search Pokémon by name or ID
    -   Filter Pokémon by type
5.  Cached data makes future launches faster

------------------------------------------------------------------------

## ▶️ Getting Started

### Prerequisites

-   Flutter SDK installed
-   Android Studio / VS Code

### Run the project

``` bash
flutter pub get
flutter run
```

------------------------------------------------------------------------

## 🌐 API

This project uses the public API:

-   https://pokeapi.co

------------------------------------------------------------------------

## 📌 Future Improvements

-   Pokémon details screen
-   Add more generations
-   Animations and transitions

------------------------------------------------------------------------

## 👨‍💻 Author

Developed by **Gabriel Rodrigues**

------------------------------------------------------------------------

## 📄 License

This project is for study and educational purposes.
