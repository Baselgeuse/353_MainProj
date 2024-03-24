CREATE DATABASE IF NOT EXISTS HFESTS;
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

CREATE TABLE WorksAt (
  employee_sin VARCHAR(20),
  fid INT,
  start_date DATE,
  end_date DATE,
  PRIMARY KEY (employee_sin, fid, start_date),
  FOREIGN KEY (employee_sin) REFERENCES Employee(employee_sin),
  FOREIGN KEY (fid) REFERENCES Facility(fid)
);

DELIMITER //
CREATE TRIGGER CheckOnlyOneFacilityAtATime
BEFORE INSERT ON WorksAt
FOR EACH ROW
BEGIN
    DECLARE count INT;
    SELECT COUNT(*) INTO count
    FROM WorksAt
    WHERE employee_sin = NEW.employee_sin AND end_date IS NULL;
    IF count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee already works somewhere, change end date before adding';
    END IF;
END //
DELIMITER ;


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

CREATE TABLE Schedule (
  sid INT,
  fid INT,
  employee_sin VARCHAR(20),
  Date DATE,
  StartTime TIME,
  EndTime TIME,
  PRIMARY KEY(sid),
  FOREIGN KEY(fid) REFERENCES Facility(fid),
  FOREIGN KEY(employee_sin) REFERENCES Employee(employee_sin),
  CONSTRAINT startLessThanEnd CHECK (StartTime < EndTime)
);

DELIMITER $$
CREATE TRIGGER Before_Insert_Schedule
BEFORE INSERT ON Schedule
FOR EACH ROW
BEGIN
  DECLARE conflict_count INT;
  SELECT COUNT(*) INTO conflict_count
  FROM Schedule
  WHERE NEW.employee_sin = employee_sin
    AND NEW.Date = Date
    AND (
      (NEW.StartTime < EndTime AND NEW.EndTime > StartTime)  -- Overlaps existing
      OR (NEW.StartTime = StartTime AND NEW.EndTime = EndTime) -- Exact match
    );
  IF conflict_count > 0 THEN
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'Schedule conflict detected.';
  END IF;
END $$
DELIMITER ;

SET foreign_key_checks = 1;

-- Note: Other constraints related to conflicting times, two-hour gaps, vaccination, and infection checks
-- should ideally be implemented through triggers or application-level logic due to their complexity
-- and the limitations of CHECK constraints in many SQL DBMSs.

-- CREATE TABLE Schedule (
--     sid INT,
--     fid INT,
--     employee_sin VARCHAR(20),
--     Date DATE,
--     StartTime TIME,
--     EndTime TIME,
--     CONSTRAINT startLessThanEnd CHECK (StartTime <= EndTime),
--     CONSTRAINT conflictingTimes CHECK (
--         (SELECT COUNT() FROM Schedule s1, Schedule s2 
--          WHERE s1.employee_sin = s2.employee_sin
--          AND s1.Date = s2.Date
--          AND s1.fid = s2.fid
--          AND s1.sid != s2.sid
--          AND ( 
--             (s1.StartTime BETWEEN s2.StartTime AND s2.EndTime) OR
--             (s1.EndTime BETWEEN s2.StartTime AND s2.EndTime) OR
--             (s2.StartTime BETWEEN s1.StartTime AND s1.EndTime) OR
--             (s2.EndTime BETWEEN s1.StartTime AND s1.EndTime)
--             )
--          ) = 0
--     ),
--     CONSTRAINT twoHourGap CHECK (
--         (SELECT COUNT() FROM Schedule s1, Schedule s2
--         WHERE s1.employee_sin = s2.employee_sin
--         AND s1.Date = s2.Date
--         AND s1.sid != s2.sid
--         AND  TIMESTAMPDIFF(hour, s1.EndTime, s2.StartTime) < 2
--         ) = 0
--     ),
--     CONSTRAINT vaccinated CHECK (
--         (SELECT COUNT() FROM Vaccinated
--         WHERE Vaccinated.person_sin = Schedule.employee_sin
--         AND DATEDIFF(Schedule.Date, Vaccinated.date) <= 180
--         ) = 0
--     ),
--     CONSTRAINT infectedCheck CHECK(
--         (SELECT COUNT() FROM Infected
--         LEFT JOIN Nurse ON Nurse.nurse_sin = Infected.person_sin
--         LEFT JOIN Doctor ON Doctor.doctor_sin = Infected.person_sin
--         WHERE Infected.person_sin = Schedule.employee_sin
--         AND DATEDIFF(Schedule.Date, Infected.date) <= 14
--         ) = 0
--     )
-- ); 

-- SET foreign_key_checks = 1;