-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Dec 13, 2024 at 08:23 AM
-- Server version: 9.1.0
-- PHP Version: 8.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mysql_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`) VALUES
(1, 1),
(2, 2),
(3, 9);

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` int NOT NULL,
  `cart_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `state_id` int NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `state_id`, `date_created`, `date_updated`) VALUES
(1, 9, 1, '2024-12-07 21:49:24', '2024-12-07 21:49:24'),
(2, 9, 1, '2024-12-07 21:53:28', '2024-12-07 21:53:28'),
(3, 9, 1, '2024-12-07 21:54:11', '2024-12-07 21:54:11'),
(4, 9, 1, '2024-12-08 12:31:34', '2024-12-08 12:31:34'),
(5, 9, 1, '2024-12-08 12:34:00', '2024-12-08 12:34:00'),
(6, 9, 1, '2024-12-08 12:46:52', '2024-12-08 12:46:52'),
(7, 9, 1, '2024-12-08 12:53:27', '2024-12-08 12:53:27'),
(8, 9, 1, '2024-12-08 12:54:34', '2024-12-08 12:54:34'),
(9, 9, 1, '2024-12-08 13:11:14', '2024-12-08 13:11:14'),
(10, 9, 1, '2024-12-08 13:50:32', '2024-12-08 13:50:32'),
(11, 9, 1, '2024-12-08 14:42:18', '2024-12-08 14:42:18'),
(12, 1, 1, '2024-12-08 15:18:34', '2024-12-08 15:18:34');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `item_id`, `quantity`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 3, 1),
(4, 2, 2, 1),
(5, 2, 3, 1),
(6, 3, 1, 1),
(7, 3, 2, 1),
(8, 3, 3, 1),
(9, 4, 1, 2),
(10, 4, 2, 1),
(11, 4, 3, 1),
(12, 4, 4, 1),
(13, 4, 5, 1),
(14, 4, 6, 1),
(15, 4, 7, 1),
(16, 4, 8, 1),
(17, 4, 9, 1),
(18, 4, 10, 2),
(19, 5, 1, 1),
(20, 5, 2, 1),
(21, 5, 3, 1),
(22, 6, 2, 1),
(23, 6, 3, 1),
(24, 7, 2, 1),
(25, 8, 1, 1),
(26, 8, 2, 1),
(27, 8, 3, 1),
(28, 8, 4, 1),
(29, 8, 5, 1),
(30, 9, 1, 1),
(31, 9, 2, 1),
(32, 9, 3, 8),
(33, 10, 1, 1),
(34, 10, 2, 1),
(35, 10, 3, 1),
(36, 11, 1, 1),
(37, 11, 2, 1),
(38, 11, 3, 6),
(39, 12, 1, 1),
(40, 12, 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `order_state`
--

CREATE TABLE `order_state` (
  `id` int NOT NULL,
  `state` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_state`
--

INSERT INTO `order_state` (`id`, `state`) VALUES
(1, 'Sukurtas');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `image_url`, `price`) VALUES
(1, 'Nešiojamas kompiuteris', 'Nešiojamas kompiuteris yra lengvas, turi ilgai laikančią bateriją, ir pakankamai greitą procesoriu sklandžiam naudojimui.', 'laptop', 999.99),
(2, 'Stacionarus kompiuteris', 'Stacionarus kompiuteris skirtas didelio pajėgumo reikalaujančiu programu vartojimui, turi greitą procesoriu, daug operatyvios atminties.', 'desktop', 1999.99),
(3, 'Monitorius', 'Monitorius turi aukštą raišką, galingą švietimą, ir tiksliai atvaizduoja spalvas.', 'monitor', 129.99),
(4, 'Pelė', 'Pelė prijungiama laidu, turi 2 mygtukus ir ratuką.', 'mouse', 10.99),
(5, 'Klaviatūra', 'Klaviatūra turi lietuviškas raides, funkcinius klavišus, ir skaičiavimo klavišus.', 'keyboard', 22.99),
(6, 'Planšetinis kompiuteris', 'Planšetinis kompiuteris yra lengvas, plonas, turi dideli ekraną ir greitai veikia.', 'tablet', 459.99),
(7, 'Išmanusis telefonas', 'Išmanusis telefonas yra greitas, turi ilgai laikančią bateriją, palaiko 5G ryšį.', 'smartphone', 359),
(8, 'Spausdintuvas', 'Spausdintuvas yra lazerinis, spausdina greitai ir aukšta raiška.', 'printer', 105.99),
(9, 'Ausinės', 'Ausinės yra aukštos kokybės, tiksliai atkartoją garso įrašus.', 'headphones', 30.99),
(10, 'Kolonėlės', 'Kolonėlės yra mažos, bet galingos, puikiai skirtos naudojimui ant stalo su kompiuteriu.', 'speakers', 52.99);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `password`) VALUES
(1, 'a', 'a'),
(2, 'ab', 'ab'),
(4, 'abc', 'ab'),
(5, 'abcd', 'ab'),
(6, 'asdasd', 'ab'),
(7, 'abasdas', 'a'),
(8, 'asdasdas', 'a'),
(9, 'aa', 'aa');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `fk_cart_id` (`cart_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `order_state`
--
ALTER TABLE `order_state`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `state` (`state`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=321;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `order_state`
--
ALTER TABLE `order_state`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `fk_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`state_id`) REFERENCES `order_state` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
