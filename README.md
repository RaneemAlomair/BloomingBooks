# 📚 Blooming Books 🌼

**Blooming Books** is a SwiftUI app that allows users to browse a collection of books, search through them, mark favorites, and switch between light and dark modes.

---

## ✨ Features
- 🔍 **Book Search**: Live filtering of books as you type.  
- ❤️ **Favorites**: Add or remove books from your favorites list.  
- 🌗 **Dark/Light Mode**: Toggle between themes using `@AppStorage`.  
- 📱 **Responsive Design**: Consistent colors and typography for both light and dark modes.
- 🚀 **Two-step Onboarding**: stores preferredCategory in @AppStorage and uses it as the initial query.
- 💥 **Error UI**: friendly error card with retry.
- 🧩 **Clean Architecture**: MVVM + Repository + Network + Combine

---

## 🛠 Tech Stack
- **Language:** Swift  
- **Framework:** SwiftUI  
- **Design:** Custom color assets with light/dark mode
- **Reactive:** Combine (AnyPublisher, eraseToAnyPublisher, sink)
- **Persistence:** UserDefaults
- **Architecture:** MVVM + Repository + Network layer
- **API:** OpenLibrary (search + covers)

---

## 🖼 Screenshots
<img width="200" alt="Simulator Screenshot - iPhone 16 Pro - 2025-09-15 at 13 47 40" src="https://github.com/user-attachments/assets/2a0c8f27-c90a-4446-ae94-6a5d15f93fe0" />
<img width="200" alt="Simulator Screenshot - iPhone 16 Pro - 2025-09-15 at 13 47 43" src="https://github.com/user-attachments/assets/479f7221-fed8-4ec5-bbd4-cef4979d22fc" />
<img width="200" alt="Simulator Screenshot - iPhone 16 Pro - 2025-09-15 at 13 47 47" src="https://github.com/user-attachments/assets/c1ffbb70-17ae-4a88-a31d-0dbf5efaccaa" />
<img width="200" alt="Simulator Screenshot - iPhone 16 Pro - 2025-09-15 at 13 48 02" src="https://github.com/user-attachments/assets/fa324a8b-80ec-4b82-ac31-8aba2c7570a9" />
<img width="200" alt="Simulator Screenshot - iPhone 16 Pro - 2025-09-15 at 13 48 31" src="https://github.com/user-attachments/assets/2cbc7ad2-0ab9-4d62-8ccb-5fd3f0e18e9e" />
<img width="200" alt="Simulator Screenshot - iPhone 16 Pro - 2025-09-15 at 13 48 11" src="https://github.com/user-attachments/assets/d644ed0f-f2e3-4aa4-954b-3d8e2f4c6330" />


---


## 📂 Project Structure
```
BloomingBooks/
├── App/
│   ├── BloomingBooksApp.swift      # App entry
│   ├── RootView.swift              # Switches Onboarding vs. main tabs
│   ├── OnboardingView.swift        # Two-step onboarding (category + start)
│   ├── SplashScreen.swift          # (optional)
│   └── tab.swift                   # (if used)
├── Data/
│   ├── BooksRepository.swift       # OpenLibraryRepository (+ protocol)
│   ├── FavoritesStore.swift        # FavoritesStore (+ protocol, UserDefaults)
│   └── Network.swift               # Network + NetworkProtocol (GET<T>)
├── Features/
│   └── BooksList/
│       ├── ViewModel/
│       │   └── BooksListViewModel.swift
│       └── Views/
│           ├── BookListView.swift
│           ├── BookDetailView.swift
│           ├── BookRowView.swift
│           ├── CoverImageView.swift
│           ├── ErrorCardView.swift
│           └── FavoritesView.swift
├── Model/
│   └── Book.swift                  # Book + SearchResponse
└── Assets/                         # Colors (blooming*), images (e.g., openBook)
```
