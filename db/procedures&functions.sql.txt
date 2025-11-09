DELIMITER //
CREATE PROCEDURE p_calculateBill(
    IN p_BookingID INT
)
BEGIN
    DECLARE v_Rate DECIMAL(10, 2);
    DECLARE v_Entry DATETIME;
    DECLARE v_Exit DATETIME;
    DECLARE v_EntryHour INT;
    DECLARE v_SlotType ENUM('Standard', 'EV', 'VIP', '2-Wheeler');
    DECLARE v_DurationHours DECIMAL(10, 2);
    DECLARE v_TotalAmount DECIMAL(10, 2);

    UPDATE Bookings SET ExitTime = CURRENT_TIMESTAMP WHERE BookingId = p_BookingID;

    SELECT b.EntryTime, b.ExitTime, ps.SlotType, HOUR(b.EntryTime)
    INTO v_Entry, v_Exit, v_SlotType, v_EntryHour
    FROM Bookings b
    JOIN ParkingSlots ps ON b.Slot_id = ps.Slot_id
    WHERE b.BookingId = p_BookingID;
    SELECT Rate INTO v_Rate
    FROM PricingRules
    WHERE SlotType = v_SlotType
      AND v_EntryHour >= StartHour
      AND v_EntryHour <= EndHour
    LIMIT 1;
    SET v_DurationHours = TIMESTAMPDIFF(MINUTE, v_Entry, v_Exit) / 60.0;
    SET v_TotalAmount = v_DurationHours * v_Rate;
    UPDATE Bookings
    SET Amount = v_TotalAmount, Status = 'Completed'
    WHERE BookingId = p_BookingID;
    SELECT v_TotalAmount AS TotalBill, v_Rate AS RateApplied;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE p_assignSlot(
    IN p_VehicleID INT,
    IN p_ExpectedExit DATETIME
)
BEGIN
    DECLARE v_SlotID INT;

    SELECT Slot_id INTO v_SlotID
    FROM ParkingSlots
    WHERE Status = 'Available'
    LIMIT 1;
    IF v_SlotID IS NOT NULL THEN
        UPDATE ParkingSlots
        SET Status = 'Occupied'
        WHERE Slot_id = v_SlotID;

        INSERT INTO Bookings(VehicleId, Slot_id, EntryTime, ExpectedExitTime, Status)
        VALUES (p_VehicleID, v_SlotID, CURRENT_TIMESTAMP, p_ExpectedExit, 'Active');

        SELECT 'Slot Assigned' AS Message, v_SlotID AS AssignedSlot;
    ELSE
        SELECT 'No available slots' AS Message;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE FUNCTION fn_GetDailyRevenue(
    p_Date DATE
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_TotalRevenue DECIMAL(10, 2);
    SELECT SUM(Amount)
    INTO v_TotalRevenue
    FROM Payments
    WHERE DATE(PaymentDate) = p_Date;

    RETURN IFNULL(v_TotalRevenue, 0.00);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE p_releaseSlot(
    IN p_BookingID INT
)
BEGIN
    DECLARE v_SlotID INT;
    DECLARE v_VehicleID INT;
    DECLARE v_ExitTime DATETIME;
    DECLARE v_Status VARCHAR(20);

    SELECT Slot_id, vehcileid, Status
    INTO v_SlotID, v_VehicleID, v_Status
    FROM Bookings
    WHERE BookingId = p_BookingID;

    IF v_Status = 'Active' THEN
        UPDATE Bookings
        SET ExitTime = CURRENT_TIMESTAMP,
            Status = 'Completed'
        WHERE BookingId = p_BookingID;
        UPDATE ParkingSlots
        SET Status = 'Available'
        WHERE Slot_id = v_SlotID;
        SELECT CONCAT('Slot ', v_SlotID, ' released for Vehicle ', v_VehicleID) AS Message;
    ELSE
        SELECT 'Booking already completed or paid' AS Message;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE p_checkout(
    IN p_BookingID INT
)
BEGIN
    DECLARE v_TotalBill DECIMAL(10,2);
    DECLARE v_Rate DECIMAL(10,2);
    DECLARE v_SlotID INT;

    CALL p_calculateBill(p_BookingID);

    SELECT Amount, Slot_id
    INTO v_TotalBill, v_SlotID
    FROM Bookings
    WHERE BookingId = p_BookingID;
    UPDATE Bookings
    SET Status = 'Completed'
    WHERE BookingId = p_BookingID
      AND Status = 'Active';
    UPDATE ParkingSlots
    SET Status = 'Available'
    WHERE Slot_id = v_SlotID;
    SELECT 
        CONCAT('Booking ', p_BookingID, ' checkout successful') AS Message,
        v_TotalBill AS TotalAmount,
        v_Rate AS RatePerHour,
        v_SlotID AS SlotReleased;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE p_checkoutPayment(
    IN p_BookingID INT,
    IN p_PaymentMode ENUM('Cash','Card','Online')
)
BEGIN
    DECLARE v_TotalBill DECIMAL(10,2);
    DECLARE v_Rate DECIMAL(10,2);
    DECLARE v_SlotID INT;
    CALL p_calculateBill(p_BookingID);
    SELECT Amount, Slot_id
    INTO v_TotalBill, v_SlotID
    FROM Bookings
    WHERE BookingId = p_BookingID;
    UPDATE Bookings
    SET Status = 'Paid'
    WHERE BookingId = p_BookingID;
    UPDATE ParkingSlots
    SET Status = 'Available'
    WHERE Slot_id = v_SlotID;
    INSERT INTO Payments (BookingID, Amount, PaymentMode, Status)
    VALUES (p_BookingID, v_TotalBill, p_PaymentMode, 'Paid');
    SELECT 
        CONCAT('Booking ', p_BookingID, ' checked out successfully!') AS Message,
        v_TotalBill AS TotalAmount,
        p_PaymentMode AS Mode,
        v_SlotID AS SlotReleased,
        NOW() AS PaymentTime;
END //
DELIMITER ;


