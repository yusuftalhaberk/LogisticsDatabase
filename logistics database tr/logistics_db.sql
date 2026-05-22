create database logistics_db;
use logistics_db;

CREATE TABLE Gorevler (
    GorevID INT AUTO_INCREMENT PRIMARY KEY,
    Sirket VARCHAR(50),
    Yuk VARCHAR(50),
    DorseTuru VARCHAR(100),
    KutleTon INT
);

CREATE TABLE Dorseler (
    DorseID INT AUTO_INCREMENT PRIMARY KEY,
    DorseTuru VARCHAR(100),
    TirID INT,
    SoforID INT,
    GarajID INT,
    GorevID INT
);

CREATE TABLE TIRLAR (
    TirID INT AUTO_INCREMENT PRIMARY KEY,
    MarkaModel VARCHAR(50),
    MotorBG INT,
    KatedilenMesafeKM INT,
    SoforID INT,
    DorseID INT,
    GarajID INT
);

CREATE TABLE SOFORLER (
    SoforID INT AUTO_INCREMENT PRIMARY KEY,
    SoforIsmi VARCHAR(50),
    TirID INT,
    DorseID INT,
    GorevID INT,
    KatedilenMesafeKM DECIMAL(10,3),
    Rutbe VARCHAR(20) AS(
    CASE
		WHEN KatedilenMesafeKM>=0 AND KatedilenMesafeKM<50000 THEN "Acemi"
		WHEN KatedilenMesafeKM>=50000 AND KatedilenMesafeKM<100000 THEN "Çırak"
		WHEN KatedilenMesafeKM>=100000 AND KatedilenMesafeKM<150000 THEN "Vasıflı"
		WHEN KatedilenMesafeKM>=150000 AND KatedilenMesafeKM<200000 THEN "Kalfa"
		WHEN KatedilenMesafeKM>=0 AND KatedilenMesafeKM<250000 THEN "Usta"
		WHEN KatedilenMesafeKM>=250000 THEN "Duayen"
	END
    ),
    UcretKM_EURO INT AS(
    CASE
		WHEN KatedilenMesafeKM>=0 AND KatedilenMesafeKM<50000 THEN 20
		WHEN KatedilenMesafeKM>=50000 AND KatedilenMesafeKM<100000 THEN 30
		WHEN KatedilenMesafeKM>=100000 AND KatedilenMesafeKM<150000 THEN 40
		WHEN KatedilenMesafeKM>=150000 AND KatedilenMesafeKM<200000 THEN 50
		WHEN KatedilenMesafeKM>=0 AND KatedilenMesafeKM<250000 THEN 60
		WHEN KatedilenMesafeKM>=250000 THEN 70
	END
    ),
    KatilimTarihi DATE
);

CREATE TABLE Garajlar (
    GarajID INT AUTO_INCREMENT PRIMARY KEY,
    Sehir VARCHAR(50),
    Boyut VARCHAR(20)
);

CREATE VIEW GarajDurum AS
SELECT 
    G.GarajID,
    G.Sehir,
    COUNT(DISTINCT T.TirID) AS TirSayisi,
    COUNT(DISTINCT D.DorseID) AS DorseSayisi
FROM Garajlar G
LEFT JOIN TIRLAR T ON G.GarajID = T.GarajID
LEFT JOIN DORSELER D ON G.GarajID = D.GarajID
GROUP BY G.GarajID, G.Sehir;


INSERT INTO Garajlar (Sehir, Boyut) VALUES
('Lyon', 'Büyük'),
('Carlisle', 'Büyük'),
('Rotterdam', 'Büyük'),
('Graz', 'Büyük'),
('Plymouth', 'Küçük');

