# Hospital Database Management System 🏥

A comprehensive MySQL-based database management system for hospitals with user role management, security features, and audit logging capabilities.

## 🚀 Features

- **Patient Management**: Complete patient records with medical history
- **Doctor & Department Management**: Staff organization with specializations
- **Appointment Scheduling**: Efficient appointment booking system
- **Billing System**: Integrated billing and payment tracking
- **User Role Security**: Role-based access control (DBA, Doctor, Nurse, Receptionist)
- **Audit Logging**: Complete change tracking for sensitive medical data
- **Performance Optimized**: Strategic indexing for faster queries
- **Automated Backups**: Daily backup procedures

## 📊 Database Schema

### Core Tables
- **patients**: Patient demographics and medical information
- **doctors**: Healthcare provider details and specializations
- **departments**: Hospital department organization
- **appointments**: Appointment scheduling and tracking
- **billing**: Financial transactions and payment status
- **audit_log**: Change tracking for data integrity

## 🛠️ Installation

### Prerequisites
- MySQL Server 8.0+
- MySQL Workbench (optional)

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/bhautikrathod9/hospital-database-system.git
   cd hospital-database-system
   ```

2. **Create the database**
   ```sql
   CREATE DATABASE hospital_management_system;
   ```

3. **Run the schema script**
   ```bash
   mysql -u root -p hospital_management_system < database/schema.sql
   ```

4. **Insert sample data**
   ```bash
   mysql -u root -p hospital_management_system < database/sample_data.sql
   ```

5. **Set up triggers and views**
   ```bash
   mysql -u root -p hospital_management_system < database/triggers.sql
   mysql -u root -p hospital_management_system < database/views.sql
   ```

## 👥 User Roles & Permissions

| Role | Permissions |
|------|-------------|
| **DBA** | Full database access and administration |
| **Doctor** | Patient records, appointments (read/write), own schedule |
| **Nurse** | Patient records (read/write), appointments (read-only) |
| **Receptionist** | Appointments, billing, patient registration |

## 🔒 Security Features

- **Role-based Access Control**: Different permission levels for each user type
- **Audit Trail**: All modifications tracked with timestamps and user info
- **Data Validation**: Constraints and triggers ensure data integrity
- **Secure Authentication**: Encrypted passwords and user management

## 📈 Performance Features

- **Optimized Indexes**: Strategic indexing on frequently queried columns
- **Efficient Queries**: Pre-built views for common operations
- **Stored Procedures**: Reusable database operations
- **Query Monitoring**: Built-in performance tracking

## 💾 Backup & Recovery

### Automated Daily Backup
```bash
# Run the backup script
./scripts/backup.sh
```

### Manual Backup
```bash
# Create backup
mysqldump -u root -p hospital_management_system > backup.sql

# Restore backup
mysql -u root -p hospital_management_system < backup.sql
```

## 📋 Usage Examples

### Common Queries

**Find patient appointments**
```sql
SELECT * FROM patient_appointment_history 
WHERE patient_name LIKE '%Wilson%';
```

**View doctor schedule**
```sql
SELECT * FROM doctor_schedule 
WHERE appointment_date = '2024-03-15';
```

**Check billing status**
```sql
SELECT p.first_name, p.last_name, b.total_amount, b.payment_status 
FROM patients p 
JOIN billing b ON p.patient_id = b.patient_id 
WHERE b.payment_status = 'pending';
```

### Using Stored Procedures
```sql
-- Get complete patient details
CALL GetPatientDetails(1);
```

## 🔧 Database Maintenance

### Monitor Performance
```sql
-- Check table usage statistics
SELECT * FROM performance_schema.table_io_waits_summary_by_table 
WHERE SCHEMA_NAME = 'hospital_management_system';
```

### View Audit Logs
```sql
-- Check recent changes
SELECT * FROM audit_log 
WHERE timestamp >= DATE_SUB(NOW(), INTERVAL 24 HOUR)
ORDER BY timestamp DESC;
```

## 📁 Project Structure

```
hospital-database-system/
├── README.md
├── database/
│   ├── schema.sql           # Main database schema
│   ├── sample_data.sql      # Test data
│   ├── triggers.sql         # Audit triggers
│   ├── views.sql           # Pre-built views
│   └── stored_procedures.sql # Reusable procedures
├── scripts/
│   ├── backup.sh           # Automated backup
│   └── restore.sh          # Restore procedures
├── docs/
│   ├── database_design.md  # Detailed design documentation
│   ├── user_guide.md       # User manual
│   └── installation.md     # Setup instructions
└── tests/
    ├── test_data.sql       # Test scenarios
    └── performance_tests.sql # Performance benchmarks
```

## 🧪 Testing

### Test User Permissions
```bash
# Test doctor access
mysql -u doctor_user -p
```

### Verify Audit Logging
```sql
-- Make a change
UPDATE patients SET phone = '555-9999' WHERE patient_id = 1;

-- Check audit log
SELECT * FROM audit_log WHERE table_name = 'patients';
```

## 📊 Sample Data

The system includes sample data for:
- 5 departments (Cardiology, Neurology, Pediatrics, etc.)
- 3 doctors with different specializations
- 3 sample patients with complete records
- Multiple appointments and billing records

## 🚀 Future Enhancements

- [ ] Web-based admin interface
- [ ] REST API for mobile apps
- [ ] Advanced reporting dashboard
- [ ] Email notifications for appointments
- [ ] Integration with external payment gateways
- [ ] Patient portal for self-service
- [ ] Telemedicine appointment support

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

Your Name - bhautikrathod9@example.com

Project Link: [https://github.com/bhautikrathod9/hospital-database-system](https://github.com/bhautikrathod9/hospital-database-system)

---

⭐ Don't forget to star this project if you found it helpful!

## 🏆 Skills Demonstrated

- MySQL Database Design & Normalization
- User Role Management & Security
- Audit Logging & Data Integrity
- Performance Optimization & Indexing
- Backup & Recovery Procedures
- Stored Procedures & Triggers
- Query Optimization
- Database Administration