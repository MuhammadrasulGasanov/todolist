
# ✅ TODO LIST

Простое Flutter-приложение для управления задачами с поддержкой категорий.  
Разработано в рамках тестового задания.

---

## 📌 Описание

TODO LIST — это приложение для добавления, редактирования и фильтрации задач.  
Пользователь может:
- Добавлять, удалять и редактировать задачи
- Отмечать задачи как выполненные
- Создавать и удалять категории
- Фильтровать задачи по категориям

---

## 🚀 Технологии

- **Flutter** (Dart)
- **Riverpod** — управление состоянием
- **Dio** — HTTP-запросы
- **Freezed / JsonSerializable** — модели
- **AutoRoute** — навигация
- **json-server** — мок-сервер API (локальный)

---

## 🧰 Установка и запуск

> ❗ Важно: проект использует `json-server`, который нужно запустить отдельно.

### 1. Клонируйте репозиторий

```bash
git clone https://github.com/MuhammadrasulGasanov/todolist.git
cd todolist
```

### 2. Установите зависимости

```bash
flutter pub get
```

### 3. Cгенерируйте .g.dart, .gr.dart, .freezed.dart файлы

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Запустите json-server

Убедитесь, что установлен `json-server`:

```bash
npm install -g json-server
```

Запустите сервер из корня проекта:

```bash
json-server --watch db.json --port 3000
```

### 5. Запуск приложения

#### Вариант 1: В браузере

```bash
flutter run -d chrome
```

#### Вариант 2: На физическом устройстве

1. Откройте в Chrome на компьютере `chrome://inspect`
2. Нажмите "Port forwarding..."
3. Добавьте в поле "Port" - `3000`, а в поле "IP address and port" - `localhost:3000`
4.Откройте Chrome на мобильном устройстве
5. Запустите:

```bash
flutter run
```
> ❗ Важно: проект не запускается на эмуляторе из-за специфики работы с  `json-server`.
---

## 📂 Структура базы данных

```json
{
  "tasks": [
    {
      "id": "c01a",
      "title": "Задача",
      "description": "Описание",
      "completed": false,
      "category": "Категория"
    }
  ],
  "categories": [
    {
      "id": "fa36",
      "name": "Категория"
    }
  ]
}
```

---

## ✅ Реализованные функции

- [x] Добавление задач
- [x] Редактирование задач
- [x] Удаление задач
- [x] Фильтрация по категориям
- [x] Отметка задач как выполненных
- [x] Управление категориями

---

## 📬 Контакты

Telegram: [@Becautiouz](https://t.me/becautiouz)  
Email: magomedr.g@gmail.com


