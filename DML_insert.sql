INSERT INTO Residence (rid, address, city, province, postal_code, phone_number, room_count, residence_type) 
VALUES 
(1, '1005 Saint Catherine', 'Montreal', 'Quebec', 'H9X3B7', '111-111-1111', 3, 'house'), # Spongebob Squarepants
(2, '200 Pine Avenue', 'Vancouver', 'British Columbia', 'V6B3C5', '222-222-2222', 2, 'apartment'), # Alex Kepekci, John Smith, Patrick Star, Jane Doe
(3, '300 Maple Road', 'Toronto', 'Ontario', 'M4B1B3', '333-333-3333', 4, 'condominium'), # Squidward Tentacles, Infected Dude
(4, '400 Oak Street', 'Calgary', 'Alberta', 'T2P5H5', '444-444-4444', 5, 'demidetached'), # Sandy Cheeks, Theo Von
(5, '500 Birch Lane', 'Halifax', 'Nova Scotia', 'B3H4R2', '555-555-5555', 3, 'house'), # Emily Smith
(6, '600 Street Avenue', 'Winnipeg', 'Manitoba', 'J0H5Z9', '666-666-666', 7, 'apartment'), # Gabriel D'Alesio, Leo Brodeur
(7, '700 King Crescent', 'Iqaluit', 'Nunavut', 'Z9Z5X5', '777-777-777', 2, 'condominium'),
 (101, '123 Elm St', 'Anytown', 'Anystate', '12345', '1112223333', 10, 'apartment'),
    (102, '456 Oak St', 'Othertown', 'Otherstate', '67890', '4445556666', 8, 'condominium'),
    (103, '789 Maple St', 'Sometown', 'Somestate', '13579', '7778889999', 15, 'demidetached'),
    (104, '101 Pine St', 'Anytown', 'Anystate', '24680', '0001112222', 12, 'house'),
    (105, '202 Cedar St', 'Othertown', 'Otherstate', '36912', '3334445555', 6, 'apartment'); # Youssef Yacoub

INSERT INTO Person (SIN, MID, fname, lname, email, DOB, phone_number, citizenship, rid) 
VALUES
# employees
('123123123', 'KEPA12341234', 'Alex', 'Kepekci', 'alexkepekci@hotmail.com', '1999-09-24', '514-123-4321', 'Canadian', 2), # lives with John Smith, Patrick Star, Jane Doe
('111222333', 'SQUAS12345678', 'SpongeBob', 'SquarePants', 'spongebob@gmail.com', '1986-07-14', '555-099-1111', 'Bikini Bottom', 1), # lives solo
('444555666', 'STARP12345678', 'Patrick', 'Star', 'patrickstar@gmail.com', '1984-02-26', '555-502-2222', 'Bikini Bottom', 2), # lives with Alex Kepekci, John Smith, Jane Doe
('777888999', 'TENS12345678', 'Squidward', 'Tentacles', 'squidwardt@gmail.com', '1977-10-09', '555-259-3333', 'Bikini Bottom', 3), # lives with Infected Dude
('123456789', 'CHEES12345678', 'Sandy', 'Cheeks', 'sandycheeks@gmail.com', '1988-11-17', '555-125-4444', 'Bikini Bottom', 4), # lives with Theo Von
('987654321', 'DOEJ87654321', 'Jane', 'Doe', 'janedoe@gmail.com', '1990-08-24', '532-555-0102', 'Canadian', 2), # lives with Alex Kepekci, John Smith, Patrick Star
('234567890', 'SMIE23456789', 'Emily', 'Smith', 'emilysmith@gmail.com', '1982-12-16', '123-559-2342', 'British', 5), # lives solo
('100000000', 'DALG11111111', 'Gabriel', 'D''Alesio', 'galesi@encs.concordia.ca', '1996-08-12', '514-923-2932', 'Canadian', 6), # lives with Leo Brodeur
('200000000', 'BROL11111111', 'Leo', 'Brodeur', 'le_brode@live.concordia.ca', '1999-12-09', '514-223-2321', 'Canadian', 6), # lives with Gabriel D'Alesio
('300000000', 'YACY11111111', 'Youssef', 'Yacoub', 'y_yacoub@live.concordia.ca', '1995-04-24', '514-999-1234', 'Canadian', 7), # lives solo
# people who live with these employees
('000000000', 'SMIJ00000000', 'John', 'Smith', 'johnsmith@gmail.com', '1960-04-23', '514-000-0000', 'Canadian', 2),
('000000001', 'DUDR00000000', 'Infected', 'Dude', 'infecteddude@gmail.com', '1998-02-20', '514-111-1111', 'Canadian', 3),
('000000002', 'VONT00000000', 'Theo', 'Von', 'theovon@gmail.com', '1979-01-02', '954-013-4324', 'Canadian', 4),
('111111111', 'M111', 'John', 'Doe', 'john.doe@example.com', '1980-05-15', '1234567890', 'Canadian', 101),
('222222222', 'M222', 'Jane', 'Smith', 'jane.smith@example.com', '1975-10-20', '9876543210', 'Canadian', 102),
('333333333', 'M333', 'Alice', 'Johnson', 'alice.johnson@example.com', '1990-03-25', '5555555555', 'American', 103),
('444444444', 'M444', 'Bob', 'Brown', 'bob.brown@example.com', '1988-12-10', '7777777777', 'British', 104),
('555555555', 'M555', 'Emily', 'Davis', 'emily.davis@example.com', '1985-07-08', '9999999999', 'Australian', 105),
('6', 'M3sa55', 'Jack', 'Davis', 'emily.davis@example.com', '1985-07-08', '9999999999', 'Australian', 105),
('7', 'M55w45', 'Alex', 'Davis', 'emily.davis@example.com', '1985-07-08', '9999999999', 'Australian', 105),
('8', 'M55225', 'Paul', 'Davis', 'emily.davis@example.com', '1985-07-08', '9999999999', 'Australian', 105),
('9', 'M3525', 'John', 'Davis', 'emily.davis@example.com', '1985-07-08', '9999999999', 'Australian', 105),
('10', 'M53545', 'Jill', 'Davis', 'emily.davis@example.com', '1985-07-08', '9999999999', 'Australian', 105),
('11', 'M54525', 'Renaud', 'Davis', 'emily.davis@example.com', '1985-07-08', '9999999999', 'Australian', 105);


