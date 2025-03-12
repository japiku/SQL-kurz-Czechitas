--Zadání domácího úkolu:

-- Vyberte prvních 5 výrobců (tabulka manufacturers) seřazených podle názvu abecedně vzestupně.
SELECT * 
FROM SQL1.manufacturers
ORDER BY Manufacturer
--Zjistěte všechny produkty z kategorie Youth a seřaďte je podle ceny (priceNew) sestupně.
SELECT DISTINCT *
FROM SQL1.Products
WHERE category in ('Youth')
ORDER BY Pricenew Desc
--Vyberte všechny prodeje uskutečněné v únoru a jejichž tržba je mezi 1800 a 1900. Zobrazte jen sloupce productid, calendarid a tržba za jeden kus a vhodně je česky pojmenujte.
SELECT productid AS produkt, calendarid AS datum, revenue/units as trzba_za_kus
FROM SQL1.Sales
WHERE extract(month from calendarid) = 02 AND (revenue >=1800 and revenue <=1900)
    --alternativní øešení
    SELECT productid AS produkt, calendarid AS datum, revenue/units as trzba_za_kus
    FROM SQL1.Sales
    WHERE extract(month from calendarid) = 02 AND revenue between 1800 and 1900
