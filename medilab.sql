-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 21, 2023 at 11:39 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medilab`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `phone` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `book_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `booked_for` varchar(100) NOT NULL,
  `dependant_id` int(11) DEFAULT NULL,
  `test_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `where_taken` text NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `latitude` varchar(100) DEFAULT NULL,
  `longitude` varchar(100) DEFAULT NULL,
  `status` text NOT NULL DEFAULT 'Pending',
  `lab_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`book_id`, `member_id`, `booked_for`, `dependant_id`, `test_id`, `appointment_date`, `appointment_time`, `where_taken`, `reg_date`, `latitude`, `longitude`, `status`, `lab_id`, `invoice_no`) VALUES
(1, 1, 'Dependant', 3, 1, '2023-01-08', '10:00:00', 'Home', '2023-06-12 09:34:10', '1.456789', '32.3456789o', 'Pending', 1, '5454545'),
(2, 2, 'Dependant', 2, 1, '2023-01-08', '10:00:00', 'Home', '2023-06-12 09:44:33', '1.456789', '32.3456789o', 'Pending', 2, '5453345'),
(3, 1, 'Dependant', 2, 1, '2023-01-08', '10:00:00', 'Home', '2023-06-19 08:05:35', '1.456789', '32.3456789o', 'Pending', 2, '5453345');

-- --------------------------------------------------------

--
-- Table structure for table `dependants`
--

