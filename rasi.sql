-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 15, 2021 at 12:57 PM
-- Server version: 10.0.38-MariaDB-0ubuntu0.16.04.1
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rasi`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_url` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_tokens`
--

CREATE TABLE `api_tokens` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metadata` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `transient` tinyint(4) NOT NULL DEFAULT '0',
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audits`
--

CREATE TABLE `audits` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `event` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auditable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auditable_id` bigint(20) UNSIGNED NOT NULL,
  `old_values` text COLLATE utf8mb4_unicode_ci,
  `new_values` text COLLATE utf8mb4_unicode_ci,
  `url` text COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audits`
--

INSERT INTO `audits` (`id`, `user_type`, `user_id`, `event`, `auditable_type`, `auditable_id`, `old_values`, `new_values`, `url`, `ip_address`, `user_agent`, `tags`, `created_at`, `updated_at`) VALUES
(1, 'App\\User', 1, 'created', 'App\\Models\\Unit', 1, '[]', '{\"name\":\"SPM\",\"description\":null,\"id\":1}', 'http://stage2.ngstpl.com/api/unit', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 15:35:52', '2020-09-23 15:35:52'),
(2, 'App\\User', 1, 'created', 'App\\Models\\Department', 1, '[]', '{\"unit_id\":1,\"name\":\"Issue\",\"description\":null,\"is_last\":0,\"id\":1}', 'http://stage2.ngstpl.com/api/department', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 15:36:19', '2020-09-23 15:36:19'),
(3, 'App\\User', 1, 'created', 'App\\Models\\Department', 2, '[]', '{\"unit_id\":1,\"name\":\"FILLING\",\"description\":null,\"is_last\":0,\"id\":2}', 'http://stage2.ngstpl.com/api/department', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 15:36:32', '2020-09-23 15:36:32'),
(4, 'App\\User', 1, 'created', 'App\\Models\\Department', 3, '[]', '{\"unit_id\":1,\"name\":\"JOOL TOOL\",\"description\":null,\"is_last\":0,\"id\":3}', 'http://stage2.ngstpl.com/api/department', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:10:02', '2020-09-23 16:10:02'),
(5, 'App\\User', 1, 'created', 'App\\Models\\Department', 4, '[]', '{\"unit_id\":1,\"name\":\"LASER\",\"description\":null,\"is_last\":0,\"id\":4}', 'http://stage2.ngstpl.com/api/department', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:10:11', '2020-09-23 16:10:11'),
(6, 'App\\User', 1, 'created', 'App\\Models\\Department', 5, '[]', '{\"unit_id\":1,\"name\":\"LAPPING\",\"description\":null,\"is_last\":0,\"id\":5}', 'http://stage2.ngstpl.com/api/department', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:10:18', '2020-09-23 16:10:18'),
(7, 'App\\User', 1, 'created', 'App\\Models\\Department', 6, '[]', '{\"unit_id\":1,\"name\":\"SETTING\",\"description\":null,\"is_last\":0,\"id\":6}', 'http://stage2.ngstpl.com/api/department', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:10:27', '2020-09-23 16:10:27'),
(8, 'App\\User', 1, 'created', 'App\\Models\\Department', 7, '[]', '{\"unit_id\":1,\"name\":\"BUFFING\",\"description\":null,\"is_last\":0,\"id\":7}', 'http://stage2.ngstpl.com/api/department', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:10:41', '2020-09-23 16:10:41'),
(9, 'App\\User', 1, 'created', 'App\\Models\\Department', 8, '[]', '{\"unit_id\":1,\"name\":\"FC\",\"description\":null,\"is_last\":1,\"id\":8}', 'http://stage2.ngstpl.com/api/department', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:10:51', '2020-09-23 16:10:51'),
(10, 'App\\User', 1, 'created', 'App\\Models\\Process', 1, '[]', '{\"name\":\"SOLDERING\",\"description\":null,\"code\":\"PC101\",\"id\":1}', 'http://stage2.ngstpl.com/api/process', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:11:28', '2020-09-23 16:11:28'),
(11, 'App\\User', 1, 'created', 'App\\Models\\Process', 2, '[]', '{\"name\":\"FILLING\",\"description\":null,\"code\":\"PC102\",\"id\":2}', 'http://stage2.ngstpl.com/api/process', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:11:36', '2020-09-23 16:11:36'),
(12, 'App\\User', 1, 'created', 'App\\Models\\Process', 3, '[]', '{\"name\":\"JOOL TOOL\",\"description\":null,\"code\":\"PC103\",\"id\":3}', 'http://stage2.ngstpl.com/api/process', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:11:43', '2020-09-23 16:11:43'),
(13, 'App\\User', 1, 'created', 'App\\Models\\Process', 4, '[]', '{\"name\":\"LASER\",\"description\":null,\"code\":\"PC104\",\"id\":4}', 'http://stage2.ngstpl.com/api/process', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:11:49', '2020-09-23 16:11:49'),
(14, 'App\\User', 1, 'created', 'App\\Models\\Process', 5, '[]', '{\"name\":\"LAPPING\",\"description\":null,\"code\":\"PC105\",\"id\":5}', 'http://stage2.ngstpl.com/api/process', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:11:57', '2020-09-23 16:11:57'),
(15, 'App\\User', 1, 'created', 'App\\Models\\Process', 6, '[]', '{\"name\":\"SETTING\",\"description\":null,\"code\":\"PC106\",\"id\":6}', 'http://stage2.ngstpl.com/api/process', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:12:04', '2020-09-23 16:12:04'),
(16, 'App\\User', 1, 'created', 'App\\Models\\Employee', 1, '[]', '{\"department_id\":2,\"name\":\"Sakthi\",\"code\":\"E01\",\"description\":null,\"user_id\":2,\"id\":1}', 'http://stage2.ngstpl.com/api/employee', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:13:24', '2020-09-23 16:13:24'),
(17, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 1, '[]', '{\"employee_id\":1,\"process_id\":1,\"id\":1}', 'http://stage2.ngstpl.com/api/employee', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:13:24', '2020-09-23 16:13:24'),
(18, 'App\\User', 1, 'created', 'App\\Models\\Employee', 2, '[]', '{\"department_id\":2,\"name\":\"Arul\",\"code\":\"E02\",\"description\":null,\"user_id\":3,\"id\":2}', 'http://stage2.ngstpl.com/api/employee', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:13:49', '2020-09-23 16:13:49'),
(19, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 2, '[]', '{\"employee_id\":2,\"process_id\":1,\"id\":2}', 'http://stage2.ngstpl.com/api/employee', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:13:49', '2020-09-23 16:13:49'),
(20, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 3, '[]', '{\"employee_id\":2,\"process_id\":2,\"id\":3}', 'http://stage2.ngstpl.com/api/employee', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:13:49', '2020-09-23 16:13:49'),
(21, 'App\\User', 1, 'created', 'App\\Models\\Employee', 3, '[]', '{\"department_id\":3,\"name\":\"Arun\",\"code\":\"E03\",\"description\":null,\"user_id\":4,\"id\":3}', 'http://stage2.ngstpl.com/api/employee', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:53:45', '2020-09-23 16:53:45'),
(22, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 4, '[]', '{\"employee_id\":3,\"process_id\":3,\"id\":4}', 'http://stage2.ngstpl.com/api/employee', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:53:45', '2020-09-23 16:53:45'),
(23, 'App\\User', 1, 'created', 'App\\Models\\Employee', 4, '[]', '{\"department_id\":3,\"name\":\"Vanmathi\",\"code\":\"E04\",\"description\":null,\"user_id\":5,\"id\":4}', 'http://stage2.ngstpl.com/api/employee', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:54:08', '2020-09-23 16:54:08'),
(24, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 5, '[]', '{\"employee_id\":4,\"process_id\":4,\"id\":5}', 'http://stage2.ngstpl.com/api/employee', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-23 16:54:08', '2020-09-23 16:54:08'),
(25, 'App\\User', 1, 'created', 'App\\Models\\Employee', 5, '[]', '{\"department_id\":4,\"name\":\"Mohammed\",\"code\":\"E004\",\"description\":null,\"user_id\":6,\"id\":5}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:12:45', '2020-09-24 07:12:45'),
(26, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 6, '[]', '{\"employee_id\":5,\"process_id\":4,\"id\":6}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:12:45', '2020-09-24 07:12:45'),
(27, 'App\\User', 1, 'created', 'App\\Models\\Employee', 6, '[]', '{\"department_id\":4,\"name\":\"Paneer\",\"code\":\"E005\",\"description\":null,\"user_id\":7,\"id\":6}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:13:19', '2020-09-24 07:13:19'),
(28, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 7, '[]', '{\"employee_id\":6,\"process_id\":4,\"id\":7}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:13:19', '2020-09-24 07:13:19'),
(29, 'App\\User', 1, 'created', 'App\\Models\\Employee', 7, '[]', '{\"department_id\":5,\"name\":\"Loganathan\",\"code\":\"E006\",\"description\":null,\"user_id\":8,\"id\":7}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:14:08', '2020-09-24 07:14:08'),
(30, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 8, '[]', '{\"employee_id\":7,\"process_id\":5,\"id\":8}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:14:08', '2020-09-24 07:14:08'),
(31, 'App\\User', 1, 'created', 'App\\Models\\Employee', 8, '[]', '{\"department_id\":5,\"name\":\"Ramesh\",\"code\":\"E007\",\"description\":null,\"user_id\":9,\"id\":8}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:14:38', '2020-09-24 07:14:38'),
(32, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 9, '[]', '{\"employee_id\":8,\"process_id\":5,\"id\":9}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:14:38', '2020-09-24 07:14:38'),
(33, 'App\\User', 1, 'created', 'App\\Models\\Employee', 9, '[]', '{\"department_id\":6,\"name\":\"Vignesh\",\"code\":\"E008\",\"description\":null,\"user_id\":10,\"id\":9}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:15:49', '2020-09-24 07:15:49'),
(34, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 10, '[]', '{\"employee_id\":9,\"process_id\":6,\"id\":10}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:15:49', '2020-09-24 07:15:49'),
(35, 'App\\User', 1, 'created', 'App\\Models\\Employee', 10, '[]', '{\"department_id\":6,\"name\":\"Vinoth\",\"code\":\"E009\",\"description\":null,\"user_id\":11,\"id\":10}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:16:14', '2020-09-24 07:16:14'),
(36, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 11, '[]', '{\"employee_id\":10,\"process_id\":6,\"id\":11}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:16:14', '2020-09-24 07:16:14'),
(37, 'App\\User', 1, 'created', 'App\\Models\\Process', 7, '[]', '{\"name\":\"Buffing\",\"description\":null,\"code\":\"PC107\",\"id\":7}', 'http://stage2.ngstpl.com/api/process', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:17:17', '2020-09-24 07:17:17'),
(38, 'App\\User', 1, 'created', 'App\\Models\\Employee', 11, '[]', '{\"department_id\":7,\"name\":\"Mohan\",\"code\":\"E010\",\"description\":null,\"user_id\":12,\"id\":11}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:17:54', '2020-09-24 07:17:54'),
(39, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 12, '[]', '{\"employee_id\":11,\"process_id\":7,\"id\":12}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:17:54', '2020-09-24 07:17:54'),
(40, 'App\\User', 1, 'created', 'App\\Models\\Employee', 12, '[]', '{\"department_id\":7,\"name\":\"Ram\",\"code\":\"E011\",\"description\":null,\"user_id\":13,\"id\":12}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:18:25', '2020-09-24 07:18:25'),
(41, 'App\\User', 1, 'created', 'App\\Models\\EmployeeProcess', 13, '[]', '{\"employee_id\":12,\"process_id\":7,\"id\":13}', 'http://stage2.ngstpl.com/api/employee', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:18:25', '2020-09-24 07:18:25'),
(42, 'App\\User', 1, 'created', 'App\\Models\\ProductCategory', 1, '[]', '{\"parent_product_category_id\":null,\"name\":\"Ring\",\"description\":null,\"id\":1}', 'http://stage2.ngstpl.com/api/product-category', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:19:02', '2020-09-24 07:19:02'),
(43, 'App\\User', 1, 'created', 'App\\Models\\ProductCategory', 2, '[]', '{\"parent_product_category_id\":1,\"name\":\"GRing\",\"description\":null,\"id\":2}', 'http://stage2.ngstpl.com/api/product-category', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:19:47', '2020-09-24 07:19:47'),
(44, 'App\\User', 1, 'created', 'App\\Models\\ProductCategory', 3, '[]', '{\"parent_product_category_id\":1,\"name\":\"BRing\",\"description\":null,\"id\":3}', 'http://stage2.ngstpl.com/api/product-category', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:20:01', '2020-09-24 07:20:01'),
(45, 'App\\User', 1, 'created', 'App\\Models\\ProductCategory', 4, '[]', '{\"parent_product_category_id\":1,\"name\":\"Lring\",\"description\":null,\"id\":4}', 'http://stage2.ngstpl.com/api/product-category', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:20:17', '2020-09-24 07:20:17'),
(46, 'App\\User', 1, 'created', 'App\\Models\\Uom', 1, '[]', '{\"name\":\"Piece\",\"description\":null,\"id\":1}', 'http://stage2.ngstpl.com/api/uom', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:28:52', '2020-09-24 07:28:52'),
(47, 'App\\User', 1, 'created', 'App\\Models\\Uom', 2, '[]', '{\"name\":\"Stones\",\"description\":null,\"id\":2}', 'http://stage2.ngstpl.com/api/uom', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:31:48', '2020-09-24 07:31:48'),
(48, 'App\\User', 1, 'created', 'App\\Models\\OtherAccessories', 1, '[]', '{\"name\":\"Link\",\"uom_id\":1,\"description\":null,\"id\":1}', 'http://stage2.ngstpl.com/api/other-accessories', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:32:48', '2020-09-24 07:32:48'),
(49, 'App\\User', 1, 'created', 'App\\Models\\OtherAccessories', 2, '[]', '{\"name\":\"Diamond\",\"uom_id\":2,\"description\":null,\"id\":2}', 'http://stage2.ngstpl.com/api/other-accessories', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:33:05', '2020-09-24 07:33:05'),
(50, 'App\\User', 1, 'created', 'App\\Models\\OtherAccessories', 3, '[]', '{\"name\":\"Color Stone\",\"uom_id\":2,\"description\":null,\"id\":3}', 'http://stage2.ngstpl.com/api/other-accessories', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:33:15', '2020-09-24 07:33:15'),
(51, 'App\\User', 1, 'created', 'App\\Models\\Configuration', 1, '[]', '{\"config_value\":\"4\",\"config_key\":\"precision\",\"id\":1}', 'http://stage2.ngstpl.com/api/configuration/save', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:33:36', '2020-09-24 07:33:36'),
(52, 'App\\User', 1, 'created', 'App\\Models\\Configuration', 2, '[]', '{\"bag_starting_department_id\":1,\"config_value\":0,\"config_key\":\"bag_starting_department\",\"id\":2}', 'http://stage2.ngstpl.com/api/configuration/save', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 07:33:36', '2020-09-24 07:33:36'),
(53, 'App\\User', 1, 'created', 'App\\Models\\Uploads', 1, '[]', '{\"uploaded_path\":\"public\\/attachments\\/t48lQ23cOJ5PZT9perRJANq6uqIIlRgaaY9jWwMc.jpeg\",\"random_key\":\"QiES8A8DtuxB5vYw90PB\",\"file_name\":\"Chrysanthemum.jpg\",\"file_size\":230155,\"user_id\":1,\"id\":1}', 'http://stage2.ngstpl.com/upload', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:02:25', '2020-09-24 15:02:25'),
(54, 'App\\User', 1, 'created', 'App\\Models\\Uploads', 2, '[]', '{\"uploaded_path\":\"public\\/attachments\\/I8Aep2a5QPIiCamerce5xGV3AovgWV0S8E2QF19z.jpeg\",\"random_key\":\"ZP3uyv6KkaxX8eAejn5j\",\"file_name\":\"Desert.jpg\",\"file_size\":250942,\"user_id\":1,\"id\":2}', 'http://stage2.ngstpl.com/upload', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:02:39', '2020-09-24 15:02:39'),
(55, 'App\\User', 1, 'created', 'App\\Models\\Uploads', 3, '[]', '{\"uploaded_path\":\"public\\/attachments\\/ObDcytL2dn4W9j4MXa1FdmbSBKUbrR8Uu99LfSqy.jpeg\",\"random_key\":\"2P5Qw8nJFnr30KdNDWbq\",\"file_name\":\"Hydrangeas.jpg\",\"file_size\":170442,\"user_id\":1,\"id\":3}', 'http://stage2.ngstpl.com/upload', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:02:54', '2020-09-24 15:02:54'),
(56, 'App\\User', 1, 'created', 'App\\Models\\Product', 1, '[]', '{\"product_category_id\":1,\"name\":\"Male Ring\",\"description\":null,\"id\":1}', 'http://stage2.ngstpl.com/api/product', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(57, 'App\\User', 1, 'created', 'App\\Models\\Style', 1, '[]', '{\"sku\":\"Plain Ring\",\"weight\":\"2.584\",\"upload_id\":null,\"uom_id\":1,\"product_id\":1,\"id\":1}', 'http://stage2.ngstpl.com/api/product', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(58, 'App\\User', 1, 'created', 'App\\Models\\StyleImages', 1, '[]', '{\"upload_id\":1,\"style_id\":1,\"id\":1}', 'http://stage2.ngstpl.com/api/product', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(59, 'App\\User', 1, 'created', 'App\\Models\\StyleImages', 2, '[]', '{\"upload_id\":2,\"style_id\":1,\"id\":2}', 'http://stage2.ngstpl.com/api/product', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(60, 'App\\User', 1, 'created', 'App\\Models\\StyleImages', 3, '[]', '{\"upload_id\":3,\"style_id\":1,\"id\":3}', 'http://stage2.ngstpl.com/api/product', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(61, 'App\\User', 1, 'created', 'App\\Models\\StyleDepartmentLossApproval', 1, '[]', '{\"department_id\":2,\"percentage\":\"1\",\"style_id\":1,\"id\":1}', 'http://stage2.ngstpl.com/api/product', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(62, 'App\\User', 1, 'created', 'App\\Models\\StyleDepartmentLossApproval', 2, '[]', '{\"department_id\":4,\"percentage\":\"0.75\",\"style_id\":1,\"id\":2}', 'http://stage2.ngstpl.com/api/product', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(63, 'App\\User', 1, 'created', 'App\\Models\\StyleDepartmentLossApproval', 3, '[]', '{\"department_id\":5,\"percentage\":\"0.025\",\"style_id\":1,\"id\":3}', 'http://stage2.ngstpl.com/api/product', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(64, 'App\\User', 1, 'created', 'App\\Models\\StyleDepartmentLossApproval', 4, '[]', '{\"department_id\":6,\"percentage\":\"0.100\",\"style_id\":1,\"id\":4}', 'http://stage2.ngstpl.com/api/product', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(65, 'App\\User', 1, 'created', 'App\\Models\\StyleDepartmentLossApproval', 5, '[]', '{\"department_id\":7,\"percentage\":\"1\",\"style_id\":1,\"id\":5}', 'http://stage2.ngstpl.com/api/product', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(66, 'App\\User', 1, 'created', 'App\\Models\\Bag', 1, '[]', '{\"bag_number\":\"BG101\",\"parent_bag_id\":null,\"order_number\":\"101\",\"instructions\":null,\"department_id\":1,\"id\":1}', 'http://stage2.ngstpl.com/api/bag', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:06:32', '2020-09-24 15:06:32'),
(67, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 1, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"30\",\"upload_id\":null,\"instructions\":null,\"bag_id\":1,\"id\":1}', 'http://stage2.ngstpl.com/api/bag', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 15:06:32', '2020-09-24 15:06:32'),
(68, 'App\\User', 1, 'created', 'App\\Models\\Bag', 2, '[]', '{\"bag_number\":\"BG102\",\"parent_bag_id\":null,\"order_number\":\"102\",\"instructions\":null,\"department_id\":1,\"id\":2}', 'http://stage2.ngstpl.com/api/bag', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 16:08:21', '2020-09-24 16:08:21'),
(69, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 2, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"30\",\"upload_id\":null,\"instructions\":null,\"bag_id\":2,\"id\":2}', 'http://stage2.ngstpl.com/api/bag', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 16:08:21', '2020-09-24 16:08:21'),
(70, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 1, '[]', '{\"transaction_date\":\"2020-09-24\",\"bag_id\":1,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"30.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":1}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 16:13:06', '2020-09-24 16:13:06'),
(71, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 1, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 16:13:06', '2020-09-24 16:13:06'),
(72, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 1, '{\"weight\":30}', '{\"weight\":\"30.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 16:13:06', '2020-09-24 16:13:06'),
(73, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 1, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":1,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"30.0000\",\"uom_id\":1,\"transaction_id\":1,\"id\":1}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 16:13:06', '2020-09-24 16:13:06'),
(74, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 2, '[]', '{\"transaction_date\":\"2020-09-24\",\"bag_id\":2,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"30.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":2}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 16:13:23', '2020-09-24 16:13:23'),
(75, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 2, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":2}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 16:13:23', '2020-09-24 16:13:23'),
(76, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 2, '{\"weight\":30}', '{\"weight\":\"30.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 16:13:23', '2020-09-24 16:13:23'),
(77, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 2, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":2,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"30.0000\",\"uom_id\":1,\"transaction_id\":2,\"id\":2}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-09-24 16:13:23', '2020-09-24 16:13:23'),
(78, 'App\\User', 3, 'created', 'App\\Models\\Transaction', 3, '[]', '{\"transaction_date\":\"2020-09-24\",\"bag_id\":2,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"26.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":3}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0', NULL, '2020-09-24 16:31:53', '2020-09-24 16:31:53'),
(79, 'App\\User', 3, 'updated', 'App\\Models\\Bag', 2, '{\"status\":0}', '{\"status\":3}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0', NULL, '2020-09-24 16:31:53', '2020-09-24 16:31:53'),
(80, 'App\\User', 3, 'created', 'App\\Models\\TransactionItem', 3, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":2,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"26.0000\",\"uom_id\":1,\"transaction_id\":3,\"id\":3}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0', NULL, '2020-09-24 16:31:53', '2020-09-24 16:31:53'),
(81, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 1, '[]', '{\"type\":1,\"weight\":\"2\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":3,\"transaction_id\":3,\"bag_style_id\":2,\"date\":\"2020-09-24\",\"user_id\":3,\"id\":1}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0', NULL, '2020-09-24 16:31:53', '2020-09-24 16:31:53'),
(82, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 2, '[]', '{\"type\":0,\"weight\":\"2\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":3,\"transaction_id\":3,\"bag_style_id\":2,\"date\":\"2020-09-24\",\"user_id\":3,\"id\":2}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0', NULL, '2020-09-24 16:31:53', '2020-09-24 16:31:53'),
(83, 'App\\User', 2, 'created', 'App\\Models\\Transaction', 4, '[]', '{\"transaction_date\":\"2020-09-24\",\"bag_id\":1,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":4,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"26.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":4}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0', NULL, '2020-09-24 16:39:11', '2020-09-24 16:39:11'),
(84, 'App\\User', 2, 'updated', 'App\\Models\\Bag', 1, '{\"status\":0}', '{\"status\":3}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0', NULL, '2020-09-24 16:39:11', '2020-09-24 16:39:11'),
(85, 'App\\User', 2, 'created', 'App\\Models\\TransactionItem', 4, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":1,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"26.0000\",\"uom_id\":1,\"transaction_id\":4,\"id\":4}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0', NULL, '2020-09-24 16:39:11', '2020-09-24 16:39:11'),
(86, 'App\\User', 2, 'created', 'App\\Models\\TransactionItemLossDetails', 3, '[]', '{\"type\":1,\"weight\":\"3\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":4,\"transaction_id\":4,\"bag_style_id\":1,\"date\":\"2020-09-24\",\"user_id\":2,\"id\":3}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0', NULL, '2020-09-24 16:39:11', '2020-09-24 16:39:11'),
(87, 'App\\User', 2, 'created', 'App\\Models\\TransactionItemLossDetails', 4, '[]', '{\"type\":0,\"weight\":\"1\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":4,\"transaction_id\":4,\"bag_style_id\":1,\"date\":\"2020-09-24\",\"user_id\":2,\"id\":4}', 'http://stage2.ngstpl.com/api/transaction', '42.106.87.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0', NULL, '2020-09-24 16:39:11', '2020-09-24 16:39:11'),
(88, 'App\\User', 1, 'created', 'App\\Models\\Bag', 3, '[]', '{\"bag_number\":\"BG103\",\"parent_bag_id\":null,\"order_number\":\"103\",\"instructions\":null,\"department_id\":1,\"id\":3}', 'http://stage2.ngstpl.com/api/bag', '157.50.167.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-09-29 15:51:14', '2020-09-29 15:51:14'),
(89, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 3, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"10\",\"upload_id\":null,\"instructions\":null,\"bag_id\":3,\"id\":3}', 'http://stage2.ngstpl.com/api/bag', '157.50.167.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-09-29 15:51:14', '2020-09-29 15:51:14'),
(90, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 5, '[]', '{\"transaction_date\":\"2020-09-29\",\"bag_id\":3,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"10.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":5}', 'http://stage2.ngstpl.com/api/transaction', '157.50.167.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-09-29 15:51:38', '2020-09-29 15:51:38'),
(91, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 3, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://stage2.ngstpl.com/api/transaction', '157.50.167.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-09-29 15:51:38', '2020-09-29 15:51:38'),
(92, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 3, '{\"weight\":10}', '{\"weight\":\"10.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.50.167.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-09-29 15:51:38', '2020-09-29 15:51:38'),
(93, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 5, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":3,\"quantity\":10,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":1,\"transaction_id\":5,\"id\":5}', 'http://stage2.ngstpl.com/api/transaction', '157.50.167.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-09-29 15:51:38', '2020-09-29 15:51:38'),
(94, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 6, '[]', '{\"transaction_date\":\"2020-09-29\",\"bag_id\":3,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":4,\"to_employee_id\":null,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"8.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":6}', 'http://stage2.ngstpl.com/api/transaction', '157.50.167.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-09-29 15:53:28', '2020-09-29 15:53:28'),
(95, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 3, '{\"status\":0}', '{\"status\":3}', 'http://stage2.ngstpl.com/api/transaction', '157.50.167.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-09-29 15:53:28', '2020-09-29 15:53:28'),
(96, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 6, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":3,\"quantity\":10,\"weight\":\"10.0000\",\"receive_weight\":\"8.0000\",\"uom_id\":1,\"transaction_id\":6,\"id\":6}', 'http://stage2.ngstpl.com/api/transaction', '157.50.167.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-09-29 15:53:28', '2020-09-29 15:53:28'),
(97, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 5, '[]', '{\"type\":1,\"weight\":\"1\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":6,\"transaction_id\":6,\"bag_style_id\":3,\"date\":\"2020-09-29\",\"user_id\":2,\"id\":5}', 'http://stage2.ngstpl.com/api/transaction', '157.50.167.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-09-29 15:53:28', '2020-09-29 15:53:28'),
(98, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 6, '[]', '{\"type\":0,\"weight\":\"1\",\"admin_approval_loss_weight\":\"0.0750\",\"transaction_item_id\":6,\"transaction_id\":6,\"bag_style_id\":3,\"date\":\"2020-09-29\",\"user_id\":2,\"id\":6}', 'http://stage2.ngstpl.com/api/transaction', '157.50.167.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-09-29 15:53:28', '2020-09-29 15:53:28'),
(99, 'App\\User', 1, 'created', 'App\\Models\\Bag', 4, '[]', '{\"bag_number\":\"BG104\",\"parent_bag_id\":null,\"order_number\":\"104\",\"instructions\":null,\"department_id\":1,\"id\":4}', 'http://stage2.ngstpl.com/api/bag', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 10:29:43', '2020-10-01 10:29:43'),
(100, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 4, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"30\",\"upload_id\":null,\"instructions\":\"sample\",\"bag_id\":4,\"id\":4}', 'http://stage2.ngstpl.com/api/bag', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 10:29:43', '2020-10-01 10:29:43'),
(101, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 7, '[]', '{\"transaction_date\":\"2020-10-01\",\"bag_id\":4,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"30.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":7}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 10:30:15', '2020-10-01 10:30:15'),
(102, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 4, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":2}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 10:30:15', '2020-10-01 10:30:15'),
(103, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 4, '{\"weight\":30}', '{\"weight\":\"30.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 10:30:15', '2020-10-01 10:30:15'),
(104, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 7, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":4,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"30.0000\",\"uom_id\":1,\"transaction_id\":7,\"id\":7}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 10:30:15', '2020-10-01 10:30:15'),
(105, 'App\\User', 3, 'created', 'App\\Models\\Transaction', 8, '[]', '{\"transaction_date\":\"2020-10-01\",\"bag_id\":4,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"29.9900\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":8}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-01 10:36:43', '2020-10-01 10:36:43'),
(106, 'App\\User', 3, 'updated', 'App\\Models\\Bag', 4, '{\"status\":0}', '{\"status\":3}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-01 10:36:43', '2020-10-01 10:36:43'),
(107, 'App\\User', 3, 'created', 'App\\Models\\TransactionItem', 8, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":4,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"29.9900\",\"uom_id\":1,\"transaction_id\":8,\"id\":8}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-01 10:36:43', '2020-10-01 10:36:43'),
(108, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 7, '[]', '{\"type\":1,\"weight\":\"0.0050\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":8,\"transaction_id\":8,\"bag_style_id\":4,\"date\":\"2020-10-01\",\"user_id\":3,\"status\":0,\"id\":7}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-01 10:36:43', '2020-10-01 10:36:43'),
(109, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 8, '[]', '{\"type\":0,\"weight\":\"0.0050\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":8,\"transaction_id\":8,\"bag_style_id\":4,\"date\":\"2020-10-01\",\"user_id\":3,\"status\":0,\"id\":8}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-01 10:36:43', '2020-10-01 10:36:43'),
(110, 'App\\User', 1, 'created', 'App\\Models\\Bag', 5, '[]', '{\"bag_number\":\"BG105\",\"parent_bag_id\":null,\"order_number\":\"ORD-0001\",\"instructions\":null,\"department_id\":1,\"id\":5}', 'http://stage2.ngstpl.com/api/bag', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 10:47:13', '2020-10-01 10:47:13'),
(111, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 5, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"10\",\"upload_id\":null,\"instructions\":null,\"bag_id\":5,\"id\":5}', 'http://stage2.ngstpl.com/api/bag', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 10:47:13', '2020-10-01 10:47:13'),
(112, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 9, '[]', '{\"transaction_date\":\"2020-10-01\",\"bag_id\":5,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"10.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":9}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 10:48:19', '2020-10-01 10:48:19'),
(113, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 5, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":2}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 10:48:19', '2020-10-01 10:48:19'),
(114, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 5, '{\"weight\":10}', '{\"weight\":\"10.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 10:48:19', '2020-10-01 10:48:19'),
(115, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 9, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":5,\"quantity\":10,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":1,\"transaction_id\":9,\"id\":9}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 10:48:19', '2020-10-01 10:48:19'),
(116, 'App\\User', 3, 'created', 'App\\Models\\Transaction', 10, '[]', '{\"transaction_date\":\"2020-10-01\",\"bag_id\":5,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":5,\"to_employee_id\":null,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"9.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":10}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-01 10:52:16', '2020-10-01 10:52:16'),
(117, 'App\\User', 3, 'updated', 'App\\Models\\Bag', 5, '{\"status\":0}', '{\"status\":3}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-01 10:52:16', '2020-10-01 10:52:16'),
(118, 'App\\User', 3, 'created', 'App\\Models\\TransactionItem', 10, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":5,\"quantity\":10,\"weight\":\"10.0000\",\"receive_weight\":\"9.0000\",\"uom_id\":1,\"transaction_id\":10,\"id\":10}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-01 10:52:16', '2020-10-01 10:52:16'),
(119, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 9, '[]', '{\"type\":1,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":10,\"transaction_id\":10,\"bag_style_id\":5,\"date\":\"2020-10-01\",\"user_id\":3,\"status\":0,\"id\":9}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-01 10:52:16', '2020-10-01 10:52:16'),
(120, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 10, '[]', '{\"type\":0,\"weight\":\"0.5\",\"admin_approval_loss_weight\":\"0.0025\",\"transaction_item_id\":10,\"transaction_id\":10,\"bag_style_id\":5,\"date\":\"2020-10-01\",\"user_id\":3,\"status\":1,\"id\":10}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.92', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-01 10:52:16', '2020-10-01 10:52:16');
INSERT INTO `audits` (`id`, `user_type`, `user_id`, `event`, `auditable_type`, `auditable_id`, `old_values`, `new_values`, `url`, `ip_address`, `user_agent`, `tags`, `created_at`, `updated_at`) VALUES
(121, 'App\\User', 1, 'created', 'App\\Models\\Bag', 6, '[]', '{\"bag_number\":\"BG106\",\"parent_bag_id\":null,\"order_number\":\"ORDER NO-0001\",\"instructions\":null,\"department_id\":1,\"id\":6}', 'http://stage2.ngstpl.com/api/bag', '157.46.91.184', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-10-01 14:43:44', '2020-10-01 14:43:44'),
(122, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 6, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"10\",\"upload_id\":null,\"instructions\":null,\"bag_id\":6,\"id\":6}', 'http://stage2.ngstpl.com/api/bag', '157.46.91.184', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-10-01 14:43:44', '2020-10-01 14:43:44'),
(123, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 11, '[]', '{\"transaction_date\":\"2020-10-01\",\"bag_id\":6,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"10.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":11}', 'http://stage2.ngstpl.com/api/transaction', '157.46.91.184', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-10-01 14:44:11', '2020-10-01 14:44:11'),
(124, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 6, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":2}', 'http://stage2.ngstpl.com/api/transaction', '157.46.91.184', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-10-01 14:44:11', '2020-10-01 14:44:11'),
(125, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 6, '{\"weight\":10}', '{\"weight\":\"10.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.46.91.184', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-10-01 14:44:11', '2020-10-01 14:44:11'),
(126, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 11, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":6,\"quantity\":10,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":1,\"transaction_id\":11,\"id\":11}', 'http://stage2.ngstpl.com/api/transaction', '157.46.91.184', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-10-01 14:44:11', '2020-10-01 14:44:11'),
(127, 'App\\User', 1, 'created', 'App\\Models\\Bag', 7, '[]', '{\"bag_number\":\"BG107\",\"parent_bag_id\":null,\"order_number\":\"107\",\"instructions\":null,\"department_id\":1,\"id\":7}', 'http://stage2.ngstpl.com/api/bag', '157.46.94.203', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 15:31:56', '2020-10-01 15:31:56'),
(128, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 7, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"20\",\"upload_id\":null,\"instructions\":null,\"bag_id\":7,\"id\":7}', 'http://stage2.ngstpl.com/api/bag', '157.46.94.203', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 15:31:56', '2020-10-01 15:31:56'),
(129, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 12, '[]', '{\"transaction_date\":\"2020-10-01\",\"bag_id\":7,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"20.0000\",\"total_receive_weight\":\"20.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":12}', 'http://stage2.ngstpl.com/api/transaction', '157.46.94.203', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 15:32:47', '2020-10-01 15:32:47'),
(130, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 7, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":2}', 'http://stage2.ngstpl.com/api/transaction', '157.46.94.203', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 15:32:47', '2020-10-01 15:32:47'),
(131, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 7, '{\"weight\":20}', '{\"weight\":\"20.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.46.94.203', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 15:32:47', '2020-10-01 15:32:47'),
(132, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 12, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":7,\"quantity\":10,\"weight\":\"20.0000\",\"receive_weight\":\"20.0000\",\"uom_id\":1,\"transaction_id\":12,\"id\":12}', 'http://stage2.ngstpl.com/api/transaction', '157.46.94.203', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-01 15:32:47', '2020-10-01 15:32:47'),
(133, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 13, '[]', '{\"transaction_date\":\"2020-10-03\",\"bag_id\":6,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"8.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":13}', 'http://stage2.ngstpl.com/api/transaction', '157.46.84.132', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-03 11:17:11', '2020-10-03 11:17:11'),
(134, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 6, '{\"status\":0}', '{\"status\":3}', 'http://stage2.ngstpl.com/api/transaction', '157.46.84.132', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-03 11:17:11', '2020-10-03 11:17:11'),
(135, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 13, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":6,\"quantity\":10,\"weight\":\"10.0000\",\"receive_weight\":\"8.0000\",\"uom_id\":1,\"transaction_id\":13,\"id\":13}', 'http://stage2.ngstpl.com/api/transaction', '157.46.84.132', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-03 11:17:11', '2020-10-03 11:17:11'),
(136, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 11, '[]', '{\"type\":1,\"weight\":\"1\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":13,\"transaction_id\":13,\"bag_style_id\":6,\"date\":\"2020-10-03\",\"user_id\":3,\"status\":0,\"id\":11}', 'http://stage2.ngstpl.com/api/transaction', '157.46.84.132', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-03 11:17:11', '2020-10-03 11:17:11'),
(137, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 12, '[]', '{\"type\":0,\"weight\":\"1\",\"admin_approval_loss_weight\":\"0.1000\",\"transaction_item_id\":13,\"transaction_id\":13,\"bag_style_id\":6,\"date\":\"2020-10-03\",\"user_id\":3,\"status\":1,\"id\":12}', 'http://stage2.ngstpl.com/api/transaction', '157.46.84.132', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-03 11:17:11', '2020-10-03 11:17:11'),
(138, 'App\\User', 3, 'created', 'App\\Models\\Transaction', 14, '[]', '{\"transaction_date\":\"2020-10-03\",\"bag_id\":7,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":3,\"to_employee_id\":4,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"20.0000\",\"total_receive_weight\":\"19.5000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":14}', 'http://stage2.ngstpl.com/api/transaction', '157.46.84.132', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-03 14:12:42', '2020-10-03 14:12:42'),
(139, 'App\\User', 3, 'updated', 'App\\Models\\Bag', 7, '{\"department_id\":2,\"employee_id\":2}', '{\"department_id\":3,\"employee_id\":4}', 'http://stage2.ngstpl.com/api/transaction', '157.46.84.132', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-03 14:12:42', '2020-10-03 14:12:42'),
(140, 'App\\User', 3, 'updated', 'App\\Models\\BagStyle', 7, '{\"weight\":20}', '{\"weight\":\"19.5000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.46.84.132', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-03 14:12:42', '2020-10-03 14:12:42'),
(141, 'App\\User', 3, 'created', 'App\\Models\\TransactionItem', 14, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":7,\"quantity\":10,\"weight\":\"20.0000\",\"receive_weight\":\"19.5000\",\"uom_id\":1,\"transaction_id\":14,\"id\":14}', 'http://stage2.ngstpl.com/api/transaction', '157.46.84.132', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-03 14:12:42', '2020-10-03 14:12:42'),
(142, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 13, '[]', '{\"type\":1,\"weight\":\"0.4000\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":14,\"transaction_id\":14,\"bag_style_id\":7,\"date\":\"2020-10-03\",\"user_id\":3,\"status\":0,\"id\":13}', 'http://stage2.ngstpl.com/api/transaction', '157.46.84.132', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-03 14:12:42', '2020-10-03 14:12:42'),
(143, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 14, '[]', '{\"type\":0,\"weight\":\"0.1000\",\"admin_approval_loss_weight\":\"0.2000\",\"transaction_item_id\":14,\"transaction_id\":14,\"bag_style_id\":7,\"date\":\"2020-10-03\",\"user_id\":3,\"status\":1,\"id\":14}', 'http://stage2.ngstpl.com/api/transaction', '157.46.84.132', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-03 14:12:42', '2020-10-03 14:12:42'),
(144, 'App\\User', 1, 'created', 'App\\Models\\Bag', 8, '[]', '{\"bag_number\":\"BG108\",\"parent_bag_id\":null,\"order_number\":\"108\",\"instructions\":null,\"department_id\":1,\"id\":8}', 'http://stage2.ngstpl.com/api/bag', '157.46.89.83', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-03 19:06:15', '2020-10-03 19:06:15'),
(145, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 8, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"10\",\"upload_id\":null,\"instructions\":null,\"bag_id\":8,\"id\":8}', 'http://stage2.ngstpl.com/api/bag', '157.46.89.83', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-03 19:06:15', '2020-10-03 19:06:15'),
(146, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 15, '[]', '{\"transaction_date\":\"2020-10-03\",\"bag_id\":8,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"10.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":15}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.83', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-03 19:06:40', '2020-10-03 19:06:40'),
(147, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 8, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":2}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.83', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-03 19:06:40', '2020-10-03 19:06:40'),
(148, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 8, '{\"weight\":10}', '{\"weight\":\"10.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.83', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-03 19:06:40', '2020-10-03 19:06:40'),
(149, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 15, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":8,\"quantity\":10,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":1,\"transaction_id\":15,\"id\":15}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.83', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-03 19:06:40', '2020-10-03 19:06:40'),
(150, 'App\\User', 3, 'created', 'App\\Models\\Transaction', 16, '[]', '{\"transaction_date\":\"2020-10-03\",\"bag_id\":8,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":3,\"to_employee_id\":4,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"9.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":16}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.83', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-03 19:08:15', '2020-10-03 19:08:15'),
(151, 'App\\User', 3, 'updated', 'App\\Models\\Bag', 8, '{\"status\":0}', '{\"status\":3}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.83', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-03 19:08:15', '2020-10-03 19:08:15'),
(152, 'App\\User', 3, 'created', 'App\\Models\\TransactionItem', 16, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":8,\"quantity\":10,\"weight\":\"10.0000\",\"receive_weight\":\"9.0000\",\"uom_id\":1,\"transaction_id\":16,\"id\":16}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.83', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-03 19:08:15', '2020-10-03 19:08:15'),
(153, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 15, '[]', '{\"type\":1,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":16,\"transaction_id\":16,\"bag_style_id\":8,\"date\":\"2020-10-03\",\"user_id\":3,\"status\":0,\"id\":15}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.83', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-03 19:08:15', '2020-10-03 19:08:15'),
(154, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 16, '[]', '{\"type\":0,\"weight\":\"0.5\",\"admin_approval_loss_weight\":\"0.1000\",\"transaction_item_id\":16,\"transaction_id\":16,\"bag_style_id\":8,\"date\":\"2020-10-03\",\"user_id\":3,\"status\":1,\"id\":16}', 'http://stage2.ngstpl.com/api/transaction', '157.46.89.83', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-03 19:08:15', '2020-10-03 19:08:15'),
(155, 'App\\User', 1, 'created', 'App\\Models\\Bag', 9, '[]', '{\"bag_number\":\"BG110\",\"parent_bag_id\":null,\"order_number\":\"110\",\"instructions\":null,\"department_id\":1,\"id\":9}', 'http://stage2.ngstpl.com/api/bag', '157.49.241.182', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-07 11:58:40', '2020-10-07 11:58:40'),
(156, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 9, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"20\",\"upload_id\":null,\"instructions\":\"sample\",\"bag_id\":9,\"id\":9}', 'http://stage2.ngstpl.com/api/bag', '157.49.241.182', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-07 11:58:40', '2020-10-07 11:58:40'),
(157, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 9, '{\"status\":0}', '{\"status\":5}', 'http://stage2.ngstpl.com/api/bag/cancel/9', '157.49.241.182', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-07 12:28:15', '2020-10-07 12:28:15'),
(158, 'App\\User', 1, 'created', 'App\\Models\\Bag', 10, '[]', '{\"bag_number\":\"BG111\",\"parent_bag_id\":null,\"order_number\":\"ON111\",\"instructions\":\"<p>Koikl<\\/p>\",\"department_id\":1,\"id\":10}', 'http://stage2.ngstpl.com/api/bag', '157.49.241.182', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-07 16:23:55', '2020-10-07 16:23:55'),
(159, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 10, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"30\",\"upload_id\":null,\"instructions\":\"sample\",\"bag_id\":10,\"id\":10}', 'http://stage2.ngstpl.com/api/bag', '157.49.241.182', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-07 16:23:55', '2020-10-07 16:23:55'),
(160, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 17, '[]', '{\"transaction_date\":\"2020-10-07\",\"bag_id\":10,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"30.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":17}', 'http://stage2.ngstpl.com/api/transaction', '157.49.241.182', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-07 16:27:59', '2020-10-07 16:27:59'),
(161, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 10, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":2}', 'http://stage2.ngstpl.com/api/transaction', '157.49.241.182', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-07 16:27:59', '2020-10-07 16:27:59'),
(162, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 10, '{\"weight\":30}', '{\"weight\":\"30.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.49.241.182', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-07 16:27:59', '2020-10-07 16:27:59'),
(163, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 17, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":10,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"30.0000\",\"uom_id\":1,\"transaction_id\":17,\"id\":17}', 'http://stage2.ngstpl.com/api/transaction', '157.49.241.182', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-07 16:27:59', '2020-10-07 16:27:59'),
(164, 'App\\User', 1, 'created', 'App\\Models\\Uploads', 4, '[]', '{\"uploaded_path\":\"public\\/attachments\\/a1vbpSnocna6Xl96Q6OltCf85lyufz4DB2Ag4k8p.jpeg\",\"random_key\":\"4rYCy1Bc27lnTOV6y2Wy\",\"file_name\":\"Chrysanthemum.jpg\",\"file_size\":20450,\"user_id\":1,\"id\":4}', 'http://stage2.ngstpl.com/upload', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 14:20:43', '2020-10-08 14:20:43'),
(165, 'App\\User', 1, 'created', 'App\\Models\\Bag', 11, '[]', '{\"bag_number\":\"123\",\"parent_bag_id\":null,\"order_number\":\"123\",\"instructions\":null,\"department_id\":1,\"id\":11}', 'http://stage2.ngstpl.com/api/bag', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 14:20:44', '2020-10-08 14:20:44'),
(166, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 11, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"30\",\"upload_id\":null,\"instructions\":\"koil\",\"bag_id\":11,\"id\":11}', 'http://stage2.ngstpl.com/api/bag', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 14:20:44', '2020-10-08 14:20:44'),
(167, 'App\\User', 1, 'created', 'App\\Models\\Uploads', 5, '[]', '{\"uploaded_path\":\"public\\/attachments\\/JTtPwq3dofepZuuLHZ7KRKxMRiYOXkrUBqMPLNBa.jpeg\",\"random_key\":\"XI4EEJfFC7oxBeUt7CkA\",\"file_name\":\"Chrysanthemum.jpg\",\"file_size\":20450,\"user_id\":1,\"id\":5}', 'http://stage2.ngstpl.com/upload', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 14:20:48', '2020-10-08 14:20:48'),
(168, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 18, '[]', '{\"transaction_date\":\"2020-10-08\",\"bag_id\":11,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"30.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":18}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 17:57:26', '2020-10-08 17:57:26'),
(169, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 11, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":2}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 17:57:26', '2020-10-08 17:57:26'),
(170, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 11, '{\"weight\":30}', '{\"weight\":\"30.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 17:57:26', '2020-10-08 17:57:26'),
(171, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 18, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":11,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"30.0000\",\"uom_id\":1,\"transaction_id\":18,\"id\":18}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 17:57:26', '2020-10-08 17:57:26'),
(172, 'App\\User', 3, 'created', 'App\\Models\\Transaction', 19, '[]', '{\"transaction_date\":\"2020-10-08\",\"bag_id\":11,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":1,\"to_employee_id\":null,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"29.7500\",\"is_eod_reporting\":1,\"transaction_mode\":0,\"status\":0,\"id\":19}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-08 18:00:59', '2020-10-08 18:00:59'),
(173, 'App\\User', 3, 'updated', 'App\\Models\\Bag', 11, '{\"department_id\":2,\"employee_id\":2}', '{\"department_id\":1,\"employee_id\":null}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-08 18:00:59', '2020-10-08 18:00:59'),
(174, 'App\\User', 3, 'updated', 'App\\Models\\BagStyle', 11, '{\"weight\":30}', '{\"weight\":\"29.7500\"}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-08 18:00:59', '2020-10-08 18:00:59'),
(175, 'App\\User', 3, 'created', 'App\\Models\\TransactionItem', 19, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":11,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"29.7500\",\"uom_id\":1,\"transaction_id\":19,\"id\":19}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-08 18:00:59', '2020-10-08 18:00:59'),
(176, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 17, '[]', '{\"type\":1,\"weight\":\"0.2000\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":19,\"transaction_id\":19,\"bag_style_id\":11,\"date\":\"2020-10-08\",\"user_id\":3,\"status\":0,\"id\":17}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-08 18:00:59', '2020-10-08 18:00:59'),
(177, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 18, '[]', '{\"type\":0,\"weight\":\"0.0500\",\"admin_approval_loss_weight\":\"0.3000\",\"transaction_item_id\":19,\"transaction_id\":19,\"bag_style_id\":11,\"date\":\"2020-10-08\",\"user_id\":3,\"status\":1,\"id\":18}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-08 18:00:59', '2020-10-08 18:00:59'),
(178, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 20, '[]', '{\"transaction_date\":\"2020-10-08\",\"bag_id\":11,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"29.7500\",\"total_receive_weight\":\"29.7500\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":20}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 18:01:50', '2020-10-08 18:01:50'),
(179, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 11, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":2}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 18:01:50', '2020-10-08 18:01:50'),
(180, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 11, '{\"weight\":29.75}', '{\"weight\":\"29.7500\"}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 18:01:50', '2020-10-08 18:01:50'),
(181, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 20, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":11,\"quantity\":10,\"weight\":\"29.7500\",\"receive_weight\":\"29.7500\",\"uom_id\":1,\"transaction_id\":20,\"id\":20}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 18:01:50', '2020-10-08 18:01:50'),
(182, 'App\\User', 1, 'created', 'App\\Models\\Uploads', 6, '[]', '{\"uploaded_path\":\"public\\/attachments\\/cdrRZT4E6eNSUlcU46jz0e3e20HrXEqBvbc9GMfD.jpeg\",\"random_key\":\"fqe2i4GBvKEpswbl0qtU\",\"file_name\":\"Penguins.jpg\",\"file_size\":17148,\"user_id\":1,\"id\":6}', 'http://stage2.ngstpl.com/upload', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 18:10:19', '2020-10-08 18:10:19'),
(183, 'App\\User', 1, 'created', 'App\\Models\\Uploads', 7, '[]', '{\"uploaded_path\":\"public\\/attachments\\/F185UFDJUdn1cqN7PnTt8x5YAncOPSBdQr2rstRy.jpeg\",\"random_key\":\"i6QrJfpEqSUbXRCHFFj6\",\"file_name\":\"Tulips.jpg\",\"file_size\":18005,\"user_id\":1,\"id\":7}', 'http://stage2.ngstpl.com/upload', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 18:10:33', '2020-10-08 18:10:33'),
(184, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 21, '[]', '{\"transaction_date\":\"2020-10-08\",\"bag_id\":11,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"29.7500\",\"total_receive_weight\":\"29.7500\",\"is_eod_reporting\":0,\"transaction_mode\":2,\"status\":0,\"id\":21}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 19:09:26', '2020-10-08 19:09:26'),
(185, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 11, '{\"status\":0}', '{\"status\":4}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 19:09:26', '2020-10-08 19:09:26'),
(186, 'App\\User', 1, 'created', 'App\\Models\\Bag', 12, '[]', '{\"bag_number\":\"123\",\"order_number\":\"123\",\"instructions\":null,\"department_id\":3,\"employee_id\":3,\"id\":12}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 19:09:26', '2020-10-08 19:09:26'),
(187, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 12, '[]', '{\"bag_id\":12,\"style_id\":1,\"upload_id\":null,\"quantity\":15,\"weight\":\"44.7500\",\"instructions\":\"koil\",\"other_accessories_id\":null,\"parent_bag_style_id\":null,\"id\":12}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 19:09:26', '2020-10-08 19:09:26'),
(188, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 21, '[]', '{\"transaction_id\":21,\"bag_style_id\":12,\"other_accessories_id\":null,\"uom_id\":1,\"quantity\":15,\"weight\":\"44.7500\",\"receive_weight\":\"44.7500\",\"type\":0,\"id\":21}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 19:09:26', '2020-10-08 19:09:26'),
(189, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 10, '{\"status\":0}', '{\"status\":4}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 19:09:26', '2020-10-08 19:09:26'),
(190, 'App\\User', 1, 'created', 'App\\Models\\Bag', 13, '[]', '{\"bag_number\":\"BG111\",\"order_number\":\"ON111\",\"instructions\":\"<p>Koikl<\\/p>\",\"department_id\":2,\"employee_id\":2,\"id\":13}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 19:09:26', '2020-10-08 19:09:26'),
(191, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 13, '[]', '{\"bag_id\":13,\"style_id\":1,\"upload_id\":null,\"quantity\":5,\"weight\":\"15.0000\",\"instructions\":\"sample\",\"other_accessories_id\":null,\"parent_bag_style_id\":null,\"id\":13}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 19:09:26', '2020-10-08 19:09:26'),
(192, 'App\\User', 1, 'updated', 'App\\Models\\Transaction', 21, '{\"bag_id\":11,\"total_transfer_quantity\":10,\"total_transfer_weight\":29.75,\"total_receive_weight\":29.75,\"to_bag_id\":null}', '{\"bag_id\":12,\"total_transfer_quantity\":15,\"total_transfer_weight\":44.75,\"total_receive_weight\":44.75,\"to_bag_id\":13}', 'http://stage2.ngstpl.com/api/transaction', '157.49.240.242', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-08 19:09:26', '2020-10-08 19:09:26'),
(193, 'App\\User', 1, 'created', 'App\\Models\\Uploads', 8, '[]', '{\"uploaded_path\":\"public\\/attachments\\/uC5xrpWjr6TaoRpwrlbTGI2rx1DEchsMmte0pVru.jpeg\",\"random_key\":\"bQZVxhd73j7M1KApgWlN\",\"file_name\":\"Hydrangeas.jpg\",\"file_size\":16880,\"user_id\":1,\"id\":8}', 'http://stage2.ngstpl.com/upload', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:32:31', '2020-10-10 08:32:31'),
(194, 'App\\User', 1, 'created', 'App\\Models\\Bag', 14, '[]', '{\"bag_number\":\"BG201\",\"parent_bag_id\":null,\"order_number\":\"201\",\"instructions\":null,\"department_id\":1,\"id\":14}', 'http://stage2.ngstpl.com/api/bag', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:32:35', '2020-10-10 08:32:35'),
(195, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 14, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"30\",\"upload_id\":8,\"instructions\":\"sample\",\"bag_id\":14,\"id\":14}', 'http://stage2.ngstpl.com/api/bag', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:32:35', '2020-10-10 08:32:35'),
(196, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 22, '[]', '{\"transaction_date\":\"2020-10-10\",\"bag_id\":14,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"30.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":22}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:32:57', '2020-10-10 08:32:57'),
(197, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 14, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":2}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:32:57', '2020-10-10 08:32:57'),
(198, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 14, '{\"weight\":30}', '{\"weight\":\"30.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:32:57', '2020-10-10 08:32:57'),
(199, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 22, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":14,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"30.0000\",\"uom_id\":1,\"transaction_id\":22,\"id\":22}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:32:57', '2020-10-10 08:32:57'),
(200, 'App\\User', 1, 'created', 'App\\Models\\Bag', 15, '[]', '{\"bag_number\":\"BG202\",\"parent_bag_id\":null,\"order_number\":\"202\",\"instructions\":null,\"department_id\":1,\"id\":15}', 'http://stage2.ngstpl.com/api/bag', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:33:34', '2020-10-10 08:33:34'),
(201, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 15, '[]', '{\"style_id\":1,\"quantity\":\"15\",\"weight\":\"45\",\"upload_id\":null,\"instructions\":\"sample\",\"bag_id\":15,\"id\":15}', 'http://stage2.ngstpl.com/api/bag', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:33:34', '2020-10-10 08:33:34'),
(202, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 23, '[]', '{\"transaction_date\":\"2020-10-10\",\"bag_id\":15,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"15.0000\",\"total_transfer_weight\":\"45.0000\",\"total_receive_weight\":\"45.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":23}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:33:59', '2020-10-10 08:33:59'),
(203, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 15, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:33:59', '2020-10-10 08:33:59'),
(204, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 15, '{\"weight\":45}', '{\"weight\":\"45.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:33:59', '2020-10-10 08:33:59'),
(205, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 23, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":15,\"quantity\":15,\"weight\":\"45.0000\",\"receive_weight\":\"45.0000\",\"uom_id\":1,\"transaction_id\":23,\"id\":23}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-10 08:33:59', '2020-10-10 08:33:59'),
(206, 'App\\User', 3, 'created', 'App\\Models\\Transaction', 24, '[]', '{\"transaction_date\":\"2020-10-10\",\"bag_id\":14,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"29.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":24}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-10 08:44:15', '2020-10-10 08:44:15'),
(207, 'App\\User', 3, 'updated', 'App\\Models\\Bag', 14, '{\"status\":0}', '{\"status\":3}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-10 08:44:15', '2020-10-10 08:44:15'),
(208, 'App\\User', 3, 'created', 'App\\Models\\TransactionItem', 24, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":14,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"29.0000\",\"uom_id\":1,\"transaction_id\":24,\"id\":24}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-10 08:44:15', '2020-10-10 08:44:15'),
(209, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 19, '[]', '{\"type\":1,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":24,\"transaction_id\":24,\"bag_style_id\":14,\"date\":\"2020-10-10\",\"user_id\":3,\"status\":0,\"id\":19}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-10 08:44:15', '2020-10-10 08:44:15'),
(210, 'App\\User', 3, 'created', 'App\\Models\\TransactionItemLossDetails', 20, '[]', '{\"type\":0,\"weight\":\"0.5\",\"admin_approval_loss_weight\":\"0.3000\",\"transaction_item_id\":24,\"transaction_id\":24,\"bag_style_id\":14,\"date\":\"2020-10-10\",\"user_id\":3,\"status\":1,\"id\":20}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.14', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-10 08:44:15', '2020-10-10 08:44:15'),
(211, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItemLossDetails', 10, '{\"status\":1,\"admin_id\":null,\"reason_type_id\":0,\"loss_description\":null}', '{\"status\":0,\"admin_id\":1,\"reason_type_id\":3,\"loss_description\":\"<p>sadsa<\\/p>\"}', 'http://stage2.ngstpl.com/api/loss-approval/status-update', '157.50.141.62', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-10-12 22:29:00', '2020-10-12 22:29:00'),
(212, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItem', 10, '{\"status\":1}', '{\"status\":0}', 'http://stage2.ngstpl.com/api/loss-approval/status-update', '157.50.141.62', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36', NULL, '2020-10-12 22:29:00', '2020-10-12 22:29:00'),
(213, 'App\\User', 1, 'created', 'App\\Models\\Uploads', 9, '[]', '{\"uploaded_path\":\"public\\/attachments\\/bzMUp0iS6u7N8MiUfCLGuoMEojzAElDBi3jl6CkC.jpeg\",\"random_key\":\"k3DD4xVdGVREibfFsReG\",\"file_name\":\"Penguins.jpg\",\"file_size\":17148,\"user_id\":1,\"id\":9}', 'http://stage2.ngstpl.com/upload', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 15:06:32', '2020-10-13 15:06:32'),
(214, 'App\\User', 1, 'created', 'App\\Models\\Bag', 16, '[]', '{\"bag_number\":\"BG203\",\"parent_bag_id\":null,\"order_number\":\"202\",\"instructions\":null,\"department_id\":1,\"id\":16}', 'http://stage2.ngstpl.com/api/bag', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 15:07:08', '2020-10-13 15:07:08'),
(215, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 16, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"30\",\"upload_id\":9,\"instructions\":\"Sample\",\"bag_id\":16,\"id\":16}', 'http://stage2.ngstpl.com/api/bag', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 15:07:08', '2020-10-13 15:07:08'),
(216, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 25, '[]', '{\"transaction_date\":\"2020-10-13\",\"bag_id\":16,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":7,\"to_employee_id\":11,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"30.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":25}', 'http://stage2.ngstpl.com/api/transaction', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 15:11:44', '2020-10-13 15:11:44'),
(217, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 16, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":7,\"employee_id\":11}', 'http://stage2.ngstpl.com/api/transaction', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 15:11:44', '2020-10-13 15:11:44'),
(218, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 16, '{\"weight\":30}', '{\"weight\":\"30.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 15:11:44', '2020-10-13 15:11:44'),
(219, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 25, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":16,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"30.0000\",\"uom_id\":1,\"transaction_id\":25,\"id\":25}', 'http://stage2.ngstpl.com/api/transaction', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 15:11:44', '2020-10-13 15:11:44'),
(220, 'App\\User', 1, 'created', 'App\\Models\\Bag', 17, '[]', '{\"bag_number\":\"BG204\",\"parent_bag_id\":null,\"order_number\":\"202\",\"instructions\":null,\"department_id\":1,\"id\":17}', 'http://stage2.ngstpl.com/api/bag', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 16:25:03', '2020-10-13 16:25:03'),
(221, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 17, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"30\",\"upload_id\":null,\"instructions\":\"sample\",\"bag_id\":17,\"id\":17}', 'http://stage2.ngstpl.com/api/bag', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 16:25:03', '2020-10-13 16:25:03'),
(222, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 26, '[]', '{\"transaction_date\":\"2020-10-13\",\"bag_id\":17,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":7,\"to_employee_id\":11,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"30.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":26}', 'http://stage2.ngstpl.com/api/transaction', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 16:25:37', '2020-10-13 16:25:37'),
(223, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 17, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":7,\"employee_id\":11}', 'http://stage2.ngstpl.com/api/transaction', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 16:25:37', '2020-10-13 16:25:37'),
(224, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 17, '{\"weight\":30}', '{\"weight\":\"30.0000\"}', 'http://stage2.ngstpl.com/api/transaction', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 16:25:37', '2020-10-13 16:25:37'),
(225, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 26, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":17,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"30.0000\",\"uom_id\":1,\"transaction_id\":26,\"id\":26}', 'http://stage2.ngstpl.com/api/transaction', '157.50.81.201', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36', NULL, '2020-10-13 16:25:37', '2020-10-13 16:25:37'),
(226, 'App\\User', 12, 'created', 'App\\Models\\Transaction', 27, '[]', '{\"transaction_date\":\"2020-10-13\",\"bag_id\":16,\"from_department_id\":7,\"from_employee_id\":11,\"to_department_id\":1,\"to_employee_id\":null,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"29.9900\",\"is_eod_reporting\":1,\"transaction_mode\":0,\"status\":0,\"id\":27}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.220', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-13 19:59:12', '2020-10-13 19:59:12'),
(227, 'App\\User', 12, 'updated', 'App\\Models\\Bag', 16, '{\"department_id\":7,\"employee_id\":11}', '{\"department_id\":1,\"employee_id\":null}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.220', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-13 19:59:12', '2020-10-13 19:59:12'),
(228, 'App\\User', 12, 'updated', 'App\\Models\\BagStyle', 16, '{\"weight\":30}', '{\"weight\":\"29.9900\"}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.220', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-13 19:59:12', '2020-10-13 19:59:12'),
(229, 'App\\User', 12, 'created', 'App\\Models\\TransactionItem', 27, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":16,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"29.9900\",\"uom_id\":1,\"transaction_id\":27,\"id\":27}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.220', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-13 19:59:12', '2020-10-13 19:59:12');
INSERT INTO `audits` (`id`, `user_type`, `user_id`, `event`, `auditable_type`, `auditable_id`, `old_values`, `new_values`, `url`, `ip_address`, `user_agent`, `tags`, `created_at`, `updated_at`) VALUES
(230, 'App\\User', 12, 'created', 'App\\Models\\TransactionItemLossDetails', 21, '[]', '{\"type\":1,\"weight\":\"0.005\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":27,\"transaction_id\":27,\"bag_style_id\":16,\"date\":\"2020-10-13\",\"user_id\":12,\"status\":0,\"id\":21}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.220', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-13 19:59:12', '2020-10-13 19:59:12'),
(231, 'App\\User', 12, 'created', 'App\\Models\\TransactionItemLossDetails', 22, '[]', '{\"type\":0,\"weight\":\"0.005\",\"admin_approval_loss_weight\":\"0.3000\",\"transaction_item_id\":27,\"transaction_id\":27,\"bag_style_id\":16,\"date\":\"2020-10-13\",\"user_id\":12,\"status\":1,\"id\":22}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.220', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-13 19:59:12', '2020-10-13 19:59:12'),
(232, 'App\\User', 12, 'created', 'App\\Models\\Transaction', 28, '[]', '{\"transaction_date\":\"2020-10-13\",\"bag_id\":17,\"from_department_id\":7,\"from_employee_id\":11,\"to_department_id\":1,\"to_employee_id\":null,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"30.0000\",\"total_receive_weight\":\"29.9900\",\"is_eod_reporting\":1,\"transaction_mode\":0,\"status\":0,\"id\":28}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.220', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-13 20:00:08', '2020-10-13 20:00:08'),
(233, 'App\\User', 12, 'updated', 'App\\Models\\Bag', 17, '{\"department_id\":7,\"employee_id\":11}', '{\"department_id\":1,\"employee_id\":null}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.220', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-13 20:00:08', '2020-10-13 20:00:08'),
(234, 'App\\User', 12, 'updated', 'App\\Models\\BagStyle', 17, '{\"weight\":30}', '{\"weight\":\"29.9900\"}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.220', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-13 20:00:08', '2020-10-13 20:00:08'),
(235, 'App\\User', 12, 'created', 'App\\Models\\TransactionItem', 28, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":17,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"29.9900\",\"uom_id\":1,\"transaction_id\":28,\"id\":28}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.220', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-13 20:00:08', '2020-10-13 20:00:08'),
(236, 'App\\User', 12, 'created', 'App\\Models\\TransactionItemLossDetails', 23, '[]', '{\"type\":1,\"weight\":\"0.005\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":28,\"transaction_id\":28,\"bag_style_id\":17,\"date\":\"2020-10-13\",\"user_id\":12,\"status\":0,\"id\":23}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.220', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-13 20:00:08', '2020-10-13 20:00:08'),
(237, 'App\\User', 12, 'created', 'App\\Models\\TransactionItemLossDetails', 24, '[]', '{\"type\":0,\"weight\":\"0.005\",\"admin_approval_loss_weight\":\"0.3000\",\"transaction_item_id\":28,\"transaction_id\":28,\"bag_style_id\":17,\"date\":\"2020-10-13\",\"user_id\":12,\"status\":1,\"id\":24}', 'http://stage2.ngstpl.com/api/transaction', '157.50.91.220', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-13 20:00:08', '2020-10-13 20:00:08'),
(238, 'App\\User', 1, 'created', 'App\\Models\\Configuration', 3, '[]', '{\"config_value\":\"9566328227\",\"config_key\":\"bag_cancel_number\",\"id\":3}', 'http://stage2.ngstpl.com/api/configuration/save', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:36:25', '2020-10-16 16:36:25'),
(239, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 17, '{\"cancel_otp\":null}', '{\"cancel_otp\":\"755473\"}', 'http://stage2.ngstpl.com/api/bag/generate-otp/17', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:36:32', '2020-10-16 16:36:32'),
(240, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 29, '[]', '{\"transaction_date\":\"2020-10-16\",\"bag_id\":17,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":7,\"to_employee_id\":11,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"29.9900\",\"total_receive_weight\":\"29.9900\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":29}', 'http://stage2.ngstpl.com/api/transaction', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:38:40', '2020-10-16 16:38:40'),
(241, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 17, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":7,\"employee_id\":11}', 'http://stage2.ngstpl.com/api/transaction', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:38:40', '2020-10-16 16:38:40'),
(242, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 17, '{\"weight\":29.99}', '{\"weight\":\"29.9900\"}', 'http://stage2.ngstpl.com/api/transaction', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:38:40', '2020-10-16 16:38:40'),
(243, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 29, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":17,\"quantity\":10,\"weight\":\"29.9900\",\"receive_weight\":\"29.9900\",\"uom_id\":1,\"transaction_id\":29,\"id\":29}', 'http://stage2.ngstpl.com/api/transaction', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:38:40', '2020-10-16 16:38:40'),
(244, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 16, '{\"cancel_otp\":null}', '{\"cancel_otp\":\"582510\"}', 'http://stage2.ngstpl.com/api/bag/generate-otp/16', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:38:55', '2020-10-16 16:38:55'),
(245, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 30, '[]', '{\"transaction_date\":\"2020-10-16\",\"bag_id\":16,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":7,\"to_employee_id\":11,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"29.9900\",\"total_receive_weight\":\"29.9900\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":30}', 'http://stage2.ngstpl.com/api/transaction', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:39:22', '2020-10-16 16:39:22'),
(246, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 16, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":7,\"employee_id\":11}', 'http://stage2.ngstpl.com/api/transaction', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:39:22', '2020-10-16 16:39:22'),
(247, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 16, '{\"weight\":29.99}', '{\"weight\":\"29.9900\"}', 'http://stage2.ngstpl.com/api/transaction', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:39:22', '2020-10-16 16:39:22'),
(248, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 30, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":16,\"quantity\":10,\"weight\":\"29.9900\",\"receive_weight\":\"29.9900\",\"uom_id\":1,\"transaction_id\":30,\"id\":30}', 'http://stage2.ngstpl.com/api/transaction', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:39:22', '2020-10-16 16:39:22'),
(249, 'App\\User', 1, 'created', 'App\\Models\\Bag', 18, '[]', '{\"bag_number\":\"525\",\"parent_bag_id\":null,\"order_number\":\"525\",\"instructions\":null,\"department_id\":1,\"id\":18}', 'http://stage2.ngstpl.com/api/bag', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:45:27', '2020-10-16 16:45:27'),
(250, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 18, '[]', '{\"style_id\":1,\"quantity\":1,\"weight\":\"1\",\"upload_id\":null,\"instructions\":null,\"bag_id\":18,\"id\":18}', 'http://stage2.ngstpl.com/api/bag', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:45:27', '2020-10-16 16:45:27'),
(251, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 18, '{\"cancel_otp\":null}', '{\"cancel_otp\":\"191769\"}', 'http://stage2.ngstpl.com/api/bag/generate-otp/18', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:45:36', '2020-10-16 16:45:36'),
(252, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 18, '{\"status\":0}', '{\"status\":5}', 'http://stage2.ngstpl.com/api/bag/cancel', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:45:50', '2020-10-16 16:45:50'),
(253, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 31, '[]', '{\"transaction_date\":\"20-10-16\",\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":1,\"to_employee_id\":null,\"bag_id\":18,\"total_transfer_weight\":0,\"total_transfer_quantity\":0,\"total_receive_weight\":0,\"status\":0,\"description\":\"DUMMY TRANSACTION\",\"id\":31}', 'http://stage2.ngstpl.com/api/bag/cancel', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:45:50', '2020-10-16 16:45:50'),
(254, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 31, '[]', '{\"transaction_id\":31,\"bag_style_id\":18,\"status\":0,\"other_accessories_id\":null,\"uom_id\":1,\"quantity\":1,\"weight\":1,\"receive_weight\":0,\"type\":0,\"id\":31}', 'http://stage2.ngstpl.com/api/bag/cancel', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:45:50', '2020-10-16 16:45:50'),
(255, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 25, '[]', '{\"date\":\"20-10-16\",\"transaction_item_id\":31,\"transaction_id\":31,\"weight\":1,\"user_id\":1,\"type\":1,\"bag_style_id\":18,\"id\":25}', 'http://stage2.ngstpl.com/api/bag/cancel', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:45:50', '2020-10-16 16:45:50'),
(256, 'App\\User', 1, 'updated', 'App\\Models\\Transaction', 31, '{\"total_transfer_weight\":0,\"total_transfer_quantity\":0}', '{\"total_transfer_weight\":1,\"total_transfer_quantity\":1}', 'http://stage2.ngstpl.com/api/bag/cancel', '106.51.49.58', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36', NULL, '2020-10-16 16:45:50', '2020-10-16 16:45:50'),
(257, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 17, '{\"status\":0}', '{\"status\":5}', 'http://stage2.ngstpl.com/api/bag/cancel', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:25:50', '2020-10-21 13:25:50'),
(258, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 32, '[]', '{\"transaction_date\":\"20-10-21\",\"from_department_id\":7,\"from_employee_id\":11,\"to_department_id\":7,\"to_employee_id\":11,\"bag_id\":17,\"total_transfer_weight\":0,\"total_transfer_quantity\":0,\"total_receive_weight\":0,\"status\":0,\"description\":\"DUMMY TRANSACTION\",\"id\":32}', 'http://stage2.ngstpl.com/api/bag/cancel', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:25:50', '2020-10-21 13:25:50'),
(259, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 32, '[]', '{\"transaction_id\":32,\"bag_style_id\":17,\"status\":0,\"other_accessories_id\":null,\"uom_id\":1,\"quantity\":10,\"weight\":29.99,\"receive_weight\":0,\"type\":0,\"id\":32}', 'http://stage2.ngstpl.com/api/bag/cancel', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:25:50', '2020-10-21 13:25:50'),
(260, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 26, '[]', '{\"date\":\"20-10-21\",\"transaction_item_id\":32,\"transaction_id\":32,\"weight\":29.99,\"user_id\":1,\"type\":1,\"bag_style_id\":17,\"id\":26}', 'http://stage2.ngstpl.com/api/bag/cancel', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:25:50', '2020-10-21 13:25:50'),
(261, 'App\\User', 1, 'updated', 'App\\Models\\Transaction', 32, '{\"total_transfer_weight\":0,\"total_transfer_quantity\":0}', '{\"total_transfer_weight\":29.99,\"total_transfer_quantity\":29.99}', 'http://stage2.ngstpl.com/api/bag/cancel', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:25:50', '2020-10-21 13:25:50'),
(262, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItemLossDetails', 24, '{\"status\":1,\"admin_id\":null,\"reason_type_id\":0}', '{\"status\":0,\"admin_id\":1,\"reason_type_id\":1}', 'http://stage2.ngstpl.com/api/loss-approval/status-update', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:30:00', '2020-10-21 13:30:00'),
(263, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 33, '[]', '{\"transaction_date\":\"2020-10-21\",\"bag_id\":16,\"from_department_id\":7,\"from_employee_id\":11,\"to_department_id\":1,\"to_employee_id\":null,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"29.9900\",\"total_receive_weight\":\"29.9900\",\"is_eod_reporting\":1,\"transaction_mode\":0,\"status\":0,\"id\":33}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:31:07', '2020-10-21 13:31:07'),
(264, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 16, '{\"department_id\":7,\"employee_id\":11}', '{\"department_id\":1,\"employee_id\":null}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:31:07', '2020-10-21 13:31:07'),
(265, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 16, '{\"weight\":29.99}', '{\"weight\":\"29.9900\"}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:31:07', '2020-10-21 13:31:07'),
(266, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 33, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":16,\"quantity\":10,\"weight\":\"29.9900\",\"receive_weight\":\"29.9900\",\"uom_id\":1,\"transaction_id\":33,\"id\":33}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:31:07', '2020-10-21 13:31:07'),
(267, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 34, '[]', '{\"transaction_date\":\"2020-10-21\",\"bag_id\":16,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":7,\"to_employee_id\":11,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"29.9900\",\"total_receive_weight\":\"29.9900\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":34}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:31:26', '2020-10-21 13:31:26'),
(268, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 16, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":7,\"employee_id\":11}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:31:26', '2020-10-21 13:31:26'),
(269, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 16, '{\"weight\":29.99}', '{\"weight\":\"29.9900\"}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:31:26', '2020-10-21 13:31:26'),
(270, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 34, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":16,\"quantity\":10,\"weight\":\"29.9900\",\"receive_weight\":\"29.9900\",\"uom_id\":1,\"transaction_id\":34,\"id\":34}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:31:26', '2020-10-21 13:31:26'),
(271, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 35, '[]', '{\"transaction_date\":\"2020-10-21\",\"bag_id\":16,\"from_department_id\":7,\"from_employee_id\":11,\"to_department_id\":1,\"to_employee_id\":null,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"29.9900\",\"total_receive_weight\":\"29.9900\",\"is_eod_reporting\":0,\"transaction_mode\":2,\"status\":0,\"id\":35}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21'),
(272, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 16, '{\"status\":0}', '{\"status\":4}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21'),
(273, 'App\\User', 1, 'created', 'App\\Models\\Bag', 19, '[]', '{\"bag_number\":\"BG203\",\"order_number\":\"202\",\"instructions\":null,\"department_id\":1,\"employee_id\":null,\"id\":19}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21'),
(274, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 19, '[]', '{\"bag_id\":19,\"style_id\":1,\"upload_id\":9,\"quantity\":11,\"weight\":\"30.9900\",\"instructions\":\"Sample\",\"other_accessories_id\":null,\"parent_bag_style_id\":null,\"id\":19}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21'),
(275, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 35, '[]', '{\"transaction_id\":35,\"bag_style_id\":19,\"other_accessories_id\":null,\"uom_id\":1,\"quantity\":11,\"weight\":\"30.9900\",\"receive_weight\":\"30.9900\",\"type\":0,\"id\":35}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21'),
(276, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 13, '{\"status\":0}', '{\"status\":4}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21'),
(277, 'App\\User', 1, 'created', 'App\\Models\\Bag', 20, '[]', '{\"bag_number\":\"BG111\",\"order_number\":\"ON111\",\"instructions\":\"<p>Koikl<\\/p>\",\"department_id\":2,\"employee_id\":2,\"id\":20}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21'),
(278, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 20, '[]', '{\"bag_id\":20,\"style_id\":1,\"upload_id\":null,\"quantity\":4,\"weight\":\"14.0000\",\"instructions\":\"sample\",\"other_accessories_id\":null,\"parent_bag_style_id\":null,\"id\":20}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21'),
(279, 'App\\User', 1, 'updated', 'App\\Models\\Transaction', 35, '{\"bag_id\":16,\"total_transfer_quantity\":10,\"total_transfer_weight\":29.99,\"total_receive_weight\":29.99,\"to_bag_id\":null}', '{\"bag_id\":19,\"total_transfer_quantity\":11,\"total_transfer_weight\":30.99,\"total_receive_weight\":30.99,\"to_bag_id\":20}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21'),
(280, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 36, '[]', '{\"transaction_date\":\"2020-10-21\",\"bag_id\":19,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"11.0000\",\"total_transfer_weight\":\"30.9900\",\"total_receive_weight\":\"30.9900\",\"is_eod_reporting\":0,\"transaction_mode\":2,\"status\":0,\"id\":36}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:53:22', '2020-10-21 13:53:22'),
(281, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 19, '{\"status\":0}', '{\"status\":4}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:53:22', '2020-10-21 13:53:22'),
(282, 'App\\User', 1, 'created', 'App\\Models\\Bag', 21, '[]', '{\"bag_number\":\"BG203\",\"order_number\":\"202\",\"instructions\":null,\"department_id\":2,\"employee_id\":1,\"id\":21}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:53:22', '2020-10-21 13:53:22'),
(283, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 21, '[]', '{\"bag_id\":21,\"style_id\":1,\"upload_id\":9,\"quantity\":12,\"weight\":\"31.9900\",\"instructions\":\"Sample\",\"other_accessories_id\":null,\"parent_bag_style_id\":null,\"id\":21}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:53:22', '2020-10-21 13:53:22'),
(284, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 36, '[]', '{\"transaction_id\":36,\"bag_style_id\":21,\"other_accessories_id\":null,\"uom_id\":1,\"quantity\":12,\"weight\":\"31.9900\",\"receive_weight\":\"31.9900\",\"type\":0,\"id\":36}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:53:22', '2020-10-21 13:53:22'),
(285, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 20, '{\"status\":0}', '{\"status\":4}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:53:22', '2020-10-21 13:53:22'),
(286, 'App\\User', 1, 'created', 'App\\Models\\Bag', 22, '[]', '{\"bag_number\":\"BG111\",\"order_number\":\"ON111\",\"instructions\":\"<p>Koikl<\\/p>\",\"department_id\":2,\"employee_id\":2,\"id\":22}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:53:22', '2020-10-21 13:53:22'),
(287, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 22, '[]', '{\"bag_id\":22,\"style_id\":1,\"upload_id\":null,\"quantity\":3,\"weight\":\"13.0000\",\"instructions\":\"sample\",\"other_accessories_id\":null,\"parent_bag_style_id\":null,\"id\":22}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:53:22', '2020-10-21 13:53:22'),
(288, 'App\\User', 1, 'updated', 'App\\Models\\Transaction', 36, '{\"bag_id\":19,\"total_transfer_quantity\":11,\"total_transfer_weight\":30.99,\"total_receive_weight\":30.99,\"to_bag_id\":null}', '{\"bag_id\":21,\"total_transfer_quantity\":12,\"total_transfer_weight\":31.99,\"total_receive_weight\":31.99,\"to_bag_id\":22}', 'http://stage2.ngstpl.com/api/transaction', '157.46.80.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:81.0) Gecko/20100101 Firefox/81.0', NULL, '2020-10-21 13:53:22', '2020-10-21 13:53:22'),
(289, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 37, '[]', '{\"transaction_date\":\"2020-11-16\",\"bag_id\":22,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":4,\"to_employee_id\":5,\"description\":null,\"total_transfer_quantity\":\"3.0000\",\"total_transfer_weight\":\"13.0000\",\"total_receive_weight\":\"12.9990\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":37}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 09:44:49', '2020-11-16 09:44:49'),
(290, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 22, '{\"department_id\":2,\"employee_id\":2}', '{\"department_id\":4,\"employee_id\":5}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 09:44:49', '2020-11-16 09:44:49'),
(291, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 22, '{\"weight\":13}', '{\"weight\":\"12.9990\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 09:44:49', '2020-11-16 09:44:49'),
(292, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 37, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":22,\"quantity\":3,\"weight\":\"13.0000\",\"receive_weight\":\"12.9990\",\"uom_id\":1,\"transaction_id\":37,\"id\":37}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 09:44:49', '2020-11-16 09:44:49'),
(293, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 27, '[]', '{\"type\":1,\"weight\":\"0.0010\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":37,\"transaction_id\":37,\"bag_style_id\":22,\"date\":\"2020-11-16\",\"user_id\":3,\"status\":0,\"id\":27}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 09:44:49', '2020-11-16 09:44:49'),
(294, 'App\\User', 1, 'created', 'App\\Models\\Bag', 23, '[]', '{\"bag_number\":\"BG133\",\"parent_bag_id\":null,\"order_number\":\"BG133\",\"instructions\":\"<p>dd<\\/p>\",\"department_id\":1,\"id\":23}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 09:55:06', '2020-11-16 09:55:06'),
(295, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 23, '[]', '{\"style_id\":1,\"quantity\":1,\"weight\":\"3\",\"upload_id\":null,\"instructions\":\"d\",\"bag_id\":23,\"id\":23}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 09:55:06', '2020-11-16 09:55:06'),
(296, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 38, '[]', '{\"transaction_date\":\"2020-11-16\",\"bag_id\":23,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"3.0000\",\"total_receive_weight\":\"3.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":38}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 09:58:14', '2020-11-16 09:58:14'),
(297, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 23, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":2}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 09:58:14', '2020-11-16 09:58:14'),
(298, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 23, '{\"weight\":3}', '{\"weight\":\"3.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 09:58:14', '2020-11-16 09:58:14'),
(299, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 38, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":23,\"quantity\":1,\"weight\":\"3.0000\",\"receive_weight\":\"3.0000\",\"uom_id\":1,\"transaction_id\":38,\"id\":38}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 09:58:14', '2020-11-16 09:58:14'),
(300, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 39, '[]', '{\"transaction_date\":\"2020-11-16\",\"bag_id\":23,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":4,\"to_employee_id\":5,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"3.0000\",\"total_receive_weight\":\"2.9900\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":39}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 10:00:29', '2020-11-16 10:00:29'),
(301, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 23, '{\"department_id\":2,\"employee_id\":2}', '{\"department_id\":4,\"employee_id\":5}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 10:00:29', '2020-11-16 10:00:29'),
(302, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 23, '{\"weight\":3}', '{\"weight\":\"2.9900\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 10:00:29', '2020-11-16 10:00:29'),
(303, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 39, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":23,\"quantity\":1,\"weight\":\"3.0000\",\"receive_weight\":\"2.9900\",\"uom_id\":1,\"transaction_id\":39,\"id\":39}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 10:00:29', '2020-11-16 10:00:29'),
(304, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 28, '[]', '{\"type\":1,\"weight\":\"0.0100\",\"admin_approval_loss_weight\":0,\"transaction_item_id\":39,\"transaction_id\":39,\"bag_style_id\":23,\"date\":\"2020-11-16\",\"user_id\":3,\"status\":0,\"id\":28}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-11-16 10:00:30', '2020-11-16 10:00:30'),
(305, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 40, '[]', '{\"transaction_date\":\"2020-12-14\",\"bag_id\":23,\"from_department_id\":4,\"from_employee_id\":5,\"to_department_id\":4,\"to_employee_id\":6,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"2.9900\",\"total_receive_weight\":\"2.9000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":40}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-14 17:33:26', '2020-12-14 17:33:26'),
(306, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 23, '{\"employee_id\":5}', '{\"employee_id\":6}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-14 17:33:26', '2020-12-14 17:33:26'),
(307, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 23, '{\"weight\":2.99}', '{\"weight\":\"2.9000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-14 17:33:26', '2020-12-14 17:33:26'),
(308, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 40, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":23,\"quantity\":1,\"weight\":\"2.9900\",\"receive_weight\":\"2.9000\",\"uom_id\":1,\"transaction_id\":40,\"id\":40}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-14 17:33:26', '2020-12-14 17:33:26'),
(311, 'App\\User', 1, 'created', 'App\\Models\\Bag', 26, '[]', '{\"bag_number\":\"BAG0000\",\"parent_bag_id\":null,\"order_number\":\"asdadasdsad\",\"instructions\":null,\"department_id\":1,\"id\":26}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-14 17:51:55', '2020-12-14 17:51:55'),
(312, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 24, '[]', '{\"style_id\":1,\"quantity\":1,\"weight\":\"2.5\",\"upload_id\":null,\"instructions\":\"sds\",\"bag_id\":26,\"id\":24}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-14 17:51:55', '2020-12-14 17:51:55'),
(313, 'App\\User', 1, 'created', 'App\\Models\\Bag', 27, '[]', '{\"bag_number\":\"BAG0001\",\"parent_bag_id\":null,\"order_number\":\"sad\",\"instructions\":null,\"department_id\":1,\"id\":27}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-14 17:52:48', '2020-12-14 17:52:48'),
(314, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 25, '[]', '{\"style_id\":1,\"quantity\":1,\"weight\":\"56\",\"upload_id\":null,\"instructions\":null,\"bag_id\":27,\"id\":25}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-14 17:52:48', '2020-12-14 17:52:48'),
(316, 'App\\User', 1, 'created', 'App\\Models\\Bag', 29, '[]', '{\"bag_number\":\"BAG0001\",\"parent_bag_id\":null,\"order_number\":\"df\",\"instructions\":null,\"department_id\":1,\"id\":29}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-16 11:06:18', '2020-12-16 11:06:18'),
(317, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 26, '[]', '{\"style_id\":1,\"quantity\":1,\"weight\":\"4\",\"upload_id\":null,\"instructions\":null,\"bag_id\":29,\"id\":26}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-16 11:06:19', '2020-12-16 11:06:19'),
(318, 'App\\User', 1, 'created', 'App\\Models\\Bag', 30, '[]', '{\"bag_number\":\"BAG0001\",\"parent_bag_id\":null,\"order_number\":\"asdfadasdasd\",\"instructions\":null,\"department_id\":1,\"inc_val\":1,\"id\":30}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-16 11:08:54', '2020-12-16 11:08:54'),
(319, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 27, '[]', '{\"style_id\":1,\"quantity\":1,\"weight\":\"45\",\"upload_id\":null,\"instructions\":null,\"bag_id\":30,\"id\":27}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-16 11:08:54', '2020-12-16 11:08:54'),
(320, 'App\\User', 1, 'created', 'App\\Models\\Bag', 31, '[]', '{\"bag_number\":\"BAG0002\",\"parent_bag_id\":null,\"order_number\":\"asdas\",\"instructions\":null,\"department_id\":1,\"inc_val\":2,\"id\":31}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-16 11:09:27', '2020-12-16 11:09:27'),
(321, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 28, '[]', '{\"style_id\":1,\"quantity\":1,\"weight\":\"56\",\"upload_id\":null,\"instructions\":null,\"bag_id\":31,\"id\":28}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-16 11:09:27', '2020-12-16 11:09:27'),
(322, 'App\\User', 1, 'created', 'App\\Models\\Bag', 32, '[]', '{\"bag_number\":\"BAG0003\",\"parent_bag_id\":null,\"order_number\":\"adas\",\"instructions\":null,\"department_id\":1,\"inc_val\":3,\"id\":32}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-18 10:22:38', '2020-12-18 10:22:38'),
(323, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 29, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"45\",\"upload_id\":null,\"instructions\":null,\"bag_id\":32,\"id\":29}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-18 10:22:38', '2020-12-18 10:22:38'),
(324, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 41, '[]', '{\"transaction_date\":\"2020-12-18\",\"bag_id\":32,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":8,\"to_employee_id\":null,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"45.0000\",\"total_receive_weight\":\"45.0000\",\"is_eod_reporting\":0,\"transaction_mode\":1,\"status\":0,\"id\":41}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-18 10:24:53', '2020-12-18 10:24:53'),
(325, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 32, '{\"status\":0}', '{\"status\":2}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-18 10:24:53', '2020-12-18 10:24:53'),
(326, 'App\\User', 1, 'created', 'App\\Models\\Bag', 33, '[]', '{\"parent_bag_id\":32,\"bag_number\":\"BAG0003\",\"order_number\":\"adas\",\"instructions\":null,\"department_id\":1,\"employee_id\":null,\"id\":33}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-18 10:24:53', '2020-12-18 10:24:53'),
(327, 'App\\User', 1, 'created', 'App\\Models\\Bag', 34, '[]', '{\"parent_bag_id\":32,\"bag_number\":\"BAG0003-1\",\"order_number\":\"adas\",\"instructions\":null,\"department_id\":8,\"employee_id\":null,\"status\":1,\"id\":34}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-18 10:24:53', '2020-12-18 10:24:53'),
(328, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 29, '{\"weight\":45}', '{\"weight\":\"45.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-18 10:24:53', '2020-12-18 10:24:53'),
(329, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 30, '[]', '{\"bag_id\":33,\"style_id\":1,\"other_accessories_id\":null,\"upload_id\":null,\"quantity\":5,\"weight\":\"40.0000\",\"instructions\":null,\"parent_bag_style_id\":29,\"id\":30}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-18 10:24:53', '2020-12-18 10:24:53'),
(330, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 31, '[]', '{\"bag_id\":34,\"style_id\":1,\"other_accessories_id\":null,\"upload_id\":null,\"quantity\":5,\"weight\":\"5.0000\",\"instructions\":null,\"parent_bag_style_id\":29,\"id\":31}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-18 10:24:53', '2020-12-18 10:24:53'),
(331, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 41, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":29,\"quantity\":10,\"weight\":\"45.0000\",\"receive_weight\":\"45.0000\",\"uom_id\":1,\"transaction_id\":41,\"id\":41}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-18 10:24:53', '2020-12-18 10:24:53'),
(332, 'App\\User', 1, 'created', 'App\\Models\\Bag', 35, '[]', '{\"bag_number\":\"BAG0004\",\"parent_bag_id\":null,\"order_number\":\"asdas\",\"instructions\":null,\"department_id\":1,\"inc_val\":4,\"id\":35}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 04:50:13', '2020-12-22 04:50:13'),
(333, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 32, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"50\",\"upload_id\":null,\"instructions\":null,\"bag_id\":35,\"id\":32}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 04:50:13', '2020-12-22 04:50:13'),
(334, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 42, '[]', '{\"transaction_date\":\"2020-12-22\",\"bag_id\":35,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"50.0000\",\"total_receive_weight\":\"50.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":42}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 04:55:27', '2020-12-22 04:55:27'),
(335, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 35, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 04:55:27', '2020-12-22 04:55:27'),
(336, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 32, '{\"weight\":50}', '{\"weight\":\"50.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 04:55:27', '2020-12-22 04:55:27'),
(337, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 42, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":32,\"quantity\":10,\"weight\":\"50.0000\",\"receive_weight\":\"50.0000\",\"uom_id\":1,\"transaction_id\":42,\"id\":42}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 04:55:27', '2020-12-22 04:55:27'),
(338, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 43, '[]', '{\"transaction_date\":\"2020-12-22\",\"bag_id\":35,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"50.0000\",\"total_receive_weight\":\"49.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":43}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 04:55:58', '2020-12-22 04:55:58'),
(339, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 35, '{\"employee_id\":1}', '{\"employee_id\":2}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 04:55:58', '2020-12-22 04:55:58'),
(340, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 32, '{\"weight\":50}', '{\"weight\":\"49.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 04:55:58', '2020-12-22 04:55:58'),
(341, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 43, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":32,\"quantity\":10,\"weight\":\"50.0000\",\"receive_weight\":\"49.0000\",\"uom_id\":1,\"transaction_id\":43,\"id\":43}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 04:55:58', '2020-12-22 04:55:58'),
(342, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 44, '[]', '{\"transaction_date\":\"2020-12-22\",\"bag_id\":35,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"49.0000\",\"total_receive_weight\":\"48.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":44}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 06:09:16', '2020-12-22 06:09:16'),
(343, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 32, '{\"weight\":49}', '{\"weight\":\"48.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 06:09:16', '2020-12-22 06:09:16'),
(344, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 44, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":32,\"quantity\":10,\"weight\":\"49.0000\",\"receive_weight\":\"48.0000\",\"uom_id\":1,\"transaction_id\":44,\"id\":44}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 06:09:16', '2020-12-22 06:09:16'),
(345, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 45, '[]', '{\"transaction_date\":\"2020-12-22\",\"bag_id\":35,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":2,\"to_employee_id\":2,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"49.0000\",\"total_receive_weight\":\"48.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":45}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 06:17:07', '2020-12-22 06:17:07'),
(346, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 32, '{\"weight\":48}', '{\"weight\":\"48.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 06:17:07', '2020-12-22 06:17:07');
INSERT INTO `audits` (`id`, `user_type`, `user_id`, `event`, `auditable_type`, `auditable_id`, `old_values`, `new_values`, `url`, `ip_address`, `user_agent`, `tags`, `created_at`, `updated_at`) VALUES
(347, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 45, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":32,\"quantity\":10,\"weight\":\"49.0000\",\"receive_weight\":\"48.0000\",\"uom_id\":1,\"transaction_id\":45,\"id\":45}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 06:17:07', '2020-12-22 06:17:07'),
(348, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 29, '[]', '{\"type\":1,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":45,\"date\":\"2020-12-22\",\"user_id\":3,\"status\":0,\"id\":29}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 06:17:08', '2020-12-22 06:17:08'),
(349, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 30, '[]', '{\"type\":0,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":45,\"date\":\"2020-12-22\",\"user_id\":3,\"status\":0,\"id\":30}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36', NULL, '2020-12-22 06:17:08', '2020-12-22 06:17:08'),
(350, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 46, '[]', '{\"transaction_date\":\"2021-01-29\",\"bag_id\":12,\"from_department_id\":3,\"from_employee_id\":3,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":15,\"total_transfer_weight\":44.7,\"total_receive_weight\":44.75,\"is_eod_reporting\":0,\"transaction_mode\":1,\"status\":0,\"id\":46}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-29 05:28:39', '2021-01-29 05:28:39'),
(351, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 12, '{\"status\":0}', '{\"status\":2}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-29 05:28:39', '2021-01-29 05:28:39'),
(352, 'App\\User', 14, 'created', 'App\\Models\\Bag', 36, '[]', '{\"parent_bag_id\":12,\"bag_number\":\"123\",\"order_number\":\"123\",\"instructions\":null,\"department_id\":3,\"employee_id\":3,\"id\":36}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-29 05:28:39', '2021-01-29 05:28:39'),
(353, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 12, '{\"weight\":44.75}', '{\"weight\":\"44.7500\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-29 05:28:39', '2021-01-29 05:28:39'),
(354, 'App\\User', 14, 'created', 'App\\Models\\BagStyle', 33, '[]', '{\"bag_id\":36,\"style_id\":1,\"other_accessories_id\":null,\"upload_id\":null,\"quantity\":15,\"weight\":\"44.7500\",\"instructions\":\"koil\",\"parent_bag_style_id\":12,\"id\":33}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-29 05:28:39', '2021-01-29 05:28:39'),
(355, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 46, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":12,\"quantity\":15,\"weight\":\"44.7500\",\"receive_weight\":\"44.7500\",\"uom_id\":1,\"transaction_id\":46,\"id\":46}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-29 05:28:39', '2021-01-29 05:28:39'),
(356, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 31, '[]', '{\"type\":0,\"weight\":\"0.05\",\"admin_approval_loss_weight\":0,\"transaction_id\":46,\"date\":\"2021-01-29\",\"user_id\":4,\"status\":0,\"id\":31}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-29 05:28:39', '2021-01-29 05:28:39'),
(357, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 36, '{\"cancel_otp\":null}', '{\"cancel_otp\":\"603942\"}', 'http://127.0.0.1:8000/api/bag/generate-otp/36', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 05:15:08', '2021-01-30 05:15:08'),
(358, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 36, '{\"status\":0}', '{\"status\":5}', 'http://127.0.0.1:8000/api/bag/cancel', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 05:27:35', '2021-01-30 05:27:35'),
(359, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 47, '[]', '{\"transaction_date\":\"21-01-30\",\"from_department_id\":3,\"from_employee_id\":3,\"to_department_id\":3,\"to_employee_id\":3,\"bag_id\":36,\"total_transfer_weight\":0,\"total_transfer_quantity\":0,\"total_receive_weight\":0,\"status\":0,\"description\":\"DUMMY TRANSACTION\",\"id\":47}', 'http://127.0.0.1:8000/api/bag/cancel', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 05:27:35', '2021-01-30 05:27:35'),
(360, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 47, '[]', '{\"transaction_id\":47,\"bag_style_id\":33,\"status\":0,\"other_accessories_id\":null,\"uom_id\":1,\"quantity\":15,\"weight\":44.75,\"receive_weight\":0,\"type\":0,\"id\":47}', 'http://127.0.0.1:8000/api/bag/cancel', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 05:27:35', '2021-01-30 05:27:35'),
(361, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 32, '[]', '{\"date\":\"21-01-30\",\"transaction_item_id\":47,\"transaction_id\":47,\"weight\":44.75,\"user_id\":14,\"type\":1,\"bag_style_id\":33,\"id\":32}', 'http://127.0.0.1:8000/api/bag/cancel', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 05:27:35', '2021-01-30 05:27:35'),
(362, 'App\\User', 14, 'updated', 'App\\Models\\Transaction', 47, '{\"total_transfer_weight\":0,\"total_transfer_quantity\":0}', '{\"total_transfer_weight\":44.75,\"total_transfer_quantity\":44.75}', 'http://127.0.0.1:8000/api/bag/cancel', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 05:27:35', '2021-01-30 05:27:35'),
(363, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 35, '{\"cancel_otp\":null}', '{\"cancel_otp\":\"969874\"}', 'http://127.0.0.1:8000/api/bag/generate-otp/35', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 05:28:49', '2021-01-30 05:28:49'),
(364, 'App\\User', 14, 'updated', 'App\\Models\\Configuration', 3, '{\"config_value\":\"9566328227\"}', '{\"config_value\":\"9108650897\"}', 'http://127.0.0.1:8000/api/configuration/save', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 05:32:16', '2021-01-30 05:32:16'),
(365, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 48, '[]', '{\"transaction_date\":\"2021-01-30\",\"bag_id\":33,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"5.0000\",\"total_transfer_weight\":\"40.0000\",\"total_receive_weight\":\"40.0000\",\"is_eod_reporting\":1,\"transaction_mode\":0,\"status\":0,\"id\":48}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 09:38:27', '2021-01-30 09:38:27'),
(366, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 33, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 09:38:27', '2021-01-30 09:38:27'),
(367, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 30, '{\"weight\":40}', '{\"weight\":\"40.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 09:38:27', '2021-01-30 09:38:27'),
(368, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 48, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":30,\"quantity\":5,\"weight\":\"40.0000\",\"receive_weight\":\"40.0000\",\"uom_id\":1,\"transaction_id\":48,\"id\":48}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 09:38:27', '2021-01-30 09:38:27'),
(369, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 49, '[]', '{\"transaction_date\":\"2021-01-30\",\"bag_id\":33,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":1,\"to_employee_id\":null,\"description\":null,\"total_transfer_quantity\":\"5.0000\",\"total_transfer_weight\":\"40.0000\",\"total_receive_weight\":\"40.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":49}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 09:38:45', '2021-01-30 09:38:45'),
(370, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 33, '{\"department_id\":2,\"employee_id\":1}', '{\"department_id\":1,\"employee_id\":null}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 09:38:45', '2021-01-30 09:38:45'),
(371, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 30, '{\"weight\":40}', '{\"weight\":\"40.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 09:38:45', '2021-01-30 09:38:45'),
(372, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 49, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":30,\"quantity\":5,\"weight\":\"40.0000\",\"receive_weight\":\"40.0000\",\"uom_id\":1,\"transaction_id\":49,\"id\":49}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 09:38:45', '2021-01-30 09:38:45'),
(373, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 50, '[]', '{\"transaction_date\":\"2021-01-30\",\"bag_id\":33,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"5.0000\",\"total_transfer_weight\":\"40.0000\",\"total_receive_weight\":\"40.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":50}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 09:39:10', '2021-01-30 09:39:10'),
(374, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 33, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 09:39:10', '2021-01-30 09:39:10'),
(375, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 30, '{\"weight\":40}', '{\"weight\":\"40.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 09:39:10', '2021-01-30 09:39:10'),
(376, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 50, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":30,\"quantity\":5,\"weight\":\"40.0000\",\"receive_weight\":\"40.0000\",\"uom_id\":1,\"transaction_id\":50,\"id\":50}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-01-30 09:39:10', '2021-01-30 09:39:10'),
(377, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 51, '[]', '{\"transaction_date\":\"2021-02-03\",\"bag_id\":26,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"2.5000\",\"total_receive_weight\":\"2.5000\",\"is_eod_reporting\":1,\"transaction_mode\":0,\"status\":0,\"id\":51}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:36:23', '2021-02-03 14:36:23'),
(378, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 26, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:36:23', '2021-02-03 14:36:23'),
(379, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 24, '{\"weight\":2.5}', '{\"weight\":\"2.5000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:36:23', '2021-02-03 14:36:23'),
(380, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 51, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":24,\"quantity\":1,\"weight\":\"2.5000\",\"receive_weight\":\"2.5000\",\"uom_id\":1,\"transaction_id\":51,\"id\":51}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:36:23', '2021-02-03 14:36:23'),
(381, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 52, '[]', '{\"transaction_date\":\"2021-02-03\",\"bag_id\":26,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":1,\"to_employee_id\":null,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"2.5000\",\"total_receive_weight\":\"2.5000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":52}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:36:31', '2021-02-03 14:36:31'),
(382, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 26, '{\"department_id\":2,\"employee_id\":1}', '{\"department_id\":1,\"employee_id\":null}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:36:31', '2021-02-03 14:36:31'),
(383, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 24, '{\"weight\":2.5}', '{\"weight\":\"2.5000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:36:31', '2021-02-03 14:36:31'),
(384, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 52, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":24,\"quantity\":1,\"weight\":\"2.5000\",\"receive_weight\":\"2.5000\",\"uom_id\":1,\"transaction_id\":52,\"id\":52}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:36:31', '2021-02-03 14:36:31'),
(385, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 53, '[]', '{\"transaction_date\":\"2021-02-03\",\"bag_id\":26,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"2.5000\",\"total_receive_weight\":\"2.5000\",\"is_eod_reporting\":1,\"transaction_mode\":0,\"status\":0,\"id\":53}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:37:08', '2021-02-03 14:37:08'),
(386, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 26, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:37:08', '2021-02-03 14:37:08'),
(387, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 24, '{\"weight\":2.5}', '{\"weight\":\"2.5000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:37:09', '2021-02-03 14:37:09'),
(388, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 53, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":24,\"quantity\":1,\"weight\":\"2.5000\",\"receive_weight\":\"2.5000\",\"uom_id\":1,\"transaction_id\":53,\"id\":53}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:37:09', '2021-02-03 14:37:09'),
(389, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 54, '[]', '{\"transaction_date\":\"2021-02-03\",\"bag_id\":26,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":1,\"to_employee_id\":null,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"2.5000\",\"total_receive_weight\":\"2.5000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":54}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:38:06', '2021-02-03 14:38:06'),
(390, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 26, '{\"department_id\":2,\"employee_id\":1}', '{\"department_id\":1,\"employee_id\":null}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:38:06', '2021-02-03 14:38:06'),
(391, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 24, '{\"weight\":2.5}', '{\"weight\":\"2.5000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:38:06', '2021-02-03 14:38:06'),
(392, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 54, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":24,\"quantity\":1,\"weight\":\"2.5000\",\"receive_weight\":\"2.5000\",\"uom_id\":1,\"transaction_id\":54,\"id\":54}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:38:06', '2021-02-03 14:38:06'),
(393, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 55, '[]', '{\"transaction_date\":\"2021-02-03\",\"bag_id\":33,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":4,\"description\":null,\"total_transfer_quantity\":\"5.0000\",\"total_transfer_weight\":\"40.0000\",\"total_receive_weight\":\"39.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":55}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:38:52', '2021-02-03 14:38:52'),
(394, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 33, '{\"department_id\":2,\"employee_id\":1}', '{\"department_id\":3,\"employee_id\":4}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:38:52', '2021-02-03 14:38:52'),
(395, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 30, '{\"weight\":40}', '{\"weight\":\"39.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:38:52', '2021-02-03 14:38:52'),
(396, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 55, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":30,\"quantity\":5,\"weight\":\"40.0000\",\"receive_weight\":\"39.0000\",\"uom_id\":1,\"transaction_id\":55,\"id\":55}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:38:52', '2021-02-03 14:38:52'),
(397, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 33, '[]', '{\"type\":1,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":55,\"date\":\"2021-02-03\",\"user_id\":2,\"status\":0,\"id\":33}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:38:52', '2021-02-03 14:38:52'),
(398, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 34, '[]', '{\"type\":0,\"weight\":\"0.3\",\"admin_approval_loss_weight\":0,\"transaction_id\":55,\"date\":\"2021-02-03\",\"user_id\":2,\"status\":0,\"id\":34}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:38:53', '2021-02-03 14:38:53'),
(399, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 35, '[]', '{\"type\":2,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":55,\"date\":\"2021-02-03\",\"user_id\":2,\"status\":0,\"id\":35}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-03 14:38:53', '2021-02-03 14:38:53'),
(400, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 56, '[]', '{\"transaction_date\":\"2021-02-04\",\"bag_id\":26,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"2.5000\",\"total_receive_weight\":\"2.5000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":56}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-04 07:06:46', '2021-02-04 07:06:46'),
(401, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 26, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-04 07:06:46', '2021-02-04 07:06:46'),
(402, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 24, '{\"weight\":2.5}', '{\"weight\":\"2.5000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-04 07:06:46', '2021-02-04 07:06:46'),
(403, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 56, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":24,\"quantity\":1,\"weight\":\"2.5000\",\"receive_weight\":\"2.5000\",\"uom_id\":1,\"transaction_id\":56,\"id\":56}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-04 07:06:46', '2021-02-04 07:06:46'),
(404, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 57, '[]', '{\"transaction_date\":\"2021-02-04\",\"bag_id\":26,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"2.5000\",\"total_receive_weight\":\"2.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":57}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-04 11:42:55', '2021-02-04 11:42:55'),
(405, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 26, '{\"department_id\":2,\"employee_id\":1}', '{\"department_id\":3,\"employee_id\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-04 11:42:55', '2021-02-04 11:42:55'),
(406, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 24, '{\"weight\":2.5}', '{\"weight\":\"2.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-04 11:42:55', '2021-02-04 11:42:55'),
(407, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 57, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":24,\"quantity\":1,\"weight\":\"2.5000\",\"receive_weight\":\"2.0000\",\"uom_id\":1,\"transaction_id\":57,\"id\":57}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-04 11:42:55', '2021-02-04 11:42:55'),
(408, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 36, '[]', '{\"type\":1,\"weight\":\"0.1\",\"admin_approval_loss_weight\":0,\"transaction_id\":57,\"date\":\"2021-02-04\",\"user_id\":2,\"status\":0,\"id\":36}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-04 11:42:55', '2021-02-04 11:42:55'),
(409, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 37, '[]', '{\"type\":0,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":57,\"date\":\"2021-02-04\",\"user_id\":2,\"status\":0,\"id\":37}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-04 11:42:55', '2021-02-04 11:42:55'),
(410, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 38, '[]', '{\"type\":2,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":57,\"date\":\"2021-02-04\",\"user_id\":2,\"status\":0,\"id\":38}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-04 11:42:55', '2021-02-04 11:42:55'),
(411, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 58, '[]', '{\"transaction_date\":\"2021-02-06\",\"bag_id\":26,\"from_department_id\":3,\"from_employee_id\":3,\"to_department_id\":4,\"to_employee_id\":5,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"2.0000\",\"total_receive_weight\":\"1.9\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":58}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-05 22:45:43', '2021-02-05 22:45:43'),
(412, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 26, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-05 22:45:43', '2021-02-05 22:45:43'),
(413, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 58, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":24,\"quantity\":1,\"weight\":\"2.0000\",\"receive_weight\":\"2.0000\",\"uom_id\":1,\"transaction_id\":58,\"id\":58}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-05 22:45:43', '2021-02-05 22:45:43'),
(414, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 39, '[]', '{\"type\":0,\"weight\":\"0.1\",\"admin_approval_loss_weight\":0,\"transaction_id\":58,\"date\":\"2021-02-06\",\"user_id\":4,\"status\":0,\"id\":39}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-05 22:45:43', '2021-02-05 22:45:43'),
(419, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 60, '[]', '{\"transaction_date\":\"2021-02-06\",\"bag_id\":27,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"2.0000\",\"total_transfer_weight\":\"58.0000\",\"total_receive_weight\":\"58\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":60}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:02:14', '2021-02-06 07:02:14'),
(420, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 27, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:02:14', '2021-02-06 07:02:14'),
(421, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 25, '{\"weight\":56}', '{\"weight\":\"56.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:02:14', '2021-02-06 07:02:14'),
(422, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 61, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":25,\"quantity\":1,\"weight\":\"56.0000\",\"receive_weight\":\"56.0000\",\"uom_id\":1,\"transaction_id\":60,\"id\":61}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:02:14', '2021-02-06 07:02:14'),
(423, 'App\\User', 14, 'created', 'App\\Models\\BagStyle', 34, '[]', '{\"other_accessories_id\":2,\"quantity\":1,\"weight\":\"2.0000\",\"bag_id\":27,\"id\":34}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:02:14', '2021-02-06 07:02:14'),
(424, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 62, '[]', '{\"status\":0,\"type\":1,\"other_accessories_id\":2,\"bag_style_id\":34,\"quantity\":1,\"weight\":\"2.0000\",\"receive_weight\":\"2.0000\",\"uom_id\":2,\"transaction_id\":60,\"id\":62}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:02:14', '2021-02-06 07:02:14'),
(425, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 61, '[]', '{\"transaction_date\":\"2021-02-06\",\"bag_id\":27,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"2.0000\",\"total_transfer_weight\":\"58.0000\",\"total_receive_weight\":\"57.5\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":61}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51'),
(426, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 27, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51'),
(427, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 63, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":25,\"quantity\":1,\"weight\":\"56.0000\",\"receive_weight\":\"56.0000\",\"uom_id\":1,\"transaction_id\":61,\"id\":63}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51'),
(428, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 64, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":34,\"quantity\":1,\"weight\":\"2.0000\",\"receive_weight\":\"2.0000\",\"uom_id\":2,\"transaction_id\":61,\"id\":64}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51'),
(429, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 40, '[]', '{\"type\":1,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":61,\"date\":\"2021-02-06\",\"user_id\":2,\"status\":0,\"id\":40}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51'),
(430, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 41, '[]', '{\"type\":0,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":61,\"date\":\"2021-02-06\",\"user_id\":2,\"status\":0,\"id\":41}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51'),
(431, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 42, '[]', '{\"type\":2,\"weight\":\"0.1\",\"admin_approval_loss_weight\":0,\"transaction_id\":61,\"date\":\"2021-02-06\",\"user_id\":2,\"status\":0,\"id\":42}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51'),
(432, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 62, '[]', '{\"transaction_date\":\"2021-02-06\",\"bag_id\":35,\"from_department_id\":2,\"from_employee_id\":2,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"20.0000\",\"total_transfer_weight\":\"50.0000\",\"total_receive_weight\":\"50\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":62}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:18:17', '2021-02-06 07:18:17'),
(433, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 35, '{\"department_id\":2,\"employee_id\":2}', '{\"department_id\":3,\"employee_id\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:18:17', '2021-02-06 07:18:17'),
(434, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 32, '{\"weight\":48}', '{\"weight\":\"48.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:18:17', '2021-02-06 07:18:17'),
(435, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 65, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":32,\"quantity\":10,\"weight\":\"48.0000\",\"receive_weight\":\"48.0000\",\"uom_id\":1,\"transaction_id\":62,\"id\":65}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:18:17', '2021-02-06 07:18:17'),
(436, 'App\\User', 14, 'created', 'App\\Models\\BagStyle', 35, '[]', '{\"other_accessories_id\":2,\"quantity\":\"10\",\"weight\":\"2.0000\",\"bag_id\":35,\"id\":35}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:18:17', '2021-02-06 07:18:17'),
(437, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 66, '[]', '{\"status\":0,\"type\":1,\"other_accessories_id\":2,\"bag_style_id\":35,\"quantity\":\"10\",\"weight\":\"2.0000\",\"receive_weight\":\"2.0000\",\"uom_id\":2,\"transaction_id\":62,\"id\":66}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 07:18:17', '2021-02-06 07:18:17'),
(438, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 63, '[]', '{\"transaction_date\":\"2021-02-06\",\"bag_id\":35,\"from_department_id\":3,\"from_employee_id\":3,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"20.0000\",\"total_transfer_weight\":\"50.0000\",\"total_receive_weight\":\"50.0000\",\"is_eod_reporting\":1,\"transaction_mode\":1,\"status\":0,\"id\":63}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 09:31:13', '2021-02-06 09:31:13'),
(439, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 35, '{\"status\":0}', '{\"status\":2}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 09:31:13', '2021-02-06 09:31:13'),
(440, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 32, '{\"weight\":48}', '{\"weight\":\"48.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 09:31:13', '2021-02-06 09:31:13'),
(441, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 67, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":32,\"quantity\":10,\"weight\":\"48.0000\",\"receive_weight\":\"48.0000\",\"uom_id\":1,\"transaction_id\":63,\"id\":67}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 09:31:13', '2021-02-06 09:31:13'),
(442, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 35, '{\"weight\":2}', '{\"weight\":\"2.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 09:31:13', '2021-02-06 09:31:13'),
(443, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 68, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":35,\"quantity\":10,\"weight\":\"2.0000\",\"receive_weight\":\"2.0000\",\"uom_id\":2,\"transaction_id\":63,\"id\":68}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 09:31:13', '2021-02-06 09:31:13'),
(444, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 64, '[]', '{\"transaction_date\":\"2021-02-06\",\"bag_id\":33,\"from_department_id\":3,\"from_employee_id\":4,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"5.0000\",\"total_transfer_weight\":\"39.0000\",\"total_receive_weight\":\"39.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":64}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 09:31:46', '2021-02-06 09:31:46'),
(445, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 33, '{\"department_id\":3,\"employee_id\":4}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 09:31:46', '2021-02-06 09:31:46'),
(446, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 30, '{\"weight\":39}', '{\"weight\":\"39.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 09:31:46', '2021-02-06 09:31:46'),
(447, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 69, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":30,\"quantity\":5,\"weight\":\"39.0000\",\"receive_weight\":\"39.0000\",\"uom_id\":1,\"transaction_id\":64,\"id\":69}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 09:31:46', '2021-02-06 09:31:46'),
(448, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 65, '[]', '{\"transaction_date\":\"2021-02-06\",\"bag_id\":29,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"4.0000\",\"total_receive_weight\":\"4.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":65}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 11:54:46', '2021-02-06 11:54:46'),
(449, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 29, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 11:54:46', '2021-02-06 11:54:46'),
(450, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 26, '{\"weight\":4}', '{\"weight\":\"4.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 11:54:46', '2021-02-06 11:54:46'),
(451, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 70, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":26,\"quantity\":1,\"weight\":\"4.0000\",\"receive_weight\":\"4.0000\",\"uom_id\":1,\"transaction_id\":65,\"id\":70}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 11:54:46', '2021-02-06 11:54:46'),
(452, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 66, '[]', '{\"transaction_date\":\"2021-02-05\",\"bag_id\":29,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"4.0000\",\"total_transfer_weight\":\"7.0000\",\"total_receive_weight\":\"6.5000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":66}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44'),
(453, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 29, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44'),
(454, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 71, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":26,\"quantity\":1,\"weight\":\"4.0000\",\"receive_weight\":\"4.0000\",\"uom_id\":1,\"transaction_id\":66,\"id\":71}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44'),
(455, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 72, '[]', '{\"status\":0,\"type\":1,\"other_accessories_id\":2,\"bag_style_id\":null,\"quantity\":\"3\",\"weight\":\"3.0000\",\"receive_weight\":\"3.0000\",\"uom_id\":2,\"transaction_id\":66,\"id\":72}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44'),
(456, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 43, '[]', '{\"type\":1,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":66,\"date\":\"2021-02-05\",\"user_id\":2,\"status\":0,\"id\":43}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44'),
(457, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 44, '[]', '{\"type\":0,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":66,\"date\":\"2021-02-05\",\"user_id\":2,\"status\":0,\"id\":44}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44'),
(458, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 45, '[]', '{\"type\":2,\"weight\":\"0.1\",\"admin_approval_loss_weight\":0,\"transaction_id\":66,\"date\":\"2021-02-05\",\"user_id\":2,\"status\":0,\"id\":45}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44'),
(466, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 69, '[]', '{\"transaction_date\":\"2021-02-06\",\"bag_id\":33,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":4,\"to_employee_id\":5,\"description\":null,\"total_transfer_quantity\":\"5.0000\",\"total_transfer_weight\":\"39.0000\",\"total_receive_weight\":\"38.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":69}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 12:49:49', '2021-02-06 12:49:49'),
(467, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 33, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 12:49:49', '2021-02-06 12:49:49'),
(468, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 75, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":30,\"quantity\":5,\"weight\":\"39.0000\",\"receive_weight\":\"39.0000\",\"uom_id\":1,\"transaction_id\":69,\"id\":75}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 12:49:49', '2021-02-06 12:49:49');
INSERT INTO `audits` (`id`, `user_type`, `user_id`, `event`, `auditable_type`, `auditable_id`, `old_values`, `new_values`, `url`, `ip_address`, `user_agent`, `tags`, `created_at`, `updated_at`) VALUES
(469, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 46, '[]', '{\"type\":1,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":69,\"date\":\"2021-02-06\",\"user_id\":2,\"status\":0,\"id\":46}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 12:49:49', '2021-02-06 12:49:49'),
(470, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 47, '[]', '{\"type\":0,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":69,\"date\":\"2021-02-06\",\"user_id\":2,\"status\":0,\"id\":47}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-06 12:49:49', '2021-02-06 12:49:49'),
(471, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 70, '[]', '{\"transaction_date\":\"2021-02-01\",\"bag_id\":30,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"45.0000\",\"total_receive_weight\":\"45.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":70}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 04:58:21', '2021-02-08 04:58:21'),
(472, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 30, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 04:58:21', '2021-02-08 04:58:21'),
(473, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 27, '{\"weight\":45}', '{\"weight\":\"45.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 04:58:21', '2021-02-08 04:58:21'),
(474, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 76, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":27,\"quantity\":1,\"weight\":\"45.0000\",\"receive_weight\":\"45.0000\",\"uom_id\":1,\"transaction_id\":70,\"id\":76}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 04:58:21', '2021-02-08 04:58:21'),
(475, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 71, '[]', '{\"transaction_date\":\"2021-02-08\",\"bag_id\":30,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"45.0000\",\"total_receive_weight\":\"44.50000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":71}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 04:59:13', '2021-02-08 04:59:13'),
(476, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 30, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 04:59:13', '2021-02-08 04:59:13'),
(477, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 77, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":27,\"quantity\":1,\"weight\":\"45.0000\",\"receive_weight\":\"45.0000\",\"uom_id\":1,\"transaction_id\":71,\"id\":77}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 04:59:13', '2021-02-08 04:59:13'),
(478, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 48, '[]', '{\"type\":1,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":71,\"date\":\"2021-02-08\",\"user_id\":2,\"status\":0,\"id\":48}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 04:59:13', '2021-02-08 04:59:13'),
(479, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 49, '[]', '{\"type\":0,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":71,\"date\":\"2021-02-08\",\"user_id\":2,\"status\":0,\"id\":49}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 04:59:13', '2021-02-08 04:59:13'),
(480, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 50, '[]', '{\"type\":2,\"weight\":\"0.1\",\"admin_approval_loss_weight\":0,\"transaction_id\":71,\"date\":\"2021-02-08\",\"user_id\":2,\"status\":0,\"id\":50}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 04:59:13', '2021-02-08 04:59:13'),
(481, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 72, '[]', '{\"transaction_date\":\"2021-02-08\",\"bag_id\":31,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"56.0000\",\"total_receive_weight\":\"56.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":72}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:02:48', '2021-02-08 05:02:48'),
(482, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 31, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:02:48', '2021-02-08 05:02:48'),
(483, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 28, '{\"weight\":56}', '{\"weight\":\"56.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:02:48', '2021-02-08 05:02:48'),
(484, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 78, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":28,\"quantity\":1,\"weight\":\"56.0000\",\"receive_weight\":\"56.0000\",\"uom_id\":1,\"transaction_id\":72,\"id\":78}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:02:48', '2021-02-08 05:02:48'),
(485, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 73, '[]', '{\"transaction_date\":\"2021-02-08\",\"bag_id\":31,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"56.0000\",\"total_receive_weight\":\"55.5000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":73}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:03:22', '2021-02-08 05:03:22'),
(486, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 31, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:03:22', '2021-02-08 05:03:22'),
(487, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 79, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":28,\"quantity\":1,\"weight\":\"56.0000\",\"receive_weight\":\"56.0000\",\"uom_id\":1,\"transaction_id\":73,\"id\":79}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:03:22', '2021-02-08 05:03:22'),
(488, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 51, '[]', '{\"type\":1,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":73,\"date\":\"2021-02-08\",\"user_id\":2,\"status\":0,\"id\":51}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:03:22', '2021-02-08 05:03:22'),
(489, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 52, '[]', '{\"type\":0,\"weight\":\".2\",\"admin_approval_loss_weight\":0,\"transaction_id\":73,\"date\":\"2021-02-08\",\"user_id\":2,\"status\":0,\"id\":52}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:03:22', '2021-02-08 05:03:22'),
(490, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 53, '[]', '{\"type\":2,\"weight\":\".1\",\"admin_approval_loss_weight\":0,\"transaction_id\":73,\"date\":\"2021-02-08\",\"user_id\":2,\"status\":0,\"id\":53}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:03:22', '2021-02-08 05:03:22'),
(491, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 74, '[]', '{\"transaction_date\":\"2021-02-08\",\"bag_id\":7,\"from_department_id\":3,\"from_employee_id\":4,\"to_department_id\":4,\"to_employee_id\":5,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"19.5000\",\"total_receive_weight\":\"19.000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":74}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:29:28', '2021-02-08 05:29:28'),
(492, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 7, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:29:28', '2021-02-08 05:29:28'),
(493, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 80, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":7,\"quantity\":10,\"weight\":\"19.5000\",\"receive_weight\":\"19.5000\",\"uom_id\":1,\"transaction_id\":74,\"id\":80}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:29:28', '2021-02-08 05:29:28'),
(494, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 54, '[]', '{\"type\":0,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":74,\"date\":\"2021-02-08\",\"user_id\":5,\"status\":0,\"id\":54}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:29:28', '2021-02-08 05:29:28'),
(495, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 75, '[]', '{\"transaction_date\":\"2021-02-08\",\"bag_id\":22,\"from_department_id\":4,\"from_employee_id\":5,\"to_department_id\":5,\"to_employee_id\":7,\"description\":null,\"total_transfer_quantity\":\"3.0000\",\"total_transfer_weight\":\"12.9990\",\"total_receive_weight\":\"12.9990\",\"is_eod_reporting\":0,\"transaction_mode\":1,\"status\":0,\"id\":75}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:37:22', '2021-02-08 05:37:22'),
(496, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 22, '{\"status\":0}', '{\"status\":2}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:37:22', '2021-02-08 05:37:22'),
(497, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 22, '{\"weight\":12.999}', '{\"weight\":\"12.9990\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:37:22', '2021-02-08 05:37:22'),
(498, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 81, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":22,\"quantity\":3,\"weight\":\"12.9990\",\"receive_weight\":\"12.9990\",\"uom_id\":1,\"transaction_id\":75,\"id\":81}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:37:22', '2021-02-08 05:37:22'),
(499, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 76, '[]', '{\"transaction_date\":\"2021-02-08\",\"bag_id\":23,\"from_department_id\":4,\"from_employee_id\":6,\"to_department_id\":5,\"to_employee_id\":7,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"2.9000\",\"total_receive_weight\":\"2.5000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":76}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:41:27', '2021-02-08 05:41:27'),
(500, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 23, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:41:27', '2021-02-08 05:41:27'),
(501, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 82, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":23,\"quantity\":1,\"weight\":\"2.9000\",\"receive_weight\":\"2.9000\",\"uom_id\":1,\"transaction_id\":76,\"id\":82}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:41:27', '2021-02-08 05:41:27'),
(502, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 55, '[]', '{\"type\":1,\"weight\":\"0.1\",\"admin_approval_loss_weight\":0,\"transaction_id\":76,\"date\":\"2021-02-08\",\"user_id\":7,\"status\":0,\"id\":55}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:41:27', '2021-02-08 05:41:27'),
(503, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 56, '[]', '{\"type\":0,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":76,\"date\":\"2021-02-08\",\"user_id\":7,\"status\":0,\"id\":56}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:41:27', '2021-02-08 05:41:27'),
(504, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 57, '[]', '{\"type\":2,\"weight\":\"0.1\",\"admin_approval_loss_weight\":0,\"transaction_id\":76,\"date\":\"2021-02-08\",\"user_id\":7,\"status\":0,\"id\":57}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 05:41:27', '2021-02-08 05:41:27'),
(505, 'App\\User', 14, 'updated', 'App\\Models\\TransactionItemLossDetails', 22, '{\"status\":1,\"admin_id\":null,\"reason_type_id\":0}', '{\"status\":0,\"admin_id\":14,\"reason_type_id\":1}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 06:43:18', '2021-02-08 06:43:18'),
(506, 'App\\User', 14, 'updated', 'App\\Models\\TransactionItemLossDetails', 20, '{\"status\":1,\"admin_id\":null,\"reason_type_id\":0}', '{\"status\":0,\"admin_id\":14,\"reason_type_id\":1}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 06:44:04', '2021-02-08 06:44:04'),
(507, 'App\\User', 14, 'updated', 'App\\Models\\TransactionItem', 24, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 06:44:04', '2021-02-08 06:44:04'),
(508, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 77, '[]', '{\"transaction_date\":\"2021-02-08\",\"bag_id\":15,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"17.0000\",\"total_transfer_weight\":\"55.0000\",\"total_receive_weight\":\"55.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":77}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 06:55:37', '2021-02-08 06:55:37'),
(509, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 15, '{\"weight\":45}', '{\"weight\":\"45.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 06:55:37', '2021-02-08 06:55:37'),
(510, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 83, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":15,\"quantity\":15,\"weight\":\"45.0000\",\"receive_weight\":\"45.0000\",\"uom_id\":1,\"transaction_id\":77,\"id\":83}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 06:55:37', '2021-02-08 06:55:37'),
(511, 'App\\User', 14, 'created', 'App\\Models\\BagStyle', 36, '[]', '{\"other_accessories_id\":2,\"quantity\":\"2\",\"weight\":\"10.0000\",\"bag_id\":15,\"id\":36}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 06:55:38', '2021-02-08 06:55:38'),
(512, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 84, '[]', '{\"status\":0,\"type\":1,\"other_accessories_id\":2,\"bag_style_id\":36,\"quantity\":\"2\",\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":2,\"transaction_id\":77,\"id\":84}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-08 06:55:38', '2021-02-08 06:55:38'),
(513, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 78, '[]', '{\"transaction_date\":\"2021-02-09\",\"bag_id\":15,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"17.0000\",\"total_transfer_weight\":\"55.0000\",\"total_receive_weight\":\"55.0000\",\"is_eod_reporting\":0,\"transaction_mode\":1,\"status\":1,\"id\":78}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:18', '2021-02-09 09:12:18'),
(514, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 15, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:18', '2021-02-09 09:12:18'),
(515, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 15, '{\"status\":3}', '{\"status\":2}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:18', '2021-02-09 09:12:18'),
(516, 'App\\User', 14, 'created', 'App\\Models\\Bag', 37, '[]', '{\"parent_bag_id\":15,\"bag_number\":\"BG202\",\"order_number\":\"202\",\"instructions\":null,\"department_id\":2,\"employee_id\":1,\"id\":37}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:18', '2021-02-09 09:12:18'),
(517, 'App\\User', 14, 'created', 'App\\Models\\Bag', 38, '[]', '{\"parent_bag_id\":15,\"bag_number\":\"BG202-1\",\"order_number\":\"202\",\"instructions\":null,\"department_id\":3,\"employee_id\":3,\"id\":38}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:18', '2021-02-09 09:12:18'),
(518, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 15, '{\"weight\":45}', '{\"weight\":\"45.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:18', '2021-02-09 09:12:18'),
(519, 'App\\User', 14, 'created', 'App\\Models\\BagStyle', 37, '[]', '{\"bag_id\":37,\"style_id\":1,\"other_accessories_id\":null,\"upload_id\":null,\"quantity\":10,\"weight\":\"30.0000\",\"instructions\":\"sample\",\"parent_bag_style_id\":15,\"id\":37}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:18', '2021-02-09 09:12:18'),
(520, 'App\\User', 14, 'created', 'App\\Models\\BagStyle', 38, '[]', '{\"bag_id\":38,\"style_id\":1,\"other_accessories_id\":null,\"upload_id\":null,\"quantity\":5,\"weight\":\"15.0000\",\"instructions\":\"sample\",\"parent_bag_style_id\":15,\"id\":38}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:18', '2021-02-09 09:12:18'),
(521, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 85, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":15,\"quantity\":15,\"weight\":\"45.0000\",\"receive_weight\":\"45.0000\",\"uom_id\":1,\"transaction_id\":78,\"id\":85}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19'),
(522, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 36, '{\"weight\":10}', '{\"weight\":\"10.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19'),
(523, 'App\\User', 14, 'created', 'App\\Models\\BagStyle', 39, '[]', '{\"bag_id\":37,\"style_id\":null,\"other_accessories_id\":2,\"upload_id\":null,\"quantity\":1,\"weight\":\"5.0000\",\"instructions\":null,\"parent_bag_style_id\":36,\"id\":39}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19'),
(524, 'App\\User', 14, 'created', 'App\\Models\\BagStyle', 40, '[]', '{\"bag_id\":38,\"style_id\":null,\"other_accessories_id\":2,\"upload_id\":null,\"quantity\":1,\"weight\":\"5.0000\",\"instructions\":null,\"parent_bag_style_id\":36,\"id\":40}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19'),
(525, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 86, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":36,\"quantity\":2,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":2,\"transaction_id\":78,\"id\":86}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19'),
(526, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 58, '[]', '{\"type\":1,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":78,\"date\":\"2021-02-09\",\"user_id\":2,\"status\":0,\"id\":58}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19'),
(527, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 59, '[]', '{\"type\":0,\"weight\":\"0.1\",\"admin_approval_loss_weight\":0,\"transaction_id\":78,\"date\":\"2021-02-09\",\"user_id\":2,\"status\":0,\"id\":59}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19'),
(528, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 60, '[]', '{\"type\":2,\"weight\":\".2\",\"admin_approval_loss_weight\":0,\"transaction_id\":78,\"date\":\"2021-02-09\",\"user_id\":2,\"status\":0,\"id\":60}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19'),
(529, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 79, '[]', '{\"transaction_date\":\"2021-02-10\",\"bag_id\":37,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"11.0000\",\"total_transfer_weight\":\"35.0000\",\"total_receive_weight\":\"34.5000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":79}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17'),
(530, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 37, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17'),
(531, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 87, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":37,\"quantity\":10,\"weight\":\"30.0000\",\"receive_weight\":\"30.0000\",\"uom_id\":1,\"transaction_id\":79,\"id\":87}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17'),
(532, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 88, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":39,\"quantity\":1,\"weight\":\"5.0000\",\"receive_weight\":\"5.0000\",\"uom_id\":2,\"transaction_id\":79,\"id\":88}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17'),
(533, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 61, '[]', '{\"type\":1,\"weight\":\"0.2\",\"admin_approval_loss_weight\":0,\"transaction_id\":79,\"date\":\"2021-02-10\",\"user_id\":2,\"status\":0,\"id\":61}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17'),
(534, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 62, '[]', '{\"type\":0,\"weight\":\".2\",\"admin_approval_loss_weight\":0,\"transaction_id\":79,\"date\":\"2021-02-10\",\"user_id\":2,\"status\":0,\"id\":62}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17'),
(535, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 63, '[]', '{\"type\":2,\"weight\":\".1\",\"admin_approval_loss_weight\":0,\"transaction_id\":79,\"date\":\"2021-02-10\",\"user_id\":2,\"status\":0,\"id\":63}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17'),
(536, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 80, '[]', '{\"transaction_date\":\"2021-02-11\",\"bag_id\":38,\"from_department_id\":3,\"from_employee_id\":3,\"to_department_id\":4,\"to_employee_id\":5,\"description\":null,\"total_transfer_quantity\":\"6.0000\",\"total_transfer_weight\":\"20.0000\",\"total_receive_weight\":\"19.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":80}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21'),
(537, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 38, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21'),
(538, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 89, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":38,\"quantity\":5,\"weight\":\"15.0000\",\"receive_weight\":\"15.0000\",\"uom_id\":1,\"transaction_id\":80,\"id\":89}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21'),
(539, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 90, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":40,\"quantity\":1,\"weight\":\"5.0000\",\"receive_weight\":\"5.0000\",\"uom_id\":2,\"transaction_id\":80,\"id\":90}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21'),
(540, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 64, '[]', '{\"type\":1,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":80,\"date\":\"2021-02-11\",\"user_id\":4,\"status\":0,\"id\":64}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21'),
(541, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 65, '[]', '{\"type\":0,\"weight\":\".2\",\"admin_approval_loss_weight\":0,\"transaction_id\":80,\"date\":\"2021-02-11\",\"user_id\":4,\"status\":0,\"id\":65}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21'),
(542, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 66, '[]', '{\"type\":2,\"weight\":\".3\",\"admin_approval_loss_weight\":0,\"transaction_id\":80,\"date\":\"2021-02-11\",\"user_id\":4,\"status\":0,\"id\":66}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21'),
(543, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 81, '[]', '{\"transaction_date\":\"2021-02-11\",\"bag_id\":21,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"12.0000\",\"total_transfer_weight\":\"31.9900\",\"total_receive_weight\":\"31.00\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":81}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:24:03', '2021-02-11 07:24:03'),
(544, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 21, '{\"department_id\":2,\"employee_id\":1}', '{\"department_id\":3,\"employee_id\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:24:03', '2021-02-11 07:24:03'),
(545, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 21, '{\"weight\":31.99}', '{\"weight\":\"31.9900\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:24:03', '2021-02-11 07:24:03'),
(546, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 91, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":21,\"quantity\":12,\"weight\":\"31.9900\",\"receive_weight\":\"31.9900\",\"uom_id\":1,\"transaction_id\":81,\"id\":91}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:24:03', '2021-02-11 07:24:03'),
(547, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 67, '[]', '{\"type\":1,\"weight\":\"0.99\",\"admin_approval_loss_weight\":0,\"transaction_id\":81,\"date\":\"2021-02-11\",\"user_id\":2,\"status\":0,\"id\":67}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:24:03', '2021-02-11 07:24:03'),
(548, 'App\\User', 14, 'updated', 'App\\Models\\TransactionItemLossDetails', 12, '{\"status\":1,\"admin_id\":null,\"reason_type_id\":0}', '{\"status\":0,\"admin_id\":14,\"reason_type_id\":1}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:25:03', '2021-02-11 07:25:03'),
(549, 'App\\User', 14, 'updated', 'App\\Models\\TransactionItem', 13, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:25:03', '2021-02-11 07:25:03'),
(550, 'App\\User', 14, 'updated', 'App\\Models\\TransactionItemLossDetails', 14, '{\"status\":1,\"admin_id\":null,\"reason_type_id\":0}', '{\"status\":0,\"admin_id\":14,\"reason_type_id\":1}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:25:11', '2021-02-11 07:25:11'),
(551, 'App\\User', 14, 'updated', 'App\\Models\\TransactionItemLossDetails', 18, '{\"status\":1,\"admin_id\":null,\"reason_type_id\":0}', '{\"status\":0,\"admin_id\":14,\"reason_type_id\":1}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:25:30', '2021-02-11 07:25:30'),
(552, 'App\\User', 14, 'updated', 'App\\Models\\TransactionItemLossDetails', 16, '{\"status\":1,\"admin_id\":null,\"reason_type_id\":0}', '{\"status\":0,\"admin_id\":14,\"reason_type_id\":1}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:25:41', '2021-02-11 07:25:41'),
(553, 'App\\User', 14, 'updated', 'App\\Models\\TransactionItem', 16, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:25:41', '2021-02-11 07:25:41'),
(554, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 82, '[]', '{\"transaction_date\":\"2021-02-11\",\"bag_id\":21,\"from_department_id\":3,\"from_employee_id\":3,\"to_department_id\":4,\"to_employee_id\":5,\"description\":null,\"total_transfer_quantity\":\"12.0000\",\"total_transfer_weight\":\"31.9900\",\"total_receive_weight\":\"31.00\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":82}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:36:35', '2021-02-11 07:36:35'),
(555, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 21, '{\"department_id\":3,\"employee_id\":3}', '{\"department_id\":4,\"employee_id\":5}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:36:35', '2021-02-11 07:36:35'),
(556, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 21, '{\"weight\":31.99}', '{\"weight\":\"31.9900\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:36:35', '2021-02-11 07:36:35'),
(557, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 92, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":21,\"quantity\":12,\"weight\":\"31.9900\",\"receive_weight\":\"31.9900\",\"uom_id\":1,\"transaction_id\":82,\"id\":92}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:36:35', '2021-02-11 07:36:35'),
(558, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 68, '[]', '{\"type\":1,\"weight\":\"0.99\",\"admin_approval_loss_weight\":0,\"transaction_id\":82,\"date\":\"2021-02-11\",\"user_id\":4,\"status\":0,\"id\":68}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 07:36:35', '2021-02-11 07:36:35'),
(559, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 83, '[]', '{\"transaction_date\":\"2021-02-11\",\"bag_id\":21,\"from_department_id\":4,\"from_employee_id\":5,\"to_department_id\":5,\"to_employee_id\":7,\"description\":null,\"total_transfer_quantity\":\"12.0000\",\"total_transfer_weight\":\"31.9900\",\"total_receive_weight\":\"31.00\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":83}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 08:12:05', '2021-02-11 08:12:05'),
(560, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 21, '{\"department_id\":4,\"employee_id\":5}', '{\"department_id\":5,\"employee_id\":7}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 08:12:05', '2021-02-11 08:12:05'),
(561, 'App\\User', 14, 'updated', 'App\\Models\\BagStyle', 21, '{\"weight\":31.99}', '{\"weight\":\"31.9900\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 08:12:05', '2021-02-11 08:12:05'),
(562, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 93, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":21,\"quantity\":12,\"weight\":\"31.9900\",\"receive_weight\":\"31.9900\",\"uom_id\":1,\"transaction_id\":83,\"id\":93}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 08:12:05', '2021-02-11 08:12:05'),
(563, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 69, '[]', '{\"type\":1,\"weight\":\"0.99\",\"admin_approval_loss_weight\":0,\"transaction_id\":83,\"date\":\"2021-02-11\",\"user_id\":6,\"status\":0,\"id\":69}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 08:12:05', '2021-02-11 08:12:05'),
(564, 'App\\User', 14, 'created', 'App\\Models\\Transaction', 84, '[]', '{\"transaction_date\":\"2021-02-11\",\"bag_id\":21,\"from_department_id\":5,\"from_employee_id\":7,\"to_department_id\":6,\"to_employee_id\":10,\"description\":null,\"total_transfer_quantity\":\"12.0000\",\"total_transfer_weight\":\"31.9900\",\"total_receive_weight\":\"31.00\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":84}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 08:27:09', '2021-02-11 08:27:09'),
(565, 'App\\User', 14, 'updated', 'App\\Models\\Bag', 21, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 08:27:09', '2021-02-11 08:27:09'),
(566, 'App\\User', 14, 'created', 'App\\Models\\TransactionItem', 94, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":21,\"quantity\":12,\"weight\":\"31.9900\",\"receive_weight\":\"31.9900\",\"uom_id\":1,\"transaction_id\":84,\"id\":94}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 08:27:09', '2021-02-11 08:27:09'),
(567, 'App\\User', 14, 'created', 'App\\Models\\TransactionItemLossDetails', 70, '[]', '{\"type\":0,\"weight\":\"0.99\",\"admin_approval_loss_weight\":0,\"transaction_id\":84,\"date\":\"2021-02-11\",\"user_id\":8,\"status\":0,\"id\":70}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-02-11 08:27:09', '2021-02-11 08:27:09'),
(568, 'App\\User', 1, 'created', 'App\\Models\\Bag', 39, '[]', '{\"bag_number\":\"BAG0005\",\"parent_bag_id\":null,\"order_number\":\"55555555\",\"instructions\":null,\"department_id\":1,\"id\":39}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-03-15 10:12:02', '2021-03-15 10:12:02'),
(569, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 41, '[]', '{\"style_id\":1,\"quantity\":1,\"weight\":\"10\",\"upload_id\":null,\"instructions\":null,\"bag_id\":39,\"id\":41}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36', NULL, '2021-03-15 10:12:02', '2021-03-15 10:12:02'),
(570, 'App\\User', 1, 'created', 'App\\Models\\Bag', 40, '[]', '{\"bag_number\":\"BAG0005\",\"parent_bag_id\":null,\"order_number\":\"455555\",\"instructions\":null,\"department_id\":1,\"id\":40}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-19 11:04:16', '2021-03-19 11:04:16'),
(571, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 42, '[]', '{\"style_id\":1,\"quantity\":1,\"weight\":\"10\",\"upload_id\":null,\"instructions\":null,\"bag_id\":40,\"id\":42}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-19 11:04:16', '2021-03-19 11:04:16'),
(572, 'App\\User', 1, 'created', 'App\\Models\\Bag', 41, '[]', '{\"bag_number\":\"BAG0005\",\"parent_bag_id\":null,\"order_number\":\"455555\",\"instructions\":null,\"department_id\":1,\"id\":41}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-24 08:11:26', '2021-03-24 08:11:26'),
(573, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 43, '[]', '{\"style_id\":1,\"quantity\":1,\"weight\":\"010\",\"upload_id\":null,\"instructions\":null,\"bag_id\":41,\"id\":43}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-24 08:11:26', '2021-03-24 08:11:26'),
(574, 'App\\User', 1, 'created', 'App\\Models\\Bag', 42, '[]', '{\"bag_number\":\"BAG0005\",\"parent_bag_id\":null,\"order_number\":\"455555\",\"instructions\":null,\"department_id\":1,\"id\":42}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:16:17', '2021-03-29 08:16:17'),
(575, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 44, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"100\",\"upload_id\":null,\"instructions\":null,\"bag_id\":42,\"id\":44}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:16:17', '2021-03-29 08:16:17'),
(576, 'App\\User', 1, 'created', 'App\\Models\\Bag', 43, '[]', '{\"bag_number\":\"BAG0005\",\"parent_bag_id\":null,\"order_number\":\"bag505\",\"instructions\":null,\"department_id\":1,\"id\":43}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:17:57', '2021-03-29 08:17:57'),
(577, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 45, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"100\",\"upload_id\":null,\"instructions\":\"test\",\"bag_id\":43,\"id\":45}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:17:57', '2021-03-29 08:17:57'),
(584, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 87, '[]', '{\"transaction_date\":\"2021-03-29\",\"bag_id\":39,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"10.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":87}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:37:32', '2021-03-29 08:37:32'),
(585, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 39, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:37:32', '2021-03-29 08:37:32'),
(586, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 41, '{\"weight\":10}', '{\"weight\":\"10.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:37:32', '2021-03-29 08:37:32');
INSERT INTO `audits` (`id`, `user_type`, `user_id`, `event`, `auditable_type`, `auditable_id`, `old_values`, `new_values`, `url`, `ip_address`, `user_agent`, `tags`, `created_at`, `updated_at`) VALUES
(587, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 97, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":41,\"quantity\":1,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":1,\"transaction_id\":87,\"id\":97}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:37:32', '2021-03-29 08:37:32'),
(588, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 88, '[]', '{\"transaction_date\":\"2021-03-29\",\"bag_id\":39,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":4,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"8.5000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":88}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:39:01', '2021-03-29 08:39:01'),
(589, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 39, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:39:01', '2021-03-29 08:39:01'),
(590, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 98, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":41,\"quantity\":1,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":1,\"transaction_id\":88,\"id\":98}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:39:01', '2021-03-29 08:39:01'),
(591, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 71, '[]', '{\"type\":1,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":88,\"date\":\"2021-03-29\",\"user_id\":2,\"status\":0,\"id\":71}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:39:02', '2021-03-29 08:39:02'),
(592, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 72, '[]', '{\"type\":0,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":88,\"date\":\"2021-03-29\",\"user_id\":2,\"status\":0,\"id\":72}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:39:02', '2021-03-29 08:39:02'),
(593, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 73, '[]', '{\"type\":2,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":88,\"date\":\"2021-03-29\",\"user_id\":2,\"status\":0,\"id\":73}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:39:02', '2021-03-29 08:39:02'),
(594, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 89, '[]', '{\"transaction_date\":\"2021-03-29\",\"bag_id\":26,\"from_department_id\":3,\"from_employee_id\":3,\"to_department_id\":4,\"to_employee_id\":5,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"2.0000\",\"total_receive_weight\":\"2.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":89}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:43:40', '2021-03-29 08:43:40'),
(595, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 26, '{\"department_id\":3,\"employee_id\":3}', '{\"department_id\":4,\"employee_id\":5}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:43:40', '2021-03-29 08:43:40'),
(596, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 24, '{\"weight\":2}', '{\"weight\":\"2.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:43:40', '2021-03-29 08:43:40'),
(597, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 99, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":24,\"quantity\":1,\"weight\":\"2.0000\",\"receive_weight\":\"2.0000\",\"uom_id\":1,\"transaction_id\":89,\"id\":99}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:43:40', '2021-03-29 08:43:40'),
(598, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 90, '[]', '{\"transaction_date\":\"2021-03-29\",\"bag_id\":26,\"from_department_id\":4,\"from_employee_id\":5,\"to_department_id\":5,\"to_employee_id\":7,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"2.0000\",\"total_receive_weight\":\"1.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":90}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:45:10', '2021-03-29 08:45:10'),
(599, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 26, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:45:10', '2021-03-29 08:45:10'),
(600, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 100, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":24,\"quantity\":1,\"weight\":\"2.0000\",\"receive_weight\":\"2.0000\",\"uom_id\":1,\"transaction_id\":90,\"id\":100}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:45:10', '2021-03-29 08:45:10'),
(601, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 74, '[]', '{\"type\":0,\"weight\":\"1\",\"admin_approval_loss_weight\":0,\"transaction_id\":90,\"date\":\"2021-03-29\",\"user_id\":6,\"status\":0,\"id\":74}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-29 08:45:10', '2021-03-29 08:45:10'),
(602, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 91, '[]', '{\"transaction_date\":\"2021-03-30\",\"bag_id\":40,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"10.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":91}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-30 03:59:04', '2021-03-30 03:59:04'),
(603, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 40, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-30 03:59:05', '2021-03-30 03:59:05'),
(604, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 42, '{\"weight\":10}', '{\"weight\":\"10.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-30 03:59:05', '2021-03-30 03:59:05'),
(605, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 101, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":42,\"quantity\":1,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":1,\"transaction_id\":91,\"id\":101}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-03-30 03:59:05', '2021-03-30 03:59:05'),
(606, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 92, '[]', '{\"transaction_date\":\"2021-04-06\",\"bag_id\":40,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":3,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"9\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"id\":92}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-06 07:24:49', '2021-04-06 07:24:49'),
(607, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 40, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-06 07:24:49', '2021-04-06 07:24:49'),
(608, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 102, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":42,\"quantity\":1,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":1,\"transaction_id\":92,\"id\":102}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-06 07:24:49', '2021-04-06 07:24:49'),
(609, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 75, '[]', '{\"type\":1,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":92,\"date\":\"2021-04-06\",\"user_id\":2,\"status\":0,\"id\":75}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-06 07:24:49', '2021-04-06 07:24:49'),
(610, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 76, '[]', '{\"type\":0,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":92,\"date\":\"2021-04-06\",\"user_id\":2,\"status\":0,\"id\":76}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-06 07:24:49', '2021-04-06 07:24:49'),
(611, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 93, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":41,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"10.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"id\":93}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:28:37', '2021-04-08 21:28:37'),
(612, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 41, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:28:37', '2021-04-08 21:28:37'),
(613, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 43, '{\"weight\":10}', '{\"weight\":\"10.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:28:37', '2021-04-08 21:28:37'),
(614, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 103, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":43,\"quantity\":1,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":1,\"transaction_id\":93,\"id\":103}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:28:37', '2021-04-08 21:28:37'),
(615, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 94, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":41,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":4,\"description\":null,\"total_transfer_quantity\":\"1.0000\",\"total_transfer_weight\":\"10.0000\",\"total_receive_weight\":\"9.5\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"total_loss_weight\":\"0.5000\",\"id\":94}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:35:23', '2021-04-08 21:35:23'),
(616, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 41, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:35:23', '2021-04-08 21:35:23'),
(617, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 104, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":43,\"quantity\":1,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":1,\"transaction_id\":94,\"id\":104}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:35:23', '2021-04-08 21:35:23'),
(618, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 77, '[]', '{\"type\":0,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":94,\"date\":\"2021-04-09\",\"user_id\":2,\"status\":0,\"id\":77}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:35:23', '2021-04-08 21:35:23'),
(622, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 95, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":42,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"100.0000\",\"total_receive_weight\":\"100.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"total_loss_weight\":\"0.0000\",\"id\":95}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:39:39', '2021-04-08 21:39:39'),
(623, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 42, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:39:39', '2021-04-08 21:39:39'),
(624, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 44, '{\"weight\":100}', '{\"weight\":\"100.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:39:39', '2021-04-08 21:39:39'),
(625, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 105, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":44,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":95,\"id\":105}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:39:39', '2021-04-08 21:39:39'),
(626, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 96, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":42,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":4,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"100.0000\",\"total_receive_weight\":\"99\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"total_loss_weight\":\"1.0000\",\"id\":96}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:40:04', '2021-04-08 21:40:04'),
(627, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 42, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:40:04', '2021-04-08 21:40:04'),
(628, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 106, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":44,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":96,\"id\":106}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:40:04', '2021-04-08 21:40:04'),
(629, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 78, '[]', '{\"type\":1,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":96,\"date\":\"2021-04-09\",\"user_id\":2,\"status\":0,\"id\":78}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:40:04', '2021-04-08 21:40:04'),
(630, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 79, '[]', '{\"type\":0,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":96,\"date\":\"2021-04-09\",\"user_id\":2,\"status\":0,\"id\":79}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:40:04', '2021-04-08 21:40:04'),
(631, 'App\\User', 1, 'created', 'App\\Models\\Bag', 44, '[]', '{\"bag_number\":\"BAG0005\",\"parent_bag_id\":null,\"order_number\":\"testorder\",\"instructions\":null,\"department_id\":1,\"inc_val\":5,\"id\":44}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:41:05', '2021-04-08 21:41:05'),
(632, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 46, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"100\",\"upload_id\":null,\"instructions\":null,\"bag_id\":44,\"id\":46}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:41:05', '2021-04-08 21:41:05'),
(633, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 97, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"100.0000\",\"total_receive_weight\":\"100.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"total_loss_weight\":\"0.0000\",\"id\":97}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:43:47', '2021-04-08 21:43:47'),
(634, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:43:47', '2021-04-08 21:43:47'),
(635, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 46, '{\"weight\":100}', '{\"weight\":\"100.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:43:47', '2021-04-08 21:43:47'),
(636, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 107, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":97,\"id\":107}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:43:47', '2021-04-08 21:43:47'),
(637, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 98, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":4,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"100.0000\",\"total_receive_weight\":\"100.0000\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"total_loss_weight\":\"0.0000\",\"id\":98}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:43:58', '2021-04-08 21:43:58'),
(638, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"department_id\":2,\"employee_id\":1}', '{\"department_id\":3,\"employee_id\":4}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:43:58', '2021-04-08 21:43:58'),
(639, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 46, '{\"weight\":100}', '{\"weight\":\"100.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:43:58', '2021-04-08 21:43:58'),
(640, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 108, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":98,\"id\":108}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:43:58', '2021-04-08 21:43:58'),
(641, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 99, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":3,\"from_employee_id\":4,\"to_department_id\":4,\"to_employee_id\":6,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"100.0000\",\"total_receive_weight\":\"99\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"total_loss_weight\":\"1.0000\",\"id\":99}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:44:31', '2021-04-08 21:44:31'),
(642, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:44:31', '2021-04-08 21:44:31'),
(643, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 109, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":99,\"id\":109}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:44:31', '2021-04-08 21:44:31'),
(644, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 80, '[]', '{\"type\":1,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":99,\"date\":\"2021-04-09\",\"user_id\":5,\"status\":0,\"id\":80}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:44:31', '2021-04-08 21:44:31'),
(645, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 81, '[]', '{\"type\":0,\"weight\":\"0.5\",\"admin_approval_loss_weight\":0,\"transaction_id\":99,\"date\":\"2021-04-09\",\"user_id\":5,\"status\":0,\"id\":81}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:44:31', '2021-04-08 21:44:31'),
(649, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 101, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":3,\"from_employee_id\":4,\"to_department_id\":4,\"to_employee_id\":6,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":\"100.0000\",\"total_receive_weight\":\"99\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"total_loss_weight\":\"1.0000\",\"id\":101}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:49:09', '2021-04-08 21:49:09'),
(650, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:49:09', '2021-04-08 21:49:09'),
(651, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 110, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":101,\"id\":110}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:49:09', '2021-04-08 21:49:09'),
(652, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 82, '[]', '{\"type\":0,\"weight\":\"1\",\"admin_approval_loss_weight\":0,\"transaction_id\":101,\"date\":\"2021-04-09\",\"user_id\":5,\"status\":0,\"id\":82}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-08 21:49:09', '2021-04-08 21:49:09'),
(655, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 102, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":3,\"from_employee_id\":4,\"to_department_id\":4,\"to_employee_id\":6,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":99,\"total_receive_weight\":\"98\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"total_loss_weight\":\"1.0000\",\"id\":102}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:23:35', '2021-04-09 00:23:35'),
(656, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"department_id\":3,\"employee_id\":4}', '{\"department_id\":4,\"employee_id\":6}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:23:35', '2021-04-09 00:23:35'),
(657, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 46, '{\"weight\":100}', '{\"weight\":\"100.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:23:35', '2021-04-09 00:23:35'),
(658, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 111, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":102,\"id\":111}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:23:35', '2021-04-09 00:23:35'),
(659, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 83, '[]', '{\"type\":1,\"weight\":\"1\",\"admin_approval_loss_weight\":0,\"transaction_id\":102,\"date\":\"2021-04-09\",\"user_id\":5,\"status\":0,\"id\":83}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:23:35', '2021-04-09 00:23:35'),
(660, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 103, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":4,\"from_employee_id\":6,\"to_department_id\":5,\"to_employee_id\":8,\"description\":null,\"total_transfer_quantity\":\"11.0000\",\"total_transfer_weight\":109,\"total_receive_weight\":\"100\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"total_loss_weight\":\"10.0000\",\"id\":103}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:30:53', '2021-04-09 00:30:53'),
(661, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:30:53', '2021-04-09 00:30:53'),
(662, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 112, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":103,\"id\":112}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:30:53', '2021-04-09 00:30:53'),
(663, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 113, '[]', '{\"status\":1,\"type\":1,\"other_accessories_id\":2,\"bag_style_id\":null,\"quantity\":1,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":2,\"transaction_id\":103,\"id\":113}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:30:53', '2021-04-09 00:30:53'),
(664, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 84, '[]', '{\"type\":1,\"weight\":\"4\",\"admin_approval_loss_weight\":0,\"transaction_id\":103,\"date\":\"2021-04-09\",\"user_id\":7,\"status\":0,\"id\":84}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:30:53', '2021-04-09 00:30:53'),
(665, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 85, '[]', '{\"type\":0,\"weight\":\"5\",\"admin_approval_loss_weight\":0,\"transaction_id\":103,\"date\":\"2021-04-09\",\"user_id\":7,\"status\":0,\"id\":85}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:30:53', '2021-04-09 00:30:53'),
(666, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 104, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":4,\"from_employee_id\":6,\"to_department_id\":5,\"to_employee_id\":8,\"description\":null,\"total_transfer_quantity\":\"11.0000\",\"total_transfer_weight\":100,\"total_receive_weight\":100,\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"total_loss_weight\":\"0.0000\",\"id\":104}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:32:16', '2021-04-09 00:32:16'),
(667, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:32:16', '2021-04-09 00:32:16'),
(668, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 114, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":104,\"id\":114}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:32:16', '2021-04-09 00:32:16'),
(669, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 115, '[]', '{\"status\":1,\"type\":1,\"other_accessories_id\":2,\"bag_style_id\":null,\"quantity\":1,\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":2,\"transaction_id\":104,\"id\":115}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:32:16', '2021-04-09 00:32:16'),
(670, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 86, '[]', '{\"type\":1,\"weight\":\"4\",\"admin_approval_loss_weight\":0,\"transaction_id\":104,\"date\":\"2021-04-09\",\"user_id\":7,\"status\":0,\"id\":86}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:32:16', '2021-04-09 00:32:16'),
(671, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 87, '[]', '{\"type\":0,\"weight\":\"5\",\"admin_approval_loss_weight\":0,\"transaction_id\":104,\"date\":\"2021-04-09\",\"user_id\":7,\"status\":0,\"id\":87}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:32:16', '2021-04-09 00:32:16'),
(672, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 105, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":4,\"from_employee_id\":6,\"to_department_id\":6,\"to_employee_id\":9,\"description\":null,\"total_transfer_quantity\":\"20.0000\",\"total_transfer_weight\":110,\"total_receive_weight\":110,\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"total_loss_weight\":\"0.0000\",\"id\":105}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:34:48', '2021-04-09 00:34:48'),
(673, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:34:48', '2021-04-09 00:34:48'),
(674, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 116, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":105,\"id\":116}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:34:48', '2021-04-09 00:34:48'),
(675, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 117, '[]', '{\"status\":1,\"type\":1,\"other_accessories_id\":2,\"bag_style_id\":null,\"quantity\":\"10\",\"weight\":\"10.0000\",\"receive_weight\":\"10.0000\",\"uom_id\":2,\"transaction_id\":105,\"id\":117}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:34:48', '2021-04-09 00:34:48'),
(676, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 88, '[]', '{\"type\":1,\"weight\":\"4\",\"admin_approval_loss_weight\":0,\"transaction_id\":105,\"date\":\"2021-04-09\",\"user_id\":7,\"status\":0,\"id\":88}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:34:48', '2021-04-09 00:34:48'),
(677, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 89, '[]', '{\"type\":0,\"weight\":\"5\",\"admin_approval_loss_weight\":0,\"transaction_id\":105,\"date\":\"2021-04-09\",\"user_id\":7,\"status\":0,\"id\":89}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:34:48', '2021-04-09 00:34:48'),
(678, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 106, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":4,\"from_employee_id\":6,\"to_department_id\":5,\"to_employee_id\":7,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":100,\"total_receive_weight\":100,\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"total_loss_weight\":\"0.0000\",\"id\":106}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:38:16', '2021-04-09 00:38:16'),
(679, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"department_id\":4,\"employee_id\":6}', '{\"department_id\":5,\"employee_id\":7}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:38:16', '2021-04-09 00:38:16'),
(680, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 46, '{\"weight\":100}', '{\"weight\":\"100.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:38:17', '2021-04-09 00:38:17'),
(681, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 118, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":106,\"id\":118}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:38:17', '2021-04-09 00:38:17'),
(682, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 107, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":5,\"from_employee_id\":7,\"to_department_id\":6,\"to_employee_id\":10,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":100,\"total_receive_weight\":\"99\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"total_loss_weight\":\"1.0000\",\"id\":107}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:38:46', '2021-04-09 00:38:46'),
(683, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"department_id\":5,\"employee_id\":7}', '{\"department_id\":6,\"employee_id\":10}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:38:46', '2021-04-09 00:38:46'),
(684, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 46, '{\"weight\":100}', '{\"weight\":\"100.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:38:46', '2021-04-09 00:38:46'),
(685, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 119, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":107,\"id\":119}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:38:46', '2021-04-09 00:38:46'),
(686, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 90, '[]', '{\"type\":1,\"weight\":\"1\",\"admin_approval_loss_weight\":0,\"transaction_id\":107,\"date\":\"2021-04-09\",\"user_id\":8,\"status\":0,\"id\":90}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:38:46', '2021-04-09 00:38:46'),
(687, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 108, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":6,\"from_employee_id\":10,\"to_department_id\":7,\"to_employee_id\":11,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":99,\"total_receive_weight\":\"98\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"total_loss_weight\":\"2.0000\",\"id\":108}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:39:23', '2021-04-09 00:39:23'),
(688, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:39:23', '2021-04-09 00:39:23'),
(689, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 120, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":108,\"id\":120}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:39:24', '2021-04-09 00:39:24'),
(690, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 91, '[]', '{\"type\":0,\"weight\":\"1\",\"admin_approval_loss_weight\":0,\"transaction_id\":108,\"date\":\"2021-04-09\",\"user_id\":11,\"status\":0,\"id\":91}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 00:39:24', '2021-04-09 00:39:24'),
(739, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 127, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":6,\"from_employee_id\":10,\"to_department_id\":7,\"to_employee_id\":11,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":98,\"total_receive_weight\":\"96\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"total_loss_weight\":\"4.0000\",\"id\":127}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 01:47:51', '2021-04-09 01:47:51'),
(740, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 46, '{\"weight\":100}', '{\"weight\":\"100.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 01:47:51', '2021-04-09 01:47:51'),
(741, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 136, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":127,\"id\":136}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 01:47:51', '2021-04-09 01:47:51'),
(742, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 92, '[]', '{\"type\":0,\"weight\":\"2\",\"admin_approval_loss_weight\":0.1,\"transaction_id\":127,\"date\":\"2021-04-09\",\"user_id\":11,\"status\":1,\"id\":92}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 01:47:51', '2021-04-09 01:47:51'),
(743, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 01:47:51', '2021-04-09 01:47:51'),
(754, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItemLossDetails', 92, '{\"status\":1,\"admin_id\":null,\"reason_type_id\":0}', '{\"status\":0,\"admin_id\":1,\"reason_type_id\":1}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:09:23', '2021-04-09 02:09:23'),
(755, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItemLossDetails', 92, '{\"status\":1,\"reason_type_id\":1}', '{\"status\":0,\"reason_type_id\":2}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:11:03', '2021-04-09 02:11:03'),
(756, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItemLossDetails', 92, '{\"status\":1,\"reason_type_id\":2}', '{\"status\":0,\"reason_type_id\":1}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:11:53', '2021-04-09 02:11:53'),
(758, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItemLossDetails', 92, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:15:03', '2021-04-09 02:15:03'),
(759, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItem', 136, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:15:03', '2021-04-09 02:15:03'),
(761, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItemLossDetails', 92, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:19:37', '2021-04-09 02:19:37'),
(762, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItem', 136, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:19:37', '2021-04-09 02:19:37'),
(763, 'App\\User', 1, 'updated', 'App\\Models\\Transaction', 127, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:19:37', '2021-04-09 02:19:37');
INSERT INTO `audits` (`id`, `user_type`, `user_id`, `event`, `auditable_type`, `auditable_id`, `old_values`, `new_values`, `url`, `ip_address`, `user_agent`, `tags`, `created_at`, `updated_at`) VALUES
(764, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"status\":3,\"department_id\":6,\"employee_id\":10}', '{\"status\":0,\"department_id\":7,\"employee_id\":11}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:19:37', '2021-04-09 02:19:37'),
(765, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 128, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":44,\"from_department_id\":7,\"from_employee_id\":11,\"to_department_id\":8,\"to_employee_id\":null,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":96,\"total_receive_weight\":\"94\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"total_loss_weight\":\"6.0000\",\"id\":128}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:32:16', '2021-04-09 02:32:16'),
(766, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 46, '{\"weight\":100}', '{\"weight\":\"100.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:32:16', '2021-04-09 02:32:16'),
(767, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 137, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":46,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":128,\"id\":137}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:32:16', '2021-04-09 02:32:16'),
(768, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 93, '[]', '{\"type\":0,\"weight\":\"2\",\"admin_approval_loss_weight\":1,\"transaction_id\":128,\"date\":\"2021-04-09\",\"user_id\":12,\"status\":1,\"id\":93}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:32:16', '2021-04-09 02:32:16'),
(769, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:32:16', '2021-04-09 02:32:16'),
(771, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItemLossDetails', 93, '{\"status\":1,\"admin_id\":null,\"reason_type_id\":0}', '{\"status\":0,\"admin_id\":1,\"reason_type_id\":2}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:34:54', '2021-04-09 02:34:54'),
(772, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItem', 137, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:34:54', '2021-04-09 02:34:54'),
(773, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItemLossDetails', 93, '{\"status\":1,\"reason_type_id\":2}', '{\"status\":0,\"reason_type_id\":1}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:36:21', '2021-04-09 02:36:21'),
(774, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItem', 137, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:36:21', '2021-04-09 02:36:21'),
(775, 'App\\User', 1, 'updated', 'App\\Models\\Transaction', 128, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:36:21', '2021-04-09 02:36:21'),
(776, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 44, '{\"status\":3,\"department_id\":7,\"employee_id\":11}', '{\"status\":1,\"department_id\":8,\"employee_id\":null}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:36:21', '2021-04-09 02:36:21'),
(777, 'App\\User', 1, 'created', 'App\\Models\\Bag', 45, '[]', '{\"bag_number\":\"BAG0006\",\"parent_bag_id\":null,\"order_number\":\"testorder\",\"instructions\":null,\"department_id\":1,\"inc_val\":6,\"id\":45}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:37:41', '2021-04-09 02:37:41'),
(778, 'App\\User', 1, 'created', 'App\\Models\\BagStyle', 47, '[]', '{\"style_id\":1,\"quantity\":\"10\",\"weight\":\"100\",\"upload_id\":null,\"instructions\":null,\"bag_id\":45,\"id\":47}', 'http://127.0.0.1:8000/api/bag', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:37:41', '2021-04-09 02:37:41'),
(779, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 129, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":45,\"from_department_id\":1,\"from_employee_id\":null,\"to_department_id\":2,\"to_employee_id\":1,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":100,\"total_receive_weight\":100,\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"total_loss_weight\":\"0.0000\",\"id\":129}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:05', '2021-04-09 02:38:05'),
(780, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 45, '{\"department_id\":1,\"employee_id\":null}', '{\"department_id\":2,\"employee_id\":1}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:05', '2021-04-09 02:38:05'),
(781, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 47, '{\"weight\":100}', '{\"weight\":\"100.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:06', '2021-04-09 02:38:06'),
(782, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 138, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":47,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":129,\"id\":138}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:06', '2021-04-09 02:38:06'),
(783, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 130, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":45,\"from_department_id\":2,\"from_employee_id\":1,\"to_department_id\":3,\"to_employee_id\":4,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":100,\"total_receive_weight\":\"98\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":1,\"total_loss_weight\":\"2.0000\",\"id\":130}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:28', '2021-04-09 02:38:28'),
(784, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 47, '{\"weight\":100}', '{\"weight\":\"100.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:28', '2021-04-09 02:38:28'),
(785, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 139, '[]', '{\"status\":1,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":47,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":130,\"id\":139}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:28', '2021-04-09 02:38:28'),
(786, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 94, '[]', '{\"type\":0,\"weight\":\"2\",\"admin_approval_loss_weight\":1,\"transaction_id\":130,\"date\":\"2021-04-09\",\"user_id\":2,\"status\":1,\"id\":94}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:28', '2021-04-09 02:38:28'),
(787, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 45, '{\"status\":0}', '{\"status\":3}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:28', '2021-04-09 02:38:28'),
(788, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItemLossDetails', 94, '{\"status\":1,\"admin_id\":null,\"reason_type_id\":0}', '{\"status\":0,\"admin_id\":1,\"reason_type_id\":2}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:37', '2021-04-09 02:38:37'),
(789, 'App\\User', 1, 'updated', 'App\\Models\\TransactionItem', 139, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:37', '2021-04-09 02:38:37'),
(790, 'App\\User', 1, 'updated', 'App\\Models\\Transaction', 130, '{\"status\":1}', '{\"status\":0}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:37', '2021-04-09 02:38:37'),
(791, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 45, '{\"status\":3,\"department_id\":2,\"employee_id\":1}', '{\"status\":0,\"department_id\":3,\"employee_id\":4}', 'http://127.0.0.1:8000/api/loss-approval/status-update', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:38:37', '2021-04-09 02:38:37'),
(792, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 131, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":45,\"from_department_id\":3,\"from_employee_id\":4,\"to_department_id\":4,\"to_employee_id\":5,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":98,\"total_receive_weight\":\"99\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"total_loss_weight\":\"-1.0000\",\"id\":131}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:39:00', '2021-04-09 02:39:00'),
(793, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 45, '{\"department_id\":3,\"employee_id\":4}', '{\"department_id\":4,\"employee_id\":5}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:39:00', '2021-04-09 02:39:00'),
(794, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 47, '{\"weight\":100}', '{\"weight\":\"100.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:39:00', '2021-04-09 02:39:00'),
(795, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 140, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":47,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":131,\"id\":140}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:39:00', '2021-04-09 02:39:00'),
(796, 'App\\User', 1, 'created', 'App\\Models\\Transaction', 132, '[]', '{\"transaction_date\":\"2021-04-09\",\"bag_id\":45,\"from_department_id\":4,\"from_employee_id\":5,\"to_department_id\":5,\"to_employee_id\":7,\"description\":null,\"total_transfer_quantity\":\"10.0000\",\"total_transfer_weight\":98,\"total_receive_weight\":\"97\",\"is_eod_reporting\":0,\"transaction_mode\":0,\"status\":0,\"total_loss_weight\":\"3.0000\",\"id\":132}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:59:44', '2021-04-09 02:59:44'),
(797, 'App\\User', 1, 'updated', 'App\\Models\\Bag', 45, '{\"department_id\":4,\"employee_id\":5}', '{\"department_id\":5,\"employee_id\":7}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:59:44', '2021-04-09 02:59:44'),
(798, 'App\\User', 1, 'updated', 'App\\Models\\BagStyle', 47, '{\"weight\":100}', '{\"weight\":\"100.0000\"}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:59:44', '2021-04-09 02:59:44'),
(799, 'App\\User', 1, 'created', 'App\\Models\\TransactionItem', 141, '[]', '{\"status\":0,\"type\":0,\"other_accessories_id\":null,\"bag_style_id\":47,\"quantity\":10,\"weight\":\"100.0000\",\"receive_weight\":\"100.0000\",\"uom_id\":1,\"transaction_id\":132,\"id\":141}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:59:44', '2021-04-09 02:59:44'),
(800, 'App\\User', 1, 'created', 'App\\Models\\TransactionItemLossDetails', 95, '[]', '{\"type\":1,\"weight\":\"1\",\"admin_approval_loss_weight\":2,\"transaction_id\":132,\"date\":\"2021-04-09\",\"user_id\":6,\"status\":0,\"id\":95}', 'http://127.0.0.1:8000/api/transaction', '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36', NULL, '2021-04-09 02:59:44', '2021-04-09 02:59:44');

-- --------------------------------------------------------

--
-- Table structure for table `bag`
--

CREATE TABLE `bag` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_bag_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bag_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instructions` longtext COLLATE utf8mb4_unicode_ci,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0=>in progress,1=>completed,2=>splitted',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `employee_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cancel_otp` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inc_val` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bag`
--

