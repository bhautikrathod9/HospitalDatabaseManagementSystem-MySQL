# 🏥 Hospital Database Management System

[![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue.svg)](https://mysql.com)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Database](https://img.shields.io/badge/Database-MySQL-orange.svg)](https://mysql.com)

A comprehensive **Hospital Database Management System** built with MySQL, featuring role-based access control, audit logging, and optimized performance for healthcare data management.

## ✨ Key Features

🔐 **Role-Based Security** - DBA, Doctor, Nurse, Receptionist access levels  
📊 **Complete Patient Management** - Demographics, medical history, appointments  
👨‍⚕️ **Doctor & Department Organization** - Staff management with specializations  
💰 **Integrated Billing System** - Payment tracking and financial management  
📝 **Comprehensive Audit Trail** - All changes tracked with timestamps  
🚀 **Performance Optimized** - Strategic indexing for fast queries  
💾 **Automated Backup System** - Daily backup with restore procedures  

## 🛠️ Quick Start

### Prerequisites
- MySQL Server 8.0+
- Basic SQL knowledge

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/hospital-database-system.git
   cd hospital-database-system
   ```

2. **Create database and run setup**
   ```sql
   CREATE DATABASE hospital_management_system;
   USE hospital_management_system;
   
   -- Run the schema file
   source database/schema.sql;
   
   -- Add sample data
   source database/sample_data.sql;
   ```

3. **Set up user roles**
   ```sql
   source database/user_roles.sql;
   ```

## 📋 Database Schema

<details>
<summary>View Database Structure</summary>

### Core Tables

| Table | Description | Key Features |
|-------|-------------|--------------|
| `patients` | Patient demographics & medical info | Medical history, emergency contacts |
| `doctors` | Healthcare provider details | Specializations, license numbers |
| `departments` | Hospital department organization | Head doctor assignments |
| `appointments` | Scheduling and tracking | Date/time validation, status tracking |
| `billing` | Financial transactions | Payment methods, status tracking |
| `audit_log` | Change tracking | User actions, timestamps, old/new values |

### Key Relationships
- Patients ↔ Appointments (One-to-Many)
- Doctors ↔ Appointments (One-to-Many)
- Departments ↔ Doctors (One-to-Many)
- Patients ↔ Billing (One-to-Many)

</details>

## 👥 User Roles & Access

| Role | Patient Data | Appointments | Billing | Admin |
|------|:------------:|:------------:|:-------:|:-----:|
| **DBA** | ✅ Full | ✅ Full | ✅ Full | ✅ Full |
| **Doctor** | ✅ Read/Write | ✅ Read/Write | ❌ No | ❌ No |
| **Nurse** | ✅ Read/Write | ✅ Read Only | ❌ No | ❌ No |
| **Receptionist** | ✅ Limited | ✅ Full | ✅ Read/Write | ❌ No |

## 🚀 Usage Examples

### Common Queries

**Find upcoming appointments**
```sql
SELECT * FROM doctor_schedule 
WHERE appointment_date >= CURDATE() 
ORDER BY appointment_date, appointment_time;
```

**Patient search with medical history**
```sql
SELECT patient_id, CONCAT(first_name, ' ', last_name) as name, 
       phone, blood_group, medical_history 
FROM patients 
WHERE last_name LIKE '%Smith%';
```

**Billing summary**
```sql
SELECT payment_status, COUNT(*) as count, SUM(total_amount) as total
FROM billing 
GROUP BY payment_status;
```

### Stored Procedures
```sql
-- Get complete patient information
CALL GetPatientDetails(1);

-- Generate department report
CALL DepartmentSummary('Cardiology');
```

## 🔒 Security Features

- **Encrypted User Authentication** - Secure password storage
- **Role-Based Access Control** - Granular permissions by user type
- **Audit Trail** - Complete change tracking with user identification
- **Data Validation** - Constraints and triggers ensure data integrity
- **SQL Injection Prevention** - Parameterized queries and validation

## 📊 Performance Optimization

### Strategic Indexing
```sql
-- Patient search optimization
CREATE INDEX idx_patient_name ON patients(last_name, first_name);
CREATE INDEX idx_patient_phone ON patients(phone);

-- Appointment queries
CREATE INDEX idx_appointment_date ON appointments(appointment_date);
CREATE INDEX idx_doctor_schedule ON appointments(doctor_id, appointment_date);
```

### Pre-built Views
- `patient_appointment_history` - Complete appointment history
- `doctor_schedule` - Upcoming appointments by doctor
- `billing_summary` - Financial overview by patient

## 💾 Backup & Recovery

### Automated Daily Backup
```bash
# Set up automated backup (runs daily at 2 AM)
crontab -e
0 2 * * * /path/to/hospital-database-system/scripts/backup.sh
```

### Manual Operations
```bash
# Create backup
./scripts/backup.sh
```

## 📁 Repository Structure

```
hospital-database-system/
├── 📄 README.md                    # You are here
├── 📁 database/
│   ├── schema.sql                  # Main database structure
│   ├── sample_data.sql             # Test data for development
│   ├── user_roles.sql              # Security setup
│   ├── triggers.sql                # Audit logging triggers
│   ├── views.sql                   # Pre-built views
│   └── stored_procedures.sql       # Reusable procedures
├── 📁 scripts/
│   ├── backup.sh                   # Automated backup script
│   └── performance_monitor.sql     # Performance tracking
├── 📁 docs/
│   └── database_design.md          # Database Design
└── 📁 tests/
    ├── test_data.sql               # Test scenarios
    └── security_tests.sql          # Permission testing
```

## 🧪 Testing

### Test User Permissions
```bash
# Test doctor access
mysql -u doctor_user -p hospital_management_system

# Try accessing billing (should fail for doctor)
SELECT * FROM billing;
```

### Verify Audit Logging
```sql
-- Make a change
UPDATE patients SET phone = '555-NEW-PHONE' WHERE patient_id = 1;

-- Check audit trail
SELECT * FROM audit_log 
WHERE table_name = 'patients' AND record_id = 1 
ORDER BY timestamp DESC LIMIT 5;
```

## 🏆 Skills Demonstrated

<table>
<tr>
<td>

**Database Design**
- Normalized schema design
- Foreign key relationships
- Data integrity constraints
- Performance optimization

</td>
<td>

**Security Implementation**
- Role-based access control
- User authentication
- Audit trail system
- Data protection policies

</td>
</tr>
<tr>
<td>

**Performance Tuning**
- Strategic indexing
- Query optimization
- Stored procedures
- Performance monitoring

</td>
<td>

**System Administration**
- Automated backups
- Database maintenance
- User management
- Recovery procedures

</td>
</tr>
</table>

## 📈 Sample Data Included

The system comes with sample data for immediate testing:

- **5 Medical Departments** (Cardiology, Neurology, Pediatrics, etc.)
- **3 Doctors** with different specializations and schedules
- **3 Patients** with complete medical records
- **Multiple Appointments** across different time periods
- **Billing Records** with various payment statuses

## 🔮 Future Roadmap

- [ ] 🌐 **Web Interface** - PHP/Python admin dashboard
- [ ] 📱 **Mobile API** - REST endpoints for mobile apps
- [ ] 📊 **Advanced Reporting** - Business intelligence features
- [ ] 📧 **Email Notifications** - Appointment reminders
- [ ] 💳 **Payment Integration** - External payment gateways
- [ ] 🔍 **Search Enhancement** - Full-text search capabilities
- [ ] 📅 **Calendar Integration** - Google Calendar sync

---

<div align="center">

**⭐ Star this repository if you found it helpful!**

Made with ❤️ for the healthcare community

[⬆ Back to top](#-hospital-database-management-system)

</div>
