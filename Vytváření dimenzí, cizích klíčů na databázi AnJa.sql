---VYTVÁŘENÍ DIMENZÍ---
-----------------------
CREATE TABLE dim_pohlavi
(
    id_pohlavi int NOT NULL,
    pohlavi NVARCHAR(50) NOT NULL
)

INSERT INTO
    dim_pohlavi (id_pohlavi, pohlavi)
VALUES
    (1, N'muž'),
    (2, N'žena'),
    (99, N'neuvedeno')

---odstranění primárního klíče (nejdříve je nutné odstranit cizí klíče viz. níže)
ALTER TABLE [dim_pohlavi] DROP CONSTRAINT PK_dim_pohlavi__id
---změna datového typu u sloupce id_pohlavi
ALTER TABLE [dim_pohlavi] ALTER COLUMN [id_pohlavi] [TINYINT] NOT NULL
---vytvoření primárního klíče
ALTER TABLE
    dim_pohlavi
ADD CONSTRAINT
    PK_dim_pohlavi__id
PRIMARY KEY CLUSTERED
    (id_pohlavi)


--------------------
--------------------
--------------------


CREATE TABLE dim_vek
(
    id_vek int NOT NULL,
    vek NVARCHAR(50) NOT NULL
)
ALTER TABLE [dim_vek] DROP CONSTRAINT PK_dim_vek__id

ALTER TABLE [dim_vek] ALTER COLUMN [id_vek] [TINYINT] NOT NULL
INSERT INTO
    dim_vek (id_vek, vek)
VALUES
    (1, N'0 až 4 roky'),
    (2, N'5 až 9 let'),
    (3, N'10 až 14 let'), 
    (4, N'15 až 19 let'),
    (5, N'20 až 24 let'), 
    (6, N'25 až 29 let'), 
    (7, N'30 až 34 let'), 
    (8, N'35 až 39 let'),
    (9, N'40 až 44 let'), 
    (10, N'45 až 49 let'), 
    (11, N'50 až 54 let'), 
    (12, N'55 až 59 let'), 
    (13, N'60 až 64 let'),
    (14, N'65 až 69 let'),
    (15, N'70 až 74 let'),
    (16, N'75 až 79 let'),
    (17, N'80 až 84 let'),
    (18, N'85 až 89 let'),
    (19, N'90 až 94 let'),
    (20, N'95 a více let'),
    (99, N'neuvedeno')

ALTER TABLE
    dim_vek
ADD CONSTRAINT
    PK_dim_vek__id
PRIMARY KEY CLUSTERED
    (id_vek)


--------------------
--------------------
--------------------

CREATE TABLE dim_kraj
(
    id_kraj NVARCHAR(50) NOT NULL,
    kraj NVARCHAR(50) NOT NULL
)

INSERT INTO
    dim_kraj (id_kraj, kraj)
VALUES
(N'CZ010', N'Hlavní město Praha'),
(N'CZ020', N'Středočeský kraj'),
(N'CZ031', N'Jihočeský kraj'),
(N'CZ032', N'Plzeňský kraj'),
(N'CZ041', N'Karlovarský kraj'),
(N'CZ042', N'Ústecký kraj'),
(N'CZ051', N'Liberecký kraj'),
(N'CZ052', N'Královéhradecký kraj'),
(N'CZ053', N'Pardubický kraj'),
(N'CZ063', N'Kraj Vysočina'),
(N'CZ064', N'Jihomoravský kraj'),
(N'CZ071', N'Olomoucký kraj'),
(N'CZ072', N'Zlínský kraj'),
(N'CZ080', N'Moravskoslezský kraj'),
(N'CZ099', N'Neznámý kraj')

ALTER TABLE
    dim_kraj
ADD CONSTRAINT
    PK_dim_kraj__id
PRIMARY KEY CLUSTERED
    (id_kraj)

--------------------
--------------------
--------------------


CREATE TABLE dim_typ_urazu
(
    id_typ_urazu NVARCHAR(50) NOT NULL,
    typ_urazu NVARCHAR(100) NOT NULL
)

INSERT INTO
    dim_typ_urazu (id_typ_urazu, typ_urazu)
VALUES
    (N'V01-V09', N'Chodec zraněný při dopravní nehodě'),
    (N'V10-V19', N'Cyklista zraněný při dopravní nehodě '),
    (N'V20-V29', N'Jezdec na motocyklu zraněný při dopravní nehodě'),
    (N'V30-V39', N'Člen osádky tříkolového motorového vozidla zraněný při dopravní nehodě'),
    (N'V40-V49', N'Člen osádky osobního automobilu zraněný při dopravní nehodě'),
    (N'V50-V59', N'Člen osádky dodávkového nebo lehkého nákladního automobilu zraněný při dopravní nehodě'),
    (N'V60-V69', N'Člen osádky těžkého nákladního vozidla zraněný při dopravní nehodě'),
    (N'V70-V79', N'Člen osádky autobusu zraněný při dopravní nehodě'),
    (N'V80-V89', N'Jiné nehody při pozemní dopravě'),
    (N'V90-V94', N'Nehody při vodní dopravě'),
    (N'V95-V97', N'Nehody při dopravě vzduchem a vesmírným prostorem'),
    (N'V98-V99', N'Jiné a neurčené dopravní nehody'),
    (N'W00-W19', N'Pády'),
    (N'W20-W49', N'Vystavení neživotným mechanickým silám'),
    (N'W50-W64', N'Vystavení životným mechanickým silám'),
    (N'W65-W74', N'Náhodné (u)tonutí a potopení'),
    (N'W75-W84', N'Jiná náhodná ohrožení dýchání'),
    (N'W85-W99', N'Vystavení elektrickému proudu, ozáření a extrémní okolní teplotě a tlaku vzduchu'),
    (N'X00-X09', N'Vystavení kouři, ohni, dýmu a plamenů'),
    (N'X10-X19', N'Kontakt s horkem a horkými látkami'),
    (N'X20-X29', N'Kontakt s jedovatými živočichy a rostlinami'),
    (N'X30-X39', N'Vystavení přírodním silám'),
    (N'X40-X49', N'Neúmyslné sebezranění'),
    (N'X50-X57', N'Úmyslné sebezranění'),
    (N'X58-X59', N'Úmyslná sebevražda')


