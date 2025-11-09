USE DBMSPROJECT;

-- Insert into USERS
INSERT INTO users VALUES
(1,'Yash Bishnoi','9876528190','yashbishnoi.yb@gmail.com','vikasnagar,dehradun'),
(2,'Siddhant Shaurya','9879538590','shauryabatman.sb@gmail.com','sector 129,gurugram'),
(3,'Bhumika Jain','8976531530','jainjain.jj@gmail.com','jain nagar,sanganer'),
(4,'Vijay Malya','9988776650','jalwamalya.jm@gmail.com','London'),
(5,'Neerav Modi','8899667750','modimodi.mm@gmail.com','Gujarat');

-- Insert into VEHICLES
INSERT INTO vehicles VALUES
(1,'UP16EU3536','4-wheeler',1),
(2,'UK07AF0007','4-wheeler',2),
(3,'UK07EU3287','2-wheeler',3),
(4,'DL05R2337','EV',4),
(5,'22BH6517A','2-wheeler',5);

-- Insert into PARKINGSLOTS
INSERT INTO parkingslots VALUES
(1,'A01',1,'Standard','Occupied'),
(2,'A02',1,'Standard','Occupied'),
(3,'A03',1,'Standard','Available'),
(4,'A04',1,'Standard','Available'),
(5,'B01',2,'2-Wheeler','Available'),
(6,'B02',2,'2-Wheeler','Available'),
(7,'B03',2,'2-Wheeler','Available'),
(8,'B04',2,'2-Wheeler','Available'),
(9,'F01',3,'Standard','Available'),
(10,'F03',3,'Standard','Available'),
(11,'F05',3,'Standard','Available'),
(12,'F06',3,'Standard','Available');

-- Insert into BOOKINGS
INSERT INTO bookings VALUES
(1,1,1,'2025-11-02 18:00:00','2025-11-05 14:01:36','2025-11-02 20:00:00',6461.90,'Completed'),
(2,2,4,'2025-11-01 10:00:00','2025-11-01 11:45:00','2025-11-01 12:00:00',120.00,'Paid'),
(3,3,2,'2025-11-01 14:00:00','2025-11-01 15:30:00','2025-11-01 15:00:00',150.00,'Completed'),
(4,3,1,'2025-11-04 12:53:06',NULL,'2025-11-04 20:00:00',NULL,'Active');

-- Insert into PAYMENTS
INSERT INTO payments VALUES
(1,2,70.00,'2025-11-01 11:46:00','Online'),
(2,NULL,120.00,'2025-11-02 09:38:06','Online');

-- Insert into PRICINGRULES
INSERT INTO pricingrules VALUES
(1,'2-Wheeler',0,23,80.00),
(2,'Standard',0,16,120.00),
(3,'Standard',17,20,95.00),
(4,'Standard',21,23,80.00),
(5,'EV',0,23,130.00),
(6,'VIP',0,23,200.00);

-- Insert into STAFF
INSERT INTO staff VALUES
(5,'Rakesh Uniyal','Manager','9675687991'),
(6,'Aaron Sharma','Attendant','9692187091'),
(7,'Amit Bhadana','Attendant','9894185090'),
(8,'Akshara Aggarwal','Attendant','9894185094');

-- Insert into VIOLATIONS
INSERT INTO violations VALUES
(1,1,'Overstay',19555.00,'2025-11-05','Pending'),
(2,1,'Overstay',19555.00,'2025-11-05','Pending'),
(3,1,'Overstay',19780.00,'2025-11-05','Pending'),
(4,1,'Overstay',19805.00,'2025-11-05','Pending'),
(5,1,'Overstay',19805.00,'2025-11-05','Pending');