INSERT INTO `bag` (`id`, `parent_bag_id`, `bag_number`, `order_number`, `instructions`, `status`, `deleted_at`, `created_at`, `updated_at`, `department_id`, `employee_id`, `cancel_otp`, `inc_val`) VALUES
(1, NULL, 'BG101', '101', NULL, 3, NULL, '2020-09-24 15:06:32', '2020-09-24 16:39:11', 2, 1, NULL, 0),
(2, NULL, 'BG102', '102', NULL, 3, NULL, '2020-09-24 16:08:21', '2020-09-24 16:31:53', 2, 2, NULL, 0),
(3, NULL, 'BG103', '103', NULL, 3, NULL, '2020-09-29 15:51:14', '2020-09-29 15:53:28', 2, 1, NULL, 0),
(4, NULL, 'BG104', '104', NULL, 3, NULL, '2020-10-01 10:29:43', '2020-10-01 10:36:43', 2, 2, NULL, 0),
(5, NULL, 'BG105', 'ORD-0001', NULL, 3, NULL, '2020-10-01 10:47:13', '2020-10-01 10:52:16', 2, 2, NULL, 0),
(6, NULL, 'BG106', 'ORDER NO-0001', NULL, 3, NULL, '2020-10-01 14:43:44', '2020-10-03 11:17:11', 2, 2, NULL, 0),
(7, NULL, 'BG107', '107', NULL, 3, NULL, '2020-10-01 15:31:56', '2021-02-08 05:29:28', 3, 4, NULL, 0),
(8, NULL, 'BG108', '108', NULL, 3, NULL, '2020-10-03 19:06:15', '2020-10-03 19:08:15', 2, 2, NULL, 0),
(9, NULL, 'BG110', '110', NULL, 5, NULL, '2020-10-07 11:58:40', '2020-10-07 12:28:15', 1, NULL, NULL, 0),
(10, NULL, 'BG111', 'ON111', '<p>Koikl</p>', 4, NULL, '2020-10-07 16:23:55', '2020-10-08 19:09:26', 2, 2, NULL, 0),
(11, NULL, '123', '123', NULL, 4, NULL, '2020-10-08 14:20:44', '2020-10-08 19:09:26', 2, 2, NULL, 0),
(12, NULL, '123', '123', NULL, 2, NULL, '2020-10-08 19:09:26', '2021-01-29 05:28:39', 3, 3, NULL, 0),
(13, NULL, 'BG111', 'ON111', '<p>Koikl</p>', 4, NULL, '2020-10-08 19:09:26', '2020-10-21 13:50:21', 2, 2, NULL, 0),
(14, NULL, 'BG201', '201', NULL, 3, NULL, '2020-10-10 08:32:35', '2020-10-10 08:44:15', 2, 2, NULL, 0),
(15, NULL, 'BG202', '202', NULL, 2, NULL, '2020-10-10 08:33:34', '2021-02-09 09:12:18', 2, 1, NULL, 0),
(16, NULL, 'BG203', '202', NULL, 4, NULL, '2020-10-13 15:07:08', '2020-10-21 13:50:21', 7, 11, '582510', 0),
(17, NULL, 'BG204', '202', NULL, 5, NULL, '2020-10-13 16:25:03', '2020-10-21 13:25:50', 7, 11, '755473', 0),
(18, NULL, '525', '525', NULL, 5, NULL, '2020-10-16 16:45:27', '2020-10-16 16:45:50', 1, NULL, '191769', 0),
(19, NULL, 'BG203', '202', NULL, 4, NULL, '2020-10-21 13:50:21', '2020-10-21 13:53:22', 1, NULL, NULL, 0),
(20, NULL, 'BG111', 'ON111', '<p>Koikl</p>', 4, NULL, '2020-10-21 13:50:21', '2020-10-21 13:53:22', 2, 2, NULL, 0),
(21, NULL, 'BG203', '202', NULL, 3, NULL, '2020-10-21 13:53:22', '2021-02-11 08:27:09', 5, 7, NULL, 0),
(22, NULL, 'BG111', 'ON111', '<p>Koikl</p>', 2, NULL, '2020-10-21 13:53:22', '2021-02-08 05:37:22', 4, 5, NULL, 0),
(23, NULL, 'BG133', 'BG133', '<p>dd</p>', 3, NULL, '2020-11-16 09:55:06', '2021-02-08 05:41:27', 4, 6, NULL, 0),
(26, NULL, 'BAG0000', 'asdadasdsad', NULL, 3, NULL, '2020-12-14 17:51:55', '2021-03-29 08:45:10', 4, 5, NULL, 0),
(27, NULL, 'BAG0001', 'sad', NULL, 3, NULL, '2020-12-14 17:52:48', '2021-02-06 07:03:51', 2, 1, NULL, 0),
(29, NULL, 'BAG0001', 'df', NULL, 3, NULL, '2020-12-16 11:06:18', '2021-02-06 12:43:44', 2, 1, NULL, 0),
(30, NULL, 'BAG0001', 'asdfadasdasd', NULL, 1, NULL, '2020-12-16 11:08:53', '2021-02-08 04:59:13', 2, 1, NULL, 1),
(31, NULL, 'BAG0002', 'asdas', NULL, 1, NULL, '2020-12-16 11:09:27', '2021-02-08 05:03:22', 2, 1, NULL, 2),
(32, NULL, 'BAG0003', 'adas', NULL, 2, NULL, '2020-12-18 10:22:38', '2020-12-18 10:24:53', 1, NULL, NULL, 3),
(33, 32, 'BAG0003', 'adas', NULL, 1, NULL, '2020-12-18 10:24:53', '2021-02-06 12:49:49', 2, 1, NULL, 0),
(34, 32, 'BAG0003-1', 'adas', NULL, 1, NULL, '2020-12-18 10:24:53', '2020-12-18 10:24:53', 8, NULL, NULL, 0),
(35, NULL, 'BAG0004', 'asdas', NULL, 2, NULL, '2020-12-22 04:50:13', '2021-02-06 09:31:13', 3, 3, '969874', 4),
(36, 12, '123', '123', NULL, 1, NULL, '2021-01-29 05:28:39', '2021-01-30 05:27:35', 3, 3, '603942', 0),
(37, 15, 'BG202', '202', NULL, 2, NULL, '2021-02-09 09:12:18', '2021-02-10 13:33:17', 2, 1, NULL, 0),
(38, 15, 'BG202-1', '202', NULL, 2, NULL, '2021-02-09 09:12:18', '2021-02-11 07:08:21', 3, 3, NULL, 0),
(39, NULL, 'BAG0005', '55555555', NULL, 2, NULL, '2021-03-15 10:12:02', '2021-03-29 08:39:01', 2, 1, NULL, 0),
(40, NULL, 'BAG0005', '455555', NULL, 2, NULL, '2021-03-19 11:04:16', '2021-04-06 07:24:49', 2, 1, NULL, 0),
(41, NULL, 'BAG0005', '455555', NULL, 2, NULL, '2021-03-24 08:11:26', '2021-04-08 21:35:23', 2, 1, NULL, 0),
(42, NULL, 'BAG0005', '455555', NULL, 2, NULL, '2021-03-29 08:16:17', '2021-04-08 21:40:04', 2, 1, NULL, 0),
(43, NULL, 'BAG0005', 'bag505', NULL, 2, NULL, '2021-03-29 08:17:57', '2021-03-29 08:17:57', 1, NULL, NULL, 0),
(44, NULL, 'BAG0005', 'testorder', NULL, 1, NULL, '2021-04-08 21:41:05', '2021-04-09 02:36:21', 8, NULL, NULL, 5),
(45, NULL, 'BAG0006', 'testorder', NULL, 0, NULL, '2021-04-09 02:37:41', '2021-04-09 02:59:44', 5, 7, NULL, 6);

