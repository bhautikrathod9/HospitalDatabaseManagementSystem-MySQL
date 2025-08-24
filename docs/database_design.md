# Hospital Management System - Database Design

## Overview
A comprehensive database system for managing hospital operations including patient records, appointments, billing, and staff management.

## Core Tables

### 1. Departments
- **Purpose**: Organize hospital departments and their leadership
- **Key Fields**: department_id, department_name, head_doctor_id
- **Relations**: Links to doctors table for department head

### 2. Doctors
- **Purpose**: Store doctor information and credentials
- **Key Fields**: doctor_id, name, email, specialization, license_number, department_id
- **Relations**: Belongs to departments, referenced by appointments
- **Features**: Status tracking (active/inactive), unique license numbers

### 3. Patients
- **Purpose**: Comprehensive patient records and demographics
- **Key Fields**: patient_id, name, date_of_birth, gender, contact info, blood_group
- **Features**: Emergency contacts, medical history, address management

### 4. Appointments
- **Purpose**: Schedule and track patient-doctor appointments
- **Key Fields**: appointment_id, patient_id, doctor_id, date, time, status
- **Relations**: Links patients and doctors
- **Constraints**: Unique appointments per doctor/date/time
- **Status Options**: scheduled, completed, cancelled, no_show

### 5. Billing
- **Purpose**: Financial transactions and payment tracking
- **Key Fields**: bill_id, patient_id, appointment_id, amounts, payment_status
- **Features**: Partial payment support, multiple payment methods
- **Payment Methods**: cash, card, insurance, online

### 6. Audit Log
- **Purpose**: Track all database changes for compliance
- **Key Fields**: log_id, table_name, operation_type, old/new values
- **Features**: JSON storage for data changes, user tracking

## Security & Access Control

### User Roles
- **DBA**: Full system access
- **Doctor**: Patient records, appointments (read/write)
- **Nurse**: Patient records (read/write), appointments (read-only)
- **Receptionist**: Appointments, billing, patient registration

### Security Features
- Role-based access control (RBAC)
- Encrypted user passwords
- Audit trail for all operations
- Restricted access by user type

## Performance Optimizations

### Indexes
- Patient name and phone lookups
- Doctor specialization searches
- Appointment date queries
- Billing date ranges
- Patient date of birth

## Key Constraints
- Unique doctor licenses
- Unique appointment slots per doctor
- Foreign key relationships maintain data integrity
- Enum fields for standardized values (gender, blood groups, status)

## Data Integrity Features
- Automatic timestamps (created_at, updated_at)
- Foreign key constraints
- Unique constraints on critical fields
- Default values for status fields
- JSON audit logging for change tracking