ALTER TABLE
    dim_typ_urazu
ADD CONSTRAINT
    PK_dim_typ_urazu__id
PRIMARY KEY CLUSTERED
    (id_typ_urazu);
--------------------
--------------------
--------------------
CREATE TABLE dim_tize_urazu
(
    id_tize_urazu NVARCHAR(50) NOT NULL,
    typ_tize_urazu NVARCHAR(100) NOT NULL
)

INSERT INTO
    dim_tize_urazu (id_tize_urazu, typ_tize_urazu)
VALUES
(N'I-a', N'Úraz ošetřený pouze ambulantně, bez další léčby a následků'),
(N'I-b', N'Ambulantní ošetření s následnou léčbou, komplikacemi'),
(N'II-a', N'Krátkodobé hospitalizace bez operace, bez komplikací'),
(N'II-b', N'Hospitalizace s operací, bez komplikací'),
(N'II-c', N'Těžké úrazy s operací a delším pobytem na JIP'),
(N'II-d', N'Polytrauma'),
(N'III-c', N'Úmrtí bezprostředně při nehodě')

ALTER TABLE
    dim_tize_urazu
ADD CONSTRAINT
    PK_dim_tize_urazu__id
PRIMARY KEY CLUSTERED
    (id_tize_urazu);

--------------------
--------------------
--------------------
CREATE TABLE dim_umrti_po_urazu
(
    id_umrti_po_urazu NVARCHAR(50) NOT NULL,
    typ_umrti_po_urazu NVARCHAR(100) NOT NULL
)

INSERT INTO
    dim_umrti_po_urazu (id_umrti_po_urazu, typ_umrti_po_urazu)
VALUES
(N'III-a', N'Úmrtí po léčbě ve vazbě na následky úrazu'),
(N'III-b', N'Úmrtí při léčbě/hospitalizaci'),
(N'III-c', N'Úmrtí bezprostředně při nehodě')

ALTER TABLE
    dim_umrti_po_urazu
ADD CONSTRAINT
    PK_dim_umrti_po_urazu__id
PRIMARY KEY CLUSTERED
    (id_umrti_po_urazu);

--------------------
--------------------
--------------------
---VYTVÁŘENÍ CIZÍCH KLÍČŮ---
----------------------------

ALTER TABLE
    urazy
ADD CONSTRAINT
    FK_urazy_pohlavi__id
FOREIGN KEY
    (pohlavi)
REFERENCES
    dim_pohlavi (id_pohlavi);

ALTER TABLE urazy DROP CONSTRAINT FK_urazy_pohlavi__id; /*odstranění cizího klíče*/


-----------------------

ALTER TABLE
    urazy
ADD CONSTRAINT
    FK_urazy_kraj_pacient__id
FOREIGN KEY
    (kraj_pacient)
REFERENCES
    dim_kraj (id_kraj);

-----------------------

ALTER TABLE
    urazy
ADD CONSTRAINT
    FK_urazy_kraj_icz__id
FOREIGN KEY
    (kraj_icz)
REFERENCES
    dim_kraj (id_kraj);

-----------------------

ALTER TABLE
    urazy
ADD CONSTRAINT
    FK_urazy_typ_urazu__id
FOREIGN KEY
    (pod_kat)
REFERENCES
    dim_typ_urazu (id_typ_urazu);

-----------------------

ALTER TABLE
    urazy
ADD CONSTRAINT
    FK_urazy_vek__id
FOREIGN KEY
    (vek_kat)
REFERENCES
    dim_vek (id_vek)

ALTER TABLE urazy DROP CONSTRAINT FK_urazy_vek__id; /*odstranění cizího klíče*/
-----------------------

ALTER TABLE
    urazy
ADD CONSTRAINT
    FK_urazy_tize_urazu__id
FOREIGN KEY
    (vaznost)
REFERENCES
    dim_tize_urazu (id_tize_urazu);

-----------------------

ALTER TABLE
    urazy
ADD CONSTRAINT
    FK_urazy_umrti_po_urazu__id
FOREIGN KEY
    (umrti)
REFERENCES
    dim_umrti_po_urazu (id_umrti_po_urazu);

----ZJIŠTĚNÍ DATOVÉHO TYPU---

EXEC sp_help 'urazy';
EXEC sp_help 'dim_pohlavi';
