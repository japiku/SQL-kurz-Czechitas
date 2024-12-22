--Zad�n� dom�c�ho �kolu:
--1. Kdy se prodalo nejv�ce v�robk� (units) a jak� to byly (Product)?
SELECT s.calendarid, p. product, sum(s.units) as PocetVyrobku
FROM SQL1.Sales s
INNER JOIN SQL1.Products p ON s.productid = p.productid
GROUP BY s.calendarid, p. product
ORDER BY PocetVyrobku desc
--2. Jak� byly tr�by v jednotliv�ch st�tech? Zaj�maj� n�s pouze m�sta
--za��naj�c� na 'Bos'.
SELECT c.state, sum(s.revenue)
FROM SQL1.Sales s
INNER JOIN SQL1.Cities c ON c.zip = s.zip
WHERE c. city LIKE 'Bos%'
GROUP BY c.state

--3. Jak� po�et produkt� maj� v�robci v kategorii Mix? Zaj�maj� n�s i
--v�robci, kte�� pro kategorii Mix nic nevyr�b�.
SELECT m.manufacturer, count(p.productid) as Pocet_Produktu
FROM SQL1.Manufacturers m
LEFT JOIN SQL1.Products p ON m.manufacturerid = p.manufacturerid
AND p.category = 'Mix'
GROUP BY m.manufacturer; 