INSERT INTO Employee (employee_sin) 
VALUES ('123123123'), ('111222333'),('444555666'),('777888999'),('123456789'),('987654321'),('234567890'),('100000000'),('200000000'),('300000000'),('111111111'), ('222222222'),('333333333'),('444444444'),('555555555'),('6'),('7'),('8'),('9'),('10'),('11');

INSERT INTO Pharmacist (pharmacist_sin)
VALUES ('123123123'), ('100000000'),('10'); # Alex Kepekci, Gabriel D'Alesio

INSERT INTO Nurse (nurse_sin) 
VALUES ('123456789'),('6'),('9'); # Sandy Cheeks

INSERT INTO Doctor (doctor_sin)
VALUES ('987654321'), ('300000000'),('111111111'), ('222222222'),('333333333'),('444444444'),('555555555'),('11'); # Jane Doe, Youssef Yacoub

INSERT INTO Receptionist (receptionist_sin)
VALUES ('111222333'),('7'),('8'); # Spongebob Squarepants

INSERT INTO Cashier (cashier_sin)
VALUES ('777888999'); # Squidward Tentacles

INSERT INTO Security (security_sin)
VALUES ('444555666'), ('200000000'); # Patrick Star, Leo Brodeur


INSERT INTO Administrative (administrative_sin)
VALUES 
('234567890'), # Emily Smith
('111222333'), # SpongeBob (also Receptionist)
('444555666'), # Patrick Star (also Security)
('777888999'), # Squidward (also Cashier)
('123456789'); # Sandy Cheeks (also Nurse)

INSERT INTO Facility (fid, name, address, city, province, postal_code, phone_number, web_address, facility_type, manager_sin, capacity) 
VALUES 
(1, 'CLSC', '101 Boul Maisonneuve', 'Montreal', 'Quebec', 'H2B5L9', '121-212-1212', 'www.clsc.com', 'clsc', '111222333', 100), # Managed by SpongeBob
(2, 'General Hospital', '202  Notre-Dame St', 'Montreal', 'Quebec', 'H3Z2Y7', '222-212-1212', 'www.generalhospital.com', 'hospital', '444555666', 1000), # Managed by Patrick Star
(3, 'Downtown Clinic', '303 Crescent St', 'Montreal', 'Quebec', 'H3C5L9', '323-212-1212', 'www.downtownclinic.com', 'clinic', '777888999', 300), # Managed by Squidward Tentacles
(4, 'Main Street Pharmacy', '404 Sherbrooke Ave', 'Montreal', 'Quebec', 'H4N5L8', '424-212-1212', 'www.mainstreetpharmacy.com', 'pharmacy', '123456789', 50), # Managed by Sandy Cheeks
(5, 'Special Health Center', '505 Union Ave', 'Montreal', 'Quebec', 'H5S6D9', '525-212-1212', 'www.specialhealthcenter.com', 'special', '234567890', 200),
(6, 'Pharmacy F', '101 Pine St', 'Anytown', 'Anystate', '24680', '0001112222', 'www.pharmacyD.com', 'pharmacy', '234567890', 50),
(101, 'Hospital A', '123 Main St', 'Anytown', 'Anystate', '12345', '1112223333', 'www.hospitalA.com', 'hospital', '234567890', 200),
(102, 'Hospital B', '456 Oak St', 'Othertown', 'Otherstate', '67890', '4445556666', 'www.hospitalB.com', 'hospital', '234567890', 150),
(103, 'Clinic C', '789 Elm St', 'Sometown', 'Somestate', '13579', '7778889999', 'www.clinicC.com', 'clinic', '234567890', 100),
(104, 'Pharmacy D', '101 Pine St', 'Anytown', 'Anystate', '24680', '0001112222', 'www.pharmacyD.com', 'pharmacy', '234567890', 50),
(105, 'Clinic E', '202 Maple St', 'Othertown', 'Otherstate', '36912', '3334445555', 'www.clinicE.com', 'clinic', '234567890', 80); # Managed by Emily Smith

