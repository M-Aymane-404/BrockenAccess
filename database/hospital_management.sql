-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 30 déc. 2025 à 16:38
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `hospital_management`
--

-- --------------------------------------------------------

--
-- Structure de la table `appointments`
--

CREATE TABLE `appointments` (
  `id` bigint(20) NOT NULL,
  `patient_id` bigint(20) NOT NULL,
  `clinician_id` bigint(20) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reason` text DEFAULT NULL,
  `status` enum('Scheduled','Confirmed','Completed','Cancelled') DEFAULT 'Scheduled',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `appointments`
--

INSERT INTO `appointments` (`id`, `patient_id`, `clinician_id`, `date_time`, `reason`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '2024-01-15 08:00:00', 'Annual checkup', 'Scheduled', NULL, '2025-12-29 23:42:56', '2025-12-29 23:42:56'),
(2, 2, 2, '2024-01-15 09:30:00', 'Follow-up consultation', 'Confirmed', NULL, '2025-12-29 23:42:56', '2025-12-29 23:42:56'),
(3, 3, 3, '2024-01-15 13:00:00', 'Initial consultation', 'Scheduled', NULL, '2025-12-29 23:42:56', '2025-12-29 23:42:56'),
(4, 4, 3, '2024-01-16 10:00:00', 'Routine examination', 'Scheduled', NULL, '2025-12-29 23:42:56', '2025-12-29 23:42:56'),
(5, 1, 3, '2024-01-20 14:30:00', 'Specialist referral', 'Scheduled', NULL, '2025-12-29 23:42:56', '2025-12-29 23:42:56');

-- --------------------------------------------------------

--
-- Structure de la table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'clinical_staff', 'Group for all clinical staff members'),
(2, 'administrative_staff', 'Group for administrative staff'),
(3, 'management', 'Group for management level staff');

-- --------------------------------------------------------

--
-- Structure de la table `group_permissions`
--

CREATE TABLE `group_permissions` (
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `group_permissions`
--

INSERT INTO `group_permissions` (`group_id`, `permission_id`) VALUES
(1, 2),
(1, 3),
(1, 6),
(1, 7),
(2, 1),
(2, 2),
(2, 5),
(2, 6),
(3, 2),
(3, 6),
(3, 10),
(3, 11);

-- --------------------------------------------------------

--
-- Structure de la table `patients`
--

CREATE TABLE `patients` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `address` text DEFAULT NULL,
  `emergency_contact` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `patients`
--

INSERT INTO `patients` (`id`, `name`, `email`, `phone`, `date_of_birth`, `address`, `emergency_contact`, `created_at`, `updated_at`) VALUES
(1, 'Alice Johnson', 'alice@email.com', '555-0101', '1985-03-15', '123 Main St, City, State', 'Bob Johnson - 555-0102', '2025-12-29 23:42:56', '2025-12-29 23:42:56'),
(2, 'Bob Smith', 'bob@email.com', '555-0202', '1978-07-22', '456 Oak Ave, City, State', 'Carol Smith - 555-0203', '2025-12-29 23:42:56', '2025-12-29 23:42:56'),
(3, 'Carol Davis', 'carol@email.com', '555-0303', '1992-11-08', '789 Pine Rd, City, State', 'David Davis - 555-0304', '2025-12-29 23:42:56', '2025-12-29 23:42:56'),
(4, 'David Wilson', 'david@email.com', '555-0404', '1965-05-30', '321 Elm St, City, State', 'Eve Wilson - 555-0405', '2025-12-29 23:42:56', '2025-12-29 23:42:56');

-- --------------------------------------------------------

--
-- Structure de la table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `description`) VALUES
(1, 'appointments:create', 'Create new appointments'),
(2, 'appointments:read', 'View appointments'),
(3, 'appointments:update', 'Update existing appointments'),
(4, 'appointments:delete', 'Delete appointments'),
(5, 'patients:create', 'Create new patient records'),
(6, 'patients:read', 'View patient information'),
(7, 'patients:update', 'Update patient information'),
(8, 'patients:delete', 'Delete patient records'),
(9, 'users:create', 'Create new users'),
(10, 'users:read', 'View user information'),
(11, 'users:update', 'Update user information'),
(12, 'users:delete', 'Delete users'),
(13, 'roles:manage', 'Manage roles and permissions'),
(14, 'system:admin', 'Full system administration');

-- --------------------------------------------------------

--
-- Structure de la table `resource_acl`
--

CREATE TABLE `resource_acl` (
  `id` bigint(20) NOT NULL,
  `resource_type` varchar(100) NOT NULL,
  `resource_id` varchar(255) NOT NULL,
  `subject_type` enum('user','role') NOT NULL,
  `subject_id` varchar(255) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `allowed` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`) VALUES
