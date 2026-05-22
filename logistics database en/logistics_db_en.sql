CREATE DATABASE IF NOT EXISTS logistics_db_en;
USE logistics_db_en;

CREATE TABLE Tasks (
    TaskID INT AUTO_INCREMENT PRIMARY KEY,
    Company VARCHAR(50),
    Cargo VARCHAR(50),
    TrailerType VARCHAR(100),
    MassTon INT
);

CREATE TABLE Trailers (
    TrailerID INT AUTO_INCREMENT PRIMARY KEY,
    TrailerType VARCHAR(100),
    TruckID INT,
    DriverID INT,
    GarageID INT,
    TaskID INT
);

CREATE TABLE Trucks (
    TruckID INT AUTO_INCREMENT PRIMARY KEY,
    BrandModel VARCHAR(50),
    EngineHP INT,
    DistanceKM INT,
    DriverID INT,
    TrailerID INT,
    GarageID INT
);

CREATE TABLE Drivers (
    DriverID INT AUTO_INCREMENT PRIMARY KEY,
    DriverName VARCHAR(50),
    TruckID INT,
    TrailerID INT,
    TaskID INT,
    DistanceKM DECIMAL(10,3),
    `Rank` VARCHAR(20) AS(
        CASE
            WHEN DistanceKM>=0 AND DistanceKM<50000 THEN "Beginner"
            WHEN DistanceKM>=50000 AND DistanceKM<100000 THEN "Apprentice"
            WHEN DistanceKM>=100000 AND DistanceKM<150000 THEN "Skilled"
            WHEN DistanceKM>=150000 AND DistanceKM<200000 THEN "Journeyman"
            WHEN DistanceKM>=200000 AND DistanceKM<250000 THEN "Master"
            WHEN DistanceKM>=250000 THEN "Veteran"
        END
    ),
    PayPerKM_EURO INT AS(
        CASE
            WHEN DistanceKM>=0 AND DistanceKM<50000 THEN 20
            WHEN DistanceKM>=50000 AND DistanceKM<100000 THEN 30
            WHEN DistanceKM>=100000 AND DistanceKM<150000 THEN 40
            WHEN DistanceKM>=150000 AND DistanceKM<200000 THEN 50
            WHEN DistanceKM>=200000 AND DistanceKM<250000 THEN 60
            WHEN DistanceKM>=250000 THEN 70
        END
    ),
    JoinDate DATE
);

CREATE TABLE Garages (
    GarageID INT AUTO_INCREMENT PRIMARY KEY,
    City VARCHAR(50),
    Size VARCHAR(20)
);

CREATE VIEW GarageStatus AS
SELECT 
    G.GarageID,
    G.City,
    COUNT(DISTINCT T.TruckID) AS TruckCount,
    COUNT(DISTINCT D.TrailerID) AS TrailerCount
FROM Garages G
LEFT JOIN Trucks T ON G.GarageID = T.GarageID
LEFT JOIN Trailers D ON G.GarageID = D.GarageID
GROUP BY G.GarageID, G.City;

INSERT INTO Garages (City, Size) VALUES
('Lyon', 'Large'),
('Carlisle', 'Large'),
('Rotterdam', 'Large'),
('Graz', 'Large'),
('Plymouth', 'Small');

INSERT INTO Tasks (Company, Cargo, TrailerType, MassTon) VALUES
('ACI SRL', 'Processor', 'Curtain-Sider', 3),
('EuroGoodies', 'Medical Equipment', 'Curtain-Sider', 8),
('ACI SRL', 'Aircraft Tire', 'Curtain-Sider', 10),
('EuroGoodies', 'Beef', 'Refrigerated', 21),
('RT Log', 'Milk', 'Refrigerated', 23),
('ACI SRL', 'Yogurt', 'Refrigerated', 17),
('EuroGoodies', 'Pear', 'Refrigerated', 15),
('Stokes', 'Lubricant Oil', 'Food Tank', 24),
('Stokes', 'Fuel', 'Food Tank', 23),
('RT Log', 'Fruit Juice Concentrate', 'Food Tank', 27),
('AI Automotive', 'Exhaust System', 'Container Carrier', 7),
('AI Automotive', 'Used Plastic', 'Container Carrier', 7),
('Kathode', 'Ventilation Unit', 'Low Loader', 18),
('Kathode', 'Forklift', 'Low Loader', 16),
('FLE', 'Empty Reel', 'Steel Log Trailer', 1),
('FLE', 'Olive Tree', 'Steel Log Trailer', 2),
('RT Log', 'Maple Syrup', 'Dry Cargo', 17),
('RT Log', 'Boric Acid', 'Dry Cargo', 16),
('EuroGoodies', 'Maple Syrup', 'Dry Cargo', 17),
('Stokes', 'Basil', 'Dry Cargo', 15);

