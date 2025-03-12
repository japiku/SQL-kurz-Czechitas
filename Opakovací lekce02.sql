--Která města mají v názvu "aa"
SELECT DISTINCT
City
FROM
Country
WHERE
City LIKE N'%aa%'

--Která města začínají na "new"
SELECT
Count(DISTINCT City)
--to co chci mít distinkt, tak je hned za distinct
--když dám SELECT DISTINCT City, tak to vezme jedinečná města, pokud mezi to vložím Count, tak to nebude fungovat
FROM
Country
WHERE
City LIKE N'New %'

--Kolik jsme vydělali v 45. týdnu roku 2014?
SELECT
Sum(Revenue)
FROM
Sales
WHERE
DATEPART(WEEK, DATE) = 45 AND YEAR(Date) = 2014
    --DATEPART - pracuje s datem - první hodnota v závorce je, co chceme "hledat", druhá hodnota, odkud tu informaci vezmeme

--Ve kterém regionu je nejvíce států? nejvíce==with ties!!!
SELECT TOP 1 WITH TIES
    Region, COUNT(Distinct State) as StateCount
FROM
    Country
Group BY
    Region
Order BY
    StateCount DESC

--Vypiš prodeje s nejnižší tržbout
SELECT TOP 1 WITH TIES
*
FROM
Sales
WHERE
Revenue IS NOT NULL
ORDER BY
Revenue

SELECT TOP 1 WITH TIES
*, ISNULL(Revenue, -100)
FROM
Sales
ORDER BY
ISNULL(Revenue,0) --nahradí hodnotu NULL za hodnotu O

--Který produkt ProductID má nejvyšší průměrný počet kusů v rámci jednoho prodeje
--pokud uvažujeme jen faktury s částkou vyšší než 10 000?

SELECT
    ProductID, AVG(Units) as AVGUnits
FROM
    Sales
WHERE
    Revenue > 10000
GROUP BY
    ProductID
ORDER BY
    AVGUnits DESC

--Ve kterých letech jsme na Floridě vydělali přes 10 M?
SELECT
YEAR(s.Date), Sum(s.Revenue) as TotalRevenue
FROM
Country c
JOIN Sales s ON c.ZIP = s.Zip
WHERE
c.State = N'FL'
GROUP BY
YEAR(Date)
Having
    SUM(Revenue) > 10000000
    --musí tady být having a ne where podmínku, protože where podmínka řeší po řádcích a my chceme celou tabulku
    --v having ani group by nemůže být alias, protože je SQL ještě nezná, když se vyhodnocují


--Které výrobky se nikdy neprodaly?
SELECT
Count(DISTINCT p.ProductID) as Products, S.Units
FROM
Product p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE
s.Units is NULL
GROUP BY
s.Units
ORDER BY
Products

--Kolik kusů výrobků UM se porodalo v roce 2013? ==výsledek 113 131
SELECT
SUM(Units)
FROM
Sales S
JOIN Product p ON s.ProductID = p.ProductID
WHERE
p.Product LIKE N'%UM-%' AND YEAR(s.Date) = 2013

--Ve kterém státě se prodalo nejvíce výrobků? Country, Product, Sales
SELECT top 1 with ties
c.State, Sum(s.Units) as SumUnits
FROM
Sales s
JOIN Country c ON s.Zip = c.Zip
Group BY
c.[State]
Order BY
SumUnits Desc

--Ve kterém státě se prodalo nejvíce RŮZNÝCH výrobků? Country, Sales
SELECT top 1 with ties
c.State, Sum(s.Units) as SumUnits
FROM
Sales s
JOIN Country c ON s.Zip = c.Zip
Group BY
c.[State]
Order BY
SumUnits Desc

--