INSERT INTO Variant (variantType) 
VALUES 
('COVID-19'), 
('SARS-Cov-2'), 
('Alpha'), 
('Omicron');

INSERT INTO LivesWith (employee_sin, person_sin, relationship) 
VALUES 
-- Alex Kepekci
('123123123', '000000000', 'parent'), # lives with John Smith
('123123123', '444555666', 'roommate'), # lives with Patrick Star
('123123123', '987654321', 'partner'), # lives with Jane Doe
-- Patrick Star
('444555666', '123123123', 'roommate'), # lives with Alex Kepekci
('444555666', '000000000', 'roommate'), # lives with John Smith
('444555666', '987654321', 'roommate'), # lives with Jane Doe
-- Squidward Tentacles
('777888999', '000000001', 'dependent'), # lives with Infected Dude
-- Jane Doe
('987654321', '123123123', 'partner'), # lives with Alex Kepekci
('987654321', '000000000', 'roommate'), # lives with John Smith
('987654321', '444555666', 'roommate'), # lives with Patrick Star
-- Sandy Cheeks
('123456789', '000000002', 'partner'), # lives with Theo Von
-- Gabriel D'Alesio
('100000000', '200000000', 'roommate'), # lives with Leo Brodeur
-- Leo Brodeur
('200000000', '100000000', 'roommate'); # lives with Gabriel D'Alesio


INSERT INTO Schedule (sid,employee_sin, fid, start_date, end_date) 
VALUES 
(1,'123123123', 1, '2024-01-01', NULL), # Alex Kepekci at CLSC
(2, '111222333', 1, '2024-03-01', NULL), # SpongeBob SquarePants at CLSC (manager)
(3,'444555666', 2, '2022-04-05', NULL), # Patrick Star at General Hospital (manager)
(4,'777888999', 3, '2023-12-12', NULL), # Squidward Tentacles at Downtown Clinic (manager)
(5,'123456789', 4, '2024-01-05', NULL), # Sandy Cheeks at Main Street Pharmacy (manager)
(6,'300000000', 4, '2019-05-09', NULL), # Youssef Yacoub at Main Street Pharmacy
(7,'234567890', 5, '2021-02-01', NULL), # Emily Smith at Special Health Center (manager)
(8,'987654321', 5, '2019-05-21', '2023-08-27'), # Jane Doe at Special Health Center (not working anymore)
(9,'100000000', 5, '2021-05-01', NULL), # Gabriel D'Alesio at Special Health Center
(15,'111111111', 5, '2022-01-05', NULL), # Leo Brodeur at Special Health Center
(11,'222222222', 5, '2022-01-05', NULL), # Leo Brodeur at Special Health Center
(12,'333333333', 5, '2022-01-05', NULL), # Leo Brodeur at Special Health Center
(13,'444444444', 5, '2022-01-05', NULL), # Leo Brodeur at Special Health Center
(14,'555555555', 5, '2024-01-05', NULL), # Leo Brodeur at Special Health Center
(10,'200000000', 5, '2024-01-05', NULL), # Leo Brodeur at Special Health Center
(16,'6', 6, '2024-01-05', NULL), # Leo Brodeur at Special Health Center
(17,'7', 6, '2024-01-05', NULL), # Leo Brodeur at Special Health Center
(18,'8', 6, '2024-01-05', NULL), # Leo Brodeur at Special Health Center
(19,'9', 6, '2024-01-05', NULL), # Leo Brodeur at Special Health Center
(20,'10', 6, '2024-01-05', NULL), # Leo Brodeur at Special Health Center
(21,'11', 6, '2024-01-05', NULL), # Leo Brodeur at Special Health Center
(22,'6', 6, '2024-01-05', NULL); # Leo Brodeur at Special Health Center(



