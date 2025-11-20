-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Čtv 20. lis 2025, 09:01
-- Verze serveru: 10.4.32-MariaDB
-- Verze PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `fotbal_halska`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `adresa`
--

CREATE TABLE `adresa` (
  `id_adresa` int(11) NOT NULL,
  `ulice` varchar(50) NOT NULL,
  `cislo_popisne` varchar(20) NOT NULL,
  `psc` varchar(15) DEFAULT NULL,
  `id_mesto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `hrac`
--

CREATE TABLE `hrac` (
  `id_hrac` int(11) NOT NULL,
  `jmeno` varchar(50) NOT NULL,
  `prijmeni` varchar(50) NOT NULL,
  `datum_narozeni` date NOT NULL,
  `pohlavi` enum('M','F') DEFAULT NULL,
  `id_klub` int(11) NOT NULL,
  `id_kategorie` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `kategorie`
--

CREATE TABLE `kategorie` (
  `id_kategorie` int(11) NOT NULL,
  `nazev` varchar(50) NOT NULL,
  `rocnik_od` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `klub`
--

CREATE TABLE `klub` (
  `id_klub` int(11) NOT NULL,
  `nazev` varchar(255) NOT NULL,
  `id_mesto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `mesto`
--

CREATE TABLE `mesto` (
  `id_mesto` int(11) NOT NULL,
  `nazev` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `soutez`
--

CREATE TABLE `soutez` (
  `id_soutez` int(11) NOT NULL,
  `nazev` varchar(50) NOT NULL,
  `typ` enum('liga','turnaj','pohár') NOT NULL,
  `id_kategorie` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `stadion`
--

CREATE TABLE `stadion` (
  `id_stadion` int(11) NOT NULL,
  `id_mesto` int(11) NOT NULL,
  `id_adresa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `zapas`
--

CREATE TABLE `zapas` (
  `id_zapas` int(11) NOT NULL,
  `id_soutez` int(11) NOT NULL,
  `id_stadion` int(11) NOT NULL,
  `id_domaci_klub` int(11) NOT NULL,
  `id_hoste_klub` int(11) NOT NULL,
  `datum` date NOT NULL,
  `cas` time NOT NULL,
  `skore_domaci` int(11) NOT NULL,
  `skore_hoste` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Indexy pro exportované tabulky
--

--
-- Indexy pro tabulku `adresa`
--
ALTER TABLE `adresa`
  ADD PRIMARY KEY (`id_adresa`),
  ADD KEY `id_mesto` (`id_mesto`);

--
-- Indexy pro tabulku `hrac`
--
ALTER TABLE `hrac`
  ADD PRIMARY KEY (`id_hrac`),
  ADD KEY `id_klub` (`id_klub`),
  ADD KEY `id_kategorie` (`id_kategorie`),
  ADD KEY `jmeno_hrace` (`jmeno`,`prijmeni`);

--
-- Indexy pro tabulku `kategorie`
--
ALTER TABLE `kategorie`
  ADD PRIMARY KEY (`id_kategorie`);

--
-- Indexy pro tabulku `klub`
--
ALTER TABLE `klub`
  ADD PRIMARY KEY (`id_klub`),
  ADD KEY `id_mesto` (`id_mesto`),
  ADD KEY `nazev_klubu` (`nazev`);

--
-- Indexy pro tabulku `mesto`
--
ALTER TABLE `mesto`
  ADD PRIMARY KEY (`id_mesto`);

--
-- Indexy pro tabulku `soutez`
--
ALTER TABLE `soutez`
  ADD PRIMARY KEY (`id_soutez`),
  ADD KEY `id_kategorie` (`id_kategorie`);

--
-- Indexy pro tabulku `stadion`
--
ALTER TABLE `stadion`
  ADD PRIMARY KEY (`id_stadion`),
  ADD KEY `id_mesto` (`id_mesto`),
  ADD KEY `id_adresa` (`id_adresa`);

--
-- Indexy pro tabulku `zapas`
--
ALTER TABLE `zapas`
  ADD PRIMARY KEY (`id_zapas`),
  ADD KEY `id_soutez` (`id_soutez`),
  ADD KEY `id_stadion` (`id_stadion`),
  ADD KEY `id_domaci_klub` (`id_domaci_klub`),
  ADD KEY `id_hoste_klub` (`id_hoste_klub`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `adresa`
--
ALTER TABLE `adresa`
  MODIFY `id_adresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pro tabulku `hrac`
--
ALTER TABLE `hrac`
  MODIFY `id_hrac` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pro tabulku `kategorie`
--
ALTER TABLE `kategorie`
  MODIFY `id_kategorie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pro tabulku `klub`
--
ALTER TABLE `klub`
  MODIFY `id_klub` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pro tabulku `mesto`
--
ALTER TABLE `mesto`
  MODIFY `id_mesto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pro tabulku `soutez`
--
ALTER TABLE `soutez`
  MODIFY `id_soutez` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pro tabulku `stadion`
--
ALTER TABLE `stadion`
  MODIFY `id_stadion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pro tabulku `zapas`
--
ALTER TABLE `zapas`
  MODIFY `id_zapas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `adresa`
--
ALTER TABLE `adresa`
  ADD CONSTRAINT `adresa_ibfk_1` FOREIGN KEY (`id_mesto`) REFERENCES `mesto` (`id_mesto`);

--
-- Omezení pro tabulku `hrac`
--
ALTER TABLE `hrac`
  ADD CONSTRAINT `hrac_ibfk_1` FOREIGN KEY (`id_klub`) REFERENCES `klub` (`id_klub`),
  ADD CONSTRAINT `hrac_ibfk_2` FOREIGN KEY (`id_kategorie`) REFERENCES `kategorie` (`id_kategorie`);

--
-- Omezení pro tabulku `klub`
--
ALTER TABLE `klub`
  ADD CONSTRAINT `klub_ibfk_1` FOREIGN KEY (`id_mesto`) REFERENCES `mesto` (`id_mesto`);

--
-- Omezení pro tabulku `soutez`
--
ALTER TABLE `soutez`
  ADD CONSTRAINT `soutez_ibfk_1` FOREIGN KEY (`id_kategorie`) REFERENCES `kategorie` (`id_kategorie`);

--
-- Omezení pro tabulku `stadion`
--
ALTER TABLE `stadion`
  ADD CONSTRAINT `stadion_ibfk_1` FOREIGN KEY (`id_mesto`) REFERENCES `mesto` (`id_mesto`),
  ADD CONSTRAINT `stadion_ibfk_2` FOREIGN KEY (`id_adresa`) REFERENCES `adresa` (`id_adresa`);

--
-- Omezení pro tabulku `zapas`
--
ALTER TABLE `zapas`
  ADD CONSTRAINT `zapas_ibfk_1` FOREIGN KEY (`id_soutez`) REFERENCES `soutez` (`id_soutez`),
  ADD CONSTRAINT `zapas_ibfk_2` FOREIGN KEY (`id_stadion`) REFERENCES `stadion` (`id_stadion`),
  ADD CONSTRAINT `zapas_ibfk_3` FOREIGN KEY (`id_domaci_klub`) REFERENCES `klub` (`id_klub`),
  ADD CONSTRAINT `zapas_ibfk_4` FOREIGN KEY (`id_hoste_klub`) REFERENCES `klub` (`id_klub`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
