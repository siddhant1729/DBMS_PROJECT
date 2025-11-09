USE DBMSPROJECT;

-- Trigger: Check Overstay after booking update
DELIMITER ;;
CREATE TRIGGER tr_CheckOverstay
AFTER UPDATE ON bookings
FOR EACH ROW
BEGIN
    DECLARE v_OverstayMinutes INT;
    DECLARE v_Fine DECIMAL(10, 2);
    IF NEW.ExitTime IS NOT NULL AND NEW.ExpectedExitTime IS NOT NULL AND NEW.ExitTime > NEW.ExpectedExitTime THEN
        SET v_OverstayMinutes = TIMESTAMPDIFF(MINUTE, NEW.ExpectedExitTime, NEW.ExitTime);
        SET v_Fine = v_OverstayMinutes * 5.00;
        INSERT INTO Violations(BookingId, ViolationType, Finefare, ViolationDate, Status)
        VALUES (NEW.BookingId, 'Overstay', v_Fine, CURDATE(), 'Pending');
    END IF;
END;;
DELIMITER ;

-- Trigger: Update booking and slot after payment
DELIMITER ;;
CREATE TRIGGER tr_AfterPaymentInsert
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    UPDATE Bookings
    SET Status = 'Paid'
    WHERE BookingId = NEW.Booking_id;
    
    UPDATE ParkingSlots
    SET Status = 'Available'
    WHERE Slot_id = (SELECT Slot_id FROM Bookings WHERE BookingId = NEW.Booking_id);
END;;
DELIMITER ;