INSERT INTO Vaccinated (person_sin, dose_number, vaccine_type, date, fid) 
VALUES 
 ('123123123', 2, 'Moderna', '2024-04-15', 1), # Alex Kepekci
('111222333', 3, 'Pfizer', '2024-09-11', 1), # Spongebob Squarepants
('444555666', 1, 'Pfizer', '2024-05-20', 2), # Patrick Star
-- ('777888999', 1, 'AstraZeneca', '2024-06-25', 3), # Squidward Tentacles
('300000000', 2, 'AstraZeneca', '2024-05-01', 4), # Youssef Yacoub
('100000000', 2, 'Moderna', '2024-06-06', 5), # Gabriel D'Alesio
('6', 2, 'Moderna', '2024-01-06', 6), # Gabriel D'Alesio
('7', 2, 'Moderna', '2024-01-06', 6), # Gabriel D'Alesio
('8', 2, 'Moderna', '2024-01-06', 6), # Gabriel D'Alesio
('9', 2, 'Moderna', '2024-01-06', 6), # Gabriel D'Alesio
('10', 2, 'Moderna', '2024-01-06', 6), # Gabriel D'Alesio
('11', 2, 'Moderna', '2024-01-06', 6), # Gabriel D'Alesio
('000000002', 1, 'Johnson & Johnson', '2023-05-01', 5), # Theo Von
('555555555', 1, 'Johnson & Johnson', '2024-01-01', 5); # Theo Von

INSERT INTO Infected (person_sin, variantType, date) 
VALUES 
('123123123', 'SARS-Cov-2', '2022-07-01'), # Alex Kepekci
('123123123', 'COVID-19', '2022-12-05'), # Alex Kepekci
('123123123', 'Omicron', '2023-1-06'), # Alex Kepekci
('111222333', 'Omicron', '2023-01-01'), # Spongebob Squarepants
('444555666', 'COVID-19', '2022-08-15'), # Patrick Star
-- ('777888999', 'Alpha', '2022-09-30'), # Squidward Tentacles
-- ('777888999', 'COVID-19', '2022-10-30'), # Squidward Tentacles
-- ('777888999', 'Omicron', '2024-04-3'), # Squidward Tentacles
-- ('777888999', 'Omicron', '2023-01-30'), # Squidward Tentacles
('123456789', 'COVID-19', '2023-12-05'), # Sandy Cheeks
('000000001', 'Omicron', '2024-04-3'), # Infected Dude
('100000000', 'Alpha', '2024-04-3'), # Gabriel D'Alesio
('200000000', 'COVID-19', '2022-05-01'), # Leo Brodeur
('200000000', 'COVID-19', '2023-01-01'), # Leo Brodeur
('200000000', 'SARS-Cov-2', '2023-03-01'), # Leo Brodeur
('200000000', 'Alpha', '2023-05-01'), # Leo Brodeur
('300000000', 'SARS-Cov-2', '2024-03-01'), # Leo Brodeur
('987654321', 'Alpha', '2024-03-01'),
('987654321', 'COVID-19', '2023-01-23'),
('111111111', 'COVID-19', '2024-04-3'),
('222222222', 'COVID-19', '2024-04-3'),
('333333333', 'COVID-19', '2024-04-3'),
('444444444', 'COVID-19', '2024-04-04'),
('555555555', 'Alpha', '2024-04-04'); # Leo Brodeur


INSERT INTO Shift (start, end, sid)
VALUES
('2024-04-01 08:00:00', '2024-04-01 16:00:00', 16),
 ('2024-04-02 08:00:00', '2024-04-02 16:00:00', 17),
 ('2024-04-01 08:00:00', '2024-04-01 16:00:00', 18), -- Shift 1
('2024-04-02 08:00:00', '2024-04-02 16:00:00', 19), -- Shift 2
 ('2024-04-04 08:00:00', '2024-04-04 16:00:00', 20), -- Shift 4
 ('2024-04-05 08:00:00', '2024-04-05 16:00:00', 21); -- Shift 5
 








INSERT INTO Secondary (rid, sin)
VALUES 
    (101, '111111111'),
    (102, '222222222'),
    (103, '333333333'),
    (104, '444444444'),
    (1, '111111111'),
    (2, '222222222'),
    (3, '333333333'),
    (4, '444444444'),
    (2, '111111111'),
    (3, '111111111'),
    (4, '222222222'),
    (1, '222222222'),
    (101, '6'),
      (1, '6'),
    (2, '6'),
    (3, '7'),
    (4, '7'),
    (2, '7'),
    (3, '8'),
    (4, '8'),
    (1, '8'),
    (101, '9'),
    (1, '9'),
      (2, '9'),
    (2, '10'),
    (3, '10'),
    (4, '11'),
    (4, '10'),
    (3, '11'),
    (5, '11');
