USE DBMSPROJECT;

-- View: Available Slots
CREATE OR REPLACE VIEW v_availableslots AS
SELECT Slot_id, SlotNumber, Floor
FROM parkingslots
WHERE Status = 'Available';

-- View: Daily Revenue
CREATE OR REPLACE VIEW v_dailyrevenue AS
SELECT CAST(PaymentDate AS DATE) AS RevenueDate,
       SUM(Amount) AS TotalRevenue
FROM payments
GROUP BY CAST(PaymentDate AS DATE);
