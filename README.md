# Geo Attendance App

Geo Attendance App is a Flutter-based attendance tracking application for teacher-led training centres. The current build is a proposal-ready UI prototype for an Android app, with screens for login, GPS-style daily attendance, class-wise student attendance, reports, and teacher profile.

## Current Scope

- Teacher login screen
- Home dashboard with check-in and check-out states
- Monthly attendance summary cards
- Class selection for attendance marking
- Student attendance marking with Present and Absent actions
- Submitted attendance locked state
- Reports page with Daily, Weekly, Monthly, and Subject Wise analytics
- Teacher profile with employee details and designation
- Client proposal screenshots and PDF flow document

## Project Structure

```text
geo-attendance-app/
+-- mobile_app/          # Flutter app source
+-- proposal_assets/     # Client proposal screenshots, PDF, and ZIP
+-- README.md
```

## Proposal Assets

Client-ready files are available in:

```text
proposal_assets/
```

Important files:

- `geo_attendance_app_page_flow_latest.pdf` - PDF showing screen flow and screenshots
- `geo_attendance_client_proposal_assets.zip` - Shareable ZIP package
- `01_login.png` through `09_profile.png` - Individual screen screenshots

## App Screens

1. Login Screen
2. Home Dashboard
3. Home - After Check In
4. Home - After Check Out
5. Attendance Classes
6. Student Attendance
7. Submitted Attendance
8. Reports - Daily
9. Reports - Weekly
10. Reports - Monthly
11. Profile Screen

## Requirements

- Flutter SDK
- Dart SDK
- Chrome or a web-capable Flutter target for preview
- Android Studio or Android SDK for Android builds

## Setup

```bash
cd mobile_app
flutter pub get
```

## Run The App

For web preview:

```bash
flutter run -d web-server --web-port 7357
```

For Android:

```bash
flutter run
```

## Run Tests

```bash
cd mobile_app
flutter test
```

## Build Web Preview

```bash
cd mobile_app
flutter build web
```

The static web output is generated in:

```text
mobile_app/build/web/
```

## Notes

- The current application is UI-first and proposal-ready.
- Backend APIs, authentication, database integration, GPS validation, and production deployment are planned for the full MVP phase.
- The app currently uses static sample data for attendance, reports, and profile details.