(1, 'admin', 'System administrator with full access'),
(2, 'clinician', 'Healthcare provider who can manage appointments and patients'),
(3, 'receptionist', 'Front desk staff who can schedule appointments'),
(4, 'nurse', 'Nursing staff who can view and update patient information'),
(5, 'patient', 'Patient role for self-service access'),
(6, 'manager', 'permet de gere les patients ');

-- --------------------------------------------------------

--
-- Structure de la table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(2, 2),
(2, 3),
(2, 6),
(2, 7),
(3, 1),
(3, 2),
(3, 5),
(3, 6),
(4, 2),
(4, 3),
(4, 6),
(4, 7),
(5, 2),
(5, 6),
(6, 1),
(6, 2),
(6, 3),
(6, 6),
(6, 7);

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `revoked_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `session_token`, `ip_address`, `user_agent`, `expires_at`, `created_at`, `revoked_at`) VALUES
(1, 1, 'a6e7e7796f661c6b1cebe2628324bbb7197d4b238684bb7ddfd91769f21adbdb', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 00:09:55', '2025-12-30 01:38:06'),
(2, 1, '353a90edba4af3ec1db7b97b1af4f845205730e64f1a7af8a99b6660f2c5f980', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 00:09:55', '2025-12-30 01:38:06'),
(3, 1, 'b08974fd5cfd253fe2ca76117a53ddb36b817ae01ddc7f94d616f965e3f4a63b', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 00:09:55', '2025-12-30 01:38:06'),
(4, 1, '84cc8d503946e049c7dd14c9f1478778d6e6ac3da7184d7b8aa3d013f9904e55', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 00:09:55', '2025-12-30 01:38:06'),
(5, 1, '06db53a4829894e3018f60709a07fcbaca0ecc3664d7a976621b3fa82cfeef92', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 00:09:56', '2025-12-30 01:38:06'),
(6, 1, '978827e7e2d8b0e0afd9520e90c9ee01118b08cd296f0e6c326501a49a4b0768', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 00:09:58', '2025-12-30 01:38:06'),
(7, 1, '6a47d35e2aaf6632df162de7ab186e151d0b3ca2ce3957ae2c5d823242c4ba3f', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 00:11:55', '2025-12-30 01:38:06'),
(8, 1, '6a35a67057eaf4b913377191f57cdbac4ac94a4c95849ae07ab785b59a5edb38', '127.0.0.1', 'Debug Script', '2025-12-30 01:38:06', '2025-12-30 00:22:22', '2025-12-30 01:38:06'),
(9, 1, 'da7c3f3ab771d02cd4152c40e44ced748112fdede71dcb692f60ffd905abadc5', '::1', 'PostmanRuntime/7.51.0', '2025-12-30 01:38:06', '2025-12-30 00:26:03', '2025-12-30 01:38:06'),
(10, 1, '67cbe47ee8bfee9236eeb924c46fae0c8455e3ea3ab1081e72222486e681080c', '::1', 'PostmanRuntime/7.51.0', '2025-12-30 01:38:06', '2025-12-30 00:29:10', '2025-12-30 01:38:06'),
(11, 1, '5ac08f90973599868b99ff3505d49fe683fa4754c51b9b31a6c4bff7ae633c5f', '::1', 'PostmanRuntime/7.51.0', '2025-12-30 01:38:06', '2025-12-30 00:31:09', '2025-12-30 01:38:06'),
(12, 1, 'cbf91ef25fd79ceb9fe49c544593083610bc30620ceb11975f76d7acd50f6628', '::1', 'PostmanRuntime/7.51.0', '2025-12-30 01:38:06', '2025-12-30 00:40:03', '2025-12-30 01:38:06'),
(13, 1, 'a9a2d1bff3635dfb60ba649de444a025c521842cb91e9ab3ef032e497adbe124', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 00:44:36', '2025-12-30 01:38:06'),
(14, 1, '541b0985ad32baea04c99e5af83b1e768a7977fb8c45220f8c41026a85d25165', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 00:45:59', '2025-12-30 01:38:06'),
(15, 1, '9ce5cb167973e44a51a0ef31c42efdcd50559ccf803f10b9b26aef5af514dd39', '::1', 'PostmanRuntime/7.51.0', '2025-12-30 01:38:06', '2025-12-30 00:52:02', '2025-12-30 01:38:06'),
(16, 1, 'a057d10dc0054a70de37288a27d96b41cfe3f1da8929cf4f69cd8ef4d5f67980', '::1', 'PostmanRuntime/7.51.0', '2025-12-30 01:38:06', '2025-12-30 01:03:23', '2025-12-30 01:38:06'),
(17, 1, 'd864e1e0b1936814f5776fd566646d49f39197806cbf7261f01e96c082ece69f', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 01:11:31', '2025-12-30 01:38:06'),
(18, 1, 'd5203873e56ca221ccbd4de9dc9015dd93867be5939f162eacd24d940f37dc0d', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 01:31:26', '2025-12-30 01:38:06'),
(19, 1, '36f7e8fb1920b2134b587d64f7a5b6d8e36ddc101c44b6831c44ec3e621e7327', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 01:35:20', '2025-12-30 01:38:06'),
(20, 1, 'be3cdeeb9361d8a226fc23f6d60fa7f14a92484f1d8726369e3fc5f2fd264346', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:38:06', '2025-12-30 01:37:40', '2025-12-30 01:38:06'),
(21, 1, '8bed5653dc9ef45814349afe6996fdcd02f8299fc6cc603c66eed00373b761e8', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:53:16', '2025-12-30 01:39:37', '2025-12-30 01:53:16'),
(22, 6, '4da6832bfa5c8c7d7ea0ce8f47cfef1fbe478d3919f20e5241340aa5ac96b5ee', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:51:14', '2025-12-30 01:51:14', '2025-12-30 01:51:14'),
(23, 6, '5634a16184bfa9ab6010de57941bc806ec76f1aa33f9feef4e72ab4054b29ee0', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:51:23', '2025-12-30 01:51:14', '2025-12-30 01:51:23'),
(24, 6, '1dd5a48e51ff05cfd0306133db6c820da8ed200f3d5f67323398a73dcfeb2eff', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:51:23', '2025-12-30 01:51:23', '2025-12-30 01:51:23'),
(25, 6, '383a48ccee1c8aa1743db0c7d0b9e19cf7d02e4976aa553f531db51d87b780cd', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:51:24', '2025-12-30 01:51:23', '2025-12-30 01:51:24'),
(26, 6, 'cb080f7975aee25c88aba0aeb617019a7469ddbb265bc24c712c47ee93b0fe53', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:51:24', '2025-12-30 01:51:24', '2025-12-30 01:51:24'),
(27, 6, '6482628d599d542a150e848e7215315126bb6a9fa4e653d47c1f1361247d6088', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:51:24', '2025-12-30 01:51:24', '2025-12-30 01:51:24'),
(28, 6, 'fa4acfc71a0c2d3da188d57eba46af22484edc428fd42d447288ecaff188bbe6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:51:35', '2025-12-30 01:51:24', '2025-12-30 01:51:35'),
(29, 6, '8c13b28f134111ff1132a28c7c50473950542d215478c1f2ba2f3ae96a83a1bb', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:53:18', '2025-12-30 01:51:35', '2025-12-30 01:53:18'),
(30, 1, 'a349350ea302a2fc9927b972b89e2117e850e0337b0b9791c4d84536bc73fb75', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:54:00', '2025-12-30 01:53:16', '2025-12-30 01:54:00'),
(31, 6, '424674137062bffebfe6c61c8c240c2730dc92f40e3a36310ea103fd5e193b24', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:54:16', '2025-12-30 01:53:18', '2025-12-30 01:54:16'),
(32, 1, 'd0f03150f53acfb6bdf8672f9d182860d90879427c833674dd11658b4ab43738', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 02:08:50', '2025-12-30 01:54:00', '2025-12-30 02:08:50'),
(33, 6, '590d53231f661582c19923b9c953c0888896d4ca3a3236189157ae840a5f9205', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:54:17', '2025-12-30 01:54:16', '2025-12-30 01:54:17'),
(34, 6, '4ac403fd1b8767663952636774840b3accf91c792c6afd7ba52a48ea221216f3', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:54:18', '2025-12-30 01:54:17', '2025-12-30 01:54:18'),
(35, 6, '8c70a592c16cd8ac4a874f86de3d6d286a1f15146866404b447f391eea7cb3c7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:54:18', '2025-12-30 01:54:18', '2025-12-30 01:54:18'),
(36, 6, 'b4e06eae3daf3c579b25c872050a90d0108297ec65baaec1f30125aa1149f5e8', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:54:19', '2025-12-30 01:54:18', '2025-12-30 01:54:19'),
(37, 6, '482bc3038be42ad988f5d25166870f4816f136ad0ec762c92d8104387acd3d1b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:57:06', '2025-12-30 01:54:19', '2025-12-30 01:57:06'),
(38, 6, '1dc6ff3ff44d67a6db35e77be7871cc42953bd5e845e641ce23cb290e9dc7a70', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 01:57:17', '2025-12-30 01:57:06', '2025-12-30 01:57:17'),
(39, 6, 'ef951fe43083f5fc969937f2c5f8c1fdd30be34fb6bf78932db06764d9d4a9aa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-31 01:57:17', '2025-12-30 01:57:17', NULL),
(40, 4, 'a82e58fe96e711f23da5fe26d475a8809d9067b84bd636f6f83cd38d94d6fad1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 02:04:17', '2025-12-30 02:01:28', '2025-12-30 02:04:17'),
(41, 4, '8b8e50650f18e6cb3959dc24e1438e39b3576b7fc7574907059e20cc7929d4ba', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 02:18:19', '2025-12-30 02:04:17', '2025-12-30 02:18:19'),
(42, 1, '979c8c7dbcbe1dd3de507151c6dcd69a589705a65a304f47febdc1d34241069a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 02:11:41', '2025-12-30 02:08:50', '2025-12-30 02:11:41'),
(43, 1, '301e40e3d2ad977d619489b17e1e9697b8eefd3a227ab01577303445f4e6f4d1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 02:26:37', '2025-12-30 02:11:41', '2025-12-30 02:26:37'),
(44, 4, 'fadbb1a091bfa73f342283cbeb3d77f1ff99ab3f0b06f9678f6e45e6d05128f1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 02:18:20', '2025-12-30 02:18:19', '2025-12-30 02:18:20'),
(45, 4, 'b8800aeafd988377fab057cfb8c7071cd74d4ebd9a6f547a0f2c8432d1d6171b', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 02:18:22', '2025-12-30 02:18:20', '2025-12-30 02:18:22'),
(46, 4, '37859424217a5d3d80ebb1dc01aaf39f1504f18bfec504f3320597afc55301be', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 02:18:32', '2025-12-30 02:18:22', '2025-12-30 02:18:32'),
(47, 4, '6aaa9383385fabd4a88936ea07349e655a6dc344decb3dd90dc32fe519ce0a3e', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 02:18:40', '2025-12-30 02:18:32', '2025-12-30 02:18:40'),
(48, 4, 'e384fcd8dc119b8fb5f5cc23865a530a60039469fed51dd8b3cc4bc8130df6e9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 02:19:10', '2025-12-30 02:18:40', '2025-12-30 02:19:10'),
(49, 4, '915c809b6cf8419157d81f6e389ec4deaf157e9315e43f38b41ccae56ffa4c89', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 02:19:19', '2025-12-30 02:19:10', '2025-12-30 02:19:19'),
(50, 4, '14ecc70849d1e1dbeb680636981b49dc197a963111ac6f88d7f85ffe8c23b208', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-30 02:20:26', '2025-12-30 02:19:19', '2025-12-30 02:20:26'),
(51, 4, 'ad54f52b7ec744ead8a94a990f143140edf2aebf762da5aca67f5c4e430899d2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-31 02:20:26', '2025-12-30 02:20:26', NULL),
(52, 1, '958d7016bb60b7c8a4cc1d81dbdd9aaccf6d9105e3f3431a5cfd8df13425af2d', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-31 02:26:37', '2025-12-30 02:26:37', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `role_id`, `created_at`) VALUES
(1, 'Admin User', 'admin@hospital.com', '$2y$10$KR9LpnF3QkOYJYieoxL8qOVe36WaxIb0nDGPL1UvfTvSTnJOX7NOC', 1, '2025-12-29 23:42:56'),
(2, 'Dr. Smith', 'drsmith@hospital.com', '$2y$10$KR9LpnF3QkOYJYieoxL8qOVe36WaxIb0nDGPL1UvfTvSTnJOX7NOC', 2, '2025-12-29 23:42:56'),
(3, 'Dr. Johnson', 'drjohnson@hospital.com', '$2y$10$KR9LpnF3QkOYJYieoxL8qOVe36WaxIb0nDGPL1UvfTvSTnJOX7NOC', 2, '2025-12-29 23:42:56'),
(4, 'Nurse Wilson', 'nwilson@hospital.com', '$2y$10$KR9LpnF3QkOYJYieoxL8qOVe36WaxIb0nDGPL1UvfTvSTnJOX7NOC', 4, '2025-12-29 23:42:56'),
(5, 'Receptionist Brown', 'rbrown@hospital.com', '$2y$10$KR9LpnF3QkOYJYieoxL8qOVe36WaxIb0nDGPL1UvfTvSTnJOX7NOC', 3, '2025-12-29 23:42:56'),
(6, 'John Patient', 'jpatient@email.com', '$2y$10$KR9LpnF3QkOYJYieoxL8qOVe36WaxIb0nDGPL1UvfTvSTnJOX7NOC', 5, '2025-12-29 23:42:56');

-- --------------------------------------------------------

--
-- Structure de la table `user_groups`
--

CREATE TABLE `user_groups` (
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user_groups`
--

