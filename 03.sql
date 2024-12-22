--Zadání domácího úkolu:
--1. Kdy se prodalo nejvíce výrobkù (units) a jaké to byly (Product)?
SELECT s.calendarid, p. product, sum(s.units) as PocetVyrobku
FROM SQL1.Sales s
INNER JOIN SQL1.Products p ON s.productid = p.productid
GROUP BY s.calendarid, p. product
ORDER BY PocetVyrobku desc
--2. Jaké byly tržby v jednotlivých státech? Zajímají nás pouze mìsta
--zaèínající na 'Bos'.
SELECT c.state, sum(s.revenue)
FROM SQL1.Sales s
INNER JOIN SQL1.Cities c ON c.zip = s.zip
WHERE c. city LIKE 'Bos%'
GROUP BY c.state

--3. Jaký poèet produktù mají výrobci v kategorii Mix? Zajímají nás i
--výrobci, kteøí pro kategorii Mix nic nevyrábí.
SELECT m.manufacturer, count(p.productid) as Pocet_Produktu
FROM SQL1.Manufacturers m
LEFT JOIN SQL1.Products p ON m.manufacturerid = p.manufacturerid
AND p.category = 'Mix'
GROUP BY m.manufacturer; 
