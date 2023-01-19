-- kill other connections --
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'healthtrace' AND pid <> pg_backend_pid();
-- (re)create the database --
DROP DATABASE IF EXISTS healthtrace;
CREATE DATABASE healthtrace;
-- connect via psql -- 
\c healthtrace

-- database configuration --
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;

--- CREATE tables ---

CREATE TABLE patients (
    id SERIAL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    date_of_birth DATE,
    sex_at_birth CHAR (1),
    phone VARCHAR (15),
    email TEXT,
    home_address TEXT,
    occupation TEXT,
    preferred_pharmacy TEXT,
    blood_type VARCHAR (3),
    PRIMARY KEY (id)
);

CREATE TABLE practitioners (
    id SERIAL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    speciality TEXT NOT NULL,
    registration_number VARCHAR (15),
    phone VARCHAR (15),
    email TEXT,
    PRIMARY KEY (id)
);

CREATE TABLE clinics (
    id SERIAL,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    phone VARCHAR (15),
    email TEXT,
    PRIMARY KEY (id)
);

CREATE TABLE encounters (
    id SERIAL,
    patient_id INT ,
    practitioner_id INT,
    date DATE NOT NULL,
    time TIMETZ NOT NULL,
    type_of_visit VARCHAR (15) NOT NULL,
    encounter_title TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE appointments (
    id SERIAL,
    patient_id INT ,
    practitioner_id INT,
    clinic_id INT,
    date DATE NOT NULL,
    time TIMETZ NOT NULL,
    status VARCHAR (15) NOT NULL,
    phone VARCHAR (15),
    email TEXT,
    service_id INT,
    PRIMARY KEY (id)
);

CREATE TABLE prescriptions (
    id SERIAL,
    patient_id INT ,
    practitioner_id INT,
    date DATE NOT NULL,
    drug_code VARCHAR (15),
    drug_name VARCHAR (50),
    notes TEXT,
    service_id INT,
    PRIMARY KEY (id)
);

CREATE TABLE laboratory_orders (
    id SERIAL,
    patient_id INT ,
    practitioner_id INT,
    clinic_id VARCHAR (10) NOT NULL,
    request_date timestamp NOT NULL,
    due_date timestamp NOT NULL,
    has_result BOOLEAN NOT NULL,
    service_id INT,
    PRIMARY KEY (id)
);

CREATE TABLE services (
  id INT,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  cost DECIMAL(10,2) NOT NULL,
  service_type VARCHAR(255) NOT NULL,
  provider VARCHAR(255) NOT NULL,
  insurance_covered BOOLEAN NOT NULL,
  prerequisites TEXT,
  appointment_length INTEGER NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE billings (
    id SERIAL,
    patient_id INT,
    service_id INT,
    cost NUMERIC (10,2) NOT NULL,
    paid BOOLEAN NOT NULL DEFAULT false,
    transaction_id uuid
);

CREATE TABLE users (
    id SERIAL,
    username VARCHAR (50) NOT NULL,
    password VARCHAR (60) NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone VARCHAR (15),
    role VARCHAR (20) NOT NULL
);
--- ALTER tables ---
ALTER SEQUENCE patients_id_seq RESTART WITH 1000;
ALTER SEQUENCE practitioners_id_seq RESTART WITH 1000;
-- ALTER SEQUENCE services_id_seq RESTART WITH 1000;
--- Add foreign key constraints --

-- ENCOUNTERS
ALTER TABLE encounters
ADD CONSTRAINT fk_patients_encounters 
FOREIGN KEY (patient_id) 
REFERENCES patients (id);

ALTER TABLE encounters
ADD CONSTRAINT fk_practitioners_encounters 
FOREIGN KEY (practitioner_id) 
REFERENCES practitioners (id);

-- APPOINTMENTS
ALTER TABLE appointments
ADD CONSTRAINT fk_patients_appointments
FOREIGN KEY (patient_id) 
REFERENCES patients (id);

ALTER TABLE appointments
ADD CONSTRAINT fk_practitioners_appointments
FOREIGN KEY (practitioner_id) 
REFERENCES practitioners (id);

ALTER TABLE appointments
ADD CONSTRAINT fk_clinics_appointments
FOREIGN KEY (clinic_id) 
REFERENCES clinics (id);

ALTER TABLE appointments
ADD CONSTRAINT fk_services_appointments
FOREIGN KEY (service_id) 
REFERENCES services (id);

-- PRESCRIPTIONS
ALTER TABLE prescriptions
ADD CONSTRAINT fk_patients_prescriptions
FOREIGN KEY (patient_id) 
REFERENCES patients (id);

ALTER TABLE prescriptions
ADD CONSTRAINT fk_practitioners_prescriptions
FOREIGN KEY (practitioner_id) 
REFERENCES practitioners (id);

ALTER TABLE prescriptions
ADD CONSTRAINT fk_services_prescriptions
FOREIGN KEY (service_id) 
REFERENCES services (id);

-- LABORATORY ORDERS
ALTER TABLE laboratory_orders
ADD CONSTRAINT fk_patients_laboratory_orders
FOREIGN KEY (patient_id) 
REFERENCES patients (id);

ALTER TABLE laboratory_orders
ADD CONSTRAINT fk_practitioners_laboratory_orders
FOREIGN KEY (practitioner_id) 
REFERENCES practitioners (id);

ALTER TABLE laboratory_orders
ADD CONSTRAINT fk_services_laboratory_orders
FOREIGN KEY (service_id) 
REFERENCES services (id);

-- BILLING
ALTER TABLE billings
ADD CONSTRAINT fk_patients_billings
FOREIGN KEY (patient_id) 
REFERENCES patients (id);
  
ALTER TABLE billings
ADD CONSTRAINT fk_services_billings
FOREIGN KEY (service_id) 
REFERENCES services (id);

INSERT INTO patients (first_name, last_name, date_of_birth, sex_at_birth, phone, email, home_address, occupation, preferred_pharmacy, blood_type)
VALUES 
('Paulo', 'Martins', '1987-08-31', 'M','+15146597924','thepv@hotmail.com', '123 Rue Amour Montreal Quebec Canada', 'Information technology specialist', 'some parmacy address very big in canada','OP'),
('John', 'Doe', '1980-01-01', 'M', '123-456-7890', 'john.doe@gmail.com', '123 Main St, Anytown USA 12345', 'Software Engineer', 'Walmart Pharmacy', 'O+'),
('Jane', 'Doe', '1985-03-20', 'F', '098-765-4321', 'jane.doe@gmail.com', '456 Market St, Anytown USA 12345', 'Doctor', 'CVS Pharmacy', 'A-'),
('Bob', 'Smith', '1990-09-15', 'M', '111-111-1111', 'bob.smith@gmail.com', '789 Market St, Anytown USA 12345', 'Teacher', 'Walgreens', 'AB+'),
('Alice', 'Johnson', '1995-07-02', 'F', '222-222-2222', 'alice.johnson@gmail.com', '321 Market St, Anytown USA 12345', 'Nurse', 'Rite Aid', 'B+'),
('Mike', 'Williams', '1970-05-30', 'M', '333-333-3333', 'mike.williams@gmail.com', '159 Market St, Anytown USA 12345', 'Accountant', 'Walmart Pharmacy', 'O-'),
('Jessica', 'Jones', '1975-12-01', 'F', '444-444-4444', 'jessica.jones@gmail.com', '753 Market St, Anytown USA 12345', 'Lawyer', 'CVS Pharmacy', 'A+'),
('Charlie', 'Brown', '1980-04-15', 'M', '555-555-5555', 'charlie.brown@gmail.com', '951 Market St, Anytown USA 12345', 'Artist', 'Walgreens', 'AB-'),
('Samantha', 'Smith', '1985-08-25', 'F', '666-666-6666', 'samantha.smith@gmail.com', '147 Market St, Anytown USA 12345', 'Manager', 'Rite Aid', 'B-'),
('Ashley', 'Johnson', '1988-06-20', 'F', '777-777-7777', 'ashley.johnson@gmail.com', '369 Market St, Anytown USA 12345', 'Marketing Manager', 'Walmart Pharmacy', 'O+'),
('David', 'Moore', '1983-11-05', 'M', '888-888-8888', 'david.moore@gmail.com', '159 Market St, Anytown USA 12345', 'Sales Representative', 'CVS Pharmacy', 'A-'),
('Emily', 'Smith', '1991-02-10', 'F', '999-999-9999', 'emily.smith@gmail.com', '753 Market St, Anytown USA 12345', 'Graphic Designer', 'Walgreens', 'AB+'),
('James', 'Williams', '1995-03-15', 'M', '000-000-0000', 'james.williams@gmail.com', '951 Market St, Anytown USA 12345', 'Web Developer', 'Rite Aid', 'B+'),
('Maria', 'Gonzalez', '1987-04-10', 'F', '246-135-7987', 'maria.gonzalez@gmail.com', 'Calle Falsa 123, Ciudad de Mexico 05020', 'Teacher', 'Walmart Pharmacy', 'A+'),
('Juan', 'Perez', '1992-08-15', 'M', '246-135-7987', 'juan.perez@gmail.com', 'Calle Falsa 123, Ciudad de Mexico 05020', 'Engineer', 'CVS Pharmacy', 'B+'),
('Ahmed', 'Ali', '1985-01-01', 'M', '135-246-7987', 'ahmed.ali@gmail.com', '123 Main St, Cairo Egypt 12345', 'Doctor', 'Walgreens', 'O+'),
('Fatima', 'Mohammed', '1990-06-20', 'F', '246-246-7987', 'fatima.mohammed@gmail.com', '456 Market St, Cairo Egypt 12345', 'Nurse', 'Rite Aid', 'A-'),
('Taro', 'Yamamoto', '1995-02-10', 'M', '135-135-7987', 'taro.yamamoto@gmail.com', '789 Market St, Tokyo Japan 12345', 'Software Engineer', 'Walmart Pharmacy', 'AB+'),
('Akiko', 'Tanaka', '1980-12-01', 'F', '246-246-7987', 'akiko.tanaka@gmail.com', '321 Market St, Tokyo Japan 12345', 'Lawyer', 'CVS Pharmacy', 'B-'),
('Li', 'Wang', '1988-09-15', 'M', '135-135-7987', 'li.wang@gmail.com', '159 Market St, Beijing China 12345', 'Accountant', 'Walgreens', 'O-'),
('Mei', 'Lin', '1983-03-20', 'F', '246-135-7987', 'mei.lin@gmail.com', '753 Market St, Beijing China 12345', 'Marketing Manager', 'Rite Aid', 'A+');



INSERT INTO practitioners (first_name, last_name, speciality, registration_number, phone, email)
VALUES
('John', 'Doe', 'Pediatrics', '12345678', '555-555-1212', 'john.doe@gmail.com'),
('Jane', 'Doe', 'Surgery', '87654321', '555-555-1213', 'jane.doe@gmail.com'),
('Bob', 'Smith', 'Orthopedics', '11111111', '555-555-1214', 'bob.smith@gmail.com'),
('Alice', 'Smith', 'Dermatology', '22222222', '555-555-1215', 'alice.smith@gmail.com'),
('Michael', 'Johnson', 'Internal Medicine', '23456789', '555-555-1216', 'michael.johnson@gmail.com'),
('Sarah', 'Williams', 'Family Medicine', '98765432', '555-555-1217', 'sarah.williams@gmail.com'),
('David', 'Jones', 'OB/GYN', '44444444', '555-555-1218', 'david.jones@gmail.com'),
('Emma', 'Brown', 'Psychiatry', '55555555', '555-555-1219', 'emma.brown@gmail.com'),
('Christopher', 'Davis', 'Cardiology', '66666666', '555-555-1220', 'christopher.davis@gmail.com'),
('Elizabeth', 'Garcia', 'Oncology', '77777777', '555-555-1221', 'elizabeth.garcia@gmail.com'),
('James', 'Martin', 'Neurology', '88888888', '555-555-1222', 'james.martin@gmail.com'),
('Samantha', 'Wilson', 'Dentistry', '99999999', '555-555-1223', 'samantha.wilson@gmail.com'),
('William', 'Thomas', 'Ophthalmology', '00000000', '555-555-1224', 'william.thomas@gmail.com'),
('Ashley', 'Jackson', 'Physical Therapy', '12121212', '555-555-1225', 'ashley.jackson@gmail.com'),
('Jessica', 'Moore', 'Endocrinology', '24681012', '555-555-1226', 'jessica.moore@gmail.com'),
('Matthew', 'Taylor', 'Gastroenterology', '13579246', '555-555-1227', 'matthew.taylor@gmail.com'),
('Stephanie', 'Anderson', 'Rheumatology', '36925814', '555-555-1228', 'stephanie.anderson@gmail.com'),
('Christopher', 'Moore', 'Anesthesiology', '25814736', '555-555-1229', 'christopher.moore@gmail.com'),
('Lauren', 'Taylor', 'Allergy and Immunology', '48172935', '555-555-1230', 'lauren.taylor@gmail.com'),
('Megan', 'Anderson', 'Urology', '96385274', '555-555-1231', 'megan.anderson@gmail.com'),
('Christopher', 'Williams', 'Pulmonology', '74125896', '555-555-1232', 'christopher.williams@gmail.com'),
('Amanda', 'Brown', 'Emergency Medicine', '14725836', '555-555-1233', 'amanda.brown@gmail.com'),
('Sara', 'Davis', 'Geriatric Medicine', '78945612', '555-555-1234', 'sara.davis@gmail.com'),
('Alex', 'Garcia', 'Physical Medicine and Rehabilitation', '95174283', '555-555-1235', 'alex.garcia@gmail.com'),
('Takashi', 'Yamamoto', 'Surgery', '11111111', '555-555-1236', 'takashi.yamamoto@gmail.com'),
('Keiko', 'Saito', 'Internal Medicine', '22222222', '555-555-1237', 'keiko.saito@gmail.com'),
('Jin', 'Kim', 'Pediatrics', '33333333', '555-555-1238', 'jin.kim@gmail.com'),
('Sun-Mi', 'Lee', 'Orthopedics', '44444444', '555-555-1239', 'sun-mi.lee@gmail.com'),
('Mohammed', 'Ahmed', 'Cardiology', '55555555', '555-555-1240', 'mohammed.ahmed@gmail.com'),
('Fatima', 'Ali', 'OB/GYN', '66666666', '555-555-1241', 'fatima.ali@gmail.com'),
('Sara', 'Mohammed', 'Psychiatry', '77777777', '555-555-1242', 'sara.mohammed@gmail.com'),
('Ahmed', 'Sami', 'Dermatology', '88888888', '555-555-1243', 'ahmed.sami@gmail.com'),
('Fadumo', 'Hassan', 'Oncology', '99999999', '555-555-1244', 'fadumo.hassan@gmail.com'),
('Ali', 'Faris', 'Neurology', '00000000', '555-555-1245', 'ali.faris@gmail.com'),
('Juan', 'Perez', 'Surgery', '11111111', '555-555-1246', 'juan.perez@gmail.com'),
('Sonia', 'Gonzalez', 'Internal Medicine', '22222222', '555-555-1247', 'sonia.gonzalez@gmail.com'),
('Mario', 'Rodriguez', 'Pediatrics', '33333333', '555-555-1248', 'mario.rodriguez@gmail.com'),
('Ana', 'Garcia', 'Orthopedics', '44444444', '555-555-1249', 'ana.garcia@gmail.com'),
('Emmanuel', 'Kamara', 'Cardiology', '55555555', '555-555-1250', 'emmanuel.kamara@gmail.com'),
('Fatou', 'Diallo', 'OB/GYN', '66666666', '555-555-1251', 'fatou.diallo@gmail.com'),
('Javier', 'Martinez', 'Psychiatry', '77777777', '555-555-1252', 'javier.martinez@gmail.com'),
('Ngozi', 'Okonkwo', 'Dermatology', '88888888', '555-555-1253', 'ngozi.okonkwo@gmail.com'),
('Ousmane', 'Ba', 'Oncology', '99999999', '555-555-1254', 'ousmane.ba@gmail.com'),
('Isabel', 'Rodriguez', 'Neurology', '00000000', '555-555-1255', 'isabel.rodriguez@gmail.com');

INSERT INTO clinics (name, address, phone, email)
VALUES
('Family Medical Clinic', '123 Main Street, Anytown USA', '555-555-1212', 'info@familymedicalclinic.com'),
('Downtown Pediatrics', '456 Maple Avenue, Anytown USA', '555-555-1213', 'info@downtownpediatrics.com'),
('Central Surgery Group', '789 Oak Boulevard, Anytown USA', '555-555-1214', 'info@centralsurgerygroup.com'),
('Northside Internal Medicine', '321 Birch Road, Anytown USA', '555-555-1215', 'info@northsideinternalmedicine.com');

INSERT INTO services (id, name, description, cost, service_type, provider, insurance_covered, prerequisites, appointment_length)
VALUES 
(1, 'Appointment','apt description', 50.00,'appointment', 'provider', false, 'none', 60),
(2, 'Prescription','drug prescription', 0.00,'document', 'provider', false, 'none', 0),
(3, 'Laboratory order', 'a lab order', 50.00, 'other', 'provider', true, 'none', 0),
(4, 'Flu shot', 'A vaccination against the flu virus', 50.00, 'Procedure', 'Nurse Johnson', true, 'None', 15),
(5, 'Consultation with specialist', 'A meeting with a specialist to discuss a medical issue', 200.00, 'Consultation', 'Dr. Patel', false, 'Referral from primary care physician', 45),
(6, 'CT scan', 'A diagnostic imaging test using X-rays and a computer', 1000.00, 'Procedure', 'Radiologist', false, 'None', 120),
(7, 'Therapy session', 'A session with a mental health therapist', 150.00, 'Consultation', 'Therapist', true, 'None', 60),
(8, 'Annual physical', 'A comprehensive physical examination', 200.00, 'Exam', 'Dr. Smith', true, 'None', 60),
(9, 'Sick visit', 'A visit for a specific illness or injury', 150.00, 'Visit', 'Dr. Johnson', true, 'None', 30),
(10, 'Allergy testing', 'Skin prick testing to determine allergies', 300.00, 'Test', 'Dr. Williams', true, 'None', 60),
(11, 'Immunizations', 'Administration of immunizations or vaccines', 50.00, 'Other', 'Nurse practitioner', true, 'None', 15),
(12, 'Weight loss consultation', 'Consultation with a weight loss specialist', 100.00, 'Consultation', 'Dr. Patel', false, 'None', 45),
(13, 'Annual physical', 'A yearly check-up and evaluation', 100.00, 'Exam', 'Dr. Smith', true, 'None', 60);

INSERT INTO laboratory_orders (patient_id,practitioner_id,clinic_id, request_date, due_date, has_result, service_id)
VALUES
(1006,1002,'1234567890', '2022-01-01 10:00:00', '2022-01-02 10:00:00', false,3),
(1004,1003,'1234567891', '2022-02-01 10:00:00', '2022-02-02 10:00:00', false,3),
(1003,1004,'1234567892', '2022-03-01 10:00:00', '2022-03-02 10:00:00', false,3),
(1002,1005,'1234567893', '2022-04-01 10:00:00', '2022-04-02 10:00:00', false,3),
(1001,1000,'1234567894', '2022-05-01 10:00:00', '2022-05-02 10:00:00', false,3);

INSERT INTO prescriptions (patient_id,practitioner_id,date, drug_code, drug_name, notes, service_id)
VALUES
(1001,1005,'2022-01-01', '12345', 'Acetaminophen', 'Take two tablets every four hours as needed for pain',2),
(1002,1004,'2022-01-02', '23456', 'Ibuprofen', 'Take one tablet every six hours as needed for inflammation',2),
(1003,1003,'2022-01-03', '34567', 'Amoxicillin', 'Take one tablet every eight hours for ten days for infection',2),
(1004,1002,'2022-01-04', '45678', 'Lisinopril', 'Take one tablet daily for high blood pressure',2),
(1005,1001,'2022-01-05', '56789', 'Metformin', 'Take one tablet twice daily with meals for diabetes',2);

INSERT INTO appointments (patient_id, practitioner_id, clinic_id, date, time, status, phone, email, service_id)
VALUES
(1004,1001,1,'2022-01-01', '10:00:00-05:00', 'scheduled','555-555-1212', 'john.doe@gmail.com',1),
(1003,1000,1,'2022-01-02', '11:00:00-05:00', 'scheduled','555-555-1213', 'jane.doe@gmail.com',1),
(1002,1004,1,'2022-01-03', '12:00:00-05:00', 'scheduled','555-555-1214', 'sarah.johnson@gmail.com',1),
(1001,1003,1,'2022-01-04', '13:00:00-05:00', 'scheduled','555-555-1215', 'michael.brown@gmail.com',1),
(1000,1005,1,'2022-01-05', '14:00:00-05:00', 'scheduled','555-555-1216', 'taylor.smith@gmail.com',1);

INSERT INTO encounters (patient_id,practitioner_id,date, time, type_of_visit, encounter_title)
VALUES
(1000,1005,'2022-01-01', '10:00:00-05:00', 'office visit', 'Annual physical'),
(1001,1004,'2022-01-02', '11:00:00-05:00', 'office visit', 'Sick visit'),
(1002,1003,'2022-01-03', '12:00:00-05:00', 'office visit', 'Follow-up appointment'),
(1003,1002,'2022-01-04', '13:00:00-05:00', 'telemedicine', 'Virtual visit'),
(1004,1001,'2022-01-05', '14:00:00-05:00', 'office visit', 'Check-up');


INSERT INTO billings (patient_id, service_id, cost, paid, transaction_id)
VALUES 
(1002, 2, 75.00, true, '3c9a6424-6d93-4437-a6b3-bfe0461b8f3c'),
(1001, 3, 100.00, true, 'b7a44f6e-d174-4607-afef-2c9b9f9b7edc'),
(1003, 4, 35.00, false, null),
(1004, 5, 45.00, true, '5c5d5fda-0a89-4b2d-b8e8-c9b932bac932'),
(1005, 1, 25.00, true, '8ee3e3e3-3cf3-4b12-8bdd-a6e2f6a0b6c7');


INSERT INTO users (username, password, first_name, last_name, email, phone, role)
VALUES
('jdoe', '$2y$10$xJDDV7Lm2bK8o7D', 'John', 'Doee', 'john.doe@gmail.com', '555-555-1212', 'doctor'),
('jane.doe', '$2y$10$/0KjztB4IpBwAZe', 'Jane', 'Doee', 'jane.doe@gmail.com', '555-555-1213', 'nurse'),
('sarah.johnson', '$2y$10$f6x1l6U8V6TJjhLsV7lZQ', 'Sarah', 'Johnson', 'sarah.johnson@gmail.com', '555-555-1214', 'receptionist'),
('michael.brown', '$2y$10$Rz.jK2J1Cw7cGvOjdZgJ1', 'Michael', 'Brown', 'michael.brown@gmail.com', '555-555-1215', 'doctor'),
('john.doe', '$2y$10$Jdoe123', 'John', 'Doe', 'john.doe@gmail.com', '555-555-1212', 'admin'),
('jane.d', '$2y$10$Jdoe123', 'Jane', 'Doe', 'jane.doe@gmail.com', '555-555-1213', 'nurse'),
('sarah.johnson', '$2y$10$SJ23', 'Sarah', 'Johnson', 'sarah.johnson@gmail.com', '555-555-1214', 'doctor'),
('michael.brown', '$2y$10$Mb123', 'Michael', 'Brown', 'michael.brown@gmail.com', '555-555-1215', 'admin');