INSERT INTO `user_groups` (`user_id`, `group_id`) VALUES
(1, 3),
(2, 1),
(3, 1),
(4, 1),
(5, 2);

-- --------------------------------------------------------

--
-- Structure de la table `user_permissions`
--

CREATE TABLE `user_permissions` (
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `allowed` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 4),
(5, 3),
(6, 5);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_appointments_patient` (`patient_id`),
  ADD KEY `idx_appointments_clinician` (`clinician_id`),
  ADD KEY `idx_appointments_datetime` (`date_time`);

--
-- Index pour la table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `group_permissions`
--
ALTER TABLE `group_permissions`
  ADD PRIMARY KEY (`group_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Index pour la table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `resource_acl`
--
ALTER TABLE `resource_acl`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_id` (`permission_id`),
  ADD KEY `idx_resource_acl_resource` (`resource_type`,`resource_id`);

--
-- Index pour la table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_token` (`session_token`),
  ADD KEY `idx_sessions_token` (`session_token`),
  ADD KEY `idx_sessions_user` (`user_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- Index pour la table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`user_id`,`group_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Index pour la table `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD PRIMARY KEY (`user_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Index pour la table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `resource_acl`
--
ALTER TABLE `resource_acl`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`clinician_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `group_permissions`
--
ALTER TABLE `group_permissions`
  ADD CONSTRAINT `group_permissions_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `resource_acl`
--
ALTER TABLE `resource_acl`
  ADD CONSTRAINT `resource_acl_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`);

--
-- Contraintes pour la table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Contraintes pour la table `user_groups`
--
ALTER TABLE `user_groups`
  ADD CONSTRAINT `user_groups_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_groups_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD CONSTRAINT `user_permissions_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_permissions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
