--Kolik prodejů se uskutečnilo v dubnu 2014?
SELECT Count(ProductID) /*součet ProductID*/
FROM
Sales
WHERE
MONTH(Date) = 04 AND
YEAR(Date) = 2014

--Vypište všechny Bostony v USA. Kolik jich je?
SELECT *
FROM Country
WHERE City LIKE N'Boston, %'

--Na kterém ZIP kódu jsme vydělali nejvíc v dubnu 2014?
SELECT TOP 1 WITH TIES 
Zip, Sum(Revenue) as pocet /*součet tržeb = sum(revenue)*/
FROM
Sales
WHERE
MONTH(Date) = 04 AND
YEAR(Date) = 2014
GROUP BY
Zip
ORDER BY
pocet Desc

--Která kategorie obsahuje nejvíce segmentů?
SELECT TOP 1 WITH TIES /*vypiš 1. v pořadí a pokud na dalších řádcích budou stejné hodnoty, tak ty taky*/
Category, Count(Segment) as segment
FROM
Product
GROUP BY
Category
ORDER BY
segment desc

--Který stát má nejméně měst
Select TOP 1 WITH TIES
    State, COUNT(DISTINCT(City)) as mesta
FROM 
    Country
Group BY
    State
Order BY
    mesta asc

--Jaký název města se objevuje v nejvíce státech?
SELECT
    LEFT(City, CHARINDEX(N',', City) -1) AS City, /*umožňuje najít v řetězci nějaký znak*/
    COUNT(Distinct State) as States
FROM
    Country
GROUP BY
LEFT(City, CHARINDEX(N',', City) -1)
Order BY
States desc

SELECT
    PATINDEX(N'%north%', City)/*vypíše číslo, na které pozici se nachází n ve slově north*/, *
FROM
    Country
WHERE
    PATINDEX(N'%north%', City) > 0 /*Hledání ne jen znaku, ale vzorce, tady north*/

--Spoj tabulky Sales a Contry a vypiš všechny sloupce s tabulky Sales a sloupec State z tabulky Country.
--Spojuje se přes ZIP
SELECT TOP 100
s.*,
c. State
FROM
Sales s /*Alias Sales bude s a nemusím tam ani psát AS*/
JOIN Country c ON s.Zip = c.Zip

SELECT TOP 100
*
FROM
Sales s
JOIN Product p ON s. ProductID = p.ProductID

---Ve kterých státech jsme vydělali nejvíc?
SELECT TOP 1 WITH TIES
c.State, SUM(s.revenue) as StateRevenue
FROM
Sales s 
JOIN Country c ON s.Zip = c.Zip /*správně se má psát INNER JOIN, pokud je tam jen JOIN, pak to SQL bere i tak jako INNER*/
Group BY
c.State
Order BY
StateRevenue desc


--Kterého výrobku se prodalo nejvíc kusů? Důležitá slova výrobek a prodalo = Product a Sales
SELECT TOP 1 WITH TIES
p.Product, SUM(s.Units) as KS
FROM
Sales s 
JOIN Product p ON s.ProductID = p.ProductID 
Group BY
p.Product
Order BY
KS desc

--Který výrobce vyrábí nejvíce výrobků?
SELECT
m.Manufacturer, Count(DISTINCT p.Product) as produkty
FROM
    Manufacturer m
JOIN Product p ON m.ManufacturerID = p.ManufacturerID
Group BY
m.Manufacturer
Order BY
produkty desc

--Který výrobce působí v nejvíce segmentech?
SELECT TOP 1 WITH TIES
m.Manufacturer, Count(DISTINCT p.Segment) as Segment
FROM
    Manufacturer m
JOIN Product p ON m.ManufacturerID = p.ManufacturerID
Group BY
m.Manufacturer
Order BY
Segment desc

--Které státy nám nejvíc vydělávají v různých kategoriích?
--Který stát vydělává nejvíc v kategorii Mix?


SELECT 
c.state, p.Category, sum(s.revenue) as Trzby
FROM
    Sales s
JOIN Product p ON s.ProductID = p.ProductID
JOIN COUNTRY c ON s.Zip = c.Zip
WHERE
p.Category = 'Mix'
Group BY
c.state, p.Category
Order BY
Category, /*nejdřív to řadí podle kategorie, pak podle Tržeb*/
Trzby desc

--Ve které kategorii jsou nejvyšší tržby v Kalifornii?
SELECT 
c.state, p.Category, sum(s.revenue) as Trzby
FROM
    Sales s
JOIN Product p ON s.ProductID = p.ProductID
JOIN COUNTRY c ON s.Zip = c.Zip
WHERE
c.state LIKE 'CA'
Group BY
c.state, p.Category
Order BY
Trzby desc

--Který výrobek se prodává v nejvíce státech? 
--- Potřebuju spojit tabulky Product a Country, ale ty nemají společný znak,
--- tak musím přidat tabulku Sales, abych tyto dvě tabulky spojila
SELECT TOP 1 WITH TIES
p.Product, COUNT(DISTINCT State) AS States
FROM
    Sales s
JOIN Product p ON s.ProductID = p.ProductID
JOIN COUNTRY c ON s.Zip = c.Zip
Group BY
p.Product
Order BY
States desc