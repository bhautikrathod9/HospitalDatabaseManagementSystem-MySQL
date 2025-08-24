-- View for patient appointment history
CREATE VIEW patient_appointment_history AS
SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) as patient_name,
    CONCAT(d.first_name, ' ', d.last_name) as doctor_name,
    d.specialization,
    a.appointment_date,
    a.appointment_time,
    a.status,
    a.reason_for_visit
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
ORDER BY a.appointment_date DESC;

-- View for doctor schedules
CREATE VIEW doctor_schedule AS
SELECT 
    CONCAT(d.first_name, ' ', d.last_name) as doctor_name,
    d.specialization,
    a.appointment_date,
    a.appointment_time,
    CONCAT(p.first_name, ' ', p.last_name) as patient_name,
    a.status
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
JOIN patients p ON a.patient_id = p.patient_id
WHERE a.appointment_date >= CURDATE()
ORDER BY a.appointment_date, a.appointment_time;