-- --------------------------------------------------------

--
-- Table structure for table `bag_styles`
--

CREATE TABLE `bag_styles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bag_id` bigint(20) UNSIGNED NOT NULL,
  `style_id` bigint(20) UNSIGNED DEFAULT NULL,
  `upload_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` double NOT NULL,
  `weight` double NOT NULL,
  `instructions` longtext COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `other_accessories_id` bigint(20) UNSIGNED DEFAULT NULL,
  `parent_bag_style_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bag_styles`
--

INSERT INTO `bag_styles` (`id`, `bag_id`, `style_id`, `upload_id`, `quantity`, `weight`, `instructions`, `deleted_at`, `created_at`, `updated_at`, `other_accessories_id`, `parent_bag_style_id`) VALUES
(1, 1, 1, NULL, 10, 30, NULL, NULL, '2020-09-24 15:06:32', '2020-09-24 16:13:06', NULL, NULL),
(2, 2, 1, NULL, 10, 30, NULL, NULL, '2020-09-24 16:08:21', '2020-09-24 16:13:23', NULL, NULL),
(3, 3, 1, NULL, 10, 10, NULL, NULL, '2020-09-29 15:51:14', '2020-09-29 15:51:38', NULL, NULL),
(4, 4, 1, NULL, 10, 30, 'sample', NULL, '2020-10-01 10:29:43', '2020-10-01 10:30:15', NULL, NULL),
(5, 5, 1, NULL, 10, 10, NULL, NULL, '2020-10-01 10:47:13', '2020-10-01 10:48:19', NULL, NULL),
(6, 6, 1, NULL, 10, 10, NULL, NULL, '2020-10-01 14:43:44', '2020-10-01 14:44:11', NULL, NULL),
(7, 7, 1, NULL, 10, 19.5, NULL, NULL, '2020-10-01 15:31:56', '2020-10-03 14:12:42', NULL, NULL),
(8, 8, 1, NULL, 10, 10, NULL, NULL, '2020-10-03 19:06:15', '2020-10-03 19:06:40', NULL, NULL),
(9, 9, 1, NULL, 10, 20, 'sample', NULL, '2020-10-07 11:58:40', '2020-10-07 11:58:40', NULL, NULL),
(10, 10, 1, NULL, 10, 30, 'sample', NULL, '2020-10-07 16:23:55', '2020-10-07 16:27:59', NULL, NULL),
(11, 11, 1, NULL, 10, 29.75, 'koil', NULL, '2020-10-08 14:20:44', '2020-10-08 18:01:50', NULL, NULL),
(12, 12, 1, NULL, 15, 44.75, 'koil', NULL, '2020-10-08 19:09:26', '2021-01-29 05:28:39', NULL, NULL),
(13, 13, 1, NULL, 5, 15, 'sample', NULL, '2020-10-08 19:09:26', '2020-10-08 19:09:26', NULL, NULL),
(14, 14, 1, 8, 10, 30, 'sample', NULL, '2020-10-10 08:32:35', '2020-10-10 08:32:57', NULL, NULL),
(15, 15, 1, NULL, 15, 45, 'sample', NULL, '2020-10-10 08:33:34', '2021-02-09 09:12:18', NULL, NULL),
(16, 16, 1, 9, 10, 29.99, 'Sample', NULL, '2020-10-13 15:07:08', '2020-10-21 13:31:26', NULL, NULL),
(17, 17, 1, NULL, 10, 29.99, 'sample', NULL, '2020-10-13 16:25:03', '2020-10-16 16:38:40', NULL, NULL),
(18, 18, 1, NULL, 1, 1, NULL, NULL, '2020-10-16 16:45:27', '2020-10-16 16:45:27', NULL, NULL),
(19, 19, 1, 9, 11, 30.99, 'Sample', NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21', NULL, NULL),
(20, 20, 1, NULL, 4, 14, 'sample', NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21', NULL, NULL),
(21, 21, 1, 9, 12, 31.99, 'Sample', NULL, '2020-10-21 13:53:22', '2021-02-11 08:12:05', NULL, NULL),
(22, 22, 1, NULL, 3, 12.999, 'sample', NULL, '2020-10-21 13:53:22', '2021-02-08 05:37:22', NULL, NULL),
(23, 23, 1, NULL, 1, 2.9, 'd', NULL, '2020-11-16 09:55:06', '2020-12-14 17:33:26', NULL, NULL),
(24, 26, 1, NULL, 1, 2, 'sds', NULL, '2020-12-14 17:51:55', '2021-03-29 08:43:40', NULL, NULL),
(25, 27, 1, NULL, 1, 56, NULL, NULL, '2020-12-14 17:52:48', '2021-02-06 07:02:14', NULL, NULL),
(26, 29, 1, NULL, 1, 4, NULL, NULL, '2020-12-16 11:06:18', '2021-02-06 11:54:46', NULL, NULL),
(27, 30, 1, NULL, 1, 45, NULL, NULL, '2020-12-16 11:08:54', '2021-02-08 04:58:21', NULL, NULL),
(28, 31, 1, NULL, 1, 56, NULL, NULL, '2020-12-16 11:09:27', '2021-02-08 05:02:48', NULL, NULL),
(29, 32, 1, NULL, 10, 45, NULL, NULL, '2020-12-18 10:22:38', '2020-12-18 10:24:53', NULL, NULL),
(30, 33, 1, NULL, 5, 39, NULL, NULL, '2020-12-18 10:24:53', '2021-02-06 09:31:46', NULL, 29),
(31, 34, 1, NULL, 5, 5, NULL, NULL, '2020-12-18 10:24:53', '2020-12-18 10:24:53', NULL, 29),
(32, 35, 1, NULL, 10, 48, NULL, NULL, '2020-12-22 04:50:13', '2021-02-06 09:31:13', NULL, NULL),
(33, 36, 1, NULL, 15, 44.75, 'koil', NULL, '2021-01-29 05:28:39', '2021-01-29 05:28:39', NULL, 12),
(34, 27, NULL, NULL, 1, 2, NULL, NULL, '2021-02-06 07:02:14', '2021-02-06 07:02:14', 2, NULL),
(35, 35, NULL, NULL, 10, 2, NULL, NULL, '2021-02-06 07:18:17', '2021-02-06 09:31:13', 2, NULL),
(36, 15, NULL, NULL, 2, 10, NULL, NULL, '2021-02-08 06:55:37', '2021-02-09 09:12:19', 2, NULL),
(37, 37, 1, NULL, 10, 30, 'sample', NULL, '2021-02-09 09:12:18', '2021-02-09 09:12:18', NULL, 15),
(38, 38, 1, NULL, 5, 15, 'sample', NULL, '2021-02-09 09:12:18', '2021-02-09 09:12:18', NULL, 15),
(39, 37, NULL, NULL, 1, 5, NULL, NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19', 2, 36),
(40, 38, NULL, NULL, 1, 5, NULL, NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19', 2, 36),
(41, 39, 1, NULL, 1, 10, NULL, NULL, '2021-03-15 10:12:02', '2021-03-29 08:37:32', NULL, NULL),
(42, 40, 1, NULL, 1, 10, NULL, NULL, '2021-03-19 11:04:16', '2021-03-30 03:59:05', NULL, NULL),
(43, 41, 1, NULL, 1, 10, NULL, NULL, '2021-03-24 08:11:26', '2021-04-08 21:28:37', NULL, NULL),
(44, 42, 1, NULL, 10, 100, NULL, NULL, '2021-03-29 08:16:17', '2021-04-08 21:39:39', NULL, NULL),
(45, 43, 1, NULL, 10, 100, 'test', NULL, '2021-03-29 08:17:57', '2021-03-29 08:17:57', NULL, NULL),
(46, 44, 1, NULL, 10, 100, NULL, NULL, '2021-04-08 21:41:05', '2021-04-09 02:32:16', NULL, NULL),
(47, 45, 1, NULL, 10, 100, NULL, NULL, '2021-04-09 02:37:41', '2021-04-09 02:59:44', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `configuration`
--

CREATE TABLE `configuration` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `config_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `config_value` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bag_starting_department_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `configuration`
--

INSERT INTO `configuration` (`id`, `config_key`, `config_value`, `deleted_at`, `created_at`, `updated_at`, `bag_starting_department_id`) VALUES
(1, 'precision', '4', NULL, '2020-09-24 07:33:36', '2020-09-24 07:33:36', NULL),
(2, 'bag_starting_department', '0', NULL, '2020-09-24 07:33:36', '2020-09-24 07:33:36', 1),
(3, 'bag_cancel_number', '9108650897', NULL, '2020-10-16 16:36:25', '2021-01-30 05:32:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `unit_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_last` int(11) NOT NULL DEFAULT '0' COMMENT '0-false,1-true'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`id`, `unit_id`, `name`, `description`, `deleted_at`, `created_at`, `updated_at`, `is_last`) VALUES
(1, 1, 'Issue', NULL, NULL, '2020-09-23 15:36:19', '2020-09-23 15:36:19', 0),
(2, 1, 'FILLING', NULL, NULL, '2020-09-23 15:36:32', '2020-09-23 15:36:32', 0),
(3, 1, 'JOOL TOOL', NULL, NULL, '2020-09-23 16:10:02', '2020-09-23 16:10:02', 0),
(4, 1, 'LASER', NULL, NULL, '2020-09-23 16:10:11', '2020-09-23 16:10:11', 0),
(5, 1, 'LAPPING', NULL, NULL, '2020-09-23 16:10:18', '2020-09-23 16:10:18', 0),
(6, 1, 'SETTING', NULL, NULL, '2020-09-23 16:10:27', '2020-09-23 16:10:27', 0),
(7, 1, 'BUFFING', NULL, NULL, '2020-09-23 16:10:41', '2020-09-23 16:10:41', 0),
(8, 1, 'FC', NULL, NULL, '2020-09-23 16:10:51', '2020-09-23 16:10:51', 1);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `department_id`, `code`, `name`, `description`, `deleted_at`, `created_at`, `updated_at`, `user_id`) VALUES
(1, 2, 'E01', 'Sakthi', NULL, NULL, '2020-09-23 16:13:24', '2020-09-23 16:13:24', 2),
(2, 2, 'E02', 'Arul', NULL, NULL, '2020-09-23 16:13:49', '2020-09-23 16:13:49', 3),
(3, 3, 'E03', 'Arun', NULL, NULL, '2020-09-23 16:53:45', '2020-09-23 16:53:45', 4),
(4, 3, 'E04', 'Vanmathi', NULL, NULL, '2020-09-23 16:54:08', '2020-09-23 16:54:08', 5),
(5, 4, 'E004', 'Mohammed', NULL, NULL, '2020-09-24 07:12:45', '2020-09-24 07:12:45', 6),
(6, 4, 'E005', 'Paneer', NULL, NULL, '2020-09-24 07:13:19', '2020-09-24 07:13:19', 7),
(7, 5, 'E006', 'Loganathan', NULL, NULL, '2020-09-24 07:14:08', '2020-09-24 07:14:08', 8),
(8, 5, 'E007', 'Ramesh', NULL, NULL, '2020-09-24 07:14:38', '2020-09-24 07:14:38', 9),
(9, 6, 'E008', 'Vignesh', NULL, NULL, '2020-09-24 07:15:49', '2020-09-24 07:15:49', 10),
(10, 6, 'E009', 'Vinoth', NULL, NULL, '2020-09-24 07:16:14', '2020-09-24 07:16:14', 11),
(11, 7, 'E010', 'Mohan', NULL, NULL, '2020-09-24 07:17:54', '2020-09-24 07:17:54', 12),
(12, 7, 'E011', 'Ram', NULL, NULL, '2020-09-24 07:18:25', '2020-09-24 07:18:25', 13);

-- --------------------------------------------------------

--
-- Table structure for table `employee_process`
--

CREATE TABLE `employee_process` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `process_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_process`
--

INSERT INTO `employee_process` (`id`, `employee_id`, `process_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, '2020-09-23 16:13:24', '2020-09-23 16:13:24'),
(2, 2, 1, NULL, '2020-09-23 16:13:49', '2020-09-23 16:13:49'),
(3, 2, 2, NULL, '2020-09-23 16:13:49', '2020-09-23 16:13:49'),
(4, 3, 3, NULL, '2020-09-23 16:53:45', '2020-09-23 16:53:45'),
(5, 4, 4, NULL, '2020-09-23 16:54:08', '2020-09-23 16:54:08'),
(6, 5, 4, NULL, '2020-09-24 07:12:45', '2020-09-24 07:12:45'),
(7, 6, 4, NULL, '2020-09-24 07:13:19', '2020-09-24 07:13:19'),
(8, 7, 5, NULL, '2020-09-24 07:14:08', '2020-09-24 07:14:08'),
(9, 8, 5, NULL, '2020-09-24 07:14:38', '2020-09-24 07:14:38'),
(10, 9, 6, NULL, '2020-09-24 07:15:49', '2020-09-24 07:15:49'),
(11, 10, 6, NULL, '2020-09-24 07:16:14', '2020-09-24 07:16:14'),
(12, 11, 7, NULL, '2020-09-24 07:17:54', '2020-09-24 07:17:54'),
(13, 12, 7, NULL, '2020-09-24 07:18:25', '2020-09-24 07:18:25');

-- --------------------------------------------------------

--
-- Table structure for table `gold_inlet`
--

CREATE TABLE `gold_inlet` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '1 - Issued 0\r\n - Waitting for approval',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invitations`
--

CREATE TABLE `invitations` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `team_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `team_id` int(10) UNSIGNED DEFAULT NULL,
  `provider_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(8,2) DEFAULT NULL,
  `tax` decimal(8,2) DEFAULT NULL,
  `card_country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_zip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vat_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2016_01_15_105324_create_roles_table', 1),
(2, '2016_01_15_114411_create_users_table', 1),
(3, '2016_01_15_114412_create_role_user_table', 1),
(4, '2016_01_26_115212_create_permissions_table', 1),
(5, '2016_01_26_115523_create_permission_role_table', 1),
(6, '2016_02_09_132439_create_permission_user_table', 1),
(7, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(8, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(9, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(10, '2016_06_01_000004_create_oauth_clients_table', 1),
(11, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(12, '2019_02_08_055115_create_performance_indicators_table', 1),
(13, '2019_02_08_055116_create_announcements_table', 1),
(14, '2019_02_08_055121_create_password_resets_table', 1),
(15, '2019_02_08_055125_create_api_tokens_table', 1),
(16, '2019_02_08_055130_create_subscriptions_table', 1),
(17, '2019_02_08_055136_create_invoices_table', 1),
(18, '2019_02_08_055143_create_notifications_table', 1),
(19, '2019_02_08_055151_create_teams_table', 1),
(20, '2019_02_08_055200_create_team_users_table', 1),
(21, '2019_02_08_055210_create_invitations_table', 1),
(22, '2019_02_10_150425_create_sessions_table', 1),
(23, '2019_02_20_114154_create_uploads_table', 1),
(24, '2019_03_31_091619_create_audits_table', 1),
(25, '2019_05_09_121938_add_soft_deletes_to_users_table', 1),
(26, '2019_06_13_075552_add_parent_id_to_permissions_table', 1),
(27, '2020_01_31_152904_create_unit_table', 1),
(28, '2020_01_31_152938_create_department_table', 1),
(29, '2020_01_31_152949_create_employee_table', 1),
(30, '2020_02_01_082714_create_process_table', 1),
(31, '2020_02_01_091549_create_product_category_table', 1),
(32, '2020_02_01_094127_create_product_table', 1),
(33, '2020_02_04_100753_create_employee_process_table', 1),
(34, '2020_02_06_110922_add_parent_product_category_to_product_category_table', 1),
(35, '2020_02_06_122515_create_uom_table', 1),
(36, '2020_02_06_131205_create_style_table', 1),
(37, '2020_02_10_172509_create_bag_table', 1),
(38, '2020_02_10_173133_create_bag_styles_table', 1),
(39, '2020_02_13_123357_add_department_id_to_bag_table', 1),
(40, '2020_02_13_131849_add_user_id_to_employee_table', 1),
(41, '2020_02_13_161611_create_transaction_table', 1),
(42, '2020_02_13_171957_create_transaction_item_table', 1),
(43, '2020_02_13_172452_add_status_to_transaction_table', 1),
(44, '2020_02_15_175514_create_other_accessories_table', 1),
(45, '2020_02_17_115746_add_employee_id_bag_table', 1),
(46, '2020_02_24_172430_add_quantity_to_transaction_item_table', 1),
(47, '2020_02_26_131158_add_departments_to_users_table', 1),
(48, '2020_03_03_124414_add_image_name_to_style_table', 1),
(49, '2020_03_03_134211_add_is_eod_reporting_to_transaction_table', 1),
(50, '2020_03_05_125309_add_is_last_to_department_table', 1),
(51, '2020_03_10_134642_add_receive_weight_to_transaction_item_table', 1),
(52, '2020_03_16_180138_create_configuration_table', 1),
(53, '2020_03_17_143554_add_total_receive_weight_to_transaction_table', 1),
(54, '2020_04_22_135126_add_other_accessories_id_to_bag_styles_table', 1),
(55, '2020_05_16_103020_create_transaction_item_loss_details_table', 1),
(56, '2020_05_20_160116_add_bag_style_id_to_transaction_item_loss_details_table', 1),
(57, '2020_06_15_181511_add_parent_bag_style_id_to_bag_styles_table', 1),
(58, '2020_06_29_133953_add_department_id_to_configuration_table', 1),
(59, '2020_08_10_162057_create_style_department_loss_approval_table', 1),
(60, '2020_08_17_145402_add_admin_approval_loss_weight_to_transaction_item_loss_details_table', 1),
(61, '2020_08_25_193532_create_style_images_table', 1),
(62, '2020_09_16_132518_add_type_to_transaction_table', 1),
(63, '2020_10_08_121324_add_cancel_otp_to_bag_table', 2),
(64, '2020_12_14_230938_add_inc_val_in_bag_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_url` text COLLATE utf8mb4_unicode_ci,
  `read` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `other_accessories`
--

CREATE TABLE `other_accessories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uom_id` bigint(20) UNSIGNED NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `other_accessories`
--

INSERT INTO `other_accessories` (`id`, `name`, `uom_id`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Link', 1, NULL, NULL, '2020-09-24 07:32:48', '2020-09-24 07:32:48'),
(2, 'Diamond', 2, NULL, NULL, '2020-09-24 07:33:05', '2020-09-24 07:33:05'),
(3, 'Color Stone', 2, NULL, NULL, '2020-09-24 07:33:15', '2020-09-24 07:33:15');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `performance_indicators`
--

CREATE TABLE `performance_indicators` (
  `id` int(10) UNSIGNED NOT NULL,
  `monthly_recurring_revenue` decimal(8,2) NOT NULL,
  `yearly_recurring_revenue` decimal(8,2) NOT NULL,
  `daily_volume` decimal(8,2) NOT NULL,
  `new_users` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `slug`, `description`, `model`, `deleted_at`, `created_at`, `updated_at`, `parent_id`) VALUES
(1, ' User', 'user', 'User', 'User', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(2, 'View/List User', 'index.user', 'User', 'User', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 1),
(3, 'Create New User', 'store.user', 'User', 'User', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 1),
(4, 'Edit/Update User', 'update.user', 'User', 'User', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 1),
(5, 'Trash/Destory User', 'destroy.user', 'User', 'User', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 1),
(6, 'Restore User', 'restore.user', 'User', 'User', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 1),
(7, ' Role', 'role', 'Role', 'Role', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(8, 'View/List Role', 'index.role', 'Role', 'Role', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 7),
(9, 'Create New Role', 'store.role', 'Role', 'Role', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 7),
(10, 'Edit/Update Role', 'update.role', 'Role', 'Role', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 7),
(11, 'Trash/Destory Role', 'destroy.role', 'Role', 'Role', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 7),
(12, 'Restore Role', 'restore.role', 'Role', 'Role', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 7),
(13, ' Unit', 'unit', 'Unit', 'Unit', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(14, 'View/List Unit', 'index.unit', 'Unit', 'Unit', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 13),
(15, 'Create New Unit', 'store.unit', 'Unit', 'Unit', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 13),
(16, 'Edit/Update Unit', 'update.unit', 'Unit', 'Unit', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 13),
(17, 'Trash/Destory Unit', 'destroy.unit', 'Unit', 'Unit', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 13),
(18, 'Restore Unit', 'restore.unit', 'Unit', 'Unit', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 13),
(19, ' Department', 'department', 'Department', 'Department', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(20, 'View/List Department', 'index.department', 'Department', 'Department', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 19),
(21, 'Create New Department', 'store.department', 'Department', 'Department', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 19),
(22, 'Edit/Update Department', 'update.department', 'Department', 'Department', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 19),
(23, 'Trash/Destory Department', 'destroy.department', 'Department', 'Department', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 19),
(24, 'Restore Department', 'restore.department', 'Department', 'Department', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 19),
(25, ' Employee', 'employee', 'Employee', 'Employee', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(26, 'View/List Employee', 'index.employee', 'Employee', 'Employee', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 25),
(27, 'Create New Employee', 'store.employee', 'Employee', 'Employee', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 25),
(28, 'Edit/Update Employee', 'update.employee', 'Employee', 'Employee', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 25),
(29, 'Trash/Destory Employee', 'destroy.employee', 'Employee', 'Employee', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 25),
(30, 'Restore Employee', 'restore.employee', 'Employee', 'Employee', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 25),
(31, ' Process', 'process', 'Process', 'Process', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(32, 'View/List Process', 'index.process', 'Process', 'Process', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 31),
(33, 'Create New Process', 'store.process', 'Process', 'Process', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 31),
(34, 'Edit/Update Process', 'update.process', 'Process', 'Process', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 31),
(35, 'Trash/Destory Process', 'destroy.process', 'Process', 'Process', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 31),
(36, 'Restore Process', 'restore.process', 'Process', 'Process', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 31),
(37, ' Product Category', 'productcategory', 'ProductCategory', 'ProductCategory', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(38, 'View/List ProductCategory', 'index.productcategory', 'ProductCategory', 'ProductCategory', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 37),
(39, 'Create New ProductCategory', 'store.productcategory', 'ProductCategory', 'ProductCategory', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 37),
(40, 'Edit/Update ProductCategory', 'update.productcategory', 'ProductCategory', 'ProductCategory', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 37),
(41, 'Trash/Destory ProductCategory', 'destroy.productcategory', 'ProductCategory', 'ProductCategory', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 37),
(42, 'Restore ProductCategory', 'restore.productcategory', 'ProductCategory', 'ProductCategory', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 37),
(43, ' Product', 'product', 'Product', 'Product', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(44, 'View/List Product', 'index.product', 'Product', 'Product', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 43),
(45, 'Create New Product', 'store.product', 'Product', 'Product', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 43),
(46, 'Edit/Update Product', 'update.product', 'Product', 'Product', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 43),
(47, 'Trash/Destory Product', 'destroy.product', 'Product', 'Product', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 43),
(48, 'Restore Product', 'restore.product', 'Product', 'Product', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 43),
(49, ' Uom', 'uom', 'Uom', 'Uom', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(50, 'View/List Uom', 'index.uom', 'Uom', 'Uom', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 49),
(51, 'Create New Uom', 'store.uom', 'Uom', 'Uom', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 49),
(52, 'Edit/Update Uom', 'update.uom', 'Uom', 'Uom', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 49),
(53, 'Trash/Destory Uom', 'destroy.uom', 'Uom', 'Uom', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 49),
(54, 'Restore Uom', 'restore.uom', 'Uom', 'Uom', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 49),
(55, ' Bag', 'bag', 'Bag', 'Bag', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(56, 'View/List Bag', 'index.bag', 'Bag', 'Bag', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 55),
(57, 'Create New Bag', 'store.bag', 'Bag', 'Bag', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 55),
(58, 'Edit/Update Bag', 'update.bag', 'Bag', 'Bag', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 55),
(59, 'Trash/Destory Bag', 'destroy.bag', 'Bag', 'Bag', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 55),
(60, 'Restore Bag', 'restore.bag', 'Bag', 'Bag', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 55),
(61, ' Transaction', 'transaction', 'Transaction', 'Transaction', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(62, 'Create New Transaction', 'store.transaction', 'Transaction', 'Transaction', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 61),
(63, ' Transaction Report', 'transactionreport', 'TransactionReport', 'TransactionReport', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(64, 'View/List TransactionReport', 'index.transactionreport', 'TransactionReport', 'TransactionReport', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 63),
(65, ' Configuration', 'configuration', 'Configuration', 'Configuration', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(66, 'View/List Configuration', 'index.configuration', 'Configuration', 'Configuration', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 65),
(67, ' Other Accessories', 'otheraccessories', 'OtherAccessories', 'OtherAccessories', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(68, 'View/List OtherAccessories', 'index.otheraccessories', 'OtherAccessories', 'OtherAccessories', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 67),
(69, 'Create New OtherAccessories', 'store.otheraccessories', 'OtherAccessories', 'OtherAccessories', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 67),
(70, 'Edit/Update OtherAccessories', 'update.otheraccessories', 'OtherAccessories', 'OtherAccessories', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 67),
(71, 'Trash/Destory OtherAccessories', 'destroy.otheraccessories', 'OtherAccessories', 'OtherAccessories', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 67),
(72, 'Restore OtherAccessories', 'restore.otheraccessories', 'OtherAccessories', 'OtherAccessories', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 67),
(73, ' Loss Approval', 'lossapproval', 'LossApproval', 'LossApproval', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(74, 'View/List LossApproval', 'index.lossapproval', 'LossApproval', 'LossApproval', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 73),
(75, ' Tally Report', 'tallyreport', 'TallyReport', 'TallyReport', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(76, 'View/List TallyReport', 'index.tallyreport', 'TallyReport', 'TallyReport', NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14', 75),
(77, 'Cancel', 'cancel.bag', 'Bag', 'Bag', NULL, '2020-10-06 15:43:40', '2020-10-06 15:43:40', 55),
(78, 'Merge', 'merge.transaction', 'Transaction', 'Transaction', NULL, '2020-10-06 15:43:40', '2020-10-06 15:43:40', 61),
(79, 'Split', 'split.transaction', 'Transaction', 'Transaction', NULL, '2020-10-06 15:43:40', '2020-10-06 15:43:40', 61);

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`id`, `permission_id`, `role_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(2, 2, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(3, 3, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(4, 4, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(5, 5, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(6, 6, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(7, 7, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(8, 8, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(9, 9, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(10, 10, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(11, 11, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(12, 12, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(13, 13, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(14, 14, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(15, 15, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(16, 16, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(17, 17, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(18, 18, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(19, 19, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(20, 20, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(21, 21, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(22, 22, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(23, 23, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(24, 24, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(25, 25, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(26, 26, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(27, 27, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(28, 28, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(29, 29, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(30, 30, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(31, 31, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(32, 32, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(33, 33, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(34, 34, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(35, 35, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(36, 36, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(37, 37, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(38, 38, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(39, 39, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(40, 40, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(41, 41, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(42, 42, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(43, 43, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(44, 44, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(45, 45, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(46, 46, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(47, 47, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(48, 48, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(49, 49, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(50, 50, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(51, 51, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(52, 52, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(53, 53, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(54, 54, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(55, 55, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(56, 56, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(57, 57, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(58, 58, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(59, 59, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(60, 60, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(61, 61, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(62, 62, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(63, 63, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(64, 64, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(65, 65, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(66, 66, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(67, 67, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(68, 68, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(69, 69, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(70, 70, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(71, 71, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(72, 72, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(73, 73, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(74, 74, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(75, 75, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(76, 76, 1, '2020-09-22 10:53:14', '2020-09-22 10:53:14', NULL),
(77, 62, 3, '2020-09-24 16:24:19', '2020-09-24 16:24:19', NULL),
(78, 61, 3, '2020-09-24 16:24:19', '2020-09-24 16:24:19', NULL),
(79, 77, 1, '2020-10-07 12:07:57', '2020-10-07 12:07:57', NULL),
(80, 78, 1, '2020-10-07 12:07:57', '2020-10-07 12:07:57', NULL),
(81, 79, 1, '2020-10-07 12:07:57', '2020-10-07 12:07:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permission_user`
--

CREATE TABLE `permission_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `process`
--

CREATE TABLE `process` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `process`
--

INSERT INTO `process` (`id`, `code`, `name`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'PC101', 'SOLDERING', NULL, NULL, '2020-09-23 16:11:28', '2020-09-23 16:11:28'),
(2, 'PC102', 'FILLING', NULL, NULL, '2020-09-23 16:11:36', '2020-09-23 16:11:36'),
(3, 'PC103', 'JOOL TOOL', NULL, NULL, '2020-09-23 16:11:43', '2020-09-23 16:11:43'),
(4, 'PC104', 'LASER', NULL, NULL, '2020-09-23 16:11:49', '2020-09-23 16:11:49'),
(5, 'PC105', 'LAPPING', NULL, NULL, '2020-09-23 16:11:57', '2020-09-23 16:11:57'),
(6, 'PC106', 'SETTING', NULL, NULL, '2020-09-23 16:12:04', '2020-09-23 16:12:04'),
(7, 'PC107', 'Buffing', NULL, NULL, '2020-09-24 07:17:17', '2020-09-24 07:17:17');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `product_category_id`, `name`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Male Ring', NULL, NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05');

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `parent_product_category_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`id`, `name`, `description`, `deleted_at`, `created_at`, `updated_at`, `parent_product_category_id`) VALUES
(1, 'Ring', NULL, NULL, '2020-09-24 07:19:02', '2020-09-24 07:19:02', NULL),
(2, 'GRing', NULL, NULL, '2020-09-24 07:19:47', '2020-09-24 07:19:47', 1),
(3, 'BRing', NULL, NULL, '2020-09-24 07:20:01', '2020-09-24 07:20:01', 1),
(4, 'Lring', NULL, NULL, '2020-09-24 07:20:17', '2020-09-24 07:20:17', 1);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `slug`, `description`, `level`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin', 'Admin Role', 5, NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14'),
(2, 'Staff', 'staff', 'Staff Role', 2, NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14'),
(3, 'Employee', 'employee', 'Employee Role', 1, NULL, '2020-09-22 10:53:14', '2020-09-22 10:53:14');

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

CREATE TABLE `role_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_user`
--

INSERT INTO `role_user` (`id`, `role_id`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, NULL, NULL, NULL),
(2, 3, 2, NULL, NULL, NULL),
(3, 3, 3, NULL, NULL, NULL),
(4, 3, 4, NULL, NULL, NULL),
(5, 3, 5, NULL, NULL, NULL),
(6, 3, 6, NULL, NULL, NULL),
(7, 3, 7, NULL, NULL, NULL),
(8, 3, 8, NULL, NULL, NULL),
(9, 3, 9, NULL, NULL, NULL),
(10, 3, 10, NULL, NULL, NULL),
(11, 3, 11, NULL, NULL, NULL),
(12, 3, 12, NULL, NULL, NULL),
(13, 3, 13, NULL, NULL, NULL),
(14, 1, 14, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `style`
--

CREATE TABLE `style` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `uom_id` bigint(20) UNSIGNED NOT NULL,
  `upload_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sku` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` double NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `style`
--

INSERT INTO `style` (`id`, `product_id`, `uom_id`, `upload_id`, `sku`, `weight`, `deleted_at`, `created_at`, `updated_at`, `image_name`) VALUES
(1, 1, 1, NULL, 'Plain Ring', 2.584, NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `style_department_loss_approval`
--

CREATE TABLE `style_department_loss_approval` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `style_id` bigint(20) UNSIGNED NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `percentage` double NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `style_department_loss_approval`
--

INSERT INTO `style_department_loss_approval` (`id`, `style_id`, `department_id`, `percentage`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 1, NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(2, 1, 4, 0.75, NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(3, 1, 5, 2, NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(4, 1, 6, 0.1, NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(5, 1, 7, 1, NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05');

-- --------------------------------------------------------

--
-- Table structure for table `style_images`
--

CREATE TABLE `style_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `upload_id` bigint(20) UNSIGNED NOT NULL,
  `style_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `style_images`
--

INSERT INTO `style_images` (`id`, `upload_id`, `style_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(2, 2, 1, NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05'),
(3, 3, 1, NULL, '2020-09-24 15:04:05', '2020-09-24 15:04:05');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_plan` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `id` int(10) UNSIGNED NOT NULL,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo_url` text COLLATE utf8mb4_unicode_ci,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_billing_plan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_last_four` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_line_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_zip` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vat_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extra_billing_information` text COLLATE utf8mb4_unicode_ci,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team_subscriptions`
--

CREATE TABLE `team_subscriptions` (
  `id` int(10) UNSIGNED NOT NULL,
  `team_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_plan` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team_users`
--

CREATE TABLE `team_users` (
  `team_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_date` date NOT NULL,
  `from_department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `from_employee_id` bigint(20) UNSIGNED DEFAULT NULL,
  `to_department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `to_employee_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bag_id` bigint(20) UNSIGNED NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0-completed,1-hold',
  `is_eod_reporting` int(11) NOT NULL DEFAULT '0' COMMENT '0-false,1-true',
  `total_transfer_quantity` double NOT NULL DEFAULT '0',
  `total_transfer_weight` double NOT NULL DEFAULT '0',
  `total_receive_weight` double NOT NULL DEFAULT '0',
  `total_loss_weight` double NOT NULL DEFAULT '0',
  `transaction_mode` int(11) NOT NULL DEFAULT '0' COMMENT '0-normal,1-splitted,2-merge',
  `to_bag_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'used for split and merge'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `transaction_date`, `from_department_id`, `from_employee_id`, `to_department_id`, `to_employee_id`, `bag_id`, `description`, `deleted_at`, `created_at`, `updated_at`, `status`, `is_eod_reporting`, `total_transfer_quantity`, `total_transfer_weight`, `total_receive_weight`, `total_loss_weight`, `transaction_mode`, `to_bag_id`) VALUES
(1, '2020-09-24', 1, NULL, 2, 1, 1, NULL, NULL, '2020-09-24 16:13:06', '2020-09-24 16:13:06', 0, 0, 10, 30, 30, 0, 0, NULL),
(2, '2020-09-24', 1, NULL, 2, 2, 2, NULL, NULL, '2020-09-24 16:13:23', '2020-09-24 16:13:23', 0, 0, 10, 30, 30, 0, 0, NULL),
(3, '2020-09-24', 2, 2, 3, 3, 2, NULL, NULL, '2020-09-24 16:31:53', '2020-09-24 16:31:53', 1, 0, 10, 30, 26, 0, 0, NULL),
(4, '2020-09-24', 2, 1, 3, 4, 1, NULL, NULL, '2020-09-24 16:39:11', '2020-09-24 16:39:11', 1, 0, 10, 30, 26, 0, 0, NULL),
(5, '2020-09-29', 1, NULL, 2, 1, 3, NULL, NULL, '2020-09-29 15:51:38', '2020-09-29 15:51:38', 0, 0, 10, 10, 10, 0, 0, NULL),
(6, '2020-09-29', 2, 1, 4, NULL, 3, NULL, NULL, '2020-09-29 15:53:28', '2020-09-29 15:53:28', 1, 0, 10, 10, 8, 0, 0, NULL),
(7, '2020-10-01', 1, NULL, 2, 2, 4, NULL, NULL, '2020-10-01 10:30:15', '2020-10-01 10:30:15', 0, 0, 10, 30, 30, 0, 0, NULL),
(8, '2020-10-01', 2, 2, 3, 3, 4, NULL, NULL, '2020-10-01 10:36:43', '2020-10-01 10:36:43', 1, 0, 10, 30, 29.99, 0, 0, NULL),
(9, '2020-10-01', 1, NULL, 2, 2, 5, NULL, NULL, '2020-10-01 10:48:19', '2020-10-01 10:48:19', 0, 0, 10, 10, 10, 0, 0, NULL),
(10, '2020-10-01', 2, 2, 5, NULL, 5, NULL, NULL, '2020-10-01 10:52:16', '2020-10-01 10:52:16', 1, 0, 10, 10, 9, 0, 0, NULL),
(11, '2020-10-01', 1, NULL, 2, 2, 6, NULL, NULL, '2020-10-01 14:44:11', '2020-10-01 14:44:11', 0, 0, 10, 10, 10, 0, 0, NULL),
(12, '2020-10-01', 1, NULL, 2, 2, 7, NULL, NULL, '2020-10-01 15:32:47', '2020-10-01 15:32:47', 0, 0, 10, 20, 20, 0, 0, NULL),
(13, '2020-10-03', 2, 2, 3, 3, 6, NULL, NULL, '2020-10-03 11:17:11', '2020-10-03 11:17:11', 1, 0, 10, 10, 8, 0, 0, NULL),
(14, '2020-10-03', 2, 2, 3, 4, 7, NULL, NULL, '2020-10-03 14:12:42', '2020-10-03 14:12:42', 0, 0, 10, 20, 19.5, 0, 0, NULL),
(15, '2020-10-03', 1, NULL, 2, 2, 8, NULL, NULL, '2020-10-03 19:06:40', '2020-10-03 19:06:40', 0, 0, 10, 10, 10, 0, 0, NULL),
(16, '2020-10-03', 2, 2, 3, 4, 8, NULL, NULL, '2020-10-03 19:08:15', '2020-10-03 19:08:15', 1, 0, 10, 10, 9, 0, 0, NULL),
(17, '2020-10-07', 1, NULL, 2, 2, 10, NULL, NULL, '2020-10-07 16:27:59', '2020-10-07 16:27:59', 0, 0, 10, 30, 30, 0, 0, NULL),
(18, '2020-10-08', 1, NULL, 2, 2, 11, NULL, NULL, '2020-10-08 17:57:26', '2020-10-08 17:57:26', 0, 0, 10, 30, 30, 0, 0, NULL),
(19, '2020-10-08', 2, 2, 1, NULL, 11, NULL, NULL, '2020-10-08 18:00:59', '2020-10-08 18:00:59', 0, 1, 10, 30, 29.75, 0, 0, NULL),
(20, '2020-10-08', 1, NULL, 2, 2, 11, NULL, NULL, '2020-10-08 18:01:50', '2020-10-08 18:01:50', 0, 0, 10, 29.75, 29.75, 0, 0, NULL),
(21, '2020-10-08', 2, 2, 3, 3, 12, NULL, NULL, '2020-10-08 19:09:26', '2020-10-08 19:09:26', 0, 0, 15, 44.75, 44.75, 0, 2, 13),
(22, '2020-10-10', 1, NULL, 2, 2, 14, NULL, NULL, '2020-10-10 08:32:57', '2020-10-10 08:32:57', 0, 0, 10, 30, 30, 0, 0, NULL),
(23, '2020-10-10', 1, NULL, 2, 1, 15, NULL, NULL, '2020-10-10 08:33:59', '2020-10-10 08:33:59', 0, 0, 15, 45, 45, 0, 0, NULL),
(24, '2020-10-10', 2, 2, 3, 3, 14, NULL, NULL, '2020-10-10 08:44:15', '2020-10-10 08:44:15', 1, 0, 10, 30, 29, 0, 0, NULL),
(25, '2020-10-13', 1, NULL, 7, 11, 16, NULL, NULL, '2020-10-13 15:11:44', '2020-10-13 15:11:44', 0, 0, 10, 30, 30, 0, 0, NULL),
(26, '2020-10-13', 1, NULL, 7, 11, 17, NULL, NULL, '2020-10-13 16:25:37', '2020-10-13 16:25:37', 0, 0, 10, 30, 30, 0, 0, NULL),
(27, '2020-10-13', 7, 11, 1, NULL, 16, NULL, NULL, '2020-10-13 19:59:12', '2020-10-13 19:59:12', 0, 1, 10, 30, 29.99, 0, 0, NULL),
(28, '2020-10-13', 7, 11, 1, NULL, 17, NULL, NULL, '2020-10-13 20:00:08', '2020-10-13 20:00:08', 0, 1, 10, 30, 29.99, 0, 0, NULL),
(29, '2020-10-16', 1, NULL, 7, 11, 17, NULL, NULL, '2020-10-16 16:38:40', '2020-10-16 16:38:40', 0, 0, 10, 29.99, 29.99, 0, 0, NULL),
(30, '2020-10-16', 1, NULL, 7, 11, 16, NULL, NULL, '2020-10-16 16:39:22', '2020-10-16 16:39:22', 0, 0, 10, 29.99, 29.99, 0, 0, NULL),
(31, '2020-10-16', 1, NULL, 1, NULL, 18, 'DUMMY TRANSACTION', NULL, '2020-10-16 16:45:50', '2020-10-16 16:45:50', 0, 0, 1, 1, 0, 0, 0, NULL),
(32, '2020-10-21', 7, 11, 7, 11, 17, 'DUMMY TRANSACTION', NULL, '2020-10-21 13:25:50', '2020-10-21 13:25:50', 0, 0, 29.99, 29.99, 0, 0, 0, NULL),
(33, '2020-10-21', 7, 11, 1, NULL, 16, NULL, NULL, '2020-10-21 13:31:07', '2020-10-21 13:31:07', 0, 1, 10, 29.99, 29.99, 0, 0, NULL),
(34, '2020-10-21', 1, NULL, 7, 11, 16, NULL, NULL, '2020-10-21 13:31:26', '2020-10-21 13:31:26', 0, 0, 10, 29.99, 29.99, 0, 0, NULL),
(35, '2020-10-21', 7, 11, 1, NULL, 19, NULL, NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21', 0, 0, 11, 30.99, 30.99, 0, 2, 20),
(36, '2020-10-21', 1, NULL, 2, 1, 21, NULL, NULL, '2020-10-21 13:53:22', '2020-10-21 13:53:22', 0, 0, 12, 31.99, 31.99, 0, 2, 22),
(37, '2020-11-16', 2, 2, 4, 5, 22, NULL, NULL, '2020-11-16 09:44:49', '2020-11-16 09:44:49', 0, 0, 3, 13, 12.999, 0, 0, NULL),
(38, '2020-11-16', 1, NULL, 2, 2, 23, NULL, NULL, '2020-11-16 09:58:14', '2020-11-16 09:58:14', 0, 0, 1, 3, 3, 0, 0, NULL),
(39, '2020-11-16', 2, 2, 4, 5, 23, NULL, NULL, '2020-11-16 10:00:29', '2020-11-16 10:00:29', 0, 0, 1, 3, 2.99, 0, 0, NULL),
(40, '2020-12-14', 4, 5, 4, 6, 23, NULL, NULL, '2020-12-14 17:33:26', '2020-12-14 17:33:26', 0, 0, 1, 2.99, 2.9, 0, 0, NULL),
(41, '2020-12-18', 1, NULL, 8, NULL, 32, NULL, NULL, '2020-12-18 10:24:53', '2020-12-18 10:24:53', 0, 0, 10, 45, 45, 0, 1, NULL),
(42, '2020-12-22', 1, NULL, 2, 1, 35, NULL, NULL, '2020-12-22 04:55:26', '2020-12-22 04:55:26', 0, 0, 10, 50, 50, 0, 0, NULL),
(43, '2020-12-22', 2, 1, 2, 2, 35, NULL, NULL, '2020-12-22 04:55:58', '2020-12-22 04:55:58', 0, 0, 10, 50, 49, 0, 0, NULL),
(44, '2020-12-22', 2, 2, 2, 2, 35, NULL, NULL, '2020-12-22 06:09:16', '2020-12-22 06:09:16', 0, 0, 10, 49, 48, 0, 0, NULL),
(45, '2020-12-22', 2, 2, 2, 2, 35, NULL, NULL, '2020-12-22 06:17:07', '2020-12-22 06:17:07', 0, 0, 10, 49, 48, 0, 0, NULL),
(46, '2021-01-29', 3, 3, 2, 1, 12, NULL, NULL, '2021-01-29 05:28:39', '2021-01-29 05:28:39', 0, 0, 15, 44.7, 44.75, 0, 1, NULL),
(47, '2021-01-30', 3, 3, 3, 3, 36, 'DUMMY TRANSACTION', NULL, '2021-01-30 05:27:35', '2021-01-30 05:27:35', 0, 0, 44.75, 44.75, 0, 0, 0, NULL),
(48, '2021-01-30', 1, NULL, 2, 1, 33, NULL, NULL, '2021-01-30 09:38:27', '2021-01-30 09:38:27', 0, 1, 5, 40, 40, 0, 0, NULL),
(49, '2021-01-30', 2, 1, 1, NULL, 33, NULL, NULL, '2021-01-30 09:38:45', '2021-01-30 09:38:45', 0, 0, 5, 40, 40, 0, 0, NULL),
(50, '2021-01-30', 1, NULL, 2, 1, 33, NULL, NULL, '2021-01-30 09:39:10', '2021-01-30 09:39:10', 0, 0, 5, 40, 40, 0, 0, NULL),
(51, '2021-02-03', 1, NULL, 2, 1, 26, NULL, NULL, '2021-02-03 14:36:23', '2021-02-03 14:36:23', 0, 1, 1, 2.5, 2.5, 0, 0, NULL),
(52, '2021-02-03', 2, 1, 1, NULL, 26, NULL, NULL, '2021-02-03 14:36:31', '2021-02-03 14:36:31', 0, 0, 1, 2.5, 2.5, 0, 0, NULL),
(53, '2021-02-03', 1, NULL, 2, 1, 26, NULL, NULL, '2021-02-03 14:37:08', '2021-02-03 14:37:08', 0, 1, 1, 2.5, 2.5, 0, 0, NULL),
(54, '2021-02-03', 2, 1, 1, NULL, 26, NULL, NULL, '2021-02-03 14:38:06', '2021-02-03 14:38:06', 0, 0, 1, 2.5, 2.5, 0, 0, NULL),
(55, '2021-02-03', 2, 1, 3, 4, 33, NULL, NULL, '2021-02-03 14:38:52', '2021-02-03 14:38:52', 0, 0, 5, 40, 39, 0, 0, NULL),
(56, '2021-02-04', 1, NULL, 2, 1, 26, NULL, NULL, '2021-02-04 07:06:46', '2021-02-04 07:06:46', 0, 0, 1, 2.5, 2.5, 0, 0, NULL),
(57, '2021-02-04', 2, 1, 3, 3, 26, NULL, NULL, '2021-02-04 11:42:55', '2021-02-04 11:42:55', 0, 0, 1, 2.5, 2, 0, 0, NULL),
(58, '2021-02-06', 3, 3, 4, 5, 26, NULL, NULL, '2021-02-05 22:45:43', '2021-02-05 22:45:43', 1, 0, 1, 2, 1.9, 0, 0, NULL),
(60, '2021-02-06', 1, NULL, 2, 1, 27, NULL, NULL, '2021-02-06 07:02:14', '2021-02-06 07:02:14', 0, 0, 2, 58, 58, 0, 0, NULL),
(61, '2021-02-06', 2, 1, 3, 3, 27, NULL, NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51', 1, 0, 2, 58, 57.5, 0, 0, NULL),
(62, '2021-02-06', 2, 2, 3, 3, 35, NULL, NULL, '2021-02-06 07:18:17', '2021-02-06 07:18:17', 0, 0, 20, 50, 50, 0, 0, NULL),
(63, '2021-02-06', 3, 3, 2, 1, 35, NULL, NULL, '2021-02-06 09:31:13', '2021-02-06 09:31:13', 0, 1, 20, 50, 50, 0, 1, NULL),
(64, '2021-02-06', 3, 4, 2, 1, 33, NULL, NULL, '2021-02-06 09:31:46', '2021-02-06 09:31:46', 0, 0, 5, 39, 39, 0, 0, NULL),
(65, '2021-02-06', 1, NULL, 2, 1, 29, NULL, NULL, '2021-02-06 11:54:46', '2021-02-06 11:54:46', 0, 0, 1, 4, 4, 0, 0, NULL),
(66, '2021-02-05', 2, 1, 3, 3, 29, NULL, NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44', 1, 0, 4, 7, 6.5, 0, 0, NULL),
(69, '2021-02-06', 2, 1, 4, 5, 33, NULL, NULL, '2021-02-06 12:49:49', '2021-02-06 12:49:49', 1, 0, 5, 39, 38, 0, 0, NULL),
(70, '2021-02-01', 1, NULL, 2, 1, 30, NULL, NULL, '2021-02-08 04:58:21', '2021-02-08 04:58:21', 0, 0, 1, 45, 45, 0, 0, NULL),
(71, '2021-02-08', 2, 1, 3, 3, 30, NULL, NULL, '2021-02-08 04:59:13', '2021-02-08 04:59:13', 1, 0, 1, 45, 44.5, 0, 0, NULL),
(72, '2021-02-08', 1, NULL, 2, 1, 31, NULL, NULL, '2021-02-08 05:02:48', '2021-02-08 05:02:48', 0, 0, 1, 56, 56, 0, 0, NULL),
(73, '2021-02-08', 2, 1, 3, 3, 31, NULL, NULL, '2021-02-08 05:03:22', '2021-02-08 05:03:22', 1, 0, 1, 56, 55.5, 0, 0, NULL),
(74, '2021-02-08', 3, 4, 4, 5, 7, NULL, NULL, '2021-02-08 05:29:28', '2021-02-08 05:29:28', 1, 0, 10, 19.5, 19, 0, 0, NULL),
(75, '2021-02-08', 4, 5, 5, 7, 22, NULL, NULL, '2021-02-08 05:37:22', '2021-02-08 05:37:22', 0, 0, 3, 12.999, 12.999, 0, 1, NULL),
(76, '2021-02-08', 4, 6, 5, 7, 23, NULL, NULL, '2021-02-08 05:41:27', '2021-02-08 05:41:27', 1, 0, 1, 2.9, 2.5, 0, 0, NULL),
(77, '2021-02-08', 2, 1, 2, 1, 15, NULL, NULL, '2021-02-08 06:55:37', '2021-02-08 06:55:37', 0, 0, 17, 55, 55, 0, 0, NULL),
(78, '2021-02-09', 2, 1, 3, 3, 15, NULL, NULL, '2021-02-09 09:12:18', '2021-02-09 09:12:18', 1, 0, 17, 55, 55, 0, 1, NULL),
(79, '2021-02-10', 2, 1, 3, 3, 37, NULL, NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17', 1, 0, 11, 35, 34.5, 0, 0, NULL),
(80, '2021-02-11', 3, 3, 4, 5, 38, NULL, NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21', 1, 0, 6, 20, 19, 0, 0, NULL),
(81, '2021-02-11', 2, 1, 3, 3, 21, NULL, NULL, '2021-02-11 07:24:03', '2021-02-11 07:24:03', 0, 0, 12, 31.99, 31, 0, 0, NULL),
(82, '2021-02-11', 3, 3, 4, 5, 21, NULL, NULL, '2021-02-11 07:36:35', '2021-02-11 07:36:35', 0, 0, 12, 31.99, 31, 0, 0, NULL),
(83, '2021-02-11', 4, 5, 5, 7, 21, NULL, NULL, '2021-02-11 08:12:05', '2021-02-11 08:12:05', 0, 0, 12, 31.99, 31, 0, 0, NULL),
(84, '2021-02-11', 5, 7, 6, 10, 21, NULL, NULL, '2021-02-11 08:27:09', '2021-02-11 08:27:09', 1, 0, 12, 31.99, 31, 0, 0, NULL),
(87, '2021-03-29', 1, NULL, 2, 1, 39, NULL, NULL, '2021-03-29 08:37:32', '2021-03-29 08:37:32', 0, 0, 1, 10, 10, 0, 0, NULL),
(88, '2021-03-29', 2, 1, 3, 4, 39, NULL, NULL, '2021-03-29 08:39:01', '2021-03-29 08:39:01', 1, 0, 1, 10, 8.5, 0, 0, NULL),
(89, '2021-03-29', 3, 3, 4, 5, 26, NULL, NULL, '2021-03-29 08:43:40', '2021-03-29 08:43:40', 0, 0, 1, 2, 2, 0, 0, NULL),
(90, '2021-03-29', 4, 5, 5, 7, 26, NULL, NULL, '2021-03-29 08:45:10', '2021-03-29 08:45:10', 1, 0, 1, 2, 1, 0, 0, NULL),
(91, '2021-03-30', 1, NULL, 2, 1, 40, NULL, NULL, '2021-03-30 03:59:04', '2021-03-30 03:59:04', 0, 0, 1, 10, 10, 1, 0, NULL),
(92, '2021-04-06', 2, 1, 3, 3, 40, NULL, NULL, '2021-04-06 07:24:49', '2021-04-06 07:24:49', 1, 0, 1, 10, 9, 1, 0, NULL),
(93, '2021-04-09', 1, NULL, 2, 1, 41, NULL, NULL, '2021-04-08 21:28:36', '2021-04-08 21:28:36', 0, 0, 1, 10, 10, 0, 0, NULL),
(94, '2021-04-09', 2, 1, 3, 4, 41, NULL, NULL, '2021-04-08 21:35:23', '2021-04-08 21:35:23', 0, 0, 1, 10, 9.5, 0.5, 0, NULL),
(95, '2021-04-09', 1, NULL, 2, 1, 42, NULL, NULL, '2021-04-08 21:39:39', '2021-04-08 21:39:39', 0, 0, 10, 100, 100, 0, 0, NULL),
(96, '2021-04-09', 2, 1, 3, 4, 42, NULL, NULL, '2021-04-08 21:40:04', '2021-04-08 21:40:04', 1, 0, 10, 100, 99, 1, 0, NULL),
(97, '2021-04-09', 1, NULL, 2, 1, 44, NULL, NULL, '2021-04-08 21:43:47', '2021-04-08 21:43:47', 0, 0, 10, 100, 100, 0, 0, NULL),
(98, '2021-04-09', 2, 1, 3, 4, 44, NULL, NULL, '2021-04-08 21:43:58', '2021-04-08 21:43:58', 0, 0, 10, 100, 100, 0, 0, NULL),
(99, '2021-04-09', 3, 4, 4, 6, 44, NULL, NULL, '2021-04-08 21:44:31', '2021-04-08 21:44:31', 1, 0, 10, 100, 99, 1, 0, NULL),
(101, '2021-04-09', 3, 4, 4, 6, 44, NULL, NULL, '2021-04-08 21:49:09', '2021-04-08 21:49:09', 1, 0, 10, 100, 99, 1, 0, NULL),
(102, '2021-04-09', 3, 4, 4, 6, 44, NULL, NULL, '2021-04-09 00:23:35', '2021-04-09 00:23:35', 0, 0, 10, 99, 98, 1, 0, NULL),
(103, '2021-04-09', 4, 6, 5, 8, 44, NULL, NULL, '2021-04-09 00:30:53', '2021-04-09 00:30:53', 1, 0, 11, 109, 100, 10, 0, NULL),
(104, '2021-04-09', 4, 6, 5, 8, 44, NULL, NULL, '2021-04-09 00:32:16', '2021-04-09 00:32:16', 1, 0, 11, 100, 100, 0, 0, NULL),
(105, '2021-04-09', 4, 6, 6, 9, 44, NULL, NULL, '2021-04-09 00:34:48', '2021-04-09 00:34:48', 0, 0, 20, 110, 110, 0, 0, NULL),
(106, '2021-04-09', 4, 6, 5, 7, 44, NULL, NULL, '2021-04-09 00:38:16', '2021-04-09 00:38:16', 0, 0, 10, 100, 100, 0, 0, NULL),
(107, '2021-04-09', 5, 7, 6, 10, 44, NULL, NULL, '2021-04-09 00:38:46', '2021-04-09 00:38:46', 0, 0, 10, 100, 99, 1, 0, NULL),
(108, '2021-04-09', 6, 10, 7, 11, 44, NULL, NULL, '2021-04-09 00:39:23', '2021-04-09 00:39:23', 1, 0, 10, 99, 98, 2, 0, NULL),
(127, '2021-04-09', 6, 10, 7, 11, 44, NULL, NULL, '2021-04-09 01:47:51', '2021-04-09 02:19:37', 0, 0, 10, 98, 96, 4, 0, NULL),
(128, '2021-04-09', 7, 11, 8, NULL, 44, NULL, NULL, '2021-04-09 02:32:16', '2021-04-09 02:36:21', 0, 0, 10, 96, 94, 6, 0, NULL),
(129, '2021-04-09', 1, NULL, 2, 1, 45, NULL, NULL, '2021-04-09 02:38:05', '2021-04-09 02:38:05', 0, 0, 10, 100, 100, 0, 0, NULL),
(130, '2021-04-09', 2, 1, 3, 4, 45, NULL, NULL, '2021-04-09 02:38:28', '2021-04-09 02:38:37', 0, 0, 10, 100, 98, 2, 0, NULL),
(131, '2021-04-09', 3, 4, 4, 5, 45, NULL, NULL, '2021-04-09 02:39:00', '2021-04-09 02:39:00', 0, 0, 10, 98, 99, 2, 0, NULL),
(132, '2021-04-09', 4, 5, 5, 7, 45, NULL, NULL, '2021-04-09 02:59:44', '2021-04-09 02:59:44', 0, 0, 10, 98, 97, 3, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_item`
--

CREATE TABLE `transaction_item` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `bag_style_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0-completed,1-hold',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `other_accessories_id` bigint(20) UNSIGNED DEFAULT NULL,
  `uom_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` double NOT NULL,
  `weight` double NOT NULL,
  `receive_weight` double NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '0-bag,1-other accessories'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction_item`
--

INSERT INTO `transaction_item` (`id`, `transaction_id`, `bag_style_id`, `status`, `deleted_at`, `created_at`, `updated_at`, `other_accessories_id`, `uom_id`, `quantity`, `weight`, `receive_weight`, `type`) VALUES
(1, 1, 1, 0, NULL, '2020-09-24 16:13:06', '2020-09-24 16:13:06', NULL, 1, 10, 30, 30, 0),
(2, 2, 2, 0, NULL, '2020-09-24 16:13:23', '2020-09-24 16:13:23', NULL, 1, 10, 30, 30, 0),
(3, 3, 2, 1, NULL, '2020-09-24 16:31:53', '2020-09-24 16:31:53', NULL, 1, 10, 30, 26, 0),
(4, 4, 1, 1, NULL, '2020-09-24 16:39:11', '2020-09-24 16:39:11', NULL, 1, 10, 30, 26, 0),
(5, 5, 3, 0, NULL, '2020-09-29 15:51:38', '2020-09-29 15:51:38', NULL, 1, 10, 10, 10, 0),
(6, 6, 3, 1, NULL, '2020-09-29 15:53:28', '2020-09-29 15:53:28', NULL, 1, 10, 10, 8, 0),
(7, 7, 4, 0, NULL, '2020-10-01 10:30:15', '2020-10-01 10:30:15', NULL, 1, 10, 30, 30, 0),
(8, 8, 4, 1, NULL, '2020-10-01 10:36:43', '2020-10-01 10:36:43', NULL, 1, 10, 30, 29.99, 0),
(9, 9, 5, 0, NULL, '2020-10-01 10:48:19', '2020-10-01 10:48:19', NULL, 1, 10, 10, 10, 0),
(10, 10, 5, 0, NULL, '2020-10-01 10:52:16', '2020-10-12 22:29:00', NULL, 1, 10, 10, 9, 0),
(11, 11, 6, 0, NULL, '2020-10-01 14:44:11', '2020-10-01 14:44:11', NULL, 1, 10, 10, 10, 0),
(12, 12, 7, 0, NULL, '2020-10-01 15:32:47', '2020-10-01 15:32:47', NULL, 1, 10, 20, 20, 0),
(13, 13, 6, 0, NULL, '2020-10-03 11:17:11', '2021-02-11 07:25:03', NULL, 1, 10, 10, 8, 0),
(14, 14, 7, 0, NULL, '2020-10-03 14:12:42', '2020-10-03 14:12:42', NULL, 1, 10, 20, 19.5, 0),
(15, 15, 8, 0, NULL, '2020-10-03 19:06:40', '2020-10-03 19:06:40', NULL, 1, 10, 10, 10, 0),
(16, 16, 8, 0, NULL, '2020-10-03 19:08:15', '2021-02-11 07:25:41', NULL, 1, 10, 10, 9, 0),
(17, 17, 10, 0, NULL, '2020-10-07 16:27:59', '2020-10-07 16:27:59', NULL, 1, 10, 30, 30, 0),
(18, 18, 11, 0, NULL, '2020-10-08 17:57:26', '2020-10-08 17:57:26', NULL, 1, 10, 30, 30, 0),
(19, 19, 11, 0, NULL, '2020-10-08 18:00:59', '2020-10-08 18:00:59', NULL, 1, 10, 30, 29.75, 0),
(20, 20, 11, 0, NULL, '2020-10-08 18:01:50', '2020-10-08 18:01:50', NULL, 1, 10, 29.75, 29.75, 0),
(21, 21, 12, 0, NULL, '2020-10-08 19:09:26', '2020-10-08 19:09:26', NULL, 1, 15, 44.75, 44.75, 0),
(22, 22, 14, 0, NULL, '2020-10-10 08:32:57', '2020-10-10 08:32:57', NULL, 1, 10, 30, 30, 0),
(23, 23, 15, 0, NULL, '2020-10-10 08:33:59', '2020-10-10 08:33:59', NULL, 1, 15, 45, 45, 0),
(24, 24, 14, 0, NULL, '2020-10-10 08:44:15', '2021-02-08 06:44:04', NULL, 1, 10, 30, 29, 0),
(25, 25, 16, 0, NULL, '2020-10-13 15:11:44', '2020-10-13 15:11:44', NULL, 1, 10, 30, 30, 0),
(26, 26, 17, 0, NULL, '2020-10-13 16:25:37', '2020-10-13 16:25:37', NULL, 1, 10, 30, 30, 0),
(27, 27, 16, 0, NULL, '2020-10-13 19:59:12', '2020-10-13 19:59:12', NULL, 1, 10, 30, 29.99, 0),
(28, 28, 17, 0, NULL, '2020-10-13 20:00:08', '2020-10-13 20:00:08', NULL, 1, 10, 30, 29.99, 0),
(29, 29, 17, 0, NULL, '2020-10-16 16:38:40', '2020-10-16 16:38:40', NULL, 1, 10, 29.99, 29.99, 0),
(30, 30, 16, 0, NULL, '2020-10-16 16:39:22', '2020-10-16 16:39:22', NULL, 1, 10, 29.99, 29.99, 0),
(31, 31, 18, 0, NULL, '2020-10-16 16:45:50', '2020-10-16 16:45:50', NULL, 1, 1, 1, 0, 0),
(32, 32, 17, 0, NULL, '2020-10-21 13:25:50', '2020-10-21 13:25:50', NULL, 1, 10, 29.99, 0, 0),
(33, 33, 16, 0, NULL, '2020-10-21 13:31:07', '2020-10-21 13:31:07', NULL, 1, 10, 29.99, 29.99, 0),
(34, 34, 16, 0, NULL, '2020-10-21 13:31:26', '2020-10-21 13:31:26', NULL, 1, 10, 29.99, 29.99, 0),
(35, 35, 19, 0, NULL, '2020-10-21 13:50:21', '2020-10-21 13:50:21', NULL, 1, 11, 30.99, 30.99, 0),
(36, 36, 21, 0, NULL, '2020-10-21 13:53:22', '2020-10-21 13:53:22', NULL, 1, 12, 31.99, 31.99, 0),
(37, 37, 22, 0, NULL, '2020-11-16 09:44:49', '2020-11-16 09:44:49', NULL, 1, 3, 13, 12.999, 0),
(38, 38, 23, 0, NULL, '2020-11-16 09:58:14', '2020-11-16 09:58:14', NULL, 1, 1, 3, 3, 0),
(39, 39, 23, 0, NULL, '2020-11-16 10:00:29', '2020-11-16 10:00:29', NULL, 1, 1, 3, 2.99, 0),
(40, 40, 23, 0, NULL, '2020-12-14 17:33:26', '2020-12-14 17:33:26', NULL, 1, 1, 2.99, 2.9, 0),
(41, 41, 29, 0, NULL, '2020-12-18 10:24:53', '2020-12-18 10:24:53', NULL, 1, 10, 45, 45, 0),
(42, 42, 32, 0, NULL, '2020-12-22 04:55:27', '2020-12-22 04:55:27', NULL, 1, 10, 50, 50, 0),
(43, 43, 32, 0, NULL, '2020-12-22 04:55:58', '2020-12-22 04:55:58', NULL, 1, 10, 50, 49, 0),
(44, 44, 32, 0, NULL, '2020-12-22 06:09:16', '2020-12-22 06:09:16', NULL, 1, 10, 49, 48, 0),
(45, 45, 32, 0, NULL, '2020-12-22 06:17:07', '2020-12-22 06:17:07', NULL, 1, 10, 49, 48, 0),
(46, 46, 12, 0, NULL, '2021-01-29 05:28:39', '2021-01-29 05:28:39', NULL, 1, 15, 44.75, 44.75, 0),
(47, 47, 33, 0, NULL, '2021-01-30 05:27:35', '2021-01-30 05:27:35', NULL, 1, 15, 44.75, 0, 0),
(48, 48, 30, 0, NULL, '2021-01-30 09:38:27', '2021-01-30 09:38:27', NULL, 1, 5, 40, 40, 0),
(49, 49, 30, 0, NULL, '2021-01-30 09:38:45', '2021-01-30 09:38:45', NULL, 1, 5, 40, 40, 0),
(50, 50, 30, 0, NULL, '2021-01-30 09:39:10', '2021-01-30 09:39:10', NULL, 1, 5, 40, 40, 0),
(51, 51, 24, 0, NULL, '2021-02-03 14:36:23', '2021-02-03 14:36:23', NULL, 1, 1, 2.5, 2.5, 0),
(52, 52, 24, 0, NULL, '2021-02-03 14:36:31', '2021-02-03 14:36:31', NULL, 1, 1, 2.5, 2.5, 0),
(53, 53, 24, 0, NULL, '2021-02-03 14:37:09', '2021-02-03 14:37:09', NULL, 1, 1, 2.5, 2.5, 0),
(54, 54, 24, 0, NULL, '2021-02-03 14:38:06', '2021-02-03 14:38:06', NULL, 1, 1, 2.5, 2.5, 0),
(55, 55, 30, 0, NULL, '2021-02-03 14:38:52', '2021-02-03 14:38:52', NULL, 1, 5, 40, 39, 0),
(56, 56, 24, 0, NULL, '2021-02-04 07:06:46', '2021-02-04 07:06:46', NULL, 1, 1, 2.5, 2.5, 0),
(57, 57, 24, 0, NULL, '2021-02-04 11:42:55', '2021-02-04 11:42:55', NULL, 1, 1, 2.5, 2, 0),
(58, 58, 24, 1, NULL, '2021-02-05 22:45:43', '2021-02-05 22:45:43', NULL, 1, 1, 2, 2, 0),
(61, 60, 25, 0, NULL, '2021-02-06 07:02:14', '2021-02-06 07:02:14', NULL, 1, 1, 56, 56, 0),
(62, 60, 34, 0, NULL, '2021-02-06 07:02:14', '2021-02-06 07:02:14', 2, 2, 1, 2, 2, 1),
(63, 61, 25, 1, NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51', NULL, 1, 1, 56, 56, 0),
(64, 61, 34, 0, NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51', NULL, 2, 1, 2, 2, 0),
(65, 62, 32, 0, NULL, '2021-02-06 07:18:17', '2021-02-06 07:18:17', NULL, 1, 10, 48, 48, 0),
(66, 62, 35, 0, NULL, '2021-02-06 07:18:17', '2021-02-06 07:18:17', 2, 2, 10, 2, 2, 1),
(67, 63, 32, 0, NULL, '2021-02-06 09:31:13', '2021-02-06 09:31:13', NULL, 1, 10, 48, 48, 0),
(68, 63, 35, 0, NULL, '2021-02-06 09:31:13', '2021-02-06 09:31:13', NULL, 2, 10, 2, 2, 0),
(69, 64, 30, 0, NULL, '2021-02-06 09:31:46', '2021-02-06 09:31:46', NULL, 1, 5, 39, 39, 0),
(70, 65, 26, 0, NULL, '2021-02-06 11:54:46', '2021-02-06 11:54:46', NULL, 1, 1, 4, 4, 0),
(71, 66, 26, 1, NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44', NULL, 1, 1, 4, 4, 0),
(72, 66, NULL, 0, NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44', 2, 2, 3, 3, 3, 1),
(75, 69, 30, 1, NULL, '2021-02-06 12:49:49', '2021-02-06 12:49:49', NULL, 1, 5, 39, 39, 0),
(76, 70, 27, 0, NULL, '2021-02-08 04:58:21', '2021-02-08 04:58:21', NULL, 1, 1, 45, 45, 0),
(77, 71, 27, 1, NULL, '2021-02-08 04:59:13', '2021-02-08 04:59:13', NULL, 1, 1, 45, 45, 0),
(78, 72, 28, 0, NULL, '2021-02-08 05:02:48', '2021-02-08 05:02:48', NULL, 1, 1, 56, 56, 0),
(79, 73, 28, 1, NULL, '2021-02-08 05:03:22', '2021-02-08 05:03:22', NULL, 1, 1, 56, 56, 0),
(80, 74, 7, 1, NULL, '2021-02-08 05:29:28', '2021-02-08 05:29:28', NULL, 1, 10, 19.5, 19.5, 0),
(81, 75, 22, 0, NULL, '2021-02-08 05:37:22', '2021-02-08 05:37:22', NULL, 1, 3, 12.999, 12.999, 0),
(82, 76, 23, 1, NULL, '2021-02-08 05:41:27', '2021-02-08 05:41:27', NULL, 1, 1, 2.9, 2.9, 0),
(83, 77, 15, 0, NULL, '2021-02-08 06:55:37', '2021-02-08 06:55:37', NULL, 1, 15, 45, 45, 0),
(84, 77, 36, 0, NULL, '2021-02-08 06:55:38', '2021-02-08 06:55:38', 2, 2, 2, 10, 10, 1),
(85, 78, 15, 1, NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19', NULL, 1, 15, 45, 45, 0),
(86, 78, 36, 0, NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19', NULL, 2, 2, 10, 10, 0),
(87, 79, 37, 1, NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17', NULL, 1, 10, 30, 30, 0),
(88, 79, 39, 0, NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17', NULL, 2, 1, 5, 5, 0),
(89, 80, 38, 1, NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21', NULL, 1, 5, 15, 15, 0),
(90, 80, 40, 0, NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21', NULL, 2, 1, 5, 5, 0),
(91, 81, 21, 0, NULL, '2021-02-11 07:24:03', '2021-02-11 07:24:03', NULL, 1, 12, 31.99, 31.99, 0),
(92, 82, 21, 0, NULL, '2021-02-11 07:36:35', '2021-02-11 07:36:35', NULL, 1, 12, 31.99, 31.99, 0),
(93, 83, 21, 0, NULL, '2021-02-11 08:12:05', '2021-02-11 08:12:05', NULL, 1, 12, 31.99, 31.99, 0),
(94, 84, 21, 1, NULL, '2021-02-11 08:27:09', '2021-02-11 08:27:09', NULL, 1, 12, 31.99, 31.99, 0),
(97, 87, 41, 0, NULL, '2021-03-29 08:37:32', '2021-03-29 08:37:32', NULL, 1, 1, 10, 10, 0),
(98, 88, 41, 1, NULL, '2021-03-29 08:39:01', '2021-03-29 08:39:01', NULL, 1, 1, 10, 10, 0),
(99, 89, 24, 0, NULL, '2021-03-29 08:43:40', '2021-03-29 08:43:40', NULL, 1, 1, 2, 2, 0),
(100, 90, 24, 1, NULL, '2021-03-29 08:45:10', '2021-03-29 08:45:10', NULL, 1, 1, 2, 2, 0),
(101, 91, 42, 0, NULL, '2021-03-30 03:59:05', '2021-03-30 03:59:05', NULL, 1, 1, 10, 10, 0),
(102, 92, 42, 1, NULL, '2021-04-06 07:24:49', '2021-04-06 07:24:49', NULL, 1, 1, 10, 10, 0),
(103, 93, 43, 0, NULL, '2021-04-08 21:28:37', '2021-04-08 21:28:37', NULL, 1, 1, 10, 10, 0),
(104, 94, 43, 0, NULL, '2021-04-08 21:35:23', '2021-04-08 21:35:23', NULL, 1, 1, 10, 10, 0),
(105, 95, 44, 0, NULL, '2021-04-08 21:39:39', '2021-04-08 21:39:39', NULL, 1, 10, 100, 100, 0),
(106, 96, 44, 1, NULL, '2021-04-08 21:40:04', '2021-04-08 21:40:04', NULL, 1, 10, 100, 100, 0),
(107, 97, 46, 0, NULL, '2021-04-08 21:43:47', '2021-04-08 21:43:47', NULL, 1, 10, 100, 100, 0),
(108, 98, 46, 0, NULL, '2021-04-08 21:43:58', '2021-04-08 21:43:58', NULL, 1, 10, 100, 100, 0),
(109, 99, 46, 1, NULL, '2021-04-08 21:44:31', '2021-04-08 21:44:31', NULL, 1, 10, 100, 100, 0),
(110, 101, 46, 1, NULL, '2021-04-08 21:49:09', '2021-04-08 21:49:09', NULL, 1, 10, 100, 100, 0),
(111, 102, 46, 0, NULL, '2021-04-09 00:23:35', '2021-04-09 00:23:35', NULL, 1, 10, 100, 100, 0),
(112, 103, 46, 1, NULL, '2021-04-09 00:30:53', '2021-04-09 00:30:53', NULL, 1, 10, 100, 100, 0),
(113, 103, NULL, 1, NULL, '2021-04-09 00:30:53', '2021-04-09 00:30:53', 2, 2, 1, 10, 10, 1),
(114, 104, 46, 0, NULL, '2021-04-09 00:32:16', '2021-04-09 00:32:16', NULL, 1, 10, 100, 100, 0),
(115, 104, NULL, 0, NULL, '2021-04-09 00:32:16', '2021-04-09 00:32:16', 2, 2, 1, 10, 10, 1),
(116, 105, 46, 1, NULL, '2021-04-09 00:34:48', '2021-04-09 00:34:48', NULL, 1, 10, 100, 100, 0),
(117, 105, NULL, 1, NULL, '2021-04-09 00:34:48', '2021-04-09 00:34:48', 2, 2, 10, 10, 10, 1),
(118, 106, 46, 0, NULL, '2021-04-09 00:38:17', '2021-04-09 00:38:17', NULL, 1, 10, 100, 100, 0),
(119, 107, 46, 0, NULL, '2021-04-09 00:38:46', '2021-04-09 00:38:46', NULL, 1, 10, 100, 100, 0),
(120, 108, 46, 1, NULL, '2021-04-09 00:39:24', '2021-04-09 00:39:24', NULL, 1, 10, 100, 100, 0),
(136, 127, 46, 0, NULL, '2021-04-09 01:47:51', '2021-04-09 02:19:37', NULL, 1, 10, 100, 100, 0),
(137, 128, 46, 0, NULL, '2021-04-09 02:32:16', '2021-04-09 02:36:21', NULL, 1, 10, 100, 100, 0),
(138, 129, 47, 0, NULL, '2021-04-09 02:38:06', '2021-04-09 02:38:06', NULL, 1, 10, 100, 100, 0),
(139, 130, 47, 0, NULL, '2021-04-09 02:38:28', '2021-04-09 02:38:37', NULL, 1, 10, 100, 100, 0),
(140, 131, 47, 0, NULL, '2021-04-09 02:39:00', '2021-04-09 02:39:00', NULL, 1, 10, 100, 100, 0),
(141, 132, 47, 0, NULL, '2021-04-09 02:59:44', '2021-04-09 02:59:44', NULL, 1, 10, 100, 100, 0);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_item_loss_details`
--

CREATE TABLE `transaction_item_loss_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `transaction_item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `weight` double NOT NULL DEFAULT '0',
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '0-loss,1-scrap',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bag_style_id` bigint(20) UNSIGNED DEFAULT NULL,
  `admin_approval_loss_weight` double NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0-approved,1-waiting for admin approval',
  `approval_date` date DEFAULT NULL,
  `admin_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'approved or rejected user',
  `reason_type_id` int(11) NOT NULL DEFAULT '0' COMMENT '0-,1-,2-,3-others',
  `loss_description` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction_item_loss_details`
--

INSERT INTO `transaction_item_loss_details` (`id`, `date`, `transaction_item_id`, `transaction_id`, `weight`, `user_id`, `type`, `deleted_at`, `created_at`, `updated_at`, `bag_style_id`, `admin_approval_loss_weight`, `status`, `approval_date`, `admin_id`, `reason_type_id`, `loss_description`) VALUES
(1, '2020-09-24', 3, 3, 2, 3, 1, NULL, '2020-09-24 16:31:53', '2020-09-24 16:31:53', 2, 0, 0, NULL, NULL, 0, NULL),
(2, '2020-09-24', 3, 3, 2, 3, 0, NULL, '2020-09-24 16:31:53', '2020-09-24 16:31:53', 2, 0, 0, NULL, NULL, 0, NULL),
(3, '2020-09-24', 4, 4, 3, 2, 1, NULL, '2020-09-24 16:39:11', '2020-09-24 16:39:11', 1, 0, 0, NULL, NULL, 0, NULL),
(4, '2020-09-24', 4, 4, 1, 2, 0, NULL, '2020-09-24 16:39:11', '2020-09-24 16:39:11', 1, 0, 0, NULL, NULL, 0, NULL),
(5, '2020-09-29', 6, 6, 1, 2, 1, NULL, '2020-09-29 15:53:28', '2020-09-29 15:53:28', 3, 0, 0, NULL, NULL, 0, NULL),
(6, '2020-09-29', 6, 6, 1, 2, 0, NULL, '2020-09-29 15:53:28', '2020-09-29 15:53:28', 3, 0.075, 0, NULL, NULL, 0, NULL),
(7, '2020-10-01', 8, 8, 0.005, 3, 1, NULL, '2020-10-01 10:36:43', '2020-10-01 10:36:43', 4, 0, 0, NULL, NULL, 0, NULL),
(8, '2020-10-01', 8, 8, 0.005, 3, 0, NULL, '2020-10-01 10:36:43', '2020-10-01 10:36:43', 4, 0, 0, NULL, NULL, 0, NULL),
(9, '2020-10-01', 10, 10, 0.5, 3, 1, NULL, '2020-10-01 10:52:16', '2020-10-01 10:52:16', 5, 0, 0, NULL, NULL, 0, NULL),
(10, '2020-10-01', 10, 10, 0.5, 3, 0, NULL, '2020-10-01 10:52:16', '2020-10-12 22:29:00', 5, 0.0025, 0, NULL, 1, 3, '<p>sadsa</p>'),
(11, '2020-10-03', 13, 13, 1, 3, 1, NULL, '2020-10-03 11:17:11', '2020-10-03 11:17:11', 6, 0, 0, NULL, NULL, 0, NULL),
(12, '2020-10-03', 13, 13, 1, 3, 0, NULL, '2020-10-03 11:17:11', '2021-02-11 07:25:03', 6, 0.1, 0, NULL, 14, 1, NULL),
(13, '2020-10-03', 14, 14, 0.4, 3, 1, NULL, '2020-10-03 14:12:42', '2020-10-03 14:12:42', 7, 0, 0, NULL, NULL, 0, NULL),
(14, '2020-10-03', 14, 14, 0.1, 3, 0, NULL, '2020-10-03 14:12:42', '2021-02-11 07:25:11', 7, 0.2, 0, NULL, 14, 1, NULL),
(15, '2020-10-03', 16, 16, 0.5, 3, 1, NULL, '2020-10-03 19:08:15', '2020-10-03 19:08:15', 8, 0, 0, NULL, NULL, 0, NULL),
(16, '2020-10-03', 16, 16, 0.5, 3, 0, NULL, '2020-10-03 19:08:15', '2021-02-11 07:25:41', 8, 0.1, 0, NULL, 14, 1, NULL),
(17, '2020-10-08', 19, 19, 0.2, 3, 1, NULL, '2020-10-08 18:00:59', '2020-10-08 18:00:59', 11, 0, 0, NULL, NULL, 0, NULL),
(18, '2020-10-08', 19, 19, 0.05, 3, 0, NULL, '2020-10-08 18:00:59', '2021-02-11 07:25:30', 11, 0.3, 0, NULL, 14, 1, NULL),
(19, '2020-10-10', 24, 24, 0.5, 3, 1, NULL, '2020-10-10 08:44:15', '2020-10-10 08:44:15', 14, 0, 0, NULL, NULL, 0, NULL),
(20, '2020-10-10', 24, 24, 0.5, 3, 0, NULL, '2020-10-10 08:44:15', '2021-02-08 06:44:04', 14, 0.3, 0, NULL, 14, 1, NULL),
(21, '2020-10-13', 27, 27, 0.005, 12, 1, NULL, '2020-10-13 19:59:12', '2020-10-13 19:59:12', 16, 0, 0, NULL, NULL, 0, NULL),
(22, '2020-10-13', 27, 27, 0.005, 12, 0, NULL, '2020-10-13 19:59:12', '2021-02-08 06:43:18', 16, 0.3, 0, NULL, 14, 1, NULL),
(23, '2020-10-13', 28, 28, 0.005, 12, 1, NULL, '2020-10-13 20:00:08', '2020-10-13 20:00:08', 17, 0, 0, NULL, NULL, 0, NULL),
(24, '2020-10-13', 28, 28, 0.005, 12, 0, NULL, '2020-10-13 20:00:08', '2020-10-21 13:30:00', 17, 0.3, 0, NULL, 1, 1, NULL),
(25, '2020-10-16', 31, 31, 1, 1, 1, NULL, '2020-10-16 16:45:50', '2020-10-16 16:45:50', 18, 0, 0, NULL, NULL, 0, NULL),
(26, '2020-10-21', 32, 32, 29.99, 1, 1, NULL, '2020-10-21 13:25:50', '2020-10-21 13:25:50', 17, 0, 0, NULL, NULL, 0, NULL),
(27, '2020-11-16', 37, 37, 0.001, 3, 1, NULL, '2020-11-16 09:44:49', '2020-11-16 09:44:49', 22, 0, 0, NULL, NULL, 0, NULL),
(28, '2020-11-16', 39, 39, 0.01, 3, 1, NULL, '2020-11-16 10:00:30', '2020-11-16 10:00:30', 23, 0, 0, NULL, NULL, 0, NULL),
(29, '2020-12-22', NULL, 45, 0.5, 3, 1, NULL, '2020-12-22 06:17:07', '2020-12-22 06:17:07', NULL, 0, 0, NULL, NULL, 0, NULL),
(30, '2020-12-22', NULL, 45, 0.5, 3, 0, NULL, '2020-12-22 06:17:08', '2020-12-22 06:17:08', NULL, 0, 0, NULL, NULL, 0, NULL),
(31, '2021-01-29', NULL, 46, 0.05, 4, 0, NULL, '2021-01-29 05:28:39', '2021-01-29 05:28:39', NULL, 0, 0, NULL, NULL, 0, NULL),
(32, '2021-01-30', 47, 47, 44.75, 14, 1, NULL, '2021-01-30 05:27:35', '2021-01-30 05:27:35', 33, 0, 0, NULL, NULL, 0, NULL),
(33, '2021-02-03', NULL, 55, 0.5, 2, 1, NULL, '2021-02-03 14:38:52', '2021-02-03 14:38:52', NULL, 0, 0, NULL, NULL, 0, NULL),
(34, '2021-02-03', NULL, 55, 0.3, 2, 0, NULL, '2021-02-03 14:38:53', '2021-02-03 14:38:53', NULL, 0, 0, NULL, NULL, 0, NULL),
(35, '2021-02-03', NULL, 55, 0.2, 2, 2, NULL, '2021-02-03 14:38:53', '2021-02-03 14:38:53', NULL, 0, 0, NULL, NULL, 0, NULL),
(36, '2021-02-04', NULL, 57, 0.1, 2, 1, NULL, '2021-02-04 11:42:55', '2021-02-04 11:42:55', NULL, 0, 0, NULL, NULL, 0, NULL),
(37, '2021-02-04', NULL, 57, 0.2, 2, 0, NULL, '2021-02-04 11:42:55', '2021-02-04 11:42:55', NULL, 0, 0, NULL, NULL, 0, NULL),
(38, '2021-02-04', NULL, 57, 0.2, 2, 2, NULL, '2021-02-04 11:42:55', '2021-02-04 11:42:55', NULL, 0, 0, NULL, NULL, 0, NULL),
(39, '2021-02-06', NULL, 58, 0.1, 4, 0, NULL, '2021-02-05 22:45:43', '2021-02-05 22:45:43', NULL, 0, 0, NULL, NULL, 0, NULL),
(40, '2021-02-06', NULL, 61, 0.2, 2, 1, NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51', NULL, 0, 0, NULL, NULL, 0, NULL),
(41, '2021-02-06', NULL, 61, 0.2, 2, 0, NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51', NULL, 0, 0, NULL, NULL, 0, NULL),
(42, '2021-02-06', NULL, 61, 0.1, 2, 2, NULL, '2021-02-06 07:03:51', '2021-02-06 07:03:51', NULL, 0, 0, NULL, NULL, 0, NULL),
(43, '2021-02-05', NULL, 66, 0.2, 2, 1, NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44', NULL, 0, 0, NULL, NULL, 0, NULL),
(44, '2021-02-05', NULL, 66, 0.2, 2, 0, NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44', NULL, 0, 0, NULL, NULL, 0, NULL),
(45, '2021-02-05', NULL, 66, 0.1, 2, 2, NULL, '2021-02-06 12:43:44', '2021-02-06 12:43:44', NULL, 0, 0, NULL, NULL, 0, NULL),
(46, '2021-02-06', NULL, 69, 0.5, 2, 1, NULL, '2021-02-06 12:49:49', '2021-02-06 12:49:49', NULL, 0, 0, NULL, NULL, 0, NULL),
(47, '2021-02-06', NULL, 69, 0.5, 2, 0, NULL, '2021-02-06 12:49:49', '2021-02-06 12:49:49', NULL, 0, 0, NULL, NULL, 0, NULL),
(48, '2021-02-08', NULL, 71, 0.2, 2, 1, NULL, '2021-02-08 04:59:13', '2021-02-08 04:59:13', NULL, 0, 0, NULL, NULL, 0, NULL),
(49, '2021-02-08', NULL, 71, 0.2, 2, 0, NULL, '2021-02-08 04:59:13', '2021-02-08 04:59:13', NULL, 0, 0, NULL, NULL, 0, NULL),
(50, '2021-02-08', NULL, 71, 0.1, 2, 2, NULL, '2021-02-08 04:59:13', '2021-02-08 04:59:13', NULL, 0, 0, NULL, NULL, 0, NULL),
(51, '2021-02-08', NULL, 73, 0.2, 2, 1, NULL, '2021-02-08 05:03:22', '2021-02-08 05:03:22', NULL, 0, 0, NULL, NULL, 0, NULL),
(52, '2021-02-08', NULL, 73, 0.2, 2, 0, NULL, '2021-02-08 05:03:22', '2021-02-08 05:03:22', NULL, 0, 0, NULL, NULL, 0, NULL),
(53, '2021-02-08', NULL, 73, 0.1, 2, 2, NULL, '2021-02-08 05:03:22', '2021-02-08 05:03:22', NULL, 0, 0, NULL, NULL, 0, NULL),
(54, '2021-02-08', NULL, 74, 0.5, 5, 0, NULL, '2021-02-08 05:29:28', '2021-02-08 05:29:28', NULL, 0, 0, NULL, NULL, 0, NULL),
(55, '2021-02-08', NULL, 76, 0.1, 7, 1, NULL, '2021-02-08 05:41:27', '2021-02-08 05:41:27', NULL, 0, 0, NULL, NULL, 0, NULL),
(56, '2021-02-08', NULL, 76, 0.2, 7, 0, NULL, '2021-02-08 05:41:27', '2021-02-08 05:41:27', NULL, 0, 0, NULL, NULL, 0, NULL),
(57, '2021-02-08', NULL, 76, 0.1, 7, 2, NULL, '2021-02-08 05:41:27', '2021-02-08 05:41:27', NULL, 0, 0, NULL, NULL, 0, NULL),
(58, '2021-02-09', NULL, 78, 0.2, 2, 1, NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19', NULL, 0, 0, NULL, NULL, 0, NULL),
(59, '2021-02-09', NULL, 78, 0.1, 2, 0, NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19', NULL, 0, 0, NULL, NULL, 0, NULL),
(60, '2021-02-09', NULL, 78, 0.2, 2, 2, NULL, '2021-02-09 09:12:19', '2021-02-09 09:12:19', NULL, 0, 0, NULL, NULL, 0, NULL),
(61, '2021-02-10', NULL, 79, 0.2, 2, 1, NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17', NULL, 0, 0, NULL, NULL, 0, NULL),
(62, '2021-02-10', NULL, 79, 0.2, 2, 0, NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17', NULL, 0, 0, NULL, NULL, 0, NULL),
(63, '2021-02-10', NULL, 79, 0.1, 2, 2, NULL, '2021-02-10 13:33:17', '2021-02-10 13:33:17', NULL, 0, 0, NULL, NULL, 0, NULL),
(64, '2021-02-11', NULL, 80, 0.5, 4, 1, NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21', NULL, 0, 0, NULL, NULL, 0, NULL),
(65, '2021-02-11', NULL, 80, 0.2, 4, 0, NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21', NULL, 0, 0, NULL, NULL, 0, NULL),
(66, '2021-02-11', NULL, 80, 0.3, 4, 2, NULL, '2021-02-11 07:08:21', '2021-02-11 07:08:21', NULL, 0, 0, NULL, NULL, 0, NULL),
(67, '2021-02-11', NULL, 81, 0.99, 2, 1, NULL, '2021-02-11 07:24:03', '2021-02-11 07:24:03', NULL, 0, 0, NULL, NULL, 0, NULL),
(68, '2021-02-11', NULL, 82, 0.99, 4, 1, NULL, '2021-02-11 07:36:35', '2021-02-11 07:36:35', NULL, 0, 0, NULL, NULL, 0, NULL),
(69, '2021-02-11', NULL, 83, 0.99, 6, 1, NULL, '2021-02-11 08:12:05', '2021-02-11 08:12:05', NULL, 0, 0, NULL, NULL, 0, NULL),
(70, '2021-02-11', NULL, 84, 0.99, 8, 0, NULL, '2021-02-11 08:27:09', '2021-02-11 08:27:09', NULL, 0, 0, NULL, NULL, 0, NULL),
(71, '2021-03-29', NULL, 88, 0.5, 2, 1, NULL, '2021-03-29 08:39:01', '2021-03-29 08:39:01', NULL, 0, 0, NULL, NULL, 0, NULL),
(72, '2021-03-29', NULL, 88, 1.5, 2, 0, NULL, '2021-03-29 08:39:02', '2021-03-29 08:39:02', NULL, 0, 0, NULL, NULL, 0, NULL),
(73, '2021-03-29', NULL, 88, 0.5, 2, 2, NULL, '2021-03-29 08:39:02', '2021-03-29 08:39:02', NULL, 0, 0, NULL, NULL, 0, NULL),
(74, '2021-03-29', NULL, 90, 1, 6, 0, NULL, '2021-03-29 08:45:10', '2021-03-29 08:45:10', NULL, 2, 1, NULL, NULL, 0, NULL),
(75, '2021-04-06', NULL, 92, 0.5, 2, 1, NULL, '2021-04-06 07:24:49', '2021-04-06 07:24:49', NULL, 0, 0, NULL, NULL, 0, NULL),
(76, '2021-04-06', NULL, 92, 0.5, 2, 0, NULL, '2021-04-06 07:24:49', '2021-04-06 07:24:49', NULL, 0, 0, NULL, NULL, 0, NULL),
(77, '2021-04-09', NULL, 94, 0.5, 2, 0, NULL, '2021-04-08 21:35:23', '2021-04-08 21:35:23', NULL, 0, 0, NULL, NULL, 0, NULL),
(78, '2021-04-09', NULL, 96, 0.5, 2, 1, NULL, '2021-04-08 21:40:04', '2021-04-08 21:40:04', NULL, 0, 0, NULL, NULL, 0, NULL),
(79, '2021-04-09', NULL, 96, 0.5, 2, 0, NULL, '2021-04-08 21:40:04', '2021-04-08 21:40:04', NULL, 0, 0, NULL, NULL, 0, NULL),
(80, '2021-04-09', NULL, 99, 0.5, 5, 1, NULL, '2021-04-08 21:44:31', '2021-04-08 21:44:31', NULL, 0, 0, NULL, NULL, 0, NULL),
(81, '2021-04-09', NULL, 99, 0.5, 5, 0, NULL, '2021-04-08 21:44:31', '2021-04-08 21:44:31', NULL, 0, 0, NULL, NULL, 0, NULL),
(82, '2021-04-09', NULL, 101, 1, 5, 0, NULL, '2021-04-08 21:49:09', '2021-04-08 21:49:09', NULL, 2, 0, NULL, NULL, 0, NULL),
(83, '2021-04-09', NULL, 102, 1, 5, 1, NULL, '2021-04-09 00:23:35', '2021-04-09 00:23:35', NULL, 0, 0, NULL, NULL, 0, NULL),
(84, '2021-04-09', NULL, 103, 4, 7, 1, NULL, '2021-04-09 00:30:53', '2021-04-09 00:30:53', NULL, 0, 0, NULL, NULL, 0, NULL),
(85, '2021-04-09', NULL, 103, 5, 7, 0, NULL, '2021-04-09 00:30:53', '2021-04-09 00:30:53', NULL, 0, 0, NULL, NULL, 0, NULL),
(86, '2021-04-09', NULL, 104, 4, 7, 1, NULL, '2021-04-09 00:32:16', '2021-04-09 00:32:16', NULL, 0, 0, NULL, NULL, 0, NULL),
(87, '2021-04-09', NULL, 104, 5, 7, 0, NULL, '2021-04-09 00:32:16', '2021-04-09 00:32:16', NULL, 0, 0, NULL, NULL, 0, NULL),
(88, '2021-04-09', NULL, 105, 4, 7, 1, NULL, '2021-04-09 00:34:48', '2021-04-09 00:34:48', NULL, 0, 0, NULL, NULL, 0, NULL),
(89, '2021-04-09', NULL, 105, 5, 7, 0, NULL, '2021-04-09 00:34:48', '2021-04-09 00:34:48', NULL, 0, 0, NULL, NULL, 0, NULL),
(90, '2021-04-09', NULL, 107, 1, 8, 1, NULL, '2021-04-09 00:38:46', '2021-04-09 00:38:46', NULL, 0, 0, NULL, NULL, 0, NULL),
(91, '2021-04-09', NULL, 108, 1, 11, 0, NULL, '2021-04-09 00:39:24', '2021-04-09 00:39:24', NULL, 0, 0, NULL, NULL, 0, NULL),
(92, '2021-04-09', NULL, 127, 2, 11, 0, NULL, '2021-04-09 01:47:51', '2021-04-09 02:19:37', NULL, 0.1, 0, NULL, 1, 1, NULL),
(93, '2021-04-09', NULL, 128, 2, 12, 0, NULL, '2021-04-09 02:32:16', '2021-04-09 02:36:21', NULL, 1, 0, NULL, 1, 1, NULL),
(94, '2021-04-09', NULL, 130, 2, 2, 0, NULL, '2021-04-09 02:38:28', '2021-04-09 02:38:37', NULL, 1, 0, NULL, 1, 2, NULL),
(95, '2021-04-09', NULL, 132, 1, 6, 1, NULL, '2021-04-09 02:59:44', '2021-04-09 02:59:44', NULL, 2, 0, NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `unit`
--

CREATE TABLE `unit` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `unit`
--

INSERT INTO `unit` (`id`, `name`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'SPM', NULL, NULL, '2020-09-23 15:35:52', '2020-09-23 15:35:52');

-- --------------------------------------------------------

--
-- Table structure for table `uom`
--

CREATE TABLE `uom` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uom`
--

INSERT INTO `uom` (`id`, `name`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Piece', NULL, NULL, '2020-09-24 07:28:52', '2020-09-24 07:28:52'),
(2, 'Stones', NULL, NULL, '2020-09-24 07:31:48', '2020-09-24 07:31:48');

-- --------------------------------------------------------

--
-- Table structure for table `uploads`
--

CREATE TABLE `uploads` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `file_name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `random_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uploaded_path` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_tmp` tinyint(4) NOT NULL DEFAULT '1',
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uploads`
--

INSERT INTO `uploads` (`id`, `file_name`, `file_size`, `random_key`, `uploaded_path`, `is_tmp`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Chrysanthemum.jpg', '230155', 'QiES8A8DtuxB5vYw90PB', 'public/attachments/t48lQ23cOJ5PZT9perRJANq6uqIIlRgaaY9jWwMc.jpeg', 1, 1, '2020-09-24 15:02:25', '2020-09-24 15:02:25', NULL),
(2, 'Desert.jpg', '250942', 'ZP3uyv6KkaxX8eAejn5j', 'public/attachments/I8Aep2a5QPIiCamerce5xGV3AovgWV0S8E2QF19z.jpeg', 1, 1, '2020-09-24 15:02:39', '2020-09-24 15:02:39', NULL),
(3, 'Hydrangeas.jpg', '170442', '2P5Qw8nJFnr30KdNDWbq', 'public/attachments/ObDcytL2dn4W9j4MXa1FdmbSBKUbrR8Uu99LfSqy.jpeg', 1, 1, '2020-09-24 15:02:54', '2020-09-24 15:02:54', NULL),
(4, 'Chrysanthemum.jpg', '20450', '4rYCy1Bc27lnTOV6y2Wy', 'public/attachments/a1vbpSnocna6Xl96Q6OltCf85lyufz4DB2Ag4k8p.jpeg', 1, 1, '2020-10-08 14:20:43', '2020-10-08 14:20:43', NULL),
(5, 'Chrysanthemum.jpg', '20450', 'XI4EEJfFC7oxBeUt7CkA', 'public/attachments/JTtPwq3dofepZuuLHZ7KRKxMRiYOXkrUBqMPLNBa.jpeg', 1, 1, '2020-10-08 14:20:48', '2020-10-08 14:20:48', NULL),
(6, 'Penguins.jpg', '17148', 'fqe2i4GBvKEpswbl0qtU', 'public/attachments/cdrRZT4E6eNSUlcU46jz0e3e20HrXEqBvbc9GMfD.jpeg', 1, 1, '2020-10-08 18:10:19', '2020-10-08 18:10:19', NULL),
(7, 'Tulips.jpg', '18005', 'i6QrJfpEqSUbXRCHFFj6', 'public/attachments/F185UFDJUdn1cqN7PnTt8x5YAncOPSBdQr2rstRy.jpeg', 1, 1, '2020-10-08 18:10:33', '2020-10-08 18:10:33', NULL),
(8, 'Hydrangeas.jpg', '16880', 'bQZVxhd73j7M1KApgWlN', 'public/attachments/uC5xrpWjr6TaoRpwrlbTGI2rx1DEchsMmte0pVru.jpeg', 1, 1, '2020-10-10 08:32:31', '2020-10-10 08:32:31', NULL),
(9, 'Penguins.jpg', '17148', 'k3DD4xVdGVREibfFsReG', 'public/attachments/bzMUp0iS6u7N8MiUfCLGuoMEojzAElDBi3jl6CkC.jpeg', 1, 1, '2020-10-13 15:06:32', '2020-10-13 15:06:32', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo_url` text COLLATE utf8mb4_unicode_ci,
  `uses_two_factor_auth` tinyint(4) NOT NULL DEFAULT '0',
  `authy_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_reset_code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_team_id` int(11) DEFAULT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_billing_plan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_last_four` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_line_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_zip` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vat_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extra_billing_information` text COLLATE utf8mb4_unicode_ci,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `last_read_announcements_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `photo_url`, `uses_two_factor_auth`, `authy_id`, `country_code`, `phone`, `two_factor_reset_code`, `current_team_id`, `stripe_id`, `current_billing_plan`, `card_brand`, `card_last_four`, `card_country`, `billing_address`, `billing_address_line_2`, `billing_city`, `billing_state`, `billing_zip`, `billing_country`, `vat_id`, `extra_billing_information`, `trial_ends_at`, `last_read_announcements_at`, `created_at`, `updated_at`, `deleted_at`, `department_id`) VALUES
(1, 'admin', 'admin@gmail.com', '$2y$10$Ey1HGOrwsq.3e7Y5n8Q/SOzhczXYaXu4egi5GE9tKbuzRtQj9/W2O', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-22 10:53:15', '2020-09-22 10:53:15', NULL, NULL),
(2, 'Sakthi', 'E01@impel.com', '$2y$10$wlQs3E8b4ZWZ3UZVSgoDPuDTC4E.HYOC3dm1d.cH0fp/M9BN9vg0y', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-23 16:13:24', '2020-09-23 16:13:24', NULL, 2),
(3, 'Arul', 'E02@impel.com', '$2y$10$n1JFsmQ87aU.ZOmcMWX0z.R2jTCyqGTk1AAZAuSNncFHtfEkB4zny', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-23 16:13:49', '2020-10-01 10:32:58', NULL, 2),
(4, 'Arun', 'E03@impel.com', '$2y$10$rNJp0ZF6vLUqXgftsxl/ze5Fw7ITxiXQjntwel.nxUJudagWqRNPe', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-23 16:53:45', '2020-09-23 16:53:45', NULL, 3),
(5, 'Vanmathi', 'E04@impel.com', '$2y$10$iuP3cxc9vt0b4xEXafKe5efVD66JEdm3joQUMjffN06/5OWTDORJO', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-23 16:54:08', '2020-09-23 16:54:08', NULL, 3),
(6, 'Mohammed', 'E004@impel.com', '$2y$10$JZU.V5OsyWva5ghcD9oCYOE83ng6VlVQqewwdlQxdvr9a96qy3VFe', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-24 07:12:45', '2020-09-24 07:12:45', NULL, 4),
(7, 'Paneer', 'E005@impel.com', '$2y$10$neXTsR0qngBHELMoQbc3Y.FGe2FuyIYo.Cw4NztRUFr4sxGfsC/56', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-24 07:13:19', '2020-09-24 07:13:19', NULL, 4),
(8, 'Loganathan', 'E006@impel.com', '$2y$10$KfFWZtWVLpet38CoJGVIHOpb6gn3/IyPaR.WjdQ0ODg4GzEQT/rxm', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-24 07:14:08', '2020-09-24 07:14:08', NULL, 5),
(9, 'Ramesh', 'E007@impel.com', '$2y$10$HhOKglEg.0zbisk0J1lIQOue2TkrXCtRh23I.Z9jiAAPPSwDHDTn.', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-24 07:14:38', '2020-09-24 07:14:38', NULL, 5),
(10, 'Vignesh', 'E008@impel.com', '$2y$10$selmCYty6euMB8jfetvBz.Lpps3V680h4Dd9qrkhrChSRkfaecRZe', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-24 07:15:49', '2020-09-24 07:15:49', NULL, 6),
(11, 'Vinoth', 'E009@impel.com', '$2y$10$7/6biM//MRjBQKh119eXlOSOw4T9E3XjZwio7KE5YAMzWz3IbxpNS', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-24 07:16:14', '2020-09-24 07:16:14', NULL, 6),
(12, 'Mohan', 'E010@impel.com', '$2y$10$bwpHvBcJuLNi5zJWC7/iquCz4SB1cgJkJVl09On2aoZjBSdlv6DDW', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-24 07:17:54', '2020-09-24 07:17:54', NULL, 7),
(13, 'Ram', 'E011@impel.com', '$2y$10$dFp.WYOlPmyJcnWYM2Zi7.nJU13V/.lInClEYJxXkpHSsgtTgL34K', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-24 07:18:25', '2020-09-24 07:18:25', NULL, 7),
(14, 'sangi', 'sangi@mail.com', '$2y$10$0mupQPjSEEG25dUcpIYRN.k3siqfQseXQ.ytZ0RkgfOo7AZW5ASRG', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2021-02-06 10:12:10', '2021-01-27 10:12:10', '2021-01-27 10:12:10', '2021-01-30 05:30:38', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_tokens`
--
ALTER TABLE `api_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `api_tokens_token_unique` (`token`),
  ADD KEY `api_tokens_user_id_expires_at_index` (`user_id`,`expires_at`);

--
-- Indexes for table `audits`
--
ALTER TABLE `audits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audits_auditable_type_auditable_id_index` (`auditable_type`,`auditable_id`),
  ADD KEY `audits_user_id_user_type_index` (`user_id`,`user_type`);

--
-- Indexes for table `bag`
--
ALTER TABLE `bag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bag_cancel_otp_unique` (`cancel_otp`),
  ADD KEY `bag_parent_bag_id_foreign` (`parent_bag_id`),
  ADD KEY `bag_department_id_foreign` (`department_id`),
  ADD KEY `bag_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `bag_styles`
--
ALTER TABLE `bag_styles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bag_styles_bag_id_foreign` (`bag_id`),
  ADD KEY `bag_styles_style_id_foreign` (`style_id`),
  ADD KEY `bag_styles_upload_id_foreign` (`upload_id`),
  ADD KEY `bag_styles_other_accessories_id_foreign` (`other_accessories_id`),
  ADD KEY `bag_styles_parent_bag_style_id_foreign` (`parent_bag_style_id`);

--
-- Indexes for table `configuration`
--
ALTER TABLE `configuration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `configuration_bag_starting_department_id_foreign` (`bag_starting_department_id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_unit_id_foreign` (`unit_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_department_id_foreign` (`department_id`),
  ADD KEY `employee_user_id_foreign` (`user_id`);

--
-- Indexes for table `employee_process`
--
ALTER TABLE `employee_process`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_process_employee_id_foreign` (`employee_id`),
  ADD KEY `employee_process_process_id_foreign` (`process_id`);

--
-- Indexes for table `gold_inlet`
--
ALTER TABLE `gold_inlet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_created_at_index` (`user_id`,`created_at`);

--
-- Indexes for table `invitations`
--
ALTER TABLE `invitations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invitations_token_unique` (`token`),
  ADD KEY `invitations_team_id_index` (`team_id`),
  ADD KEY `invitations_user_id_index` (`user_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoices_created_at_index` (`created_at`),
  ADD KEY `invoices_user_id_index` (`user_id`),
  ADD KEY `invoices_team_id_index` (`team_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_created_at_index` (`user_id`,`created_at`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `other_accessories`
--
ALTER TABLE `other_accessories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `other_accessories_uom_id_foreign` (`uom_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `performance_indicators`
--
ALTER TABLE `performance_indicators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `performance_indicators_created_at_index` (`created_at`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_slug_unique` (`slug`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_role_permission_id_index` (`permission_id`),
  ADD KEY `permission_role_role_id_index` (`role_id`);

--
-- Indexes for table `permission_user`
--
ALTER TABLE `permission_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_user_permission_id_index` (`permission_id`),
  ADD KEY `permission_user_user_id_index` (`user_id`);

--
-- Indexes for table `process`
--
ALTER TABLE `process`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_product_category_id_foreign` (`product_category_id`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_category_parent_product_category_id_foreign` (`parent_product_category_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_slug_unique` (`slug`);

--
-- Indexes for table `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_user_role_id_index` (`role_id`),
  ADD KEY `role_user_user_id_index` (`user_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD UNIQUE KEY `sessions_id_unique` (`id`);

--
-- Indexes for table `style`
--
ALTER TABLE `style`
  ADD PRIMARY KEY (`id`),
  ADD KEY `style_product_id_foreign` (`product_id`),
  ADD KEY `style_uom_id_foreign` (`uom_id`),
  ADD KEY `style_upload_id_foreign` (`upload_id`);

--
-- Indexes for table `style_department_loss_approval`
--
ALTER TABLE `style_department_loss_approval`
  ADD PRIMARY KEY (`id`),
  ADD KEY `style_department_loss_approval_style_id_foreign` (`style_id`),
  ADD KEY `style_department_loss_approval_department_id_foreign` (`department_id`);

--
-- Indexes for table `style_images`
--
ALTER TABLE `style_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `style_images_upload_id_foreign` (`upload_id`),
  ADD KEY `style_images_style_id_foreign` (`style_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `teams_slug_unique` (`slug`),
  ADD KEY `teams_owner_id_index` (`owner_id`);

--
-- Indexes for table `team_subscriptions`
--
ALTER TABLE `team_subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `team_users`
--
ALTER TABLE `team_users`
  ADD UNIQUE KEY `team_users_team_id_user_id_unique` (`team_id`,`user_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_from_department_id_foreign` (`from_department_id`),
  ADD KEY `transaction_from_employee_id_foreign` (`from_employee_id`),
  ADD KEY `transaction_to_department_id_foreign` (`to_department_id`),
  ADD KEY `transaction_to_employee_id_foreign` (`to_employee_id`),
  ADD KEY `transaction_bag_id_foreign` (`bag_id`),
  ADD KEY `transaction_to_bag_id_foreign` (`to_bag_id`);

--
-- Indexes for table `transaction_item`
--
ALTER TABLE `transaction_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_item_transaction_id_foreign` (`transaction_id`),
  ADD KEY `transaction_item_bag_style_id_foreign` (`bag_style_id`),
  ADD KEY `transaction_item_other_accessories_id_foreign` (`other_accessories_id`),
  ADD KEY `transaction_item_uom_id_foreign` (`uom_id`);

--
-- Indexes for table `transaction_item_loss_details`
--
ALTER TABLE `transaction_item_loss_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_item_loss_details_transaction_item_id_foreign` (`transaction_item_id`),
  ADD KEY `transaction_item_loss_details_transaction_id_foreign` (`transaction_id`),
  ADD KEY `transaction_item_loss_details_user_id_index` (`user_id`),
  ADD KEY `transaction_item_loss_details_bag_style_id_foreign` (`bag_style_id`),
  ADD KEY `transaction_item_loss_details_admin_id_index` (`admin_id`);

--
-- Indexes for table `unit`
--
ALTER TABLE `unit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uom`
--
ALTER TABLE `uom`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uploads`
--
ALTER TABLE `uploads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uploads_random_key_unique` (`random_key`),
  ADD KEY `uploads_random_key_index` (`random_key`),
  ADD KEY `uploads_user_id_index` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_department_id_foreign` (`department_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audits`
--
ALTER TABLE `audits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=801;

--
-- AUTO_INCREMENT for table `bag`
--
ALTER TABLE `bag`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `bag_styles`
--
ALTER TABLE `bag_styles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `configuration`
--
ALTER TABLE `configuration`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `employee_process`
--
ALTER TABLE `employee_process`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `other_accessories`
--
ALTER TABLE `other_accessories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `performance_indicators`
--
ALTER TABLE `performance_indicators`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `permission_user`
--
ALTER TABLE `permission_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `process`
--
ALTER TABLE `process`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `role_user`
--
ALTER TABLE `role_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `style`
--
ALTER TABLE `style`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `style_department_loss_approval`
--
ALTER TABLE `style_department_loss_approval`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `style_images`
--
ALTER TABLE `style_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team_subscriptions`
--
ALTER TABLE `team_subscriptions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT for table `transaction_item`
--
ALTER TABLE `transaction_item`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `transaction_item_loss_details`
--
ALTER TABLE `transaction_item_loss_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `unit`
--
ALTER TABLE `unit`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `uom`
--
ALTER TABLE `uom`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `uploads`
--
ALTER TABLE `uploads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audits`
--
ALTER TABLE `audits`
  ADD CONSTRAINT `audits_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `bag`
--
ALTER TABLE `bag`
  ADD CONSTRAINT `bag_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  ADD CONSTRAINT `bag_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `bag_parent_bag_id_foreign` FOREIGN KEY (`parent_bag_id`) REFERENCES `bag` (`id`);

--
-- Constraints for table `bag_styles`
--
ALTER TABLE `bag_styles`
  ADD CONSTRAINT `bag_styles_bag_id_foreign` FOREIGN KEY (`bag_id`) REFERENCES `bag` (`id`),
  ADD CONSTRAINT `bag_styles_other_accessories_id_foreign` FOREIGN KEY (`other_accessories_id`) REFERENCES `other_accessories` (`id`),
  ADD CONSTRAINT `bag_styles_parent_bag_style_id_foreign` FOREIGN KEY (`parent_bag_style_id`) REFERENCES `bag_styles` (`id`),
  ADD CONSTRAINT `bag_styles_style_id_foreign` FOREIGN KEY (`style_id`) REFERENCES `style` (`id`),
  ADD CONSTRAINT `bag_styles_upload_id_foreign` FOREIGN KEY (`upload_id`) REFERENCES `uploads` (`id`);

--
-- Constraints for table `configuration`
--
ALTER TABLE `configuration`
  ADD CONSTRAINT `configuration_bag_starting_department_id_foreign` FOREIGN KEY (`bag_starting_department_id`) REFERENCES `department` (`id`);

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `department_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`id`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  ADD CONSTRAINT `employee_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `employee_process`
--
ALTER TABLE `employee_process`
  ADD CONSTRAINT `employee_process_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `employee_process_process_id_foreign` FOREIGN KEY (`process_id`) REFERENCES `process` (`id`);

--
-- Constraints for table `other_accessories`
--
ALTER TABLE `other_accessories`
  ADD CONSTRAINT `other_accessories_uom_id_foreign` FOREIGN KEY (`uom_id`) REFERENCES `uom` (`id`);

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `permission_user`
--
ALTER TABLE `permission_user`
  ADD CONSTRAINT `permission_user_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  ADD CONSTRAINT `permission_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_product_category_id_foreign` FOREIGN KEY (`product_category_id`) REFERENCES `product_category` (`id`);

--
-- Constraints for table `product_category`
--
ALTER TABLE `product_category`
  ADD CONSTRAINT `product_category_parent_product_category_id_foreign` FOREIGN KEY (`parent_product_category_id`) REFERENCES `product_category` (`id`);

--
-- Constraints for table `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `style`
--
ALTER TABLE `style`
  ADD CONSTRAINT `style_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `style_uom_id_foreign` FOREIGN KEY (`uom_id`) REFERENCES `uom` (`id`),
  ADD CONSTRAINT `style_upload_id_foreign` FOREIGN KEY (`upload_id`) REFERENCES `uploads` (`id`);

--
-- Constraints for table `style_department_loss_approval`
--
ALTER TABLE `style_department_loss_approval`
  ADD CONSTRAINT `style_department_loss_approval_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  ADD CONSTRAINT `style_department_loss_approval_style_id_foreign` FOREIGN KEY (`style_id`) REFERENCES `style` (`id`);

--
-- Constraints for table `style_images`
--
ALTER TABLE `style_images`
  ADD CONSTRAINT `style_images_style_id_foreign` FOREIGN KEY (`style_id`) REFERENCES `style` (`id`),
  ADD CONSTRAINT `style_images_upload_id_foreign` FOREIGN KEY (`upload_id`) REFERENCES `uploads` (`id`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_bag_id_foreign` FOREIGN KEY (`bag_id`) REFERENCES `bag` (`id`),
  ADD CONSTRAINT `transaction_from_department_id_foreign` FOREIGN KEY (`from_department_id`) REFERENCES `department` (`id`),
  ADD CONSTRAINT `transaction_from_employee_id_foreign` FOREIGN KEY (`from_employee_id`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `transaction_to_bag_id_foreign` FOREIGN KEY (`to_bag_id`) REFERENCES `bag` (`id`),
  ADD CONSTRAINT `transaction_to_department_id_foreign` FOREIGN KEY (`to_department_id`) REFERENCES `department` (`id`),
  ADD CONSTRAINT `transaction_to_employee_id_foreign` FOREIGN KEY (`to_employee_id`) REFERENCES `employee` (`id`);

--
-- Constraints for table `transaction_item`
--
ALTER TABLE `transaction_item`
  ADD CONSTRAINT `transaction_item_bag_style_id_foreign` FOREIGN KEY (`bag_style_id`) REFERENCES `bag_styles` (`id`),
  ADD CONSTRAINT `transaction_item_other_accessories_id_foreign` FOREIGN KEY (`other_accessories_id`) REFERENCES `other_accessories` (`id`),
  ADD CONSTRAINT `transaction_item_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`),
  ADD CONSTRAINT `transaction_item_uom_id_foreign` FOREIGN KEY (`uom_id`) REFERENCES `uom` (`id`);

--
-- Constraints for table `transaction_item_loss_details`
--
ALTER TABLE `transaction_item_loss_details`
  ADD CONSTRAINT `transaction_item_loss_details_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `transaction_item_loss_details_bag_style_id_foreign` FOREIGN KEY (`bag_style_id`) REFERENCES `bag_styles` (`id`),
  ADD CONSTRAINT `transaction_item_loss_details_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`),
  ADD CONSTRAINT `transaction_item_loss_details_transaction_item_id_foreign` FOREIGN KEY (`transaction_item_id`) REFERENCES `transaction_item` (`id`),
  ADD CONSTRAINT `transaction_item_loss_details_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `uploads`
--
ALTER TABLE `uploads`
  ADD CONSTRAINT `uploads_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
