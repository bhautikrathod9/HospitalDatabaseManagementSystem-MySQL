-- Procedure to get patient details with billing info
DELIMITER //
CREATE PROCEDURE GetPatientDetails(IN p_patient_id INT)
BEGIN
    SELECT 
        p.*,
        COUNT(a.appointment_id) as total_appointments,
        SUM(b.total_amount) as total_billed,
        SUM(b.paid_amount) as total_paid
    FROM patients p
    LEFT JOIN appointments a ON p.patient_id = a.patient_id
    LEFT JOIN billing b ON p.patient_id = b.patient_id
    WHERE p.patient_id = p_patient_id
    GROUP BY p.patient_id;
END//
DELIMITER ;