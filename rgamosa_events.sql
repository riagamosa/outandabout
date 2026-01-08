-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 07, 2025 at 04:25 PM
-- Server version: 8.4.7
-- PHP Version: 8.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rgamosa_events`
--

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` smallint NOT NULL,
  `name` varchar(300) COLLATE utf8mb3_unicode_ci NOT NULL,
  `price_type` enum('fixed','range','free','donation') COLLATE utf8mb3_unicode_ci NOT NULL,
  `price_min` decimal(10,2) DEFAULT NULL,
  `price_max` decimal(10,2) DEFAULT NULL,
  `require_reservation` tinyint(1) NOT NULL,
  `location` smallint NOT NULL,
  `time_start` time NOT NULL,
  `time_end` time DEFAULT NULL,
  `date` date NOT NULL,
  `description` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `image` varchar(200) COLLATE utf8mb3_unicode_ci NOT NULL,
  `alt` varchar(535) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `name`, `price_type`, `price_min`, `price_max`, `require_reservation`, `location`, `time_start`, `time_end`, `date`, `description`, `image`, `alt`) VALUES
(1, 'ByWard Rooftop Movie Night', 'fixed', 18.00, 18.00, 1, 8, '20:30:00', '23:00:00', '2026-08-07', 'Watch cult classics and rom-coms under the stars with city skyline views. Cozy beanbads, drinks, and themed snacks available. \r\n', 'rooftop.jpg', 'a group of people sitting in front of a projector screen on the rooftop with hanging lights on them'),
(2, 'Paws in the Park Festival', 'fixed', 10.00, 10.00, 0, 7, '09:00:00', '16:00:00', '2026-08-09', 'A fun outdoor event for dog lovers. A fun way for you and your fur babies connect with the community. Enjoy agility demos, costume contests, pet treat vendors, and live acoustic music.', 'paws.jpg', 'a golden retriever and a shih tzu touching noses on grass '),
(3, 'Capital Eats Street Food Showdown', 'fixed', 15.00, 45.00, 1, 6, '11:00:00', '20:00:00', '2026-07-25', 'Ottawa’s best food trucks go head-to-head for the “Tastiest Bite” crown! Enjoy live music, eating contests, and craft sodas.', 'street_food.jpg', 'a vendor man barbecuing skewers in a night market'),
(4, 'Sunset Groove: Dance by the Canal ', 'range', 20.00, 30.00, 1, 1, '19:00:00', '23:30:00', '2026-07-11', 'A sunset dance party by the water featuring Ottawa DJs mixing house, disco, and summer pop. Light installations and mocktail bar included.', 'sunset_groove.jpg', 'silhouette of two girls dancing during sunset'),
(5, 'Morning Flow on Parliament Hill', 'donation', NULL, NULL, 1, 5, '08:00:00', '09:30:00', '2025-08-10', 'A calm yoga and meditation session in front of Parliament’s iconic skyline. Open to all experience levels. Bring your own mat! ', 'yoga.jpg', 'a girl stretching forward with a group of people doing yoga'),
(6, 'Electric Dead in Concert', 'range', 50.00, 700.00, 1, 3, '21:00:00', '23:50:00', '2026-07-19', 'Triple Grammy-winning Swedish band The Electric Dead will hold just three concerts in Canada; don\'t miss out on this unique opportunity to see one of the hottest acts in the world.', 'outdoor_concert.jpg', 'an outdoor concert with a large crowd facing the stage'),
(7, 'Charity 10K Run', 'donation', NULL, NULL, 1, 2, '09:00:00', NULL, '2026-07-04', 'Set a personal best and contribute to a good cause at the same time. The annual House the Homeless Run features courses for 5, 10 and 20K distances, with a minimum donation set for each.', 'run.jpg', 'overlooking two ladies\' shoulders, watching a group of people run a marathon'),
(8, 'Skate Rideau Canal', 'free', NULL, NULL, 1, 1, '19:30:00', NULL, '2026-07-01', 'Spend the day with friends and family ice skating along the seven kilometer length of the Rideau Canal! This event is entirely free, but you should be prepared to pay for skate rental if you don\'t bring your own. Bring some cash to buy some of the food and hot drinks available from vendors along the route on either side of the canal.', 'canal_skate.jpg', 'view of an ice rink with people skating on it');

-- --------------------------------------------------------

--
-- Table structure for table `eventstags`
--

CREATE TABLE `eventstags` (
  `events_id` smallint NOT NULL,
  `tags_id` smallint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `eventstags`
--

INSERT INTO `eventstags` (`events_id`, `tags_id`) VALUES
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(7, 2),
(8, 2),
(8, 3),
(7, 4),
(6, 5),
(3, 6),
(4, 6),
(6, 6),
(5, 8),
(5, 9),
(4, 10),
(1, 11),
(4, 11),
(6, 11),
(4, 12),
(2, 13),
(8, 13),
(3, 14),
(3, 15),
(2, 16),
(3, 16),
(2, 17),
(2, 18),
(5, 18),
(7, 18),
(2, 19),
(1, 20),
(1, 21),
(1, 22);

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `id` smallint NOT NULL,
  `name` varchar(300) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `name`) VALUES
(1, 'Rideau Canal'),
(2, 'Ottawa City Hall'),
(3, 'TD Place'),
(4, 'Southam Hall, National Arts Centre'),
(5, 'Parliament Hill Lawn'),
(6, 'Lansdowne Park, Aberdeen Square'),
(7, 'Vincent Massey Park'),
(8, 'Andaz Hotel Rooftop Terrace, ByWard Market');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` smallint NOT NULL,
  `name` varchar(60) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`) VALUES
(1, 'outdoors'),
(2, 'exercise'),
(3, 'free'),
(4, 'donation'),
(5, 'concert'),
(6, 'music'),
(7, 'indoors'),
(8, 'yoga'),
(9, 'morning'),
(10, 'nightlife'),
(11, '18+'),
(12, 'dance'),
(13, 'family'),
(14, 'food'),
(15, 'competition'),
(16, 'festival'),
(17, 'pets'),
(18, 'community'),
(19, 'market'),
(20, 'film'),
(21, 'date night'),
(22, 'rooftop');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_events_location` (`location`);

--
-- Indexes for table `eventstags`
--
ALTER TABLE `eventstags`
  ADD PRIMARY KEY (`events_id`,`tags_id`),
  ADD KEY `fk_eventstags_tags_id` (`tags_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `fk_events_location` FOREIGN KEY (`location`) REFERENCES `location` (`id`);

--
-- Constraints for table `eventstags`
--
ALTER TABLE `eventstags`
  ADD CONSTRAINT `fk_eventstags_events_id` FOREIGN KEY (`events_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `fk_eventstags_tags_id` FOREIGN KEY (`tags_id`) REFERENCES `tags` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
