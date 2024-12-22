--Zadání domácího úkolu:

--1. Ve kterém segmentu je nejvíce produktù?
SELECT Segment, Count(Product)
FROM SQL1.Products
GROUP BY segment
ORDER BY Count(Product) DESC
--2. Vytvoø pøehled jaké segmenty jsou zastoupeny v jednotlivých kategoriích,
--kolik výrobkù obsahují a jaká je prùmìrná cena výrobku v tomto èlenìní.
SELECT Segment, Category, count(product) as ProductCount, avg(pricenew) as AVGPrice
FROM SQL1.Products
Group by Category, Segment
--3. Kterých výrobkù (ProductID) se prodalo nejvíce v dubnu 2015? (zajímají
--nás kusy - units)
SELECT ProductID, sum(units)
FROM SQL1.Sales
WHERE to_char(calendarid, 'MMYYYY') = '042015'
GROUP BY ProductID
ORDER BY sum(units) desc;