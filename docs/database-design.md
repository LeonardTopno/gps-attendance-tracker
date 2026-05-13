# Phase 1 Database Design

The executable schema lives in:

```text
database/phase1-schema.sql
```

## Tables

### `users`

Stores both admin and teacher accounts.

| Column | Notes |
| --- | --- |
| `id` | Primary key |
| `full_name` | Admin or teacher display name |
| `email` | Unique login identifier |
| `phone` | Optional contact field |
| `password_hash` | Secure password hash |
| `role` | `admin` or `teacher` |
| `status` | `active`, `inactive`, or `suspended` |
| `created_at`, `updated_at` | Audit timestamps |

### `centres`

Stores teaching centres and their GPS validation settings.

| Column | Notes |
| --- | --- |
| `id` | Primary key |
| `name` | Centre name |
| `code` | Unique business identifier |
| `latitude`, `longitude` | Centre coordinates |
| `allowed_radius_meters` | GPS attendance radius |
| `status` | `active` or `inactive` |
| `created_at`, `updated_at` | Audit timestamps |

### `students`

Stores learners attached to a teaching centre.

| Column | Notes |
| --- | --- |
| `id` | Primary key |
| `centre_id` | Foreign key to `centres` |
| `student_code` | Unique student identifier |
| `full_name` | Student name |
| `guardian_phone` | Optional contact field |
| `status` | `active`, `inactive`, or `graduated` |
| `created_at`, `updated_at` | Audit timestamps |

### `staff_centre_assignments`

Maps teachers to centres.

| Column | Notes |
| --- | --- |
| `id` | Primary key |
| `staff_user_id` | Foreign key to teacher row in `users` |
| `centre_id` | Foreign key to `centres` |
| `assigned_from`, `assigned_until` | Assignment validity |
| `status` | `active` or `inactive` |
| `created_at`, `updated_at` | Audit timestamps |

### `staff_attendance`

Stores one daily attendance row per teacher and centre.

| Column | Notes |
| --- | --- |
| `id` | Primary key |
| `staff_user_id` | Foreign key to `users` |
| `centre_id` | Foreign key to `centres` |
| `attendance_date` | Attendance business date |
| `check_in_at`, `check_out_at` | Teacher attendance times |
| GPS fields | Captured latitude, longitude, and accuracy |
| `status` | `checked_in`, `checked_out`, `late`, or `rejected` |
| `created_at`, `updated_at` | Audit timestamps |

### `student_attendance`

Stores daily present or absent marks for students.

| Column | Notes |
| --- | --- |
| `id` | Primary key |
| `student_id` | Foreign key to `students` |
| `centre_id` | Foreign key to `centres` |
| `marked_by_user_id` | Foreign key to teacher in `users` |
| `attendance_date` | Attendance business date |
| `attendance_status` | `present` or `absent` |
| `remarks` | Optional teacher note |
| `status` | `submitted`, `corrected`, or `void` |
| `created_at`, `updated_at` | Audit timestamps |

## Relationship Summary

- One centre has many students.
- One teacher can be assigned to one or more centres over time.
- One centre can have many teacher assignments.
- One teacher can have one daily staff attendance row per centre.
- One student can have one daily attendance mark per date.

## Core Constraints

- `users.email` is unique.
- `centres.code` is unique.
- `students.student_code` is unique.
- Active teacher-centre pairs should be managed to avoid duplicate assignments.
- `staff_attendance` uses a unique key on teacher, centre, and attendance date.
- `student_attendance` uses a unique key on student and attendance date.

## Seed Data Included

The SQL file includes:

- One admin account
- One teacher account
- One centre
- One active teacher-centre assignment
- Five students

Password hash values are placeholders and should be replaced with actual hashes before login flows are implemented.
