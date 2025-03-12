--Kolik je v tabulce netflix hororu?
SELECT
Count(show_id)
FROM
netflix
WHERE
listed_in LIKE N'horor%'

--Jaký je v tabulce netflix nejstarší film?
SELECT TOP 1 WITH TIES
*
FROM
netflix
WHERE
type = N'Movie'
ORDER BY
release_year

--Jaký je nejlépe hodnocený sci-fi film?
SELECT TOP 1 WITH TIES
*
FROM
imdb_titles it
JOIN imdb_ratings ir ON it.tconst=ir.tconst
WHERE
genres LIKE N'%Sci-fi%' AND titleType = N'Movie'
ORDER BY
averageRating DESC

--Kolik je v imdb datech nehodnocených filmů? Potřebuju tabulku titles celou a k tomu dořadit data z ratingu.
---Kde nebude rating, tam se vyplní NULL. Pak hledám počet titulů, které jsou film a zároveň nemají hodnocení.
---Když dám titleType Movie do joinu, tak pokud v levé tabulce bude film s typem Short, takže není splněna podmínka, že je to Movie,
---tak se v pravé části vyplní NULL, což nechci, je teda nutné dát Movie do WHERE
---BACHA - count nepočítá NULL hodnoty - vždy se při Countu podívat do popisu tabulky, jestli obsahuje Null hodnoty
SELECT
COUNT(it.primaryTitle) as CountFilms 
FROM 
imdb_titles it
LEFT JOIN imdb_ratings ir ON it.tconst = ir.tconst
WHERE
ir.averageRating IS NULL AND it.titleType = N'Movie'
ORDER BY
CountFilms Desc

--Ve kterých letech vzniklo přes 5000 hodin filmu?
SELECT
startYear, Sum(runtimeMinutes)
FROM
imdb_titles
WHERE
titleType = N'Movie'
GROUP BY
StartYear
HAVING
    SUM(runtimeMinutes) > 5000*60

--Existují hodnocení, ke kterým není titul?
--Kolik jich je?
SELECT
COUNT(*)
FROM
imdb_ratings ir
LEFT JOIN imdb_titles it ON ir.tconst = it.tconst
WHERE
it.tconst IS NULL