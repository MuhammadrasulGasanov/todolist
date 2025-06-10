# ✅ TODO LIST

A simple Flutter task management app with category support.  
Created as part of a test assignment.

---

## 📌 Description

TODO LIST is an app for adding, editing, and filtering tasks.  
Users can:
- Add, delete, and edit tasks
- Mark tasks as completed
- Create and delete categories
- Filter tasks by category

---

## 🚀 Technologies

- **Flutter** (Dart)
- **Riverpod** — state management
- **Dio** — HTTP requests
- **Freezed / JsonSerializable** — model generation
- **AutoRoute** — navigation
- **Go** — backend server
- **PostgreSQL** — database

---

## 🧰 Installation & Run

> ❗ Note: The app now works with a remote Go backend and PostgreSQL database.  
> Local `json-server` is no longer used.

### 1. Clone the repository

```bash
git clone https://github.com/MuhammadrasulGasanov/todolist.git
cd todolist
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Generate `.g.dart`, `.gr.dart`, `.freezed.dart` files

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run the app

The app connects to a remote server by default.  
Make sure you have an internet connection.

#### Option 1: On Web

```bash
flutter run -d chrome
```

#### Option 2: On a physical device

```bash
flutter run
```

---

## ✅ Features

- [x] Add tasks
- [x] Edit tasks
- [x] Delete tasks
- [x] Filter tasks by category
- [x] Mark tasks as completed
- [x] Manage categories

---

## 📬 Contact

Telegram: [@Becautiouz](https://t.me/Becautiouz)  
Email: magomedr.g@gmail.com


