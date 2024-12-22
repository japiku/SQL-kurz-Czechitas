--Zad�n� dom�c�ho �kolu:

-- Vyberte prvn�ch 5 v�robc� (tabulka manufacturers) se�azen�ch podle n�zvu abecedn� vzestupn�.
SELECT * 
FROM SQL1.manufacturers
ORDER BY Manufacturer
--Zjist�te v�echny produkty z kategorie Youth a se�a� je podle ceny (priceNew) sestupn�.
SELECT DISTINCT *
FROM SQL1.Products
WHERE category in ('Youth')
ORDER BY Pricenew Desc
--Vyberte v�echny prodeje uskute�n�n� v �noru a jejich� tr�ba je mezi 1800 a 1900. Zobrazte jen sloupce productid, calendarid a tr�ba za jeden kus a vhodn� je �esky pojmenujte.
SELECT productid AS produkt, calendarid AS datum, revenue/units as trzba_za_kus
FROM SQL1.Sales
WHERE extract(month from calendarid) = 02 AND (revenue >=1800 and revenue <=1900)
    --alternativn� �e�en�
    SELECT productid AS produkt, calendarid AS datum, revenue/units as trzba_za_kus
    FROM SQL1.Sales
    WHERE extract(month from calendarid) = 02 AND revenue between 1800 and 1900