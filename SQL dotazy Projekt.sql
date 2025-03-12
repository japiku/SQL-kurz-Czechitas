--Vytvoření tabulky dim daly year
---Create table - název tabulky
---do závorky název sloupce a datový typ

CREATE TABLE dim_daly_year (
    ID TINYINT,
    druh_zraneni TINYINT,
    DALY FLOAT
);
---------------------------------------------------------------
--Úprava specifikace sloupce z defaultního null na not null
--Alter table jméno tabulky, ve které budu dělat změny
--Alter column změna ve sloupci - název sloupce, datový typ a not null

ALTER TABLE dim_daly_year
ALTER COLUMN ID TINYINT NOT NULL;

ALTER TABLE dim_daly_year
ALTER COLUMN druh_zraneni TINYINT NOT NULL;

ALTER TABLE dim_daly_year
ALTER COLUMN DALY FLOAT NOT NULL;
---------------------------------------------------------
--Z tabulky diagnozy_s_deti_mladistvi_detail hledám, kolik je záznamů v každé kategorii MKN2


SELECT
COUNT(ID_urazu) as PocetZraneni, MKN2
FROM diagnozy_s_deti_mladistvi_detail
GROUP BY
MKN2

```
--výsledek vyhledávání--
613232	S0 Poranění hlavy
30367	S1 Poranění krku
24073	S2 Poranění hrudníku
32021	S3 Poranění břicha‚ dolní části zad‚ bederní páteře a pánve
152334	S4 Poranění ramene a paže (nadloktí)
361536	S5 Poranění lokte a předloktí 
616759	S6 Poranění zápěstí a ruky
22133	S7 Poranění kyčle a stehna
367302	S8 Poranění kolena a bérce
610907	S9 Poranění kotníku a nohy pod ním
```
--Hledání počtu případů, které spadají do kategorie S o libovolném 1. čísle a dvojce na 2. místě
--nefunguje klasický regex, zástupný znak za libovolní znak je podtržítkko
SELECT
COUNT(ID_urazu) as PocetZraneni, MKN2
FROM diagnozy_s_selekce_unpivoted_py
WHERE
MKN2 LIKE N'S_2'
GROUP BY
MKN2

```
výsledek:
31874	S02
607	    S12
3806	S22
2624	S32
88560	S42
202285	S52
126481	S62
4068	S72
71578	S82
71372	S92
```
--------------------------------------
SELECT
COUNT(ID_urazu) as PocetPripadu, MKN2
FROM urazy_diagnozy_s
WHERE zlomenina = 1
GROUP BY MKN2
ORDER BY
PocetPripadu

```
výsledek:
61244	S1 Poranění krku
461670	S3 Poranění břicha‚ dolní části zad‚ bederní páteře a pánve
608271	S2 Poranění hrudníku
731699	S7 Poranění kyčle a stehna
816890	S0 Poranění hlavy
834520	S4 Poranění ramene a paže (nadloktí)
969521	S9 Poranění kotníku a nohy pod ním
1056296	S8 Poranění kolena a bérce
1317321	S6 Poranění zápěstí a ruky
1369004	S5 Poranění lokte a předloktí 
```

--Přidání sloupce
ALTER TABLE dim_daly_year
ADD doba_postizeni FLOAT NOT NULL;

--Přejmenování sloupce
---EXEC klíčové slovo, které SQL serveru říká, že spouštím uloženou proceduru nebo funkci
---sp_rename je název systémové uložené procedury k přjmenování databázových objektů 
----sp=stored procedure uložená procedura
----umí přejmenovat Tabulky a objekty (OBJECT) nebo sloupce (COLUMN)
--přejmenování automaticky nezmění závislé objekty např. pohledy views nebo uložené procedury, je nutné je zkontrolovat
--obecně: EXEC sp_rename 'jmeno_tabulky.puvodni_nazev_sloupce', 'novy_nazev_sloupce', 'COLUMN';
EXEC sp_rename 'dim_daly_year.DALY', 'tize_zraneni', 'COLUMN';

--Přejmenování tabulky
EXEC sp_rename 'dim_dw_rt', 'dim_mkn2_rt_dw';

--Změna datového typu u sloupce
ALTER TABLE dim_mkn2_rt_dw
ALTER COLUMN druh_zraneni VARCHAR(50) NOT NULL;

--Vložení dat do tabulky
INSERT INTO dim_mkn2_rt_dw (ID, druh_zraneni, tize_zraneni, doba_postizeni)
VALUES 
(1, 'S02', 0.134, 0.073),
(2, 'S12', 0.172, 0.132),
(3, 'S22', 0.192, 0.150),
(4, 'S32', 0.240, 0.390),
(5, 'S42', 0.125, 0.053),
(6, 'S52', 0.134, 0.065),
(7, 'S62', 0.192, 0.025),
(8, 'S72', 0.211, 0.250),
(9, 'S82', 0.192, 0.087),
(10, 'S92', 0.134, 0.330);

--Přejmenování sloupců
EXEC sp_rename 'dim_mkn2_rt_dw.dobapostizeni', 'doba_postizeni', 'COLUMN';

EXEC sp_rename 'dim_mkn2_rt_dw.doba_postizeni', 'tize_zraneni', 'COLUMN';

--Odstranění sloupce
-- ALTER TABLE jmeno_tabulky
-- DROP COLUMN nazev_sloupce;
ALTER TABLE dim_mkn2_rt_dw
DROP COLUMN ID;

