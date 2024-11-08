-- Active: 1731000061149@@127.0.0.1@3306@mydb
-- Active: 1731000061149@@127.0.0.1@3306@mydb
create table appointment(a_id int PRIMARY KEY, a_date DATE);
create table patient(p_id int PRIMARY KEY, p_name VARCHAR(25) NOT NULL, p_dob DATE, p_gender VARCHAR(10), p_email VARCHAR(25),p_pin int, p_state VARCHAR(25));

create Table payment(p_id int, pay_id int, pay_amt int, FOREIGN KEY(p_id) REFERENCES patient(p_id));

create table pat_ph(p_id int, p_ph int, FOREIGN KEY (p_id) REFERENCES patient(p_id));

create table room(r_id VARCHAR(25), r_type VARCHAR(25) DEFAULT 'normal', r_charges int);

create table admit(ad_id varchar(25), ad_date DATE);

create table department(dept_id int PRIMARY KEY, dept_name VARCHAR(25) NOT NULL);

CREATE TABLE doctor (
    doc_id INT PRIMARY KEY,
    doc_name VARCHAR(25) NOT NULL,
    doc_email VARCHAR(25) UNIQUE,
    doc_gender VARCHAR(10) NOT NULL,
    doc_adPIN INT NOT NULL,
    doc_adSTATE VARCHAR(25) DEFAULT 'Hyderabad'
);

CREATE TABLE doc_ph (
    doc_id INT,
    doc_ph VARCHAR(15),
    FOREIGN KEY (doc_id) REFERENCES doctor(doc_id)
);



INSERT INTO department (dept_id, dept_name)
VALUES
    (101, 'Cardiology'),
    (102, 'Neurology'),
    (103, 'Orthopedics'),
    (104, 'Orthopedics'),
    (105, 'Orthopedics');

INSERT INTO room (r_id, r_type, r_charges)
VALUES
    ('R01', 'normal', 1000),
    ('R02', 'normal', 1500),
    ('R03', 'private', 4500);


INSERT INTO appointment (a_id, a_date) 
VALUES 
    (9701, '2020-01-10'),
    (9702, '2021-03-14'),
    (9703, '2018-06-29'),
    (9704, '2019-12-09');


INSERT INTO doctor (doc_id, doc_name, doc_email, doc_gender, doc_adPIN, doc_adSTATE)
VALUES
    (1, 'Rebecca', 'rebecaaa@gmail.com', 'Female', 720019, 'Goa'),
    (2, 'Uppi', 'bahubalivfx@gmail.com', 'Male', 500102, 'Kerala'),
    (43, 'Shirley', 'angelakka@gmail.com', 'Female', 720016, 'Chennai'),
    (17, 'Kaushik', 'nenactoravtha@gmail.com', 'Male', 500103, 'Hyderabad'),
    (69, 'Vivek', 'thagudam@gmail.com', 'Male', 500103, 'Hyderabad'),
    (20, 'Karthik', 'develop@gmail.com', 'Male', 500072, 'Hyderabad');



INSERT INTO patient (p_id, p_name, p_dob, p_gender, p_email, p_pin, p_state)
VALUES
    (98047, 'Tharun Bhaskar', '1990-06-07', 'Male', 'keedakola@gmail.com', 500000, 'Telangana'),
    (98005, 'Prashanth', '1990-07-07', 'Male', 'naasavnensastha@gmail.com', 720100, 'Tamil Nadu'),
    (98019, 'Chitra', '2000-01-29', 'Female', 'foodtruck@gmail.com', 420100, 'Delhi');


INSERT INTO payment (p_id, pay_id, pay_amt)
VALUES
    (98047, 110001, 1050),
    (98005, 110003, 22000),
    (98019, 11023, 7500);


INSERT INTO pat_ph (p_id, p_ph)
VALUES
    (98047, 998800227),
    (98005, 888800227),
    (98019, 778800227);


INSERT INTO doc_ph (doc_id, doc_ph)
VALUES
    (1, '9876543210'),
    (2, '9876543211'),
    (43, '9876543212'),
    (17, '9876543213'),
    (69, '9876543214'),
    (20, '9876543215');


INSERT INTO admit (ad_id, ad_date)
VALUES
    ('AD001', '2022-01-01'),
    ('AD002', '2023-04-29'),
    ('AD003', '2021-07-30');

