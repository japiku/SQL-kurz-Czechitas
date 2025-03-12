SELECT
    *
FROM
    Country c
    LEFT JOIN Sales s ON c.Zip = s.Zip AND City LIKE N'U%'

SELECT
    *
FROM
    Country c
    LEFT JOIN Sales s ON c.Zip = s.Zip
WHERE
    c.City LIKE N'U%'

SELECT
    -- COUNT(*)
    *
FROM
    Country c
    LEFT JOIN Sales s ON c.Zip = s.Zip AND City LIKE N'U%'
WHERE
    s.Zip is NULL


--Kolik mají jednotliví výrobci produktů v jednotlivých kategoriích?
--Manufacturer, Product
SELECT
m.Manufacturer, p.Category, Count(ProductID) as Products
FROM
Manufacturer M
JOIN Product p ON m.ManufacturerID = p.ManufacturerID
GROUP BY
m.Manufacturer, p.Category

--Vytvořte z předchozího dotazu pohled
CREATE VIEW ManufacturerCategoryProduct AS
(
SELECT
m.Manufacturer, p.Category, Count(ProductID) as Products
FROM
Manufacturer M
JOIN Product p ON m.ManufacturerID = p.ManufacturerID
GROUP BY
m.Manufacturer, p.Category
)

SELECT
DATEPART(DAY, Date), Revenue
FROM
Sales
