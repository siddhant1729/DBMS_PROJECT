# 🚗 Smart Parking Management System (DBMS Project)

## 📘 Overview
This project is a **Smart Parking Management System** implemented using **MySQL**.  
It manages users, vehicles, parking slots, bookings, payments, staff, and violations.  
It also includes **stored procedures**, **functions**, **triggers**, and **views** for automating operations like billing, slot assignment, payment updates, and fine generation.

---

## 🧩 Database Details
- **Database Name:** `dbmsproject`
- **Tables:**
  - `users`
  - `vehicles`
  - `parkingslots`
  - `bookings`
  - `payments`
  - `pricingrules`
  - `staff`
  - `violations`

---

## 🗂️ File Descriptions

| File Name | Description |
|------------|-------------|
| `createtables.sql` | Contains all table creation commands for the database schema. |
| `insertdata.sql` | Inserts sample data into all the tables. |
| `procedures&functions.sql` | Contains stored procedures and functions used for automating billing, checkout, and revenue calculation. |
| `triggers.sql` | Defines triggers that automatically handle overstay fines and update statuses after payments. |
| `views.sql` | Contains database views for available slots and daily revenue summaries. |

---

## 🧮 Functions
### 1. `fn_GetDailyRevenue`
Returns total revenue collected for a given date.

---

## 🖼️ Screenshots
Below are some example outputs:
- Slot assignment output  
- Billing calculation result  
- Daily revenue function call

*(Screenshots stored in `/screenshots` folder)*

---

## ⚙️ How to Run the Project

### Step 1: Open MySQL Command Line
Open your **MySQL Command Line Client** or **MySQL Workbench**.

### Step 2: Create and Use Database
```sql
CREATE DATABASE dbmsproject;
USE dbmsproject;

🪄 Views:
v_availableslots: Shows all currently available parking slots.

v_dailyrevenue: Shows total revenue generated each day.

👥 Team Members:

Yash Bishnoi
Siddhant Shaurya 

🧾 Tools Used:

MySQL Server / Command Line Client