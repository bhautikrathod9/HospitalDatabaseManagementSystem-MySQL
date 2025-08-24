-- Create the main database
CREATE DATABASE hospital_management_system;
USE hospital_management_system;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    head_doctor_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    specialization VARCHAR(100),
    department_id INT,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    hire_date DATE,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('M', 'F', 'Other') NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    address TEXT,
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(15),
    blood_group ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'),
    medical_history TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('scheduled', 'completed', 'cancelled', 'no_show') DEFAULT 'scheduled',
    reason_for_visit TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    UNIQUE KEY unique_appointment (doctor_id, appointment_date, appointment_time)
);

CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    appointment_id INT,
    bill_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    paid_amount DECIMAL(10,2) DEFAULT 0.00,
    payment_status ENUM('pending', 'partial', 'paid') DEFAULT 'pending',
    payment_method ENUM('cash', 'card', 'insurance', 'online') NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    operation_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    record_id INT NOT NULL,
    old_values JSON,
    new_values JSON,
    user_name VARCHAR(50),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add foreign key for department head doctor
ALTER TABLE departments 
ADD CONSTRAINT fk_head_doctor 
FOREIGN KEY (head_doctor_id) REFERENCES doctors(doctor_id);

-- Indexes for faster searches
CREATE INDEX idx_patient_name ON patients(last_name, first_name);
CREATE INDEX idx_patient_phone ON patients(phone);
CREATE INDEX idx_doctor_specialization ON doctors(specialization);
CREATE INDEX idx_appointment_date ON appointments(appointment_date);
CREATE INDEX idx_billing_date ON billing(bill_date);
CREATE INDEX idx_patient_dob ON patients(date_of_birth);


-- Create users for different roles
CREATE USER 'dba_user'@'localhost' IDENTIFIED BY 'SecurePass123!';
CREATE USER 'doctor_user'@'localhost' IDENTIFIED BY 'DocPass123!';
CREATE USER 'nurse_user'@'localhost' IDENTIFIED BY 'NursePass123!';
CREATE USER 'receptionist_user'@'localhost' IDENTIFIED BY 'RecepPass123!';

-- DBA - Full access
GRANT ALL PRIVILEGES ON hospital_management_system.* TO 'dba_user'@'localhost';

-- Doctor - Can view and update patient records, appointments
GRANT SELECT, INSERT, UPDATE ON hospital_management_system.patients TO 'doctor_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON hospital_management_system.appointments TO 'doctor_user'@'localhost';
GRANT SELECT ON hospital_management_system.doctors TO 'doctor_user'@'localhost';
GRANT SELECT ON hospital_management_system.departments TO 'doctor_user'@'localhost';

-- Nurse - Can view and update patient records, limited appointment access
GRANT SELECT, INSERT, UPDATE ON hospital_management_system.patients TO 'nurse_user'@'localhost';
GRANT SELECT ON hospital_management_system.appointments TO 'nurse_user'@'localhost';
GRANT SELECT ON hospital_management_system.doctors TO 'nurse_user'@'localhost';

-- Receptionist - Appointment and billing management
GRANT SELECT, INSERT, UPDATE, DELETE ON hospital_management_system.appointments TO 'receptionist_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON hospital_management_system.patients TO 'receptionist_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON hospital_management_system.billing TO 'receptionist_user'@'localhost';
GRANT SELECT ON hospital_management_system.doctors TO 'receptionist_user'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;