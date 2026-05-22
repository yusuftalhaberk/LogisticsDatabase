-- Example Queries
SELECT * FROM Drivers;

SELECT * FROM Drivers ORDER BY DistanceKM DESC;

-- Drivers with their truck and task information
SELECT 
    D.DriverName,
    T.BrandModel,
    Tk.Cargo,
    Tk.MassTon,
    Tk.Company
FROM Drivers D
JOIN Trucks T ON D.TruckID = T.TruckID
JOIN Tasks Tk ON D.TaskID = Tk.TaskID;

-- Total task tonnage per company (Descending)
SELECT 
    Company,
    SUM(MassTon) AS TotalTonnage
FROM Tasks
GROUP BY Company
ORDER BY TotalTonnage DESC;
