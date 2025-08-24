-- Test doctor user permissions
mysql -u doctor_user -p
USE hospital_management_system;
SELECT * FROM patients; -- Should work
SELECT * FROM billing;   -- Should fail

-- Update a patient record
UPDATE patients SET phone = '555-9999' WHERE patient_id = 1;

-- Check audit log
SELECT * FROM audit_log WHERE table_name = 'patients';