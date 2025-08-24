-- Insert departments
INSERT INTO departments (department_name) VALUES 
('Cardiology'),
('Neurology'),
('Pediatrics'),
('Orthopedics'),
('Emergency Medicine');

-- Insert doctors
INSERT INTO doctors (first_name, last_name, email, phone, specialization, department_id, license_number, hire_date) VALUES
('John', 'Smith', 'john.smith@hospital.com', '555-1234', 'Cardiologist', 1, 'MD123456', '2020-01-15'),
('Sarah', 'Johnson', 'sarah.johnson@hospital.com', '555-5678', 'Neurologist', 2, 'MD789012', '2019-03-20'),
('Mike', 'Brown', 'mike.brown@hospital.com', '555-9012', 'Pediatrician', 3, 'MD345678', '2021-06-10');

-- Insert sample patients
INSERT INTO patients (first_name, last_name, date_of_birth, gender, email, phone, blood_group) VALUES
('Alice', 'Wilson', '1985-05-15', 'F', 'alice.wilson@email.com', '555-2468', 'O+'),
('Bob', 'Davis', '1990-08-22', 'M', 'bob.davis@email.com', '555-1357', 'A+'),
('Carol', 'Miller', '1978-12-03', 'F', 'carol.miller@email.com', '555-9753', 'B-');

-- Insert sample appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit) VALUES
(1, 1, '2024-03-15', '10:00:00', 'Regular checkup'),
(2, 2, '2024-03-16', '14:30:00', 'Headache consultation'),
(3, 3, '2024-03-17', '09:15:00', 'Child vaccination');

-- Insert sample billing
INSERT INTO billing (patient_id, appointment_id, bill_date, total_amount, payment_status) VALUES
(1, 1, '2024-03-15', 150.00, 'paid'),
(2, 2, '2024-03-16', 200.00, 'pending'),
(3, 3, '2024-03-17', 75.00, 'paid');