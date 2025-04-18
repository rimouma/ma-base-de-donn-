-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 18 avr. 2025 à 22:12
-- Version du serveur :  10.4.14-MariaDB
-- Version de PHP : 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `monprojetfindetude`
--

-- --------------------------------------------------------

--
-- Structure de la table `commune`
--

CREATE TABLE `commune` (
  `id_commune` int(11) NOT NULL,
  `nom_commune` varchar(50) NOT NULL,
  `id_wilaya` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `contenir1`
--

CREATE TABLE `contenir1` (
  `id_offre` int(11) NOT NULL,
  `id_medicament` int(11) NOT NULL,
  `qte_dispo` int(11) NOT NULL,
  `prix_u` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `contenir3`
--

CREATE TABLE `contenir3` (
  `id_transaction` int(11) NOT NULL,
  `id_medicament` int(11) NOT NULL,
  `qte_tr` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `demande_externe`
--

CREATE TABLE `demande_externe` (
  `id_dmE` int(11) NOT NULL,
  `date_heure_dme` datetime NOT NULL,
  `type_dme` varchar(20) DEFAULT NULL,
  `id_pharmacie` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `demande_interne`
--

CREATE TABLE `demande_interne` (
  `id_dmi` int(11) NOT NULL,
  `date_heure_dmi` datetime NOT NULL,
  `type_dmi` varchar(20) DEFAULT NULL,
  `id_utilisateur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `medicament`
--

CREATE TABLE `medicament` (
  `id_medicament` int(11) NOT NULL,
  `nom_medicament` varchar(50) NOT NULL,
  `dosage` varchar(30) DEFAULT NULL,
  `forme` varchar(30) DEFAULT NULL,
  `date_per` date DEFAULT NULL,
  `id_med` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `medicament_algerie`
--

CREATE TABLE `medicament_algerie` (
  `id_med` int(11) NOT NULL,
  `nom_m` varchar(50) NOT NULL,
  `forme` varchar(30) DEFAULT NULL,
  `voie` varchar(50) DEFAULT NULL,
  `statut_autorisation` varchar(25) DEFAULT NULL,
  `procedure_autorisation` varchar(25) DEFAULT NULL,
  `commercialisation` enum('oui','non') DEFAULT NULL,
  `date_autorisation` date DEFAULT NULL,
  `laboratoire` varchar(80) DEFAULT NULL,
  `generique` enum('Oui','Non') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `offre`
--

CREATE TABLE `offre` (
  `id_offre` int(11) NOT NULL,
  `date_heure_offre` datetime NOT NULL,
  `condition_speciale` text DEFAULT NULL,
  `id_dmE` int(11) DEFAULT NULL,
  `id_utilisateur` int(11) DEFAULT NULL,
  `id_pharmacie` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `pharmacie`
--

CREATE TABLE `pharmacie` (
  `id_pharmacie` int(11) NOT NULL,
  `nom_pharmacie` varchar(80) NOT NULL,
  `n_tlphn_pharmacie` varchar(10) DEFAULT NULL,
  `email_pharmacie` varchar(100) DEFAULT NULL,
  `id_commune` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `transaction`
--

CREATE TABLE `transaction` (
  `id_transaction` int(11) NOT NULL,
  `date_transaction` datetime NOT NULL,
  `type_transaction` varchar(15) DEFAULT NULL,
  `statut` varchar(25) DEFAULT NULL,
  `id_offre` int(11) DEFAULT NULL,
  `id_dmi` int(11) DEFAULT NULL,
  `id_dmE` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id_utilisateur` int(11) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `email_utilisateur` varchar(100) NOT NULL,
  `mot_de_passe_utilisateur` varchar(255) NOT NULL,
  `n_tlphn` varchar(10) DEFAULT NULL,
  `role` enum('admin_global','admin_pharmacie','employe') NOT NULL DEFAULT 'employe',
  `id_pharmacie` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `wilaya`
--

CREATE TABLE `wilaya` (
  `id_wilaya` int(11) NOT NULL,
  `nom_wilaya` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `commune`
--
ALTER TABLE `commune`
  ADD PRIMARY KEY (`id_commune`),
  ADD KEY `id_wilaya` (`id_wilaya`);

--
-- Index pour la table `contenir1`
--
ALTER TABLE `contenir1`
  ADD PRIMARY KEY (`id_offre`,`id_medicament`),
  ADD KEY `id_medicament` (`id_medicament`);

--
-- Index pour la table `contenir3`
--
ALTER TABLE `contenir3`
  ADD PRIMARY KEY (`id_transaction`,`id_medicament`),
  ADD KEY `id_medicament` (`id_medicament`);

--
-- Index pour la table `demande_externe`
--
ALTER TABLE `demande_externe`
  ADD PRIMARY KEY (`id_dmE`),
  ADD KEY `id_pharmacie` (`id_pharmacie`);

--
-- Index pour la table `demande_interne`
--
ALTER TABLE `demande_interne`
  ADD PRIMARY KEY (`id_dmi`),
  ADD KEY `id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `medicament`
--
ALTER TABLE `medicament`
  ADD PRIMARY KEY (`id_medicament`),
  ADD KEY `id_med` (`id_med`);

--
-- Index pour la table `medicament_algerie`
--
ALTER TABLE `medicament_algerie`
  ADD PRIMARY KEY (`id_med`);

--
-- Index pour la table `offre`
--
ALTER TABLE `offre`
  ADD PRIMARY KEY (`id_offre`),
  ADD KEY `id_dmE` (`id_dmE`),
  ADD KEY `id_utilisateur` (`id_utilisateur`),
  ADD KEY `id_pharmacie` (`id_pharmacie`);

--
-- Index pour la table `pharmacie`
--
ALTER TABLE `pharmacie`
  ADD PRIMARY KEY (`id_pharmacie`),
  ADD KEY `id_commune` (`id_commune`);

--
-- Index pour la table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id_transaction`),
  ADD KEY `id_offre` (`id_offre`),
  ADD KEY `id_dmi` (`id_dmi`),
  ADD KEY `id_dmE` (`id_dmE`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id_utilisateur`),
  ADD UNIQUE KEY `email_utilisateur` (`email_utilisateur`),
  ADD KEY `id_pharmacie` (`id_pharmacie`);

--
-- Index pour la table `wilaya`
--
ALTER TABLE `wilaya`
  ADD PRIMARY KEY (`id_wilaya`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `commune`
--
ALTER TABLE `commune`
  MODIFY `id_commune` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `demande_externe`
--
ALTER TABLE `demande_externe`
  MODIFY `id_dmE` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `demande_interne`
--
ALTER TABLE `demande_interne`
  MODIFY `id_dmi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `medicament`
--
ALTER TABLE `medicament`
  MODIFY `id_medicament` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `medicament_algerie`
--
ALTER TABLE `medicament_algerie`
  MODIFY `id_med` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `offre`
--
ALTER TABLE `offre`
  MODIFY `id_offre` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `pharmacie`
--
ALTER TABLE `pharmacie`
  MODIFY `id_pharmacie` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id_transaction` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `wilaya`
--
ALTER TABLE `wilaya`
  MODIFY `id_wilaya` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commune`
--
ALTER TABLE `commune`
  ADD CONSTRAINT `commune_ibfk_1` FOREIGN KEY (`id_wilaya`) REFERENCES `wilaya` (`id_wilaya`);

--
-- Contraintes pour la table `contenir1`
--
ALTER TABLE `contenir1`
  ADD CONSTRAINT `contenir1_ibfk_1` FOREIGN KEY (`id_offre`) REFERENCES `offre` (`id_offre`),
  ADD CONSTRAINT `contenir1_ibfk_2` FOREIGN KEY (`id_medicament`) REFERENCES `medicament` (`id_medicament`);

--
-- Contraintes pour la table `contenir3`
--
ALTER TABLE `contenir3`
  ADD CONSTRAINT `contenir3_ibfk_1` FOREIGN KEY (`id_transaction`) REFERENCES `transaction` (`id_transaction`),
  ADD CONSTRAINT `contenir3_ibfk_2` FOREIGN KEY (`id_medicament`) REFERENCES `medicament` (`id_medicament`);

--
-- Contraintes pour la table `demande_externe`
--
ALTER TABLE `demande_externe`
  ADD CONSTRAINT `demande_externe_ibfk_1` FOREIGN KEY (`id_pharmacie`) REFERENCES `pharmacie` (`id_pharmacie`);

--
-- Contraintes pour la table `demande_interne`
--
ALTER TABLE `demande_interne`
  ADD CONSTRAINT `demande_interne_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`);

--
-- Contraintes pour la table `medicament`
--
ALTER TABLE `medicament`
  ADD CONSTRAINT `medicament_ibfk_1` FOREIGN KEY (`id_med`) REFERENCES `medicament_algerie` (`id_med`);

--
-- Contraintes pour la table `offre`
--
ALTER TABLE `offre`
  ADD CONSTRAINT `offre_ibfk_1` FOREIGN KEY (`id_dmE`) REFERENCES `demande_externe` (`id_dmE`),
  ADD CONSTRAINT `offre_ibfk_2` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`),
  ADD CONSTRAINT `offre_ibfk_3` FOREIGN KEY (`id_pharmacie`) REFERENCES `pharmacie` (`id_pharmacie`);

--
-- Contraintes pour la table `pharmacie`
--
ALTER TABLE `pharmacie`
  ADD CONSTRAINT `pharmacie_ibfk_1` FOREIGN KEY (`id_commune`) REFERENCES `commune` (`id_commune`);

--
-- Contraintes pour la table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`id_offre`) REFERENCES `offre` (`id_offre`),
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`id_dmi`) REFERENCES `demande_interne` (`id_dmi`),
  ADD CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`id_dmE`) REFERENCES `demande_externe` (`id_dmE`);

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `utilisateur_ibfk_1` FOREIGN KEY (`id_pharmacie`) REFERENCES `pharmacie` (`id_pharmacie`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