SELECT * from payment WHERE pay_amt>5000;
SELECT * from payment where pay_id = 11023;
SELECT * FROM room WHERE r_charges>=1500;

SELECT * FROM doctor where `doc_adSTATE` LIKE 'h%';

SELECT * FROM patient WHERE p_state IN ('Delhi','Female');

SELECT UPPER(p_name) FROM patient;
SELECT LOWER(p_name) FROM patient;

SELECT MAX(pay_amt) as highest_amount_paid FROM payment;

SELECT MIN(pay_amt) as least_amount_paid FROM payment;

SELECT p_id, MAX(pay_amt) as max_amount FROM payment GROUP BY p_id;


CREATE TABLE doc_dep(doc_id int, dept_id int, PRIMARY KEY(doc_id,dept_id), FOREIGN KEY(doc_id) REFERENCES doctor(doc_id), FOREIGN key(dept_id) REFERENCES department(dept_id));

INSERT INTO doc_dep (doc_id, dept_id)
VALUES
    (17, 102),
    (69, 102),
    (20, 103),
    (2, 104),
    (1, 105),
    (43, 104);


SELECT doctor.doc_id, doctor.doc_name, department.dept_id, department.dept_name from doc_dep INNER JOIN doctor on doc_dep.doc_id=doctor.doc_id INNER JOIN department on doc_dep.dept_id = department.dept_id;

SELECT patient.p_name, doctor.doc_name FROM patient FULL JOIN doctor on patient.p_pin = doctor.`doc_adPIN`;

SELECT patient.p_name, doctor.doc_name FROM patient RIGHT JOIN doctor on patient.p_pin = doctor.`doc_adPIN`;

SELECT * FROM patient LEFT JOIN doctor on patient.p_pin = doctor.`doc_adPIN`;

SELECT doc_id, doc_name, doc_email from doctor where `doc_adSTATE` = (SELECT `doc_adSTATE` from doctor where doc_name='Vivek') AND doc_id>(SELECT doc_id FROM doctor WHERE doc_name = 'Rebecca');

SELECT doc_name, doc_gender, doc_adstate FROM doctor where `doc_adPIN` < ALL(SELECT `doc_adPIN` from doctor where `doc_adPIN`=720019) And `doc_adPIN`<>720019;

SELECT doc_name, doc_gender, doc_adstate from doctor WHERE `doc_adPIN` IN (SELECT MIN(`doc_adPIN`) from doctor GROUP BY `doc_adSTATE`);

DELIMITER $$

CREATE PROCEDURE GetTotalAmount()
BEGIN
    DECLARE total_amount INT;

    -- Calculate the total amount from the payment table
    SELECT SUM(pay_amt) INTO total_amount FROM payment;

    -- Output the total amount
    SELECT CONCAT('Total = ', total_amount) AS total;
END $$

DELIMITER ;
CALL GetTotalAmount();


alter table payment add(tax int);
UPDATE payment set tax = 249 where p_id = 98047;
UPDATE payment set tax = 1152 where p_id = 98005;
UPDATE payment set tax = 479 where p_id = 98019;

CREATE OR REPLACE TRIGGER payment_update_trigger
BEFORE UPDATE ON payment
FOR EACH ROW
DECLARE
    v_pay_tax CONSTANT NUMBER := 0.1;
BEGIN
    :New.pay_amt := :New.pay_amt + (:New.pay_amt * v_pay_tax);
    DBMS_OUTPUT>PUT_LINE('Payment updated successfully. New amount: '|| :NEW.pay_amt);
END;
/

UPDATE payment SET pay_amt = 1000 WHERE pay_id = 110003;


DECLARE
    payid payment.pay_id%TYPE := 110001;
    payment payment.pay_amt%TYPE;
    pay_tax CONSTANT NUMBER := 0.1;
BEGIN
    SELECT pay_amt INTO payamt
    FROM payment
    WHERE pay_id = payid;

    payment := payamt + (payamt * pay_tax);

    UPDATE payment 
    SET pay_amt = pay_amt
    WHERE pay_id = payid;

    DBMS_OUTPUT.PUT_LINE('Payment updated successfully. New amount: ' || payamt);
END;
/
