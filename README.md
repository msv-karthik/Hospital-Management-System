# Hospital-Management-System

## Overview

This project implements a **Hospital Management System** using SQL (MySQL). It is designed to manage key components of a hospital including patients, doctors, appointments, payments, rooms, departments, and more. The system also integrates triggers, stored procedures, and various types of queries to handle data efficiently.

### Key Features

- **Patient Management**: Stores and retrieves patient details including personal information, phone numbers, and payments.
- **Doctor Management**: Handles doctor information, including personal details, specialization, and contact information.
- **Appointment Management**: Tracks appointments between patients and doctors.
- **Payment Management**: Keeps records of payments made by patients and calculates total amounts with taxes.
- **Room Allocation**: Manages room types, charges, and availability.
- **Department Management**: Associates doctors with their respective departments.
- **Triggers and Procedures**: Implements automated triggers for updating payment amounts and stored procedures to calculate total payment.

## Database Schema

The following tables are created to manage the hospital operations:

- **appointment**: Stores appointment details.
- **patient**: Stores patient information including name, date of birth, gender, email, address, and state.
- **payment**: Stores patient payment details.
- **pat_ph**: Stores patient phone numbers.
- **room**: Stores room details including type and charges.
- **admit**: Stores information about patient admissions.
- **department**: Stores hospital departments.
- **doctor**: Stores doctor details including name, email, and address information.
- **doc_ph**: Stores doctor phone numbers.
- **doc_dep**: Maps doctors to departments.

## Setup Instructions

### Prerequisites

- **MySQL Server**: You should have MySQL Server installed on your local machine or server.
- **SQL Client**: Use any SQL client (e.g., MySQL Workbench, DBeaver) to connect to the database.

### Installation Steps

1. **Clone the repository** or copy the SQL script to your local machine.
   
   ```bash
   git clone https://github.com/yourusername/hospital-management-system.git

### Installation Steps

1. **Open your SQL client** and connect to the MySQL server.

2. **Run the SQL script** to create the required tables and insert sample data.

   ```sql
   -- Example: Run hospital_management.sql file
   source path/to/hospital_management.sql;