INSERT INTO Trucks (BrandModel, EngineHP, DistanceKM, DriverID, TrailerID, GarageID) VALUES
('Mercedes New Actors', 625, 120207, 5, 6, 2),
('Volvo FH4', 750, 115759, 3, 25, 4),
('Renault Magnum', 520, 110040, 8, 5, 3),
('Iveco Hi-Way', 560, 102291, 18, 19, 1),
('Renault Magnum', 520, 92353, 1, 7, 2),
('Volvo FH4', 750, 81653, 17, 14, 4),
('Mercedes New Actors', 625, 79083, 20, 1, 1),
('Mercedes New Actors', 625, 76492, 4, 18, 2),
('Scania R', 730, 57551, 11, 12, 1),
('MAN TGX Euro 5', 680, 71085, NULL, NULL, 1),
('Mercedes New Actors', 625, 64343, 12, 23, 2),
('Mercedes New Actors', 625, 64063, 21, 2, 3),
('Mercedes New Actors', 625, 61142, 6, 21, 4),
('Volvo FH4', 750, 42042, 19, 20, 1),
('Volvo FH4', 750, 55904, 23, 17, 3),
('Volvo FH4', 750, 51671, NULL, NULL, 5),
('Mercedes New Actors', 625, 51981, 9, 10, 2),
('Mercedes New Actors', 625, 50380, 3, 3, 3),
('Volvo FH4', 750, 43912, 14, 16, 5),
('Volvo FH4', 750, 44215, 16, 4, 1),
('Scania S', 730, 10953, 2, 15, 2),
('Scania S', 730, 11809, 22, 11, 3),
('Scania S', 730, 11313, 24, 24, 5),
('Scania S', 730, 11337, 7, 22, 5),
('Scania Streamline', 730, 12375, 10, 8, 3);

INSERT INTO Drivers (DriverName, TruckID, TrailerID, TaskID, DistanceKM, JoinDate) 
VALUES
('John D.', 5, 7, 11, 245987, '2016-03-12'),
('Jacek V.', 21, 15, 10, 165589, '2017-07-25'),
('Julian C.', 18, 3, 8, 138964, '2018-11-14'),
('Sabrina C.', 8, 18, 17, 297780, '2015-02-05'),
('Elise V.', 1, 6, 2, 81789, '2021-09-19'),
('Flemming V.', 13, 21, 7, 117512, '2019-06-07'),
('Tim D.', 24, 22, 20, 209456, '2017-01-28'),
('Lucas P.', 3, 5, 16, 68068, '2022-10-03'),
('Pierre B.', 17, 10, 1, 305450, '2015-04-11'),
('Magnus M.', 25, 8, 13, 197169, '2018-08-22'),
('Jano K.', 9, 12, 15, 217753, '2017-12-09'),
('Cathy C.', 11, 23, 13, 50789, '2022-05-16'),
('Jack R.', 2, 25, 9, 70896, '2021-07-27'),
('Adam S.', 19, 16, 14, 167956, '2018-03-04'),
('Maja V.', NULL, NULL, NULL, 60861, '2021-09-30'),
('Arek L.', 20, 9, 9, 198943, '2018-02-12'),
('Marek T.', 6, 19, 9, 149785, '2019-06-21'),
('Etienne J.', 4, 19, 18, 94158, '2020-11-08'),
('Despot D.', 14, 20, 4, 420042, '2016-01-17'),
('Sophie I.', 7, 3, 3, 167354, '2019-07-29'),
('Linda V.', 12, 6, 5, 274856, '2016-07-02'),
('Daniel O.', 22, 11, 6, 45756, '2023-08-14'),
('Ethan C.', 15, 7, 10, 55289, '2020-10-05'),
('Mateusz U.', 23, 10, 6, 157789, '2019-12-19');

INSERT INTO Trailers (TrailerType, TruckID, DriverID, GarageID, TaskID) VALUES
('Curtain-Sider', 7, 20, 1, 3),
('Refrigerated, Moving Floor', 12, 21, 3, 5),
('Food Tank, Painted', 18, 3, 3, 8),
('Low Loader', NULL, NULL, 1, NULL),
('Steel Log Trailer', 3, 8, 1, 16),
('Curtain-Sider', 1, 5, 2, 2),
('Container Carrier B-Double', 5, 1, 2, 11),
('Low Bed', 25, 10, 4, 13),
('Food Tank, Painted', 20, 16, 3, 9),
('Curtain-Sider', 17, 9, 2, 1),
('Steel Log Trailer', 22, 3, 3, 15),
('Wood Log Trailer B-Double', 9, 11, 1, 15),
('Open Bed with Crane', NULL, NULL, 5, NULL),
('Food Tank, Painted', 6, 17, 4, 9),
('Food Tank, Painted', 21, 2, 4, 10),
('Low Loader', 19, 14, 5, 14),
('Refrigerated, Side Door B-Double', 15, 23, 3, 6),
('Dry Cargo, Moving Floor', 8, 4, 2, 17),
('Dry Cargo, Moving Floor', 4, 18, 1, 12),
('Refrigerated, Moving Floor', 14, 19, 1, 7),
('Refrigerated, Side Door B-Double', 13, 6, 3, 4),
('Dry Cargo, Moving Floor', 24, 7, 5, 20),
('Low Loader', 11, 12, 5, 10),
('Food Tank, Painted', 23, 24, 3, 13),
('Food Tank, Painted', 2, 13, 4, 10);

ALTER TABLE Trailers
    ADD FOREIGN KEY (TruckID) REFERENCES Trucks(TruckID),
    ADD FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    ADD FOREIGN KEY (GarageID) REFERENCES Garages(GarageID),
    ADD FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID);

ALTER TABLE Trucks
    ADD FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    ADD FOREIGN KEY (TrailerID) REFERENCES Trailers(TrailerID),
    ADD FOREIGN KEY (GarageID) REFERENCES Garages(GarageID);

ALTER TABLE Drivers
    ADD FOREIGN KEY (TruckID) REFERENCES Trucks(TruckID),
    ADD FOREIGN KEY (TrailerID) REFERENCES Trailers(TrailerID),
    ADD FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID);
    

