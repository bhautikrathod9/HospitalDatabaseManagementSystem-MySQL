-- Trigger for patients table updates
DELIMITER //
CREATE TRIGGER patients_audit_update
    AFTER UPDATE ON patients
    FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, operation_type, record_id, old_values, new_values, user_name)
    VALUES (
        'patients', 
        'UPDATE', 
        NEW.patient_id,
        JSON_OBJECT(
            'first_name', OLD.first_name,
            'last_name', OLD.last_name,
            'phone', OLD.phone,
            'email', OLD.email
        ),
        JSON_OBJECT(
            'first_name', NEW.first_name,
            'last_name', NEW.last_name,
            'phone', NEW.phone,
            'email', NEW.email
        ),
        USER()
    );
END//
DELIMITER ;

-- Trigger for patients table deletes
DELIMITER //
CREATE TRIGGER patients_audit_delete
    BEFORE DELETE ON patients
    FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, operation_type, record_id, old_values, user_name)
    VALUES (
        'patients', 
        'DELETE', 
        OLD.patient_id,
        JSON_OBJECT(
            'first_name', OLD.first_name,
            'last_name', OLD.last_name,
            'phone', OLD.phone,
            'email', OLD.email
        ),
        USER()
    );
END//
DELIMITER ;