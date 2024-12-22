--Zadání domácího úkolu:

-- Vyberte prvních 5 vırobcù (tabulka manufacturers) seøazenıch podle názvu abecednì vzestupnì.
SELECT * 
FROM SQL1.manufacturers
ORDER BY Manufacturer
--Zjistìte všechny produkty z kategorie Youth a seøaï je podle ceny (priceNew) sestupnì.
SELECT DISTINCT *
FROM SQL1.Products
WHERE category in ('Youth')
ORDER BY Pricenew Desc
--Vyberte všechny prodeje uskuteènìné v únoru a jejich trba je mezi 1800 a 1900. Zobrazte jen sloupce productid, calendarid a trba za jeden kus a vhodnì je èesky pojmenujte.
SELECT productid AS produkt, calendarid AS datum, revenue/units as trzba_za_kus
FROM SQL1.Sales
WHERE extract(month from calendarid) = 02 AND (revenue >=1800 and revenue <=1900)
    --alternativní øešení
    SELECT productid AS produkt, calendarid AS datum, revenue/units as trzba_za_kus
    FROM SQL1.Sales
    WHERE extract(month from calendarid) = 02 AND revenue between 1800 and 1900