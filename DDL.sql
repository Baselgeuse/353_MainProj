CREATE DATABASE IF NOT EXISTS zkc353_4;
SET foreign_key_checks = 0;

DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Pharmacist;
DROP TABLE IF EXISTS Nurse;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Receptionist;
DROP TABLE IF EXISTS Cashier;
DROP TABLE IF EXISTS Administrative;
DROP TABLE IF EXISTS Security;
DROP TABLE IF EXISTS Residence;
DROP TABLE IF EXISTS Facility;
DROP TABLE IF EXISTS Variant;
DROP TABLE IF EXISTS LivesWith;
DROP TABLE IF EXISTS WorksAt;
DROP TABLE IF EXISTS Vaccinated;
DROP TABLE IF EXISTS Infected;
DROP TABLE IF EXISTS Schedule;
DROP TABLE IF EXISTS Shift;
DROP TABLE IF EXISTS Secondary;


CREATE TABLE Person (
    SIN VARCHAR(20) NOT NULL UNIQUE, -- added NOT NULL UNIQUE
    MID VARCHAR(20) NOT NULL UNIQUE, -- added NOT NULL UNIQUE
    fname VARCHAR(255),
    lname VARCHAR(255),
    email VARCHAR(255),
    DOB DATE,
    phone_number VARCHAR(20),
    citizenship VARCHAR(50),
    rid INT NOT NULL,
    PRIMARY KEY(SIN, MID),
    FOREIGN KEY (rid) REFERENCES Residence(rid)
);

CREATE TABLE Employee (
  employee_sin VARCHAR(20) PRIMARY KEY,
  FOREIGN KEY (employee_sin) REFERENCES Person(SIN)
);

CREATE TABLE Pharmacist (
  pharmacist_sin VARCHAR(20) PRIMARY KEY,
  FOREIGN KEY (pharmacist_sin) REFERENCES Employee(employee_sin)
);
CREATE TABLE Nurse (
  nurse_sin VARCHAR(20) PRIMARY KEY,
  FOREIGN KEY (nurse_sin) REFERENCES Employee(employee_sin)
);
CREATE TABLE Doctor (
  doctor_sin VARCHAR(20) PRIMARY KEY,
  FOREIGN KEY (doctor_sin) REFERENCES Employee(employee_sin)
);
CREATE TABLE Receptionist(
    receptionist_sin VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (receptionist_sin) REFERENCES Employee(employee_sin)
);
CREATE TABLE Cashier(
    cashier_sin VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (cashier_sin) REFERENCES Employee(employee_sin)
);
CREATE TABLE Administrative(
    administrative_sin VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (administrative_sin) REFERENCES Employee(employee_sin)
);
CREATE TABLE Security(
    security_sin VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (security_sin) REFERENCES Employee(employee_sin)
);

CREATE TABLE Residence (
  rid INT PRIMARY KEY,
  address VARCHAR(255),
  city VARCHAR(255),
  province VARCHAR(255),
  postal_code VARCHAR(10),
  phone_number VARCHAR(20),
  room_count INT,
  residence_type VARCHAR(50),
  CHECK (residence_type IN ('apartment', 'condominium', 'demidetached','house'))
);

CREATE TABLE Facility (
  fid INT PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255),
  city VARCHAR(255),
  province VARCHAR(255),
  postal_code VARCHAR(10),
  phone_number VARCHAR(20),
  web_address VARCHAR(255),
  facility_type VARCHAR(50),
  manager_sin VARCHAR(20),
  capacity INT,
    CHECK (facility_type IN ('hospital', 'clinic', 'pharmacy','CLSC','special')),
    FOREIGN KEY (manager_sin) REFERENCES Administrative(administrative_sin)
);

CREATE TABLE Variant (
  variantType VARCHAR(50) PRIMARY KEY
);

CREATE TABLE LivesWith (
    employee_sin VARCHAR(20),
    person_sin VARCHAR(20),
    relationship VARCHAR(50) NOT NULL CHECK (relationship IN ('roommate', 'partner', 'parent', 'dependent')), -- this allows only specific values for this relationship
    PRIMARY KEY (employee_sin, person_sin),
    FOREIGN KEY (employee_sin) REFERENCES Employee(employee_sin),
    FOREIGN KEY (person_sin) REFERENCES Person(SIN)
);


