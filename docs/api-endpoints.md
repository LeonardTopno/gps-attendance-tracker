# Planned API Endpoints

Base path proposal:

```text
/api/v1
```

## Response Shape

```json
{
  "success": true,
  "message": "Request completed.",
  "data": {}
}
```

## Authentication

| Method | Endpoint | Purpose |
| --- | --- | --- |
| POST | `/admin/auth/login` | Authenticate an admin for the PHP admin panel |
| POST | `/teacher/auth/login` | Authenticate a teacher and return an access token |
| GET | `/teacher/auth/me` | Return the authenticated teacher profile and current centre assignment |

## Admin: Centres and Teachers

| Method | Endpoint | Purpose |
| --- | --- | --- |
| POST | `/admin/centres` | Create a teaching centre with latitude and longitude |
| GET | `/admin/centres` | List centres |
| POST | `/admin/teachers` | Create a teacher account |
| GET | `/admin/teachers` | List teachers |
| POST | `/admin/staff-centre-assignments` | Assign a teacher to a centre |

## Teacher Attendance

| Method | Endpoint | Purpose |
| --- | --- | --- |
| POST | `/teacher/attendance/check-in` | GPS-based teacher check-in |
| POST | `/teacher/attendance/check-out` | GPS-based teacher check-out |
| GET | `/teacher/attendance/today` | Return today's attendance state |

## Student Attendance

| Method | Endpoint | Purpose |
| --- | --- | --- |
| GET | `/teacher/students` | List students for the teacher's assigned centre |
| POST | `/teacher/student-attendance` | Submit tick/cross attendance for one or more students |

## Reporting

| Method | Endpoint | Purpose |
| --- | --- | --- |
| GET | `/admin/reports/daily-attendance` | Return daily teacher and student attendance summary |

## Draft Payloads

### Teacher Check In

```json
{
  "latitude": 12.971599,
  "longitude": 77.594566,
  "accuracy_meters": 12,
  "captured_at": "2026-05-13T09:00:00+05:30"
}
```

### Teacher Check Out

```json
{
  "latitude": 12.971601,
  "longitude": 77.594571,
  "accuracy_meters": 10,
  "captured_at": "2026-05-13T18:00:00+05:30"
}
```

### Student Attendance Submission

```json
{
  "attendance_date": "2026-05-13",
  "students": [
    {
      "student_id": 1,
      "attendance_status": "present"
    },
    {
      "student_id": 2,
      "attendance_status": "absent"
    }
  ]
}
```

## Validation Notes

- Teacher attendance submissions should require authentication.
- The API should validate latitude and longitude ranges.
- The API should compare submitted GPS coordinates with the assigned centre radius.
- The API should reject duplicate or logically invalid teacher check-in/check-out actions.
- Student attendance writes should be limited to students in the teacher's assigned centre.
- Exact request and response contracts will be finalized during implementation.
