# GPS Attendance Tracking System Requirements

## Project Goal

Build a GPS-based attendance platform with:

- A Flutter Android app for employees or students
- PHP REST APIs for authentication, attendance, location validation, and reporting
- A MySQL database for durable application data
- A PHP admin panel for management and oversight

## Core User Roles

### Teacher

- Sign in through the mobile API
- View assigned teaching centre
- Check in with GPS
- Check out with GPS
- View the assigned student list
- Mark student attendance using present or absent states
- Review the current day's attendance activity

### Administrator

- Sign in to the admin panel
- Create and manage teaching centres with latitude and longitude
- Create teacher accounts
- Assign teachers to teaching centres
- Review teacher attendance and student attendance
- Generate daily attendance reports

## Functional Requirements

### Mobile App

- Teacher authentication flow
- Login screen
- Home screen with current assignment and attendance status
- Check in / check out screen
- GPS permission handling
- Student attendance screen with tick/cross workflow
- Attendance history screen
- Error handling for denied permissions, disabled GPS, or rejected locations

### Backend API

- Teacher login endpoint
- Teacher attendance check-in endpoint
- Teacher attendance check-out endpoint
- Student list endpoint
- Student attendance marking endpoint
- Daily attendance reporting endpoint
- Server-side GPS validation against assigned centre coordinates
- Consistent JSON response format

### Admin Panel

- Admin login screen
- Teaching centre management
- Teacher management
- Teacher-to-centre assignment management
- Daily attendance report view

### Database

- Store users, centres, students, teacher-centre assignments, staff attendance, and student attendance
- Preserve created and updated timestamps where useful
- Support future expansion for shifts, report exports, and correction workflows

## Non-Functional Requirements

- Clear separation between mobile, API, admin, database, and documentation assets
- REST responses should be predictable and versionable
- Passwords must be stored as secure hashes
- Attendance writes should be validated server-side
- Timestamps should use a consistent timezone strategy
- Structure should remain easy to extend without premature overengineering

## Deferred For Later Phases

- Flutter project generation and package setup
- Actual PHP API implementation
- Authentication provider selection
- Database migration tooling
- Admin panel UI templates
- Push notifications
- Offline sync
- Anti-spoofing or device attestation