CREATE TABLE Vaccinated (
  person_sin VARCHAR(20),
  dose_number INT,
  vaccine_type VARCHAR(255) NOT NULL,
  date DATE NOT NULL,
  fid INT NOT NULL,
  PRIMARY KEY (person_sin, dose_number),
  FOREIGN KEY (person_sin) REFERENCES Person(SIN),
  FOREIGN KEY (fid) REFERENCES Facility(fid),
    CHECK (dose_number > 0)
);

CREATE TABLE Infected (
  person_sin VARCHAR(20),
  variantType VARCHAR(50) NOT NULL,
  date DATE NOT NULL,
  PRIMARY KEY (person_sin, variantType, date), -- so that a person can be infected more than once
  FOREIGN KEY (person_sin) REFERENCES Person(SIN),
  FOREIGN KEY (variantType) REFERENCES Variant(variantType)
);

CREATE TABLE Secondary (
	rid INT NOT NULL,
    sin VARCHAR(20) NOT NULL,
    PRIMARY KEY (sin, rid),
    FOREIGN KEY (sin) REFERENCES Person(SIN),
	FOREIGN KEY (rid) REFERENCES Residence(rid)
);

CREATE TABLE Schedule (
  sid INT NOT NULL,
  employee_sin VARCHAR(20) NOT NULL,
  fid INT NOT NULL,
  start_date DATE,
  end_date DATE,
  PRIMARY KEY (sid),
  FOREIGN KEY (employee_sin) REFERENCES Employee(employee_sin),
  FOREIGN KEY (fid) REFERENCES Facility(fid)
);

CREATE TABLE Shift (
    start DATETIME NOT NULL,
    end DATETIME NOT NULL,
    sid INT NOT NULL,
    shift_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(shift_id, sid),
    FOREIGN KEY (sid) REFERENCES Schedule(sid) ON DELETE CASCADE,
    CONSTRAINT ends_before_start CHECK (start < end)
);

DELIMITER //

CREATE TRIGGER CheckOverlapTime
BEFORE INSERT ON Schedule
FOR EACH ROW
BEGIN
    DECLARE active_assignments INT;

    SELECT COUNT(*) INTO  active_assignments
	FROM (
    SELECT employee_sin, fid
    FROM Schedule
    WHERE end_date is NULL
    GROUP BY employee_sin, fid
    HAVING COUNT(*) > 1
    
) AS duplicates;
    IF active_assignments > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee already has overlapping assignments';
    END IF;
END//

DELIMITER //
CREATE TRIGGER CheckVaccinated
BEFORE INSERT ON Shift
FOR EACH ROW
BEGIN
    DECLARE vaccinations INT;

    SELECT COUNT(*) INTO  vaccinations
	FROM  Vaccinated
    JOIN Schedule ON Vaccinated.person_sin = Schedule.employee_sin
	Where Schedule.sid = New.sid
    AND DATEDIFF(New.start,Vaccinated.date) <= 180;

    IF vaccinations = 0 THEN
        SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT = 'Employee hasnt been vaccinated in the past 6 months';
    END IF;
END//

DELIMITER //
CREATE TRIGGER CheckTwoHourBreak
BEFORE INSERT ON Shift
FOR EACH ROW
BEGIN
    DECLARE violations INT;
    SELECT COUNT(*) INTO violations
    FROM Employee
    JOIN Schedule on Schedule.employee_sin = Employee.employee_sin
    JOIN Shift ON Schedule.sid = Shift.sid
    WHERE Employee.employee_sin = 
		(Select e.employee_sin 
        FROM Employee e
        JOIN Schedule on Schedule.employee_sin = e.employee_sin
        Where New.sid = Schedule.sid
        )
    AND DATE(Shift.end) = DATE(NEW.start)
    AND TIMESTAMPDIFF(hour, new.start,Shift.end) <= 2;

    IF violations > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee needs at least a 2 hour break after previous shift';
    END IF;
END//


DELIMITER //
CREATE TRIGGER CheckInfected
BEFORE INSERT ON Shift
FOR EACH ROW
BEGIN
    DECLARE infected_count INT;

    SELECT COUNT(*) INTO infected_count
    FROM Infected
    LEFT JOIN Nurse ON Nurse.nurse_sin = Infected.person_sin
    LEFT JOIN Doctor ON Doctor.doctor_sin = Infected.person_sin
    LEFT JOIN Schedule ON New.sid = Schedule.sid
    WHERE Infected.person_sin = Schedule.employee_sin
    AND DATEDIFF(Schedule.start_date, Infected.date) <= 14;

    IF infected_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee is infected and cannot be scheduled.';
    END IF;
END//



SET foreign_key_checks = 1;
