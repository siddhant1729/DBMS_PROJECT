-- Create Database
CREATE DATABASE IF NOT EXISTS DBMSPROJECT;
USE DBMSPROJECT;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS violations, payments, bookings, parkingslots, pricingrules, staff, users, vehicles;

-- USERS TABLE
CREATE TABLE users (
  UserId INT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(100) NOT NULL,
  Contact_no VARCHAR(50) NOT NULL,
  Email VARCHAR(50) NOT NULL,
  Address VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (UserId),
  UNIQUE KEY (Address)
);

-- VEHICLES TABLE
CREATE TABLE vehicles (
  vehcileid INT NOT NULL AUTO_INCREMENT,
  vehcileno VARCHAR(50) NOT NULL,
  Type ENUM('2-wheeler','4-wheeler','EV') NOT NULL,
  Ownerid INT DEFAULT NULL,
  PRIMARY KEY (vehcileid),
  UNIQUE KEY (vehcileno),
  FOREIGN KEY (Ownerid) REFERENCES users(UserId)
);

-- PARKING SLOTS TABLE
CREATE TABLE parkingslots (
  Slot_id INT NOT NULL AUTO_INCREMENT,
  SlotNumber VARCHAR(30) NOT NULL,
  Floor INT DEFAULT NULL,
  SlotType ENUM('Standard','EV','VIP','2-Wheeler') NOT NULL DEFAULT 'Standard',
  Status ENUM('Available','Occupied','Under Maintenance') NOT NULL DEFAULT 'Available',
  PRIMARY KEY (Slot_id)
);

-- BOOKINGS TABLE
CREATE TABLE bookings (
  BookingId INT NOT NULL AUTO_INCREMENT,
  vehcileid INT DEFAULT NULL,
  Slot_id INT DEFAULT NULL,
  EntryTime DATETIME NOT NULL,
  ExitTime DATETIME DEFAULT NULL,
  ExpectedExitTime DATETIME DEFAULT NULL,
  Amount DECIMAL(10,2) DEFAULT NULL,
  Status ENUM('Active','Completed','Paid') NOT NULL DEFAULT 'Active',
  PRIMARY KEY (BookingId),
  FOREIGN KEY (vehcileid) REFERENCES vehicles(vehcileid),
  FOREIGN KEY (Slot_id) REFERENCES parkingslots(Slot_id)
);

-- PAYMENTS TABLE
CREATE TABLE payments (
  Payment_id INT NOT NULL AUTO_INCREMENT,
  Booking_id INT DEFAULT NULL,
  Amount DECIMAL(10,2) NOT NULL,
  PaymentDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PaymentMode ENUM('Cash','Card','Online') NOT NULL,
  PRIMARY KEY (Payment_id),
  FOREIGN KEY (Booking_id) REFERENCES bookings(BookingId)
);

-- PRICING RULES TABLE
CREATE TABLE pricingrules (
  RuleID INT NOT NULL AUTO_INCREMENT,
  SlotType ENUM('Standard','EV','VIP','2-Wheeler') NOT NULL,
  StartHour INT NOT NULL,
  EndHour INT NOT NULL,
  Rate DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (RuleID)
);

-- STAFF TABLE
CREATE TABLE staff (
  StaffId INT NOT NULL AUTO_INCREMENT,
  Name VARCHAR(150) NOT NULL,
  Designation VARCHAR(50) DEFAULT NULL,
  Contact VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (StaffId),
  UNIQUE KEY (Contact)
);

-- VIOLATIONS TABLE
CREATE TABLE violations (
  ViolationID INT NOT NULL AUTO_INCREMENT,
  BookingId INT DEFAULT NULL,
  ViolationType VARCHAR(100) NOT NULL,
  Finefare DECIMAL(10,2) NOT NULL,
  ViolationDate DATE NOT NULL,
  Status ENUM('Pending','Paid') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (ViolationID),
  FOREIGN KEY (BookingId) REFERENCES bookings(BookingId)
);