--Přetypování sloupce
ALTER TABLE dim_mkn2_rt_dw
ALTER COLUMN druh_zraneni NVARCHAR(50) NOT NULL;

ALTER TABLE diagnozy_s_zlomeniny
ALTER COLUMN MKN2 NVARCHAR(50) NOT NULL;

--Vytváření primárního klíče
ALTER TABLE
    pady_deti_mladistvi_fraktury /*název tabulky, ve které vytvářím primární klíč*/
ADD CONSTRAINT
    PK_ID_urazu__id /*libovolný název s PK na začátku a id na konci za dvěmi podtržítky*/
PRIMARY KEY CLUSTERED
    (ID_urazu); /*název sloupce, který bude sloužit jako primární klíč*/

----------------
ALTER TABLE
    dim_mkn2_rt_dw /*název tabulky, ve které vytvářím primární klíč*/
ADD CONSTRAINT
    PK_druh_zraneni__id /*libovolný název s PK na začátku a id na konci za dvěmi podtržítky*/
PRIMARY KEY CLUSTERED
    (druh_zraneni); /*název sloupce, který bude sloužit jako primární klíč*/



--Vytváření cizích klíčů
ALTER TABLE
    pady_deti_mladistvi_fraktury /*název tabulky do které chci přidat cizí klíč*/
ADD CONSTRAINT
    FK_pady_fraktury_pohlavi__id /*označení cizího klíče, ideálně na počátku FK, na konci id po dvou podtržítkách*/
FOREIGN KEY
    (pohlavi) /*připojená tabulka - odtud se bere FK*/
REFERENCES
    dim_pohlavi (id_pohlavi); /*název tabulky FK (název sloupce)*/

-----------------
ALTER TABLE
    pady_deti_mladistvi_fraktury /*název tabulky do které chci přidat cizí klíč*/
ADD CONSTRAINT
    FK_pady_fraktury_vaznost__id /*označení cizího klíče, ideálně na počátku FK, na konci id po dvou podtržítkách*/
FOREIGN KEY
    (vaznost) /*název sloupce ve faktovce/tabulce, ke kterému se přidá FK*/
REFERENCES
    dim_tize_urazu (id_tize_urazu); /*název tabulky FK (název sloupce)*/

--------------------------
ALTER TABLE
    diagnozy_s_zlomeniny /*název tabulky do které chci přidat cizí klíč*/
ADD CONSTRAINT
    FK_MKN2_druh_zraneni__id /*označení cizího klíče, ideálně na počátku FK, na konci id po dvou podtržítkách*/
FOREIGN KEY
    (MKN2) /*název sloupce ve faktovce/tabulce, ke kterému se přidá FK*/
REFERENCES
    dim_mkn2_rt_dw (druh_zraneni); /*název tabulky FK (název sloupce)*/

-----------------------------
ALTER TABLE
    diagnozy_s_zlomeniny /*název tabulky do které chci přidat cizí klíč*/
ADD CONSTRAINT
    FK_ID_urazu__id /*označení cizího klíče, ideálně na počátku FK, na konci id po dvou podtržítkách*/
FOREIGN KEY
    (ID_urazu) /*název sloupce ve faktovce/tabulce, ke kterému se přidá FK*/
REFERENCES
    pady_deti_mladistvi_fraktury (ID_urazu); /*název tabulky FK (název sloupce)*/

------------------------------
--Zjištění podrobností o tabulkách
EXEC sp_help 'diagnozy_s_zlomeniny'
EXEC sp_help 'dim_mkn2_rt_dw'



--------------------------------
SELECT 
DISTINCT((doba_postizeni * tize_zraneni) * COUNT(fr.ID_urazu)/12) as CelkovaDobaSTizi, dsz.MKN2
---vypočítání doby postižení krát tíže zranění, distinct je tam proto, aby se mi neopakovalo S02 = 0,32...
---as až za násobení, zahrnuje všechny matematické operace
---dsz.MKN2, abych měla výsledek výpočtu k danému typu úrazu
---děleno 12, abych získala hodnoty za jeden rok (je nutné do toho nezahrnout DISTINCT a AS)
FROM
diagnozy_s_zlomeniny dsz
LEFT JOIN dim_mkn2_rt_dw mrd ON dsz.MKN2 = mrd.druh_zraneni
LEFT JOIN pady_deti_mladistvi_fraktury fr ON dsz.ID_urazu = fr.ID_urazu
---spojení tabulek
GROUP BY
dsz.MKN2, tize_zraneni, doba_postizeni
---do group by musí být všechny sloupce, i ty, které násobím
ORDER BY
CelkovaDobaSTizi DESC
---to co je v agregační funkci


-------------------------
--Změna hodnoty v tabulce

UPDATE
    dim_mkn2_rt_dw /*úprava v tabulce dim_mkn2_rt_dw*/
SET
    tize_zraneni = 0.033 /*jaký sloupce a jaká je nová hodnota*/
WHERE
    druh_zraneni = 'S92' /*řádek, který má ve sloupci druh_zraneni hodnotu S92*/

---------------------
--Vyhledání počtu případů, kde je ve sloupci pohlaví označeno "neuvedeno"
SELECT
COUNT(*)
FROM
dim_pohlavi
WHERE
pohlavi = N'neuvedeno'
---------------------
--Zjištění TOP 100 jedinečných záznamů z tabulky pady_deti_mladistvi_fraktury
SELECT DISTINCT TOP 100
 *
FROM
pady_deti_mladistvi_fraktury