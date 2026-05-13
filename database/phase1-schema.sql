CREATE DATABASE IF NOT EXISTS gps_attendance_tracker
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE gps_attendance_tracker;

CREATE TABLE IF NOT EXISTS users (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  full_name VARCHAR(150) NOT NULL,
  email VARCHAR(190) NOT NULL,
  phone VARCHAR(30) NULL,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('admin', 'teacher') NOT NULL,
  status ENUM('active', 'inactive', 'suspended') NOT NULL DEFAULT 'active',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_users_email (email),
  KEY idx_users_role_status (role, status)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS centres (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NOT NULL,
  code VARCHAR(60) NOT NULL,
  address_line VARCHAR(255) NULL,
  latitude DECIMAL(10, 7) NOT NULL,
  longitude DECIMAL(10, 7) NOT NULL,
  allowed_radius_meters INT UNSIGNED NOT NULL DEFAULT 100,
  status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_centres_code (code),
  KEY idx_centres_status (status)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS students (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  centre_id BIGINT UNSIGNED NOT NULL,
  student_code VARCHAR(60) NOT NULL,
  full_name VARCHAR(150) NOT NULL,
  guardian_phone VARCHAR(30) NULL,
  status ENUM('active', 'inactive', 'graduated') NOT NULL DEFAULT 'active',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_students_student_code (student_code),
  KEY idx_students_centre_status (centre_id, status),
  CONSTRAINT fk_students_centre
    FOREIGN KEY (centre_id) REFERENCES centres(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS staff_centre_assignments (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  staff_user_id BIGINT UNSIGNED NOT NULL,
  centre_id BIGINT UNSIGNED NOT NULL,
  assigned_from DATE NOT NULL,
  assigned_until DATE NULL,
  status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_staff_centre_assignment (staff_user_id, centre_id, assigned_from),
  KEY idx_assignments_centre_status (centre_id, status),
  CONSTRAINT fk_assignments_staff_user
    FOREIGN KEY (staff_user_id) REFERENCES users(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_assignments_centre
    FOREIGN KEY (centre_id) REFERENCES centres(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS staff_attendance (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  staff_user_id BIGINT UNSIGNED NOT NULL,
  centre_id BIGINT UNSIGNED NOT NULL,
  attendance_date DATE NOT NULL,
  check_in_at DATETIME NULL,
  check_in_latitude DECIMAL(10, 7) NULL,
  check_in_longitude DECIMAL(10, 7) NULL,
  check_in_accuracy_meters DECIMAL(6, 2) NULL,
  check_out_at DATETIME NULL,
  check_out_latitude DECIMAL(10, 7) NULL,
  check_out_longitude DECIMAL(10, 7) NULL,
  check_out_accuracy_meters DECIMAL(6, 2) NULL,
  status ENUM('checked_in', 'checked_out', 'late', 'rejected') NOT NULL DEFAULT 'checked_in',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_staff_attendance_daily (staff_user_id, centre_id, attendance_date),
  KEY idx_staff_attendance_centre_date (centre_id, attendance_date),
  CONSTRAINT fk_staff_attendance_user
    FOREIGN KEY (staff_user_id) REFERENCES users(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_staff_attendance_centre
    FOREIGN KEY (centre_id) REFERENCES centres(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS student_attendance (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  student_id BIGINT UNSIGNED NOT NULL,
  centre_id BIGINT UNSIGNED NOT NULL,
  marked_by_user_id BIGINT UNSIGNED NOT NULL,
  attendance_date DATE NOT NULL,
  attendance_status ENUM('present', 'absent') NOT NULL,
  remarks VARCHAR(255) NULL,
  status ENUM('submitted', 'corrected', 'void') NOT NULL DEFAULT 'submitted',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_student_attendance_daily (student_id, attendance_date),
  KEY idx_student_attendance_centre_date (centre_id, attendance_date),
  KEY idx_student_attendance_marker (marked_by_user_id),
  CONSTRAINT fk_student_attendance_student
    FOREIGN KEY (student_id) REFERENCES students(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_student_attendance_centre
    FOREIGN KEY (centre_id) REFERENCES centres(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_student_attendance_marker
    FOREIGN KEY (marked_by_user_id) REFERENCES users(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

INSERT INTO users (
  id,
  full_name,
  email,
  phone,
  password_hash,
  role,
  status
) VALUES
  (
    1,
    'System Admin',
    'admin@example.com',
    '9999999999',
    'REPLACE_WITH_BCRYPT_HASH_FOR_ADMIN_PASSWORD',
    'admin',
    'active'
  ),
  (
    2,
    'Anita Teacher',
    'teacher@example.com',
    '8888888888',
    'REPLACE_WITH_BCRYPT_HASH_FOR_TEACHER_PASSWORD',
    'teacher',
    'active'
  )
ON DUPLICATE KEY UPDATE
  full_name = VALUES(full_name),
  phone = VALUES(phone),
  role = VALUES(role),
  status = VALUES(status);

INSERT INTO centres (
  id,
  name,
  code,
  address_line,
  latitude,
  longitude,
  allowed_radius_meters,
  status
) VALUES
  (
    1,
    'Central Teaching Centre',
    'CTC-001',
    'Demo Address, Bengaluru',
    12.9715990,
    77.5945660,
    120,
    'active'
  )
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  address_line = VALUES(address_line),
  latitude = VALUES(latitude),
  longitude = VALUES(longitude),
  allowed_radius_meters = VALUES(allowed_radius_meters),
  status = VALUES(status);

INSERT INTO staff_centre_assignments (
  id,
  staff_user_id,
  centre_id,
  assigned_from,
  assigned_until,
  status
) VALUES
  (
    1,
    2,
    1,
    '2026-05-13',
    NULL,
    'active'
  )
ON DUPLICATE KEY UPDATE
  assigned_until = VALUES(assigned_until),
  status = VALUES(status);

INSERT INTO students (
  id,
  centre_id,
  student_code,
  full_name,
  guardian_phone,
  status
) VALUES
  (1, 1, 'STU-001', 'Aarav Sharma', '9000000001', 'active'),
  (2, 1, 'STU-002', 'Diya Patel', '9000000002', 'active'),
  (3, 1, 'STU-003', 'Ishaan Verma', '9000000003', 'active'),
  (4, 1, 'STU-004', 'Meera Nair', '9000000004', 'active'),
  (5, 1, 'STU-005', 'Kabir Rao', '9000000005', 'active')
ON DUPLICATE KEY UPDATE
  centre_id = VALUES(centre_id),
  full_name = VALUES(full_name),
  guardian_phone = VALUES(guardian_phone),
  status = VALUES(status);
