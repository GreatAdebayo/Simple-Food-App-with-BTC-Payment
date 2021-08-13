-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 13, 2021 at 06:57 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `block`
--

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `code` varchar(256) NOT NULL,
  `address` varchar(256) NOT NULL,
  `price` double NOT NULL,
  `status` int(11) NOT NULL,
  `product` varchar(256) NOT NULL,
  `ip` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`id`, `code`, `address`, `price`, `status`, `product`, `ip`) VALUES
(30, 'Ma6aRcASwLE5CwaS41RjAM0GV', '1DtUVGkpPFwJapamtrEX5A9Sij9VXjhTYT', 50, -1, 'rice', '::1'),
(31, '46PvC9t7rYoNDUynQU0UQFMEO', '1EX5grV1kknXregh1V1ph163Tc5KfBiot5', 50, 2, 'rice', '::1'),
(32, '2obib9HkLeHbf5fk3iJkrRvE6', '18CEYx8GJkGKDWnxAfA1k4JxR1pkVmZaf4', 20, -1, 'burger', '::1'),
(33, 'EwxpQUvs2gl1UYO2YubptWzBL', '13L4t7N8twKDcP6XVioai7MzbfpMyZcqk5', 50, 2, 'rice', '::1'),
(34, '7Tb29rlw48tpgMun7fhxUTyhl', '1FqXhLp8tRLXaJcGMcKFRCV5xbZp44MrPo', 20, 2, 'burger', '::1'),
(35, 'b96NrTZA5X1GtrGwzs0RIb3tg', '12takFiTBPjyeKUXR4W7WmSRdarHpJ4ssd', 50, 2, 'rice', '::1'),
(36, 'NGXzdDVjlOdBcr4U7jRm9SV6v', '1EkMUFUnD87aW44F2MzQfvr4jnrsZ3vwNL', 50, 2, 'rice', '::1'),
(37, 'W664FUU1CgTQQc0PHzmtdHatY', '1GMpp4U57HScNXi7CEzVVn8pDhfrzVeHv8', 20, 1, 'burger', '::1'),
(38, 'OYRBRo8g2pN8Q0Nf3zc2qo7tk', '13aB1M8sGVky39uZT9GRr5ksMa2UYDzcg7', 20, -1, 'burger', '::1'),
(39, 'YEztEFgBtWvnpuvw62fKa3MTs', '1KuqGiWjQ6kdjZY7U3cfHJWRUCRaSSFuUP', 50, 1, 'rice', '::1'),
(40, '1t6tpdt1o8NPW50fg8oezut8J', '17WvVqaAotgzjepJqduSNPWiw9F2SEYrbb', 20, 2, 'burger', '::1');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `txid` varchar(256) NOT NULL,
  `addr` varchar(256) NOT NULL,
  `value` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `txid`, `addr`, `value`, `status`) VALUES
(24, 'WarningThisIsAGeneratedTestPaymentAndNotARealBitcoinTransaction', '1EX5grV1kknXregh1V1ph163Tc5KfBiot5', 107675, 2),
(25, 'WarningThisIsAGeneratedTestPaymentAndNotARealBitcoinTransaction', '18CEYx8GJkGKDWnxAfA1k4JxR1pkVmZaf4', 43091, 2),
(26, 'WarningThisIsAGeneratedTestPaymentAndNotARealBitcoinTransaction', '13L4t7N8twKDcP6XVioai7MzbfpMyZcqk5', 108173, 0),
(27, 'WarningThisIsAGeneratedTestPaymentAndNotARealBitcoinTransaction', '13L4t7N8twKDcP6XVioai7MzbfpMyZcqk5', 108173, 2),
(28, 'WarningThisIsAGeneratedTestPaymentAndNotARealBitcoinTransaction', '1FqXhLp8tRLXaJcGMcKFRCV5xbZp44MrPo', 43265, 2),
(29, 'WarningThisIsAGeneratedTestPaymentAndNotARealBitcoinTransaction', '12takFiTBPjyeKUXR4W7WmSRdarHpJ4ssd', 108162, 0),
(30, 'WarningThisIsAGeneratedTestPaymentAndNotARealBitcoinTransaction', '1EkMUFUnD87aW44F2MzQfvr4jnrsZ3vwNL', 107864, 2),
(31, 'WarningThisIsAGeneratedTestPaymentAndNotARealBitcoinTransaction', '1GMpp4U57HScNXi7CEzVVn8pDhfrzVeHv8', 43146, 1),
(32, 'WarningThisIsAGeneratedTestPaymentAndNotARealBitcoinTransaction', '1KuqGiWjQ6kdjZY7U3cfHJWRUCRaSSFuUP', 107733, 1),
(33, 'WarningThisIsAGeneratedTestPaymentAndNotARealBitcoinTransaction', '17WvVqaAotgzjepJqduSNPWiw9F2SEYrbb', 43093, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
