SELECT 
Count(it1.primaryTitle)
FROM imdb_titles it1
LEFT JOIN imdb_titles it2 ON it1.tconst = it2.tconst AND it1.primaryTitle != it2.originalTitle
WHERE 
it2.originalTitle is NOT NULL

