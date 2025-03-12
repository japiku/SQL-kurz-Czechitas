--Vypiště posledních 20 prodejů (podle data)
SELECT *
FROM Sales
Order BY
date DESC
--Vypište prvních 100 výrobků, který začínají písmenem F
Select TOP 100 /*Když je TOP, tak musí být Order By, protože jinak je nejisté, podle čeho to řadí*/
    *
FROM 
    Product
WHERE 
    Product LIKE N'F%'
ORDER BY
    Product ASC

--Kolik výrobků vyrábí společnost Abbas?
SELECT
    Count(*)
FROM
    Product
WHERE
    PRODUCT Like N'Abbas%'
    --LEFT (Product, 5) = N'Abbas' /*LEFT - počítá znaky zleva, 5 je tam proto, že abbas má pět znaků*%

--Vypiště všechna města státu New Hampshire (NH)
SELECT
    Count (DISTINCT City)
FROM
    Country
WHERE
    State Like N'NH'

--Kolik ZIP kódů má stát Florida (FL)?
SELECT
    Count (Zip)
FROM
    Country
WHERE
  STATE =  N'FL'

--Kolik prodejů proběhlo 21. 6. 2015?
SELECT
    Count(*)
FROM
    Sales
WHERE
  --YEAR(Date) = 2015 AND MONTH(Date) = 06 AND DAY(Date) = 21
  --YEAR(Date) = 2015 AND MONTH(Date) = 06 AND DAY(Date) IN (11, 15, 21) /*Varianta s IN je dobrá proto, abych tam mohla dát víc dní, které třeba nejsou po sobě - 11., 15., 21.*/
  Date >= '2015-06-21T00:00:00' AND Date < '2015-06-22T00:00:00' /*psát i s hodinou, na levé straně i s =, aby vzal v potaz i půlnoc*/

--Na který den v týdnu připadnou 30. narozeniny člověka, který se narodil dnes?
SET DATEFIRST 1 /*určení, že náš týden začíná pondělím*/
SELECT DATEPART(WEEKDAY, DATEADD(YEAR, 30, CURRENT_TIMESTAMP)) /*vyber den v týdnu, kdy rok je +30 ode dneška - dnešek je current_timestamp 
(bacha, jde o čas serveru, který nemusí souhlasit s časem mého počítače)
toto se dá využít, když chci najít třeba fakturu před 30 lety, pak bych zadala -30*/

--Kolik jsme toho prodali za rok 2014? Celková suma.
SELECT
    SUM(Revenue)
FROM
    Sales
WHERE
  YEAR(Date) = 2014

--Kolik jsme toho prodali za rok 2014? U každého produktu.
SELECT
    ProductID, SUM(Revenue) AS ProductRevenue
FROM
    Sales
WHERE
  YEAR(Date) = 2014
GROUP BY
    ProductID
ORDER By
    ProductRevenue DESC

--Srovnání, kolik jsme vydělali v lednu 2014 a 2015?
SELECT
   YEAR(Date) AS Rok,
   SUM(Revenue)
FROM
    Sales
WHERE
  MONTH(Date) = 01 AND
  YEAR(Date) IN (2014, 2015)
GROUP BY
    YEAR(Date) /*Je potřeba tam napsat tento formát a ne Rok, protože SQL prochází příkaz ne od Selectu, ale od Where a tak nezná ještě název Rok*/
ORDER By
    YEAR(Date) /*Tady už můžu použít alias, protože po GROUP BY vyhodnocuje SELECT a pak ORDER BY, takže už zná alis, ale je v pořádku tam napsat místo aliasu skutečný název*/

--Kterého ProductID jsme prodali nejvíce kusů?
SELECT
    ProductID, Sum(Units) AS TotalUnits
FROM
    Sales
GROUP BY
   ProductID
Order BY
    TotalUnits DESC

