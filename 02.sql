--Zad�n� dom�c�ho �kolu:

--1. Ve kter�m segmentu je nejv�ce produkt�?
SELECT Segment, Count(Product)
FROM SQL1.Products
GROUP BY segment
ORDER BY Count(Product) DESC
--2. Vytvo� p�ehled jak� segmenty jsou zastoupeny v jednotliv�ch kategori�ch,
--kolik v�robk� obsahuj� a jak� je pr�m�rn� cena v�robku v tomto �len�n�.
SELECT Segment, Category, count(product) as ProductCount, avg(pricenew) as AVGPrice
FROM SQL1.Products
Group by Category, Segment
--3. Kter�ch v�robk� (ProductID) se prodalo nejv�ce v dubnu 2015? (zaj�maj�
--n�s kusy - units)
SELECT ProductID, sum(units)
FROM SQL1.Sales
WHERE to_char(calendarid, 'MMYYYY') = '042015'
GROUP BY ProductID
ORDER BY sum(units) desc;