CREATE TABLE `dependants` (
  `dependant_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `surname` text NOT NULL,
  `others` text NOT NULL,
  `dob` date NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dependants`
--

INSERT INTO `dependants` (`dependant_id`, `member_id`, `surname`, `others`, `dob`, `reg_date`) VALUES
(1, 2, 'Paul', 'kimani', '2010-09-04', '2023-06-08 07:48:18'),
(2, 2, 'John', 'kimani', '2013-07-09', '2023-06-08 07:50:46'),
(3, 1, 'Garvin', 'Mukusa', '2023-02-02', '2023-06-08 07:52:11'),
(4, 2, 'Grace', 'Nyokabi', '2022-01-09', '2023-06-08 07:53:04'),
(5, 1, 'Bravin', 'Kabi', '2022-04-09', '2023-06-19 08:04:01');

-- --------------------------------------------------------

--
-- Table structure for table `laboratories`
--

CREATE TABLE `laboratories` (
  `lab_id` int(11) NOT NULL,
  `lab_name` text NOT NULL,
  `permit_id` varchar(100) DEFAULT NULL,
  `email` varchar(200) NOT NULL,
  `phone` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `role` text NOT NULL DEFAULT 'admin',
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `laboratories`
--

INSERT INTO `laboratories` (`lab_id`, `lab_name`, `permit_id`, `email`, `phone`, `password`, `role`, `reg_date`) VALUES
(1, 'Lancet Kenya', '452854112', 'lancet@gmail.com', '07152431321', '123456', 'admin', '2023-05-31 08:07:58'),
(2, 'Medpath', '65514d', 'medp@gmail.com', '+254722665544', '123456', 'admin', '2023-06-12 07:49:21'),
(3, 'Tunza Kenya', '125457', 'tunzakenya@gmail.com', 'gAAAAABkirpoQXOOOCKa7t9YBVkMgVkjV4F4s4eEwIG1DT5O3aQNGU9pIaudcb7c3UCK7IEn7sqVbpQau-2aPWQuOvrT8SW-vA==', '$2b$12$0s/UDSfjndoVrQasbHdWQOnW.Gp5iF4PT555firUk4ZyKrkXvlTLW', 'admin', '2023-06-15 07:14:48');

-- --------------------------------------------------------

--
-- Table structure for table `lab_tests`
--

CREATE TABLE `lab_tests` (
  `test_id` int(11) NOT NULL,
  `lab_id` int(11) NOT NULL,
  `test_name` text NOT NULL,
  `test_description` text NOT NULL,
  `test_cost` int(11) NOT NULL,
  `test_discount` int(11) NOT NULL,
  `availability` text NOT NULL,
  `more_info` varchar(100) DEFAULT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lab_tests`
--

INSERT INTO `lab_tests` (`test_id`, `lab_id`, `test_name`, `test_description`, `test_cost`, `test_discount`, `availability`, `more_info`, `reg_date`) VALUES
(1, 1, 'Covid-19', 'take once a day', 5000, 500, '', NULL, '2023-06-12 06:49:47'),
(2, 1, 'Test X', 'This is a test example', 2700, 200, '', NULL, '2023-06-12 06:51:27'),
(3, 2, 'Test X', 'This is an example test', 2800, 100, '', NULL, '2023-06-12 07:18:47'),
(4, 2, 'Full Metabolic Test', 'This is a nice test', 500, 39, 'Available', 'N/A', '2023-06-15 09:16:43'),
(5, 1, 'Full Metabolic Test', 'This is a nice test', 530, 9, 'Available', 'N/A', '2023-06-15 09:17:38');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL,
  `location` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`location_id`, `location`) VALUES
(1, 'Nairobi'),
(2, 'Nakuru');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `member_id` int(11) NOT NULL,
  `surname` text NOT NULL,
  `others` text NOT NULL,
  `gender` text NOT NULL,
  `email` varchar(200) NOT NULL,
  `phone` varchar(200) NOT NULL,
  `dob` date NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `password` varchar(200) NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`member_id`, `surname`, `others`, `gender`, `email`, `phone`, `dob`, `status`, `password`, `reg_date`, `location_id`) VALUES
(1, 'Wayne', 'Mukusa', 'Male', 'gAAAAABkgDmcNXooEhnASdha2nxZ_oZm2tquiyWy8EzK649uf4cYMgHUXlJVlFxh-0lkHZW7WFYX8GEokdPdZiqY39DzdEgfVw==', 'gAAAAABkgDmc5r1DVIRw5hnumDSDNqEjcYnD2dT0KXfnRDfSTx3PKtwzQea6uhCaBR-NqSaR3GfkMcz0ForiGA30Gfl3ai3BoQ==', '2008-08-05', 1, '$2b$12$HyDuKtV73lG/5uycsSXHoegcXhLMz4.KXn6qqDUhoK9xV6NMUgNH2', '2023-06-07 08:16:10', 1),
(2, 'Jane', 'Wanjiku', 'Female', 'gAAAAABkgD34f2kznQtIeYMPo-PTuFu780oAJ4Ipf4_tco8AEmRXiSc29ERNY_glC0OlRktfVR-r6uFJ9mJMbaM-o1SXSTnNUA==', 'gAAAAABkgD343_eljHkI842Z0NqAcBqvt2qQZ_vDwqMHhEaoHeMtT3mZmSUM9lp5R9I_qeByZZggvSyK4E7INx7Y_FYd04uUSw==', '2008-08-05', 1, '$2b$12$E4/xxtvpMR9rKCIcR82/iOitiZptR3eB35bzGLVnzPc6WRWdcaJV6', '2023-06-07 08:21:12', 1);

-- --------------------------------------------------------

--
-- Table structure for table `nurses`
--

CREATE TABLE `nurses` (
  `nurse_id` int(11) NOT NULL,
  `surname` text NOT NULL,
  `others` text NOT NULL,
  `lab_id` int(11) NOT NULL,
  `gender` text NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `email` varchar(200) NOT NULL,
  `phone` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nurses`
--

INSERT INTO `nurses` (`nurse_id`, `surname`, `others`, `lab_id`, `gender`, `reg_date`, `email`, `phone`, `password`) VALUES
(1, 'Shirlin', 'Wanjiru', 1, 'Female', '2023-06-19 08:52:23', 'gAAAAABkkBdHMEYR0B0qd4PHb5uhUBN-uMwmY7OzFth2CZzv4MwA--K3_GcgctDG7G2yc8gJdBEblpP_dQVbQpr15zJEcd_ncjOpmKsX2yGB6pHAFZXUv-M=', '+254745474526', '$2b$12$jAimLQtwaiT.U.RrFJLwHuBlLDtF8zA4n8Ngi//HhYXx/wFyMgw3e');

-- --------------------------------------------------------

--
-- Table structure for table `nurse_lab_allocations`
--

CREATE TABLE `nurse_lab_allocations` (
  `allocation_id` int(11) NOT NULL,
  `nurse_id` int(11) NOT NULL,
  `invoice_no` int(11) NOT NULL,
  `flag` varchar(50) NOT NULL DEFAULT 'active',
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nurse_lab_allocations`
--

INSERT INTO `nurse_lab_allocations` (`allocation_id`, `nurse_id`, `invoice_no`, `flag`, `reg_date`) VALUES
(1, 1, 5454545, 'active', '2023-06-20 08:08:11');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `total_amount` int(11) NOT NULL,
  `reg_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`book_id`),
  ADD KEY `bookings_fk0` (`member_id`),
  ADD KEY `bookings_fk1` (`dependant_id`),
  ADD KEY `bookings_fk2` (`test_id`),
  ADD KEY `bookings_fk3` (`lab_id`);

--
-- Indexes for table `dependants`
--
ALTER TABLE `dependants`
  ADD PRIMARY KEY (`dependant_id`),
  ADD KEY `dependants_fk0` (`member_id`);

--
-- Indexes for table `laboratories`
--
ALTER TABLE `laboratories`
  ADD PRIMARY KEY (`lab_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `lab_tests`
--
ALTER TABLE `lab_tests`
  ADD PRIMARY KEY (`test_id`),
  ADD KEY `lab_tests_fk0` (`lab_id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`member_id`),
  ADD KEY `members_fk0` (`location_id`);

--
-- Indexes for table `nurses`
--
ALTER TABLE `nurses`
  ADD PRIMARY KEY (`nurse_id`),
  ADD UNIQUE KEY `lab_id` (`lab_id`),
  ADD UNIQUE KEY `surname` (`surname`) USING HASH;

--
-- Indexes for table `nurse_lab_allocations`
--
ALTER TABLE `nurse_lab_allocations`
  ADD PRIMARY KEY (`allocation_id`),
  ADD UNIQUE KEY `nurse_id` (`nurse_id`,`invoice_no`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dependants`
--
ALTER TABLE `dependants`
  MODIFY `dependant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `laboratories`
--
ALTER TABLE `laboratories`
  MODIFY `lab_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lab_tests`
--
ALTER TABLE `lab_tests`
  MODIFY `test_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `member_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `nurses`
--
ALTER TABLE `nurses`
  MODIFY `nurse_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `nurse_lab_allocations`
--
ALTER TABLE `nurse_lab_allocations`
  MODIFY `allocation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_fk0` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`),
  ADD CONSTRAINT `bookings_fk1` FOREIGN KEY (`dependant_id`) REFERENCES `dependants` (`dependant_id`),
  ADD CONSTRAINT `bookings_fk2` FOREIGN KEY (`test_id`) REFERENCES `lab_tests` (`test_id`),
  ADD CONSTRAINT `bookings_fk3` FOREIGN KEY (`lab_id`) REFERENCES `laboratories` (`lab_id`);

--
-- Constraints for table `dependants`
--
ALTER TABLE `dependants`
  ADD CONSTRAINT `dependants_fk0` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`);

--
-- Constraints for table `lab_tests`
--
ALTER TABLE `lab_tests`
  ADD CONSTRAINT `lab_tests_fk0` FOREIGN KEY (`lab_id`) REFERENCES `laboratories` (`lab_id`);

--
-- Constraints for table `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `members_fk0` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
