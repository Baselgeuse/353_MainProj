-- 1. CheckOverlapTime: Prevents an employee from being registered at a facility if they are already registered

INSERT INTO Schedule (sid,employee_sin, fid, start_date, end_date) 
VALUES 
-- (21,'11', 6, '2024-01-05', NULL) exists in database, the employee is registered and will be blocked
(23,'11', 6, '2024-01-06', NULL); 

-- 2. CheckVaccinated: Makes sure employees have been vaccinated within the past 6 months before being given a shift

INSERT INTO Shift (start, end, sid)
VALUES
-- No vaccinations on employee 777888999 in last 6 months
-- (4,'777888999', 3, '2023-12-12', NULL), Schedule number 4 for employee 777888999
('2024-04-01 08:00:00', '2024-04-01 16:00:00', 4);

-- 3. CheckTwoHourBreak: Makes sure employees have had at least 2 hours between shifts regardless 
-- of their facility, this also prevents a shift from starting before the end of a previous one

	-- example 1, no 2 hour break
	INSERT INTO Shift (start, end, sid)
	VALUES
	-- ('2024-04-01 08:00:00', '2024-04-01 16:00:00', 16) schedule 16 and 22 are for employee 6
	-- Insert value is only after 1 hour between both facilities
	('2024-04-01 17:00:00', '2024-04-01 20:00:00', 22);

	-- example 2, starts before previous ends
	INSERT INTO Shift (start, end, sid)
	VALUES
	-- ('2024-04-01 08:00:00', '2024-04-01 16:00:00', 16) schedule 16 and 22 are for employee 6
	-- Insert value is only after 1 hour between both facilities
	('2024-04-01 14:00:00', '2024-04-01 20:00:00', 22);

-- 4. CheckInfected: Checks if an employee is infected before giving him a shift

INSERT INTO Shift (start, end, sid)
VALUES
-- ('555555555', 'Alpha', '2024-04-04'); Infected employee 55555555
-- Inserting shift at its schedule "14"
('2024-04-05 08:00:00', '2024-04-05 16:00:00', 14);

-- 6. Start before end: prevents a shift from lasting a negative amount of time
INSERT INTO Shift (start, end, sid)
VALUES
('2024-04-05 10:00:00', '2024-04-05 9:00:00', 21);

