CREATE TABLE `Klub` (
  `id_klub` int PRIMARY KEY,
  `nazev` varchar(255),
  `id_mesto` int
);

CREATE TABLE `Kategorie` (
  `id_kategorie` int PRIMARY KEY,
  `nazev` varchar(50),
  `rocnik_od` year
);

CREATE TABLE `Hrac` (
  `id_hrac` int PRIMARY KEY,
  `jmeno` varchar(50),
  `prijmeni` varchar(50),
  `datum_narozeni` date,
  `pohlavi` ENUM ('M', 'F'),
  `id_klub` int,
  `id_kategorie` int
);

CREATE TABLE `Stadion` (
  `id_stadion` int PRIMARY KEY,
  `id_mesto` int,
  `id_adresa` int
);

CREATE TABLE `Soutez` (
  `id_soutez` int PRIMARY KEY,
  `nazev` varchar(50),
  `typ` ENUM ('liga', 'turnaj', 'pohár'),
  `id_kategorie` int
);

CREATE TABLE `Zapas` (
  `id_zapas` int PRIMARY KEY,
  `id_soutez` int,
  `id_stadion` int,
  `id_domaci_klub` int,
  `id_hoste_klub` int,
  `datum` date,
  `cas` time,
  `skore_domaci` int,
  `skore_hoste` int
);

CREATE TABLE `Mesto` (
  `id_mesto` int PRIMARY KEY,
  `nazev` varchar(50)
);

CREATE TABLE `Adresa` (
  `id_adresa` int PRIMARY KEY,
  `ulice` varchar(50),
  `cislo_popisne` varchar(20),
  `psc` varchar(15),
  `id_mesto` int
);

ALTER TABLE `Klub` ADD FOREIGN KEY (`id_mesto`) REFERENCES `Mesto` (`id_mesto`);

ALTER TABLE `Hrac` ADD FOREIGN KEY (`id_klub`) REFERENCES `Klub` (`id_klub`);

ALTER TABLE `Hrac` ADD FOREIGN KEY (`id_kategorie`) REFERENCES `Kategorie` (`id_kategorie`);

ALTER TABLE `Stadion` ADD FOREIGN KEY (`id_mesto`) REFERENCES `Mesto` (`id_mesto`);

ALTER TABLE `Stadion` ADD FOREIGN KEY (`id_adresa`) REFERENCES `Adresa` (`id_adresa`);

ALTER TABLE `Soutez` ADD FOREIGN KEY (`id_kategorie`) REFERENCES `Kategorie` (`id_kategorie`);

ALTER TABLE `Zapas` ADD FOREIGN KEY (`id_soutez`) REFERENCES `Soutez` (`id_soutez`);

ALTER TABLE `Zapas` ADD FOREIGN KEY (`id_stadion`) REFERENCES `Stadion` (`id_stadion`);

ALTER TABLE `Zapas` ADD FOREIGN KEY (`id_domaci_klub`) REFERENCES `Klub` (`id_klub`);

ALTER TABLE `Zapas` ADD FOREIGN KEY (`id_hoste_klub`) REFERENCES `Klub` (`id_klub`);

ALTER TABLE `Adresa` ADD FOREIGN KEY (`id_mesto`) REFERENCES `Mesto` (`id_mesto`);