INSERT INTO Gorevler (Sirket, Yuk, DorseTuru, KutleTon) VALUES
('ACI SRL', 'İşlemci', 'Perdeli', 3),
('EuroGoodies', 'Tıbbi Ekipman', 'Perdeli', 8),
('ACI SRL', 'Uçak Lastiği', 'Perdeli', 10),
('EuroGoodies', 'Sığır Eti', 'Frigorifik', 21),
('RT Log', 'Süt', 'Frigorifik', 23),
('ACI SRL', 'Yoğurt', 'Frigorifik', 17),
('EuroGoodies', 'Armut', 'Frigorifik', 15),
('Stokes', 'Madeni Yağ', 'Gıda Tankı', 24),
('Stokes', 'Akaryakıt', 'Gıda Tankı', 23),
('RT Log', 'Meyve Suyu Konsantresi', 'Gıda Tankı', 27),
('AI Automotive', 'Egzoz Sistemi', 'Konteyner Taşıyıcısı', 7),
('AI Automotive', 'Kullanılmış Plastik', 'Konteyner Taşıyıcısı', 7),
('Kathode', 'Havalandırma Ünitesi', 'Low Loader', 18),
('Kathode', 'Forklift', 'Low Loader', 16),
('FLE', 'Boş Makara', 'Çelik Tabanlı Tomruk Dorsesi', 1),
('FLE', 'Zeytin Ağacı', 'Çelik Tabanlı Tomruk Dorsesi', 2),
('RT Log', 'Akçaağaç Şurubu', 'Kuru Yük', 17),
('RT Log', 'Borik Asit', 'Kuru Yük', 16),
('EuroGoodies', 'Akçaağaç Şurubu', 'Kuru Yük', 17),
('Stokes', 'Fesleğen', 'Kuru Yük', 15);

INSERT INTO TIRLAR (MarkaModel, MotorBG, KatedilenMesafeKM, SoforID, DorseID, GarajID) VALUES
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

INSERT INTO SOFORLER (SoforIsmi, TirID, DorseID, GorevID, KatedilenMesafeKM, KatilimTarihi) 
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

INSERT INTO Dorseler (DorseTuru, TirID, SoforID, GarajID, GorevID) VALUES
('Perdeli', 7, 20, 1, 3),
('Frigorifik, Hareketli Zeminli', 12, 21, 3, 5),
('Gıda Tankı, Boyalı', 18, 3, 3, 8),
('Low Loader', null, null, 1, NULL),
('Çelik Tabanlı Tomruk Dorsesi', 3, 8, 1, 16),
('Perdeli', 1, 5, 2, 2),
('Konteyner Taşıyıcısı B-Double', 5, 1, 2, 11),
('Low Bed', 25, 10, 4, 13),
('Gıda Tankı, Boyalı', 20, 16, 3, 9),
('Perdeli', 17, 9, 2, 1),
('Çelik Tabanlı Tomruk Dorsesi', 22, 3, 3, 15),
('Ahşap Tabanlı Tomruk Dorsesi B-Double', 9, 11, 1, 15),
('Vinçli Açık Kasa', NULL, NULL, 5, NULL),
('Gıda Tankı, Boyalı', 6, 17, 4, 9),
('Gıda Tankı, Boyalı', 21, 2, 4, 10),
('Low Loader', 19, 14, 5, 14),
('Frigorifik, Yan Kapılı B-Double', 15, 23, 3, 6),
('Kuru Yük, Hareketli Zeminli', 8, 4, 2, 17),
('Kuru Yük, Hareketli Zeminli', 4, 18, 1, 12),
('Frigorifik, Hareketli Zeminli', 14, 19, 1, 7),
('Frigorifik, Yan Kapılı B-Double', 13, 6, 3, 4),
('Kuru Yük, Hareketli Zeminli', 24, 7, 5, 20),
('Low Loader', 11, 12, 5, 10),
('Gıda Tankı, Boyalı', 23, 24, 3, 13),
('Gıda Tankı, Boyalı', 2, 13, 4, 10);

ALTER TABLE Dorseler
    ADD FOREIGN KEY (TirID) REFERENCES TIRLAR(TirID),
    ADD FOREIGN KEY (SoforID) REFERENCES SOFORLER(SoforID),
    ADD FOREIGN KEY (GarajID) REFERENCES Garajlar(GarajID),
    ADD FOREIGN KEY (GorevID) REFERENCES Gorevler(GorevID);

ALTER TABLE TIRLAR
    ADD FOREIGN KEY (SoforID) REFERENCES SOFORLER(SoforID),
    ADD FOREIGN KEY (DorseID) REFERENCES Dorseler(DorseID),
    ADD FOREIGN KEY (GarajID) REFERENCES Garajlar(GarajID);

ALTER TABLE SOFORLER
    ADD FOREIGN KEY (TirID) REFERENCES TIRLAR(TirID),
    ADD FOREIGN KEY (DorseID) REFERENCES Dorseler(DorseID),
    ADD FOREIGN KEY (GorevID) REFERENCES Gorevler(GorevID);
