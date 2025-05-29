-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 28, 2025 at 01:40 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `groupchat`
--

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `id` int(11) NOT NULL,
  `sender` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `chat_time` time DEFAULT curtime(),
  `image_url` varchar(255) DEFAULT NULL,
  `reply_to` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`id`, `sender`, `message`, `time`, `chat_time`, `image_url`, `reply_to`) VALUES
(1, 'areen', 'test at4:22pm', '2025-05-23 10:52:11', '17:30:02', NULL, NULL),
(2, 'areen', 'hi', '2025-05-23 10:52:34', '17:30:02', NULL, NULL),
(3, 'areen', 'hello', '2025-05-23 10:52:43', '17:30:02', NULL, NULL),
(4, 'rishu', 'test at 4:23', '2025-05-23 10:53:36', '17:30:02', NULL, NULL),
(5, 'rishu', 'RISHU', '2025-05-23 10:53:42', '17:30:02', NULL, NULL),
(6, 'rishu', 'hi', '2025-05-23 10:56:40', '17:30:02', NULL, NULL),
(7, 'rishu', 'snfkjsnsjd', '2025-05-23 11:02:29', '17:30:02', NULL, NULL),
(8, 'areen', 'kjdzkjdslkdsl', '2025-05-23 11:02:52', '17:30:02', NULL, NULL),
(9, 'areen', 'kjdzkjdslkdsl', '2025-05-23 11:03:23', '17:30:02', NULL, NULL),
(10, 'areen', '4:35', '2025-05-23 11:05:14', '17:30:02', NULL, NULL),
(11, 'areen', '4.35 part2', '2025-05-23 11:05:48', '17:30:02', NULL, NULL),
(12, 'areen', 'again', '2025-05-23 11:05:57', '17:30:02', NULL, NULL),
(13, 'areen', 'new test 4.42', '2025-05-23 11:12:18', '17:30:02', NULL, NULL),
(14, 'areen', 'hi', '2025-05-23 11:12:24', '17:30:02', NULL, NULL),
(15, 'areen', 'byee', '2025-05-23 11:12:31', '17:30:02', NULL, NULL),
(16, 'rishu', 'test at 4.46', '2025-05-23 11:16:10', '17:30:02', NULL, NULL),
(17, 'Areen ', 'hello', '2025-05-23 22:13:48', '03:43:48', NULL, NULL),
(18, 'Areen ', 'hi', '2025-05-23 22:14:38', '03:44:38', NULL, NULL),
(19, 'Areen ', 'ghgchg', '2025-05-23 22:15:14', '03:45:14', NULL, NULL),
(20, 'Areen ', 'hi', '2025-05-23 22:19:41', '03:49:41', NULL, NULL),
(21, 'Areen ', 'test 3:51am', '2025-05-23 22:21:37', '03:51:37', NULL, NULL),
(22, 'Areen ', 'tets 3:53am', '2025-05-23 22:22:43', '03:52:43', NULL, NULL),
(23, 'Areen ', 'hi', '2025-05-23 22:23:43', '03:53:43', NULL, NULL),
(24, 'Areen Vishwakarma', 'Hiii', '2025-05-26 10:05:09', '15:35:09', NULL, NULL),
(25, 'Areen Vishwakarma', 'test msg 3.38', '2025-05-26 10:08:11', '15:38:11', NULL, NULL),
(26, 'Rishu ', 'rishu test msg', '2025-05-26 10:08:59', '15:38:59', NULL, NULL),
(27, 'Rishu ', 'hello', '2025-05-26 10:17:58', '15:47:58', NULL, NULL),
(28, 'Rishu ', 'hi', '2025-05-26 10:24:04', '15:54:04', NULL, NULL),
(29, 'Rishu ', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', '2025-05-26 12:45:16', '18:15:16', NULL, NULL),
(30, 'Rishu ', 'Hello Sab kaise hai', '2025-05-26 12:55:09', '18:25:09', NULL, NULL),
(31, 'areen', 'bkjbkjbk', '2025-05-26 21:40:03', '03:10:03', NULL, NULL),
(32, 'areen', 'refresh test', '2025-05-26 22:01:01', '03:31:01', NULL, NULL),
(33, 'Areen Vishwakarma', 'hi', '2025-05-26 22:18:11', '03:48:11', NULL, NULL),
(34, 'Areen Vishwakarma', 'this is my personal WhatsApp grp', '2025-05-26 22:19:12', '03:49:12', NULL, NULL),
(35, 'Areen Vishwakarma', 'made by me        I wrote the code of it', '2025-05-26 22:19:36', '03:49:36', NULL, NULL),
(36, 'Areen Vishwakarma', 'areenwish.mum@gmail.com', '2025-05-26 22:26:07', '03:56:07', NULL, NULL),
(37, 'Rishu Vishwakarma', 'test run', '2025-05-26 22:32:29', '04:02:29', NULL, NULL),
(38, 'Rishu', 'hi', '2025-05-26 23:18:49', '04:48:49', NULL, NULL),
(39, 'Rishu', '3.15 test', '2025-05-27 09:45:14', '15:15:14', NULL, NULL),
(40, 'Areen Vishwakarma', 'hiii test message ', '2025-05-27 10:01:04', '15:31:04', NULL, NULL),
(41, 'Rishu', 'test message form RISHU', '2025-05-27 10:01:23', '15:31:23', NULL, NULL),
(42, 'Areen Vishwakarma', 'hello', '2025-05-27 10:04:40', '15:34:40', NULL, NULL),
(43, 'Areen Vishwakarma', 'byeee', '2025-05-27 10:04:52', '15:34:52', NULL, NULL),
(44, 'Rishu', 'isisnlns', '2025-05-27 10:04:57', '15:34:57', NULL, NULL),
(45, 'Areen Vishwakarma', 'hello', '2025-05-27 10:11:14', '15:41:14', NULL, NULL),
(46, 'Rishu', 'reload test', '2025-05-27 10:11:23', '15:41:23', NULL, NULL),
(47, 'Rishu', 'sddvkjdfnv', '2025-05-27 10:11:36', '15:41:36', NULL, NULL),
(48, 'Areen Vishwakarma', 'oufknf', '2025-05-27 10:11:39', '15:41:39', NULL, NULL),
(49, 'Areen Vishwakarma', 'hi', '2025-05-27 10:30:15', '16:00:15', NULL, NULL),
(50, 'Rishu', 'yoyoyoyoyo', '2025-05-27 10:34:36', '16:04:36', NULL, NULL),
(51, 'Areen Vishwakarma', 'hihihihihih', '2025-05-27 10:34:47', '16:04:47', NULL, NULL),
(52, 'Areen Vishwakarma', 'hehehhehehe', '2025-05-27 10:45:59', '16:15:59', NULL, NULL),
(53, 'Rishu', 'hohohohohoho', '2025-05-27 10:46:07', '16:16:07', NULL, NULL),
(54, 'Areen Vishwakarma', 'ghgchg', '2025-05-27 11:11:22', '16:41:22', NULL, NULL),
(55, 'Areen Vishwakarma', 'hi', '2025-05-27 11:50:33', '17:20:33', NULL, NULL),
(56, 'Rishu', 'jebfj', '2025-05-27 11:51:07', '17:21:07', NULL, NULL),
(57, 'Areen Vishwakarma', 'hehehehe', '2025-05-27 11:51:19', '17:21:19', NULL, NULL),
(58, 'Rishu', 'hihihihhi', '2025-05-27 11:51:35', '17:21:35', NULL, NULL),
(59, 'Areen Vishwakarma', 'hi', '2025-05-27 11:55:09', '17:25:09', NULL, NULL),
(60, 'Areen Vishwakarma', 'jncjnddnckjdnlanvljsdnv', '2025-05-27 11:57:13', '17:27:13', NULL, NULL),
(61, 'Rishu', 'jkbvkdbkjd', '2025-05-27 11:57:16', '17:27:16', NULL, NULL),
(62, 'Areen Vishwakarma', 'knclsncl', '2025-05-27 11:57:30', '17:27:30', NULL, NULL),
(63, 'Rishu', 'j', '2025-05-27 11:57:33', '17:27:33', NULL, NULL),
(64, 'Areen Vishwakarma', 'hi', '2025-05-27 14:27:38', '19:57:38', NULL, NULL),
(65, 'Areen Vishwakarma', 'esha pagal hai', '2025-05-27 14:30:38', '20:00:38', NULL, NULL),
(66, 'Areen Vishwakarma', 'hiiiiii', '2025-05-27 14:33:28', '20:03:28', NULL, NULL),
(67, 'Rishu', 'yoooooo', '2025-05-27 14:33:42', '20:03:42', NULL, NULL),
(68, 'Areen Vishwakarma', 'hiiiiiiiiiii', '2025-05-27 14:34:04', '20:04:04', NULL, NULL),
(69, 'mummy', 'hiiiiiiii', '2025-05-27 14:35:28', '20:05:28', NULL, NULL),
(70, 'Areen Vishwakarma', 'yoyo', '2025-05-28 09:56:04', '15:26:04', NULL, NULL),
(71, 'Rishu', 'yoyo', '2025-05-28 09:57:20', '15:27:20', NULL, NULL),
(72, 'Areen Vishwakarma', 'Hii', '2025-05-28 10:02:51', '15:32:51', NULL, NULL),
(73, 'Areen Vishwakarma', 'hello', '2025-05-28 10:04:15', '15:34:15', NULL, NULL),
(74, 'Areen Vishwakarma', 'Hello', '2025-05-28 10:05:01', '15:35:01', NULL, NULL),
(75, 'Rishu', 'hii', '2025-05-28 10:05:08', '15:35:08', NULL, NULL),
(76, 'Areen Vishwakarma', 'Helo', '2025-05-28 10:05:18', '15:35:18', NULL, NULL),
(77, 'Rishu', 'How are you', '2025-05-28 10:05:23', '15:35:23', NULL, NULL),
(78, 'Areen Vishwakarma', 'Hello', '2025-05-28 10:06:53', '15:36:53', NULL, NULL),
(79, 'Rishu', 'Hii', '2025-05-28 10:07:00', '15:37:00', NULL, NULL),
(80, 'Areen Vishwakarma', 'Hello', '2025-05-28 10:10:15', '15:40:15', NULL, NULL),
(81, 'Rishu', 'Hii', '2025-05-28 10:10:19', '15:40:19', NULL, NULL),
(82, 'Rishu', 'Hii how are you', '2025-05-28 10:10:28', '15:40:28', NULL, NULL),
(83, 'Areen Vishwakarma', 'Hello', '2025-05-28 10:12:01', '15:42:01', NULL, NULL),
(84, 'Areen Vishwakarma', 'Hii', '2025-05-28 10:12:16', '15:42:16', NULL, NULL),
(85, 'Areen Vishwakarma', 'Hello', '2025-05-28 10:14:02', '15:44:02', NULL, NULL),
(86, 'Areen Vishwakarma', 'Hello', '2025-05-28 10:18:40', '15:48:40', NULL, NULL),
(87, 'Rishu', 'Hiii', '2025-05-28 10:18:46', '15:48:46', NULL, NULL),
(88, 'Areen Vishwakarma', 'jasjas', '2025-05-28 10:23:28', '15:53:28', NULL, NULL),
(89, 'Areen Vishwakarma', 'hii', '2025-05-28 10:23:58', '15:53:58', NULL, NULL),
(90, 'Areen Vishwakarma', 'Hii', '2025-05-28 10:24:08', '15:54:08', NULL, NULL),
(91, 'Rishu', 'Whats Going on', '2025-05-28 10:24:16', '15:54:16', NULL, NULL),
(92, 'Areen Vishwakarma', 'How are you? Kaisa hai tu?', '2025-05-28 10:24:53', '15:54:53', NULL, NULL),
(93, 'Rishu', 'Bas mast bhai', '2025-05-28 10:24:58', '15:54:58', NULL, NULL),
(94, 'Rishu', 'Tu apna bata?', '2025-05-28 10:25:02', '15:55:02', NULL, NULL),
(95, 'Areen Vishwakarma', 'Bas chal rahi hai zindagi', '2025-05-28 10:25:09', '15:55:09', NULL, NULL),
(96, 'esha', 'hi esha here', '2025-05-28 10:28:56', '15:58:56', NULL, NULL),
(97, 'Rishu', 'hello rishu here', '2025-05-28 10:29:09', '15:59:09', NULL, NULL),
(98, 'Areen Vishwakarma', 'yo AReen this side', '2025-05-28 10:29:17', '15:59:17', NULL, NULL),
(99, 'Areen Vishwakarma', 'img', '2025-05-28 10:50:48', '16:20:48', NULL, NULL),
(100, 'Areen Vishwakarma', 'hi', '2025-05-28 10:53:24', '16:23:24', NULL, NULL),
(101, 'Areen Vishwakarma', '', '2025-05-28 11:02:06', '16:32:06', 'uploaded_images/1748430126452_13.jpg', NULL),
(102, 'Areen Vishwakarma', '', '2025-05-28 11:02:53', '16:32:53', 'uploaded_images/1748430173755_15.jpg', NULL),
(103, 'Areen Vishwakarma', '', '2025-05-28 11:09:42', '16:39:42', 'uploaded_images/1748430582749_13.jpg', NULL),
(104, 'Areen Vishwakarma', 'hello', '2025-05-28 11:29:44', '16:59:44', NULL, 98),
(105, 'Areen Vishwakarma', 'nice img', '2025-05-28 11:31:30', '17:01:30', NULL, 103),
(106, 'Rishu', 'thank you', '2025-05-28 11:31:41', '17:01:41', NULL, 105),
(107, 'Areen Vishwakarma', 'Hello', '2025-05-28 11:32:17', '17:02:17', NULL, NULL),
(108, 'Rishu', 'Me Badhiya ', '2025-05-28 11:32:28', '17:02:28', NULL, 107),
(109, 'Rishu', 'thank you', '2025-05-28 11:33:21', '17:03:21', NULL, NULL),
(110, 'Areen Vishwakarma', 'Hello', '2025-05-28 11:36:18', '17:06:18', NULL, 108);

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`name`, `email`, `password`) VALUES
('Areen Vishwakarma', 'areenwish.mum@gmail.com', 'areen123'),
('Rishu Vishwakarma', 'rishuwish.mum@gmail.com', 'rishu123'),
('Areen Vishwakarma', 'rishuwish.mum@gmail.com', 'areen123ll'),
('mummy', 'mummywish.mum@gmail.com', 'mummy'),
('esha', 'esha@gmail.com', 'esha123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
