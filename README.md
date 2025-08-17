# 📚 Blooming Books 🌼

**Blooming Books** is a SwiftUI app that allows users to browse a collection of books, search through them, mark favorites, and switch between light and dark modes.

---

## ✨ Features
- 🔍 **Book Search**: Live filtering of books as you type.  
- ❤️ **Favorites**: Add or remove books from your favorites list.  
- 🌗 **Dark/Light Mode**: Toggle between themes using `@AppStorage`.  
- 📱 **Responsive Design**: Consistent colors and typography for both light and dark modes.  

---

## 🛠 Tech Stack
- **Language:** Swift  
- **Framework:** SwiftUI  
- **State Management:** `@EnvironmentObject`, `@AppStorage`  
- **Design:** Custom color assets with light/dark mode  

---

## 📂 Project Structure
BloomingBooks/
│── Models/ # Book model
│── ViewModels/ # BooksListViewModel
│── Views/ # SwiftUI views (BooksList, Favorites, Details)
│── Assets/ # Colors & images
