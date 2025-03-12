---
--vytváření dimenzí pro úrazy
---
CREATE TABLE dim_cast_tela
(
    id_cast_tela int NOT NULL,
    cast_tela NVARCHAR(50) NOT NULL
)

INSERT INTO
    dim_cast_tela (id_cast_tela, cast_tela)
VALUES
    (N'S0 ', N'Poranění hlavy'),
    (N'S1 ', N'Poranění krku'),
    (N'S2 ', N'Poranění hrudníku'),
    (N'S3 ', N'Poranění břicha‚ dolní části zad‚ bederní páteře a pánve'),
    (N'S4 ', N'Poranění ramene a paže (nadloktí)'),
    (N'S5 ', N'Poranění lokte a předloktí'),
    (N'S6 ', N'Poranění zápěstí a ruky'),
    (N'S7 ', N'Poranění kyčle a stehna'),
    (N'S8 ', N'Poranění kolena a bérce'),
    (N'S9 ', N'Poranění kotníku a nohy pod ním')


ALTER TABLE
    dim_cast_tela
ADD CONSTRAINT
    PK_dim_cast_tela__id
PRIMARY KEY CLUSTERED
    (id_cast_tela)

---vytváření cizích klíčů
--
ALTER TABLE
    urazy
ADD CONSTRAINT
    FK_urazy_cast_tela__id
FOREIGN KEY
    (cast_tela)
REFERENCES
    dim_cast_tela (id_cast_tela);