-- Který výrobce (ManufacturerID) má výrobky v nejvíce kategoriích?
    ---Vyberu si v Selectu dva sloupce - unikátní ManufacturerID a součet Count(Category)
    ---Z tabulky Product
    ---Sluč to na hromádky podle ManufacturerID
    ---Seřaď podle součtu Count(Category) sestupně
SELECT 
    DISTINCT (ManufacturerID),
    Count(Category)
FROM
    Product
GROUP BY
   ManufacturerID
ORDER BY
    Count(Category) DESC

--Kolik měst má Florida (FL)?
SELECT 
    Count(DISTINCT City)
FROM
    Country
WHERE
    State = N'FL' /*Tady nebude %, ale proč to nevím*/

-- Kolik Zip kódů mají jednotlivá města ve státě Florida (FL)
SELECT 
    City, Count(DISTINCT Zip) /*Tady by nemuselo být DISTINCT, protože Zip kódy jsou unikátní, ale je to jistota to tam mít*/
FROM
    Country
WHERE
    State = N'FL'
GROUP BY
    City
ORDER BY
    Count(Zip) Desc /*Nezapomínat na Desc, aby mi to neukazovalo nejmenší počet*/
--Které město ve státě Florida (FL) má nejvíc Zip kódů?
SELECT 
    City, Count(DISTINCT Zip) AS ZipCount /*Tady by nemuselo být DISTINCT, protože Zip kódy jsou unikátní, ale je to jistota to tam mít*/
FROM
    Country
WHERE /*Hodnotí jednotlivé řádky*/
    State = N'FL'
GROUP BY
    City
HAVING /*Hodnotí celé hromádky, ne jednotlivé řádky*/
    COUNT (DISTINCT Zip) > 1
ORDER BY
    Count(Zip) Desc /*Nezapomínat na Desc, aby mi to neukazovalo nejmenší počet*/

--Které floridské město je zhruba stejně velké jako Brno?
--Brno má 32 PSČ
SELECT 
    City, Count(DISTINCT Zip) /*Tady by nemuselo být DISTINCT, protože Zip kódy jsou unikátní, ale je to jistota to tam mít*/
FROM
    Country
WHERE
    State = N'FL'
GROUP BY
    City
HAVING
    Count(DISTINCT Zip) BETWEEN 25 AND 35
ORDER BY
    Count(Zip) Desc /*Nezapomínat na Desc, aby mi to neukazovalo nejmenší počet*/

--Kolik průměrně vyděláváme za jednotlivé produkty?
--Jaká je průměrná částka na faktuře?
SELECT 
    ProductID, 
    AVG(1.0*Revenue) AS AvgRevenue, /*Když tam dám 1.0*Revenue, pak mi to počítá v desetinných místech a ne v celočísleném dělení (tzn. že uřízne zbytek a ne, že to zaokrouhlí)
                                               AVG znamená průměr*/
   SUM(Revenue)/COUNT(*) /*Průměrná cena bez použití funkce AVG*/, 
   --AVG(Revenue / Units) AS CenaZaJednotku --takto by se dala spočítat průměrná cena za jednotku, ale musí se zrušit ORDER BY
FROM
    Sales
GROUP BY
    ProductID
ORDER BY
   AvgRevenue DESC

--Ve kterém segmentu působí nejvíce výrobců?
SELECT 
    Segment,
    COUNT(DISTINCT ManufacturerID) AS Manufacturers
FROM
    Product
GROUP BY
    Segment
ORDER BY
    Manufacturers DESC /*Když tady dám Segment místo Manufacturers, tak se to seřadí sestupně podle abecedy názvy segmentů, což není správné řešení zadání*/

--Jaké jsou rozsahy Zip kódu jednotlivých států?
SELECT
    State,
    MIN(Zip) AS ZipMin,
    MAX(Zip) AS ZipMax,
    MAX(CAST(Zip AS int)) - MIN(CAST(Zip AS int)) AS [Range] /* CAST(název sloupce AS typ) - přetypování sloupce na jiný typ např. int nebo str*/
FROM
    Country
GROUP BY
    State

