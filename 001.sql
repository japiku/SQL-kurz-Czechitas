
--Ve kterém regionu jsme vydělali nejvíce?
SELECT 
    c.Region, 
    sum(Revenue) as Sum_revenue
FROM 
    Country c
    JOIN Sales s ON s.Zip = c.Zip
GROUP BY
    c.Region
ORDER BY
    Sum_revenue DESC

--Který výrobce nám vydělal nejvíc celkem?
SELECT 
    m.Manufacturer, 
    sum(Revenue) as Sum_revenue
FROM 
    Manufacturer m
    JOIN Product p ON m.ManufacturerID = p.ManufacturerID
    JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY
    m.Manufacturer
ORDER BY
    Sum_revenue DESC

--Kteří výrobci nám vydělali nejvíce v jednotlivých státech?
SELECT 
    m.Manufacturer, c.State,
    sum(Revenue) as Sum_revenue
FROM 
    Manufacturer m
    JOIN Product p ON m.ManufacturerID = p.ManufacturerID
    JOIN Sales s ON p.ProductID = s.ProductID
    JOIN Country c ON s.Zip = c.Zip
GROUP BY
    c.State, m.Manufacturer
ORDER BY
    c.State, Sum_revenue DESC
--Kdo vydělal nejvíc v Texasu?
SELECT 
    m.Manufacturer, 
    c.State,
    sum(Revenue) as Sum_revenue
FROM 
    Manufacturer m
    JOIN Product p ON m.ManufacturerID = p.ManufacturerID
    JOIN Sales s ON p.ProductID = s.ProductID
    JOIN Country c ON s.Zip = c.Zip
WHERE
   c.State LIKE N'%TX%' /*musí tady být like, když tam mám regex*/
--c.State = N'TX' /*jiná varianta, u rovná se nemůže být regex, protože hledá přesnou shodu*/
GROUP BY
    c.State, m.Manufacturer
--HAVING
    --c.State = N'TX' /*místo podmínky WHERE můžu použít HAVING*/
ORDER BY
    c.State, Sum_revenue DESC

--Kolik bylo v jednotlivých kategoiích výrobků, které jsme v lednu 2014 neprodali?
SELECT 
    p.Category,
    COUNT(DISTINCT p.ProductID)
FROM 
    Product p 
    LEFT JOIN Sales s ON p.ProductID = s.ProductID AND YEAR(s.Date) = 2014 AND MONTH(s.Date) = 01
WHERE
    s.ProductID is NULL
GROUP BY
    p.Category

--Kolik je v Texasu měst pouze s jedním Zip kódem?
SELECT
    City
FROM
    Country
WHERE
    State = N'TX'
GROUP BY
    City
Having 
    COUNT(ZIP) = 1
----jiné řešení
SELECT
    *
FROM
    Country c1
    LEFT JOIN Country c2 ON c1.City = c2.City AND c1.Zip != c2.Zip
WHERE
    c1.State = N'TX' AND
    c2.Zip IS NULL

SELECT TOP 1 WITH TIES
Manufacturer, SUM(TotalRevenue) as Total_revenue
FROM
StateManufacturerView
GROUP BY
Manufacturer
ORDER BY
Total_revenue desc

--Který stát nám vydělává nejvíc?
SELECT
    State, SUM(TotalRevenue) as total
FROM
    StateManufacturerView
GROUP BY    
    State
ORDER BY
    total DESC

--Ve kterých státech vydělali jednotliví výrobci nejvíc?
SELECT
    *
FROM
    StateManufacturerView smv1
    LEFT JOIN StateManufacturerView smv2 ON smv1.Manufacturer = smv2.Manufacturer AND smv2.TotalRevenue > smv1.TotalRevenue
WHERE
    smv2.State is NULL


DECLARE @cisla AS TABLE ([skupina] char, [cislo] int)
INSERT INTO
    @cisla ([skupina], [cislo])
VALUES
    ('A', 4),
    ('A', 7),
    ('A', 1),
    ('A', 3),
    ('A', 8),
    ('B', 5),
    ('B', 12),
    ('C', 1)

SELECT
    * 
FROM 
    @cisla c1
    LEFT JOIN @cisla c2 ON c1.skupina = c2.skupina AND c2.cislo > c1.cislo
WHERE
    c2.cislo IS NULL