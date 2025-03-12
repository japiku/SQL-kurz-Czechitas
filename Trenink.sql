--Ve kterém regionu jsme v červenci 2014 vydělali nejvíc? Region, datum, sales
SELECT TOP 1 WITH TIES
    c.Region, sum(s.Revenue) as total_revenue
FROM
    Country c
    JOIN Sales s ON c.Zip = s.ZIP 
WHERE
    MONTH(Date) = 07 AND
    YEAR(DATE) = 2014
GROUP BY
    c.Region
ORDER BY
    total_revenue DESC

--Který výrobce prodal nejvíce kusů výrobků řady UM? Výrobce, Ks výrobků, řada
SELECT
    m.Manufacturer, SUM(s.Units) as total_units
FROM
    Manufacturer m
    JOIN Product p ON m.ManufacturerID = p.ManufacturerID
    JOIN Sales s ON p.ProductID = s.ProductID
WHERE
    p.PRODUCT LIKE N'% UM-%'
GROUP BY
    m.Manufacturer
ORDER BY
    total_units DESC

--Které státy vydělaly nejvíce v kategorii Urban? Státy, vydělali, kategorie
SELECT
    c.State, SUM(s.Revenue) as Total_revenue
FROM
    Country c
    JOIN Sales s ON c.Zip = s.Zip
    JOIN Product p ON s.ProductID = p.ProductID
WHERE
    p.Category = 'Urban'
GROUP BY
    c.[State]
ORDER BY
    Total_revenue DESC

--Ve kterém městě vydělala společnost Abbas nejvíce v segmentu Youth? Město, společnost, segment, vydělala
SELECT TOP 1 WITH TIES
c.City, SUM(s.Revenue) as Total_revenue
FROM
Country c
JOIN Sales s ON c.Zip=s.Zip
JOIN Product p ON s.ProductID=p.ProductID
JOIN Manufacturer m ON p.ManufacturerID=p.ManufacturerID
WHERE
m.Manufacturer = N'Abbas' AND p.Segment = N'Youth'
GROUP BY
c.City
ORDER BY
Total_revenue DESC

SELECT
    c1.State,
    c1.Zip,
    c1.City
FROM
    Country c1
    LEFT JOIN Country c2 ON c1.State = c2.State AND c2.Zip > c1.Zip
WHERE
    c2.Zip IS NULL
ORDER BY
    c1.State


SELECT TOP 20
*
FROM
Product