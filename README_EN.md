
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
- **json-server** — local mock API server

---

## 🧰 Installation & Run

> ❗ Note: The project uses `json-server`, which must be started separately.

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

### 4. Run json-server

Make sure `json-server` is installed:

```bash
npm install -g json-server
```

Start the server:

```bash
json-server --watch db.json --port 3000
```

### 5. Run the app

#### Option 1: On Web

```bash
flutter run -d chrome
```

#### Option 2: On a physical Android device

1.Open chrome://inspect in Chrome on your computer
2.Click on “Port forwarding…”
3.In the “Port” field, enter 3000, and in the “IP address and port” field, enter localhost:3000
4.Open Chrome on your mobile device
5. Run:

```bash
flutter run
```
>❗ Important: the project does not run on the emulator due to the specifics of how json-server works.

---

## 📂 Example database

```json
{
  "tasks": [
    {
      "id": "c01a",
      "title": "Sample",
      "description": "Task",
      "completed": false,
      "category": "example-category"
    }
  ],
  "categories": [
    {
      "id": "fa36",
      "name": "example-category"
    }
  ]
}
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


