# Saranghae Honey Bee Farm 🐝🌼

A Flutter mobile application designed to monitor and manage beehive conditions efficiently. The app provides real-time updates on temperature, humidity, and hive weight, while also offering user-friendly features like fan toggling, notifications, historical logs, and reminders.

## 📱 Project Overview

Saranghae Honey Bee Farm is an IoT-inspired monitoring tool for beekeepers. It ensures optimal conditions inside beehives and provides timely alerts and visual data to support bee health and productivity.

### 🌟 Key Features

- **Hive Dashboard (Home Tab):**
  - Real-time status display: Temperature, Humidity, and Hive Weight.
  - Cooling fan toggle to simulate environmental control.
  - Daily reminder setup using Flutter's native `TimePicker`.
  - Line charts for each metric powered by [`fl_chart`](https://pub.dev/packages/fl_chart).

- **Notifications Tab:**
  - Displays system-generated alerts for environmental thresholds (e.g., high humidity or honey harvest readiness).
  - Dismiss or tap for more details.

- **History Tab:**
  - Lists recent activities, logs, and hive-related changes for tracking past conditions.

## 🛠️ Tech Stack

- **Framework:** Flutter (Dart)
- **UI Components:** Material Design
- **Charts:** `fl_chart` for dynamic graph rendering
- **Fonts:** Custom fonts (`TitleFont`, `Lexend`)
- **Icons:** Material Icons

## 📂 Project Structure

