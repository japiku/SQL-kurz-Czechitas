--Která města začínají písmenem X
SELECT 
    Distinct(City)
FROM
    Country
WHERE 
    City LIKE 'X%'

---Kterým písmenem začíná nejvíce měst?
SELECT 
    LEFT(City, 1)  AS mesto, 
    COUNT(City) AS mesto_soucet,
    COUNT(DISTINCT(City)) AS mesto_soucet_jedinecny
FROM
    Country
GROUP BY
    LEFT(City, 1) /*Vem zleva první písmeno z kategorie City - toto se musí promítnout i do selectu*/
ORDER BY
    mesto_soucet DESC

---Kolik se prodalu kusů výrobku řady UM-01?
SELECT sum(units)
FROM Product p
JOIN Sales s ON p.ProductID = s.ProductID
Where p.Product Like '% UM-01'

---Kolik jsme vydělali v jednotlivých regionech?
SELECT sum(s.revenue) as trzby, c.region
FROM Country c
JOIN Sales s ON c.Zip = s.Zip
Group by 
c.region
Order BY
trzby DESC

---Který výrobce prodává v nejméně státech? Manufacturer, Sales, Country
SELECT Count(DISTINCT c.State) as Zeme, m.Manufacturer
FROM Country c
JOIN Sales s ON c.Zip = s. Zip
JOIN Product p ON s.ProductID = p.ProductID
JOIN Manufacturer m ON p.ManufacturerID = m.ManufacturerID
GROUP BY
m.Manufacturer
Order BY
Zeme DESC

---------------
---LEFT JOIN---Abych mohla hledat NULL hodnoty v druhé tabulce.
---------------

---Které výrobky se neprodávaly?
SELECT
    *
FROM
    Product p
    LEFT JOIN Sales s ON s.ProductID = p.ProductID
WHERE
    s.ProductID IS NULL

---Kteří výrobci nemají výrobky v kategorii Rural?
SELECT
*
FROM
    Manufacturer m
    LEFT JOIN Product p ON m.ManufacturerID = p.ManufacturerID AND p.Category = N'Rural' /*vem tabulku Manufacturer
    a propoj ji s tabulkou Product na základě klíče Manufacturer ID, tam kde v tabulce Product není hodnota pro ManufactureID
    v tabulce Manufacturer, tam dej NULL - zároveň ale vem jen ty řádky, kde je v kategorii Rural*/
WHERE
    p.ManufacturerID is NULL

---Vypište pro všechny státy město s nejvyšším Zip kódem---
SELECT
    *
FROM    
    Country c1
    LEFT JOIN COuntry c2 ON c1.State = c2.State AND c2.Zip > c1.Zip /*z tabulky c2 vem větší zip kód než v tabulce c1*/
WHERE
    c2.Zip IS NULL

---Které výrobky se neprodávaly před rokem 2014?
SELECT
    *
FROM
    Product p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID AND YEAR(s.Date) < 2014
WHERE
    s.ProductID IS NULL
