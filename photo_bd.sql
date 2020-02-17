-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-02-2020 a las 16:34:36
-- Versión del servidor: 10.1.34-MariaDB
-- Versión de PHP: 7.0.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `abogado_db`
--
CREATE DATABASE IF NOT EXISTS `abogado_db` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `abogado_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customers`
--

CREATE TABLE `customers` (
  `idcustomers` int(11) NOT NULL,
  `identification` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `name` varchar(145) COLLATE utf8_spanish_ci DEFAULT NULL,
  `lastname` varchar(145) COLLATE utf8_spanish_ci DEFAULT NULL,
  `phonenumber` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `address` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `address2` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `votingstation` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `email` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `city` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `neighborhood` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `state` enum('ACTIVO','ELIMINADO') COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `customers`
--

INSERT INTO `customers` (`idcustomers`, `identification`, `name`, `lastname`, `phonenumber`, `address`, `address2`, `votingstation`, `email`, `city`, `neighborhood`, `create_at`, `state`) VALUES
(3, '1045698783', 'Jeffer', 'Ariza', '3006380300', 'Calle 45', NULL, 'Colegio san jose', 'jefferaroiza@outlook.com', 'Santa Marta', 'La loma', '2018-05-07 16:00:45', 'ACTIVO'),
(4, '72133028', 'william', 'ariza', '3340376', 'calle 46', NULL, 'colegio las 22', 'william@fgj.com', 'barranquuilla', 'la victortia', '2018-05-07 16:00:45', 'ACTIVO'),
(5, '3356548', 'HEctor', 'agarrala', '335445566', 'calle gaira', NULL, 'el colegio por hai', 'hectot@gkg.com', 'Santa Marta', 'Gaira', '2018-05-07 16:02:22', 'ACTIVO'),
(6, '1045698', 'nombre', 'apellido', 'ttel', 'dir1', 'dir2', 'lasalle', 'outllok', 'quilla', 'victoria', '2018-05-12 00:36:14', 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `diary`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `diary` (
`identification` varchar(45)
,`name` varchar(291)
,`phonenumber` varchar(15)
,`history` longtext
,`state` enum('ACTIVO','ELIMINADO','CERRADO')
,`type` varchar(45)
,`follow` longtext
,`date` date
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `follow`
--

CREATE TABLE `follow` (
  `idfollow` int(11) NOT NULL,
  `description` longtext COLLATE utf8_spanish_ci,
  `next_appointment` date DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `state` enum('ACTIVO','ELIMINADO') COLLATE utf8_spanish_ci DEFAULT NULL,
  `idhistory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `follow`
--

INSERT INTO `follow` (`idfollow`, `description`, `next_appointment`, `create_time`, `state`, `idhistory`) VALUES
(1, 'Repuesta icetex', '2018-05-30', '2018-05-07 16:09:27', 'ACTIVO', 8),
(2, 'CArro Ok ty', NULL, '2018-05-07 16:09:27', 'ACTIVO', 10),
(3, 'icetex', '2018-05-31', '2018-05-07 16:10:08', 'ACTIVO', 9),
(4, 'HEctor examen derecho', '2018-05-08', '2018-05-07 16:32:25', 'ACTIVO', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `history`
--

CREATE TABLE `history` (
  `idhistory` int(11) NOT NULL,
  `description` longtext COLLATE utf8_spanish_ci,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `state` enum('ACTIVO','ELIMINADO','CERRADO') COLLATE utf8_spanish_ci DEFAULT NULL,
  `type` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `idcustomers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `history`
--

INSERT INTO `history` (`idhistory`, `description`, `create_time`, `state`, `type`, `idcustomers`) VALUES
(6, 'sd', '2018-05-07 16:48:05', 'ACTIVO', NULL, 5),
(7, 'asd', '2018-05-07 16:48:05', 'ACTIVO', NULL, 4),
(8, 'icetes 1', '2018-05-07 16:48:05', 'ACTIVO', NULL, 3),
(9, 'icetex 2', '2018-05-07 16:48:05', 'ACTIVO', NULL, 3),
(10, 'carro ok', '2018-05-07 16:48:05', 'ACTIVO', NULL, 4);

-- --------------------------------------------------------

--
-- Estructura para la vista `diary`
--
DROP TABLE IF EXISTS `diary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `diary`  AS  select `c`.`identification` AS `identification`,concat(`c`.`name`,' ',`c`.`lastname`) AS `name`,`c`.`phonenumber` AS `phonenumber`,`h`.`description` AS `history`,`h`.`state` AS `state`,`h`.`type` AS `type`,`f`.`description` AS `follow`,`f`.`next_appointment` AS `date` from ((`customers` `c` join `history` `h` on((`h`.`idcustomers` = `c`.`idcustomers`))) join `follow` `f` on((`f`.`idhistory` = `h`.`idhistory`))) where (`f`.`next_appointment` <> '') order by `f`.`next_appointment` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`idcustomers`);

--
-- Indices de la tabla `follow`
--
ALTER TABLE `follow`
  ADD PRIMARY KEY (`idfollow`),
  ADD KEY `fk_follow_history1_idx` (`idhistory`);

--
-- Indices de la tabla `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`idhistory`),
  ADD KEY `fk_history_customers_idx` (`idcustomers`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `customers`
--
ALTER TABLE `customers`
  MODIFY `idcustomers` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `follow`
--
ALTER TABLE `follow`
  MODIFY `idfollow` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `history`
--
ALTER TABLE `history`
  MODIFY `idhistory` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `follow`
--
ALTER TABLE `follow`
  ADD CONSTRAINT `fk_follow_history1` FOREIGN KEY (`idhistory`) REFERENCES `history` (`idhistory`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `fk_history_customers` FOREIGN KEY (`idcustomers`) REFERENCES `customers` (`idcustomers`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Base de datos: `bd_park`
--
CREATE DATABASE IF NOT EXISTS `bd_park` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bd_park`;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `calendariotodate`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `calendariotodate` (
`id_calendario` int(11)
,`fecha` date
,`horario` varchar(145)
,`id_espacio` int(11)
,`espacio` varchar(45)
,`nombre` varchar(291)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `spacelibres`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `spacelibres` (
`espacioid` int(11)
,`nombre` varchar(45)
,`idpiso` int(11)
,`idbloque` int(11)
,`nombrepiso` varchar(45)
,`dia` varchar(45)
,`mes` varchar(45)
,`anio` int(11)
,`hora` varchar(145)
,`idedificio` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_asignacion_reserva_temp`
--

CREATE TABLE `tb_asignacion_reserva_temp` (
  `id_asignacion_temp` int(11) NOT NULL,
  `id_espacio` varchar(45) DEFAULT NULL,
  `numero_espacio` varchar(45) DEFAULT NULL,
  `idpiso` varchar(45) DEFAULT NULL,
  `pisonumero` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `jornada` varchar(45) DEFAULT NULL,
  `ocupado_m` varchar(45) DEFAULT NULL,
  `ocupado_t` varchar(45) DEFAULT NULL,
  `ocupado_dia` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tb_asignacion_reserva_temp`
--

INSERT INTO `tb_asignacion_reserva_temp` (`id_asignacion_temp`, `id_espacio`, `numero_espacio`, `idpiso`, `pisonumero`, `fecha`, `jornada`, `ocupado_m`, `ocupado_t`, `ocupado_dia`) VALUES
(309, '40', '517A', '7', '5', '2019-12-04', 'DIA', '0', '0', '0'),
(310, '81', '422', '6', '4', '2019-12-04', 'TARDE', '0', '0', '0'),
(311, '53', '408', '6', '4', '2019-12-04', 'DIA', '0', '0', '0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_bloque`
--

CREATE TABLE `tb_bloque` (
  `id_bloque` int(11) NOT NULL,
  `numero` varchar(45) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_edificio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_bloque`
--

INSERT INTO `tb_bloque` (`id_bloque`, `numero`, `estado`, `id_edificio`) VALUES
(2, 'Bloque 1', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_calendario`
--

CREATE TABLE `tb_calendario` (
  `id_calendario` int(11) NOT NULL,
  `dia` varchar(45) DEFAULT NULL,
  `mes` varchar(45) DEFAULT NULL,
  `anio` int(11) DEFAULT NULL,
  `horario` varchar(145) DEFAULT NULL,
  `id_espacio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_calendario`
--

INSERT INTO `tb_calendario` (`id_calendario`, `dia`, `mes`, `anio`, `horario`, `id_espacio`) VALUES
(22, '17', '07', 2017, 'Libre de 14:00 a 18:00', 60),
(29, '18', '07', 2017, 'Libre de 8:00 a 12:00', 94),
(30, '21', '07', 2017, 'Libre Todo el dia', 107),
(32, '21', '07', 2017, 'Libre de 14:00 a 18:00', 85),
(34, '26', '07', 2017, 'Libre de 14:00 a 18:00', 107),
(35, '26', '07', 2017, 'Libre de 14:00 a 18:00', 81),
(36, '25', '07', 2017, 'Libre Todo el dia', 81),
(38, '27', '07', 2017, 'Libre Todo el dia', 107),
(40, '27', '07', 2017, 'Libre de 14:00 a 18:00', 81),
(41, '28', '07', 2017, 'Libre de 14:00 a 18:00', 81),
(42, '31', '07', 2017, 'Libre Todo el dia', 107),
(43, '31', '07', 2017, 'Libre de 14:00 a 18:00', 81),
(48, '01', '08', 2017, 'Libre de 14:00 a 18:00', 53),
(51, '02', '08', 2017, 'Libre Todo el dia', 46),
(53, '01', '08', 2017, 'Libre Todo el dia', 81),
(54, '02', '08', 2017, 'Libre Todo el dia', 87),
(55, '03', '08', 2017, 'Libre Todo el dia', 87),
(56, '02', '08', 2017, 'Libre Todo el dia', 45),
(59, '02', '08', 2017, 'Libre Todo el dia', 53),
(60, '02', '08', 2017, 'Libre Todo el dia', 73),
(62, '02', '08', 2017, 'Libre Todo el dia', 107),
(63, '02', '08', 2017, 'Libre Todo el dia', 60),
(64, '03', '08', 2017, 'Libre Todo el dia', 53),
(65, '03', '08', 2017, 'Libre Todo el dia', 60),
(66, '04', '08', 2017, 'Libre Todo el dia', 60),
(74, '04', '08', 2017, 'Libre Todo el dia', 44),
(75, '04', '08', 2017, 'Libre Todo el dia', 89),
(76, '04', '08', 2017, 'Libre Todo el dia', 78),
(79, '04', '08', 2017, 'Libre Todo el dia', 85),
(80, '04', '08', 2017, 'Libre de 14:00 a 18:00', 103),
(81, '04', '08', 2017, 'Libre Todo el dia', 73),
(82, '04', '08', 2017, 'Libre de 14:00 a 18:00', 93),
(83, '08', '08', 2017, 'Libre Todo el dia', 54),
(84, '08', '08', 2017, 'Libre Todo el dia', 85),
(85, '08', '08', 2017, 'Libre de 14:00 a 18:00', 93),
(86, '09', '08', 2017, 'Libre Todo el dia', 73),
(87, '10', '08', 2017, 'Libre Todo el dia', 73),
(88, '11', '08', 2017, 'Libre Todo el dia', 73),
(89, '09', '08', 2017, 'Libre Todo el dia', 53),
(90, '09', '08', 2017, 'Libre Todo el dia', 60),
(92, '09', '08', 2017, 'Libre Todo el dia', 43),
(93, '09', '08', 2017, 'Libre Todo el dia', 85),
(94, '10', '08', 2017, 'Libre Todo el dia', 85),
(95, '11', '08', 2017, 'Libre Todo el dia', 85),
(96, '09', '08', 2017, 'Libre de 14:00 a 18:00', 54),
(97, '10', '08', 2017, 'Libre Todo el dia', 54),
(98, '11', '08', 2017, 'Libre Todo el dia', 54),
(99, '12', '08', 2017, 'Libre Todo el dia', 54),
(100, '13', '08', 2017, 'Libre Todo el dia', 54),
(101, '14', '08', 2017, 'Libre Todo el dia', 54),
(102, '15', '08', 2017, 'Libre Todo el dia', 54),
(103, '16', '08', 2017, 'Libre Todo el dia', 54),
(104, '17', '08', 2017, 'Libre Todo el dia', 54),
(105, '18', '08', 2017, 'Libre Todo el dia', 54),
(106, '19', '08', 2017, 'Libre Todo el dia', 54),
(107, '20', '08', 2017, 'Libre Todo el dia', 54),
(108, '21', '08', 2017, 'Libre Todo el dia', 54),
(109, '22', '08', 2017, 'Libre Todo el dia', 54),
(110, '23', '08', 2017, 'Libre Todo el dia', 54),
(111, '24', '08', 2017, 'Libre Todo el dia', 54),
(112, '25', '08', 2017, 'Libre Todo el dia', 54),
(113, '26', '08', 2017, 'Libre Todo el dia', 54),
(114, '27', '08', 2017, 'Libre Todo el dia', 54),
(115, '28', '08', 2017, 'Libre Todo el dia', 54),
(116, '09', '08', 2017, 'Libre Todo el dia', 93),
(117, '09', '08', 2017, 'Libre de 14:00 a 18:00', 55),
(119, '10', '08', 2017, 'Libre Todo el dia', 43),
(120, '10', '08', 2017, 'Libre de 14:00 a 18:00', 55),
(121, '11', '08', 2017, 'Libre Todo el dia', 53),
(122, '14', '08', 2017, 'Libre Todo el dia', 53),
(123, '15', '08', 2017, 'Libre Todo el dia', 73),
(124, '16', '08', 2017, 'Libre Todo el dia', 73),
(125, '17', '08', 2017, 'Libre Todo el dia', 73),
(126, '18', '08', 2017, 'Libre Todo el dia', 73),
(127, '19', '08', 2017, 'Libre Todo el dia', 73),
(128, '20', '08', 2017, 'Libre Todo el dia', 73),
(129, '15', '08', 2017, 'Libre Todo el dia', 82),
(146, '01', '09', 2017, 'Libre Todo el dia', 82),
(147, '02', '09', 2017, 'Libre Todo el dia', 82),
(148, '03', '09', 2017, 'Libre Todo el dia', 82),
(157, '15', '08', 2017, 'Libre Todo el dia', 45),
(158, '16', '08', 2017, 'Libre Todo el dia', 45),
(159, '15', '08', 2017, 'Libre Todo el dia', 53),
(160, '16', '08', 2017, 'Libre Todo el dia', 53),
(161, '17', '08', 2017, 'Libre Todo el dia', 53),
(162, '18', '08', 2017, 'Libre Todo el dia', 53),
(163, '15', '08', 2017, 'Libre Todo el dia', 85),
(164, '16', '08', 2017, 'Libre Todo el dia', 85),
(165, '17', '08', 2017, 'Libre Todo el dia', 85),
(166, '18', '08', 2017, 'Libre Todo el dia', 85),
(167, '15', '08', 2017, 'Libre Todo el dia', 102),
(168, '16', '08', 2017, 'Libre Todo el dia', 36),
(169, '17', '08', 2017, 'Libre Todo el dia', 36),
(170, '18', '08', 2017, 'Libre Todo el dia', 36),
(171, '15', '08', 2017, 'Libre Todo el dia', 93),
(172, '16', '08', 2017, 'Libre Todo el dia', 93),
(174, '15', '08', 2017, 'Libre de 8:00 a 12:00', 89),
(175, '15', '08', 2017, 'Libre de 8:00 a 12:00', 43),
(176, '15', '08', 2017, 'Libre de 14:00 a 18:00', 90),
(180, '18', '08', 2017, 'Libre Todo el dia', 107),
(181, '16', '08', 2017, 'Libre Todo el dia', 90),
(182, '17', '08', 2017, 'Libre Todo el dia', 90),
(183, '18', '08', 2017, 'Libre Todo el dia', 90),
(184, '16', '08', 2017, 'Libre Todo el dia', 80),
(185, '17', '08', 2017, 'Libre Todo el dia', 80),
(186, '18', '08', 2017, 'Libre Todo el dia', 80),
(187, '19', '08', 2017, 'Libre Todo el dia', 80),
(188, '20', '08', 2017, 'Libre Todo el dia', 80),
(189, '21', '08', 2017, 'Libre Todo el dia', 80),
(190, '22', '08', 2017, 'Libre Todo el dia', 80),
(191, '23', '08', 2017, 'Libre Todo el dia', 80),
(192, '24', '08', 2017, 'Libre Todo el dia', 80),
(193, '25', '08', 2017, 'Libre Todo el dia', 80),
(194, '26', '08', 2017, 'Libre Todo el dia', 80),
(195, '27', '08', 2017, 'Libre Todo el dia', 80),
(196, '28', '08', 2017, 'Libre Todo el dia', 80),
(197, '29', '08', 2017, 'Libre Todo el dia', 80),
(198, '30', '08', 2017, 'Libre Todo el dia', 80),
(199, '31', '08', 2017, 'Libre Todo el dia', 80),
(200, '01', '09', 2017, 'Libre Todo el dia', 80),
(201, '02', '09', 2017, 'Libre Todo el dia', 80),
(202, '03', '09', 2017, 'Libre Todo el dia', 80),
(203, '04', '09', 2017, 'Libre Todo el dia', 80),
(204, '05', '09', 2017, 'Libre Todo el dia', 80),
(205, '17', '08', 2017, 'Libre Todo el dia', 103),
(206, '17', '08', 2017, 'Libre Todo el dia', 81),
(207, '16', '08', 2017, 'Libre de 14:00 a 18:00', 89),
(210, '17', '08', 2017, 'Libre Todo el dia', 89),
(211, '18', '08', 2017, 'Libre Todo el dia', 89),
(212, '16', '08', 2017, 'Libre Todo el dia', 88),
(213, '16', '08', 2017, 'Libre Todo el dia', 57),
(214, '17', '08', 2017, 'Libre Todo el dia', 57),
(215, '18', '08', 2017, 'Libre Todo el dia', 57),
(216, '17', '08', 2017, 'Libre Todo el dia', 44),
(218, '17', '08', 2017, 'Libre Todo el dia', 47),
(219, '17', '08', 2017, 'Libre de 8:00 a 12:00', 49),
(220, '17', '08', 2017, 'Libre de 8:00 a 12:00', 92),
(221, '17', '08', 2017, 'Libre Todo el dia', 106),
(222, '18', '08', 2017, 'Libre Todo el dia', 106),
(223, '17', '08', 2017, 'Libre de 14:00 a 18:00', 74),
(224, '17', '08', 2017, 'Libre de 14:00 a 18:00', 60),
(225, '17', '08', 2017, 'Libre Todo el dia', 34),
(226, '18', '08', 2017, 'Libre Todo el dia', 84),
(227, '23', '08', 2017, 'Libre Todo el dia', 96),
(228, '22', '08', 2017, 'Libre Todo el dia', 86),
(229, '22', '08', 2017, 'Libre Todo el dia', 81),
(230, '23', '08', 2017, 'Libre Todo el dia', 81),
(231, '24', '08', 2017, 'Libre Todo el dia', 81),
(232, '25', '08', 2017, 'Libre Todo el dia', 81),
(234, '22', '08', 2017, 'Libre Todo el dia', 53),
(235, '22', '08', 2017, 'Libre Todo el dia', 34),
(236, '23', '08', 2017, 'Libre de 8:00 a 12:00', 34),
(237, '22', '08', 2017, 'Libre Todo el dia', 98),
(238, '22', '08', 2017, 'Libre Todo el dia', 73),
(239, '23', '08', 2017, 'Libre Todo el dia', 73),
(240, '24', '08', 2017, 'Libre Todo el dia', 73),
(241, '25', '08', 2017, 'Libre Todo el dia', 73),
(242, '22', '08', 2017, 'Libre Todo el dia', 74),
(243, '22', '08', 2017, 'Libre Todo el dia', 92),
(244, '23', '08', 2017, 'Libre de 8:00 a 12:00', 39),
(245, '23', '08', 2017, 'Libre Todo el dia', 89),
(246, '24', '08', 2017, 'Libre Todo el dia', 89),
(247, '25', '08', 2017, 'Libre Todo el dia', 89),
(248, '22', '08', 2017, 'Libre de 14:00 a 18:00', 55),
(250, '23', '08', 2017, 'Libre Todo el dia', 55),
(251, '22', '08', 2017, 'Libre Todo el dia', 47),
(252, '23', '08', 2017, 'Libre Todo el dia', 47),
(253, '24', '08', 2017, 'Libre Todo el dia', 47),
(254, '23', '08', 2017, 'Libre Todo el dia', 93),
(256, '23', '08', 2017, 'Libre Todo el dia', 98),
(257, '23', '08', 2017, 'Libre de 8:00 a 12:00', 74),
(258, '23', '08', 2017, 'Libre Todo el dia', 49),
(259, '31', '08', 2017, 'Libre de 8:00 a 12:00', 92),
(260, '01', '09', 2017, 'Libre Todo el dia', 92),
(261, '24', '08', 2017, 'Libre Todo el dia', 36),
(262, '24', '08', 2017, 'Libre Todo el dia', 98),
(263, '24', '08', 2017, 'Libre Todo el dia', 69),
(264, '25', '08', 2017, 'Libre Todo el dia', 69),
(265, '24', '08', 2017, 'Libre Todo el dia', 107),
(266, '24', '08', 2017, 'Libre de 14:00 a 18:00', 60),
(267, '24', '08', 2017, 'Libre Todo el dia', 74),
(268, '25', '08', 2017, 'Libre de 8:00 a 12:00', 55),
(269, '25', '08', 2017, 'Libre Todo el dia', 36),
(270, '25', '08', 2017, 'Libre de 14:00 a 18:00', 93),
(272, '28', '08', 2017, 'Libre Todo el dia', 46),
(273, '28', '08', 2017, 'Libre Todo el dia', 108),
(274, '29', '08', 2017, 'Libre Todo el dia', 108),
(275, '30', '08', 2017, 'Libre Todo el dia', 108),
(276, '31', '08', 2017, 'Libre Todo el dia', 108),
(277, '01', '09', 2017, 'Libre Todo el dia', 108),
(278, '02', '09', 2017, 'Libre Todo el dia', 108),
(279, '03', '09', 2017, 'Libre Todo el dia', 108),
(280, '04', '09', 2017, 'Libre Todo el dia', 108),
(281, '05', '09', 2017, 'Libre Todo el dia', 108),
(282, '06', '09', 2017, 'Libre Todo el dia', 108),
(283, '07', '09', 2017, 'Libre Todo el dia', 108),
(284, '08', '09', 2017, 'Libre Todo el dia', 108),
(285, '28', '08', 2017, 'Libre Todo el dia', 81),
(286, '29', '08', 2017, 'Libre Todo el dia', 81),
(287, '28', '08', 2017, 'Libre Todo el dia', 43),
(288, '29', '08', 2017, 'Libre Todo el dia', 43),
(289, '30', '08', 2017, 'Libre Todo el dia', 43),
(290, '31', '08', 2017, 'Libre Todo el dia', 43),
(291, '01', '09', 2017, 'Libre Todo el dia', 43),
(292, '02', '09', 2017, 'Libre Todo el dia', 43),
(293, '03', '09', 2017, 'Libre Todo el dia', 43),
(294, '04', '09', 2017, 'Libre Todo el dia', 43),
(295, '05', '09', 2017, 'Libre Todo el dia', 43),
(296, '06', '09', 2017, 'Libre Todo el dia', 43),
(297, '27', '08', 2017, 'Libre Todo el dia', 43),
(298, '28', '08', 2017, 'Libre de 14:00 a 18:00', 89),
(299, '30', '08', 2017, 'Libre Todo el dia', 89),
(300, '31', '08', 2017, 'Libre Todo el dia', 89),
(301, '29', '08', 2017, 'Libre Todo el dia', 89),
(302, '28', '08', 2017, 'Libre Todo el dia', 85),
(303, '29', '08', 2017, 'Libre Todo el dia', 102),
(304, '30', '08', 2017, 'Libre Todo el dia', 96),
(305, '29', '08', 2017, 'Libre Todo el dia', 53),
(306, '30', '08', 2017, 'Libre Todo el dia', 37),
(307, '31', '08', 2017, 'Libre Todo el dia', 37),
(308, '30', '08', 2017, 'Libre Todo el dia', 98),
(309, '31', '08', 2017, 'Libre Todo el dia', 36),
(310, '01', '09', 2017, 'Libre Todo el dia', 36),
(311, '31', '08', 2017, 'Libre Todo el dia', 85),
(312, '31', '08', 2017, 'Libre Todo el dia', 98),
(313, '31', '08', 2017, 'Libre de 8:00 a 12:00', 74),
(314, '01', '09', 2017, 'Libre Todo el dia', 85),
(315, '01', '09', 2017, 'Libre Todo el dia', 74),
(318, '04', '09', 2017, 'Libre Todo el dia', 97),
(319, '04', '09', 2017, 'Libre de 14:00 a 18:00', 85),
(320, '05', '09', 2017, 'Libre Todo el dia', 85),
(321, '07', '09', 2017, 'Libre Todo el dia', 46),
(322, '05', '09', 2017, 'Libre Todo el dia', 53),
(323, '05', '09', 2017, 'Libre Todo el dia', 81),
(324, '06', '09', 2017, 'Libre Todo el dia', 81),
(325, '05', '09', 2017, 'Libre Todo el dia', 47),
(326, '06', '09', 2017, 'Libre Todo el dia', 47),
(327, '06', '09', 2017, 'Libre Todo el dia', 53),
(328, '07', '09', 2017, 'Libre Todo el dia', 53),
(329, '08', '09', 2017, 'Libre Todo el dia', 53),
(330, '09', '09', 2017, 'Libre Todo el dia', 53),
(331, '10', '09', 2017, 'Libre Todo el dia', 53),
(332, '11', '09', 2017, 'Libre Todo el dia', 53),
(333, '12', '09', 2017, 'Libre Todo el dia', 53),
(334, '13', '09', 2017, 'Libre Todo el dia', 53),
(335, '14', '09', 2017, 'Libre Todo el dia', 53),
(336, '15', '09', 2017, 'Libre Todo el dia', 53),
(337, '06', '09', 2017, 'Libre Todo el dia', 36),
(338, '06', '09', 2017, 'Libre Todo el dia', 85),
(339, '06', '09', 2017, 'Libre Todo el dia', 49),
(340, '06', '09', 2017, 'Libre de 14:00 a 18:00', 93),
(341, '07', '09', 2017, 'Libre Todo el dia', 85),
(342, '08', '09', 2017, 'Libre Todo el dia', 85),
(343, '07', '09', 2017, 'Libre Todo el dia', 103),
(344, '08', '09', 2017, 'Libre Todo el dia', 77),
(345, '07', '09', 2017, 'Libre Todo el dia', 55),
(346, '08', '09', 2017, 'Libre Todo el dia', 55),
(347, '09', '09', 2017, 'Libre Todo el dia', 55),
(348, '10', '09', 2017, 'Libre Todo el dia', 55),
(349, '11', '09', 2017, 'Libre Todo el dia', 55),
(350, '12', '09', 2017, 'Libre Todo el dia', 55),
(351, '13', '09', 2017, 'Libre Todo el dia', 55),
(352, '14', '09', 2017, 'Libre Todo el dia', 55),
(353, '15', '09', 2017, 'Libre Todo el dia', 55),
(354, '07', '09', 2017, 'Libre Todo el dia', 43),
(355, '08', '09', 2017, 'Libre Todo el dia', 43),
(356, '07', '09', 2017, 'Libre de 14:00 a 18:00', 93),
(358, '08', '09', 2017, 'Libre Todo el dia', 44),
(359, '08', '09', 2017, 'Libre Todo el dia', 106),
(360, '08', '09', 2017, 'Libre Todo el dia', 68),
(361, '08', '09', 2017, 'Libre Todo el dia', 73),
(362, '08', '09', 2017, 'Libre Todo el dia', 47),
(363, '08', '09', 2017, 'Libre de 14:00 a 18:00', 81),
(364, '08', '09', 2017, 'Libre Todo el dia', 60),
(365, '08', '09', 2017, 'Libre Todo el dia', 82),
(366, '09', '09', 2017, 'Libre Todo el dia', 82),
(367, '10', '09', 2017, 'Libre Todo el dia', 82),
(368, '11', '09', 2017, 'Libre Todo el dia', 82),
(369, '12', '09', 2017, 'Libre Todo el dia', 82),
(370, '11', '09', 2017, 'Libre Todo el dia', 73),
(371, '12', '09', 2017, 'Libre Todo el dia', 73),
(372, '13', '09', 2017, 'Libre Todo el dia', 73),
(373, '14', '09', 2017, 'Libre Todo el dia', 73),
(374, '15', '09', 2017, 'Libre Todo el dia', 73),
(375, '16', '09', 2017, 'Libre Todo el dia', 73),
(378, '11', '09', 2017, 'Libre Todo el dia', 85),
(379, '11', '09', 2017, 'Libre Todo el dia', 86),
(380, '11', '09', 2017, 'Libre Todo el dia', 43),
(382, '12', '09', 2017, 'Libre Todo el dia', 35),
(383, '11', '09', 2017, 'Libre Todo el dia', 89),
(384, '12', '09', 2017, 'Libre Todo el dia', 89),
(385, '13', '09', 2017, 'Libre Todo el dia', 89),
(386, '11', '09', 2017, 'Libre Todo el dia', 46),
(387, '12', '09', 2017, 'Libre Todo el dia', 46),
(388, '13', '09', 2017, 'Libre Todo el dia', 46),
(389, '12', '09', 2017, 'Libre Todo el dia', 43),
(390, '12', '09', 2017, 'Libre Todo el dia', 102),
(391, '13', '09', 2017, 'Libre de 14:00 a 18:00', 102),
(393, '14', '09', 2017, 'Libre Todo el dia', 62),
(394, '14', '09', 2017, 'Libre Todo el dia', 43),
(395, '15', '09', 2017, 'Libre Todo el dia', 43),
(396, '14', '09', 2017, 'Libre Todo el dia', 85),
(397, '15', '09', 2017, 'Libre Todo el dia', 85),
(398, '18', '09', 2017, 'Libre de 8:00 a 12:00', 89),
(399, '19', '09', 2017, 'Libre Todo el dia', 89),
(400, '20', '09', 2017, 'Libre Todo el dia', 89),
(401, '21', '09', 2017, 'Libre Todo el dia', 89),
(402, '17', '09', 2017, 'Libre Todo el dia', 106),
(403, '18', '09', 2017, 'Libre Todo el dia', 106),
(404, '19', '09', 2017, 'Libre Todo el dia', 106),
(405, '20', '09', 2017, 'Libre Todo el dia', 106),
(406, '21', '09', 2017, 'Libre Todo el dia', 106),
(407, '22', '09', 2017, 'Libre Todo el dia', 106),
(408, '23', '09', 2017, 'Libre Todo el dia', 106),
(409, '24', '09', 2017, 'Libre Todo el dia', 106),
(410, '21', '09', 2017, 'Libre Todo el dia', 60),
(411, '22', '09', 2017, 'Libre Todo el dia', 60),
(412, '18', '09', 2017, 'Libre Todo el dia', 98),
(413, '18', '09', 2017, 'Libre Todo el dia', 59),
(414, '18', '09', 2017, 'Libre Todo el dia', 43),
(415, '19', '09', 2017, 'Libre Todo el dia', 43),
(416, '18', '09', 2017, 'Libre Todo el dia', 36),
(417, '18', '09', 2017, 'Libre Todo el dia', 73),
(418, '19', '09', 2017, 'Libre Todo el dia', 73),
(419, '18', '09', 2017, 'Libre de 14:00 a 18:00', 77),
(420, '18', '09', 2017, 'Libre Todo el dia', 47),
(421, '19', '09', 2017, 'Libre Todo el dia', 47),
(422, '20', '09', 2017, 'Libre Todo el dia', 47),
(423, '21', '09', 2017, 'Libre Todo el dia', 47),
(424, '22', '09', 2017, 'Libre Todo el dia', 47),
(425, '19', '09', 2017, 'Libre Todo el dia', 85),
(426, '19', '09', 2017, 'Libre Todo el dia', 59),
(427, '20', '09', 2017, 'Libre Todo el dia', 59),
(428, '20', '09', 2017, 'Libre Todo el dia', 86),
(429, '20', '09', 2017, 'Libre Todo el dia', 36),
(430, '21', '09', 2017, 'Libre Todo el dia', 36),
(431, '22', '09', 2017, 'Libre Todo el dia', 36),
(432, '23', '09', 2017, 'Libre Todo el dia', 36),
(433, '24', '09', 2017, 'Libre Todo el dia', 36),
(436, '21', '09', 2017, 'Libre Todo el dia', 85),
(437, '21', '09', 2017, 'Libre Todo el dia', 86),
(438, '21', '09', 2017, 'Libre Todo el dia', 73),
(439, '22', '09', 2017, 'Libre Todo el dia', 73),
(441, '21', '09', 2017, 'Libre de 14:00 a 18:00', 93),
(442, '22', '09', 2017, 'Libre Todo el dia', 85),
(443, '22', '09', 2017, 'Libre Todo el dia', 43),
(444, '22', '09', 2017, 'Libre Todo el dia', 81),
(445, '22', '09', 2017, 'Libre de 14:00 a 18:00', 49),
(446, '23', '09', 2017, 'Libre Todo el dia', 86),
(447, '24', '09', 2017, 'Libre Todo el dia', 86),
(448, '24', '09', 2017, 'Libre Todo el dia', 78),
(449, '25', '09', 2017, 'Libre Todo el dia', 43),
(450, '25', '09', 2017, 'Libre Todo el dia', 73),
(451, '26', '09', 2017, 'Libre Todo el dia', 73),
(452, '27', '09', 2017, 'Libre Todo el dia', 73),
(453, '28', '09', 2017, 'Libre Todo el dia', 73),
(454, '29', '09', 2017, 'Libre Todo el dia', 73),
(455, '30', '09', 2017, 'Libre Todo el dia', 73),
(456, '25', '09', 2017, 'Libre Todo el dia', 86),
(457, '25', '09', 2017, 'Libre de 14:00 a 18:00', 81),
(458, '26', '09', 2017, 'Libre Todo el dia', 81),
(459, '27', '09', 2017, 'Libre Todo el dia', 81),
(460, '26', '09', 2017, 'Libre Todo el dia', 44),
(461, '27', '09', 2017, 'Libre Todo el dia', 44),
(462, '26', '09', 2017, 'Libre Todo el dia', 85),
(463, '27', '09', 2017, 'Libre Todo el dia', 85),
(464, '26', '09', 2017, 'Libre Todo el dia', 103),
(465, '27', '09', 2017, 'Libre Todo el dia', 103),
(466, '26', '09', 2017, 'Libre Todo el dia', 106),
(467, '27', '09', 2017, 'Libre Todo el dia', 106),
(468, '26', '09', 2017, 'Libre Todo el dia', 47),
(469, '27', '09', 2017, 'Libre Todo el dia', 47),
(471, '26', '09', 2017, 'Libre Todo el dia', 95),
(472, '27', '09', 2017, 'Libre Todo el dia', 95),
(473, '28', '09', 2017, 'Libre Todo el dia', 57),
(474, '28', '09', 2017, 'Libre Todo el dia', 55),
(475, '28', '09', 2017, 'Libre Todo el dia', 86),
(476, '28', '09', 2017, 'Libre Todo el dia', 45),
(477, '28', '09', 2017, 'Libre Todo el dia', 36),
(478, '29', '09', 2017, 'Libre Todo el dia', 36),
(479, '28', '09', 2017, 'Libre Todo el dia', 37),
(480, '03', '10', 2017, 'Libre Todo el dia', 45),
(481, '02', '10', 2017, 'Libre de 14:00 a 18:00', 90),
(482, '03', '10', 2017, 'Libre Todo el dia', 90),
(483, '02', '10', 2017, 'Libre Todo el dia', 85),
(484, '02', '10', 2017, 'Libre Todo el dia', 59),
(485, '03', '10', 2017, 'Libre Todo el dia', 59),
(486, '04', '10', 2017, 'Libre Todo el dia', 59),
(487, '05', '10', 2017, 'Libre Todo el dia', 59),
(488, '06', '10', 2017, 'Libre Todo el dia', 59),
(489, '07', '10', 2017, 'Libre Todo el dia', 59),
(490, '02', '10', 2017, 'Libre Todo el dia', 73),
(491, '03', '10', 2017, 'Libre Todo el dia', 73),
(492, '04', '10', 2017, 'Libre Todo el dia', 73),
(493, '05', '10', 2017, 'Libre Todo el dia', 73),
(494, '06', '10', 2017, 'Libre Todo el dia', 73),
(495, '02', '10', 2017, 'Libre de 14:00 a 18:00', 45),
(496, '03', '10', 2017, 'Libre Todo el dia', 93),
(497, '03', '10', 2017, 'Libre Todo el dia', 55),
(498, '03', '10', 2017, 'Libre Todo el dia', 87),
(499, '03', '10', 2017, 'Libre Todo el dia', 108),
(501, '03', '10', 2017, 'Libre de 8:00 a 12:00', 77),
(502, '03', '10', 2017, 'Libre Todo el dia', 57),
(503, '03', '10', 2017, 'Libre de 8:00 a 12:00', 82),
(504, '03', '10', 2017, 'Libre Todo el dia', 46),
(505, '04', '10', 2017, 'Libre Todo el dia', 46),
(506, '05', '10', 2017, 'Libre Todo el dia', 46),
(507, '06', '10', 2017, 'Libre Todo el dia', 46),
(508, '03', '10', 2017, 'Libre Todo el dia', 36),
(509, '04', '10', 2017, 'Libre Todo el dia', 85),
(510, '04', '10', 2017, 'Libre Todo el dia', 38),
(511, '04', '10', 2017, 'Libre Todo el dia', 70),
(512, '05', '10', 2017, 'Libre Todo el dia', 85),
(513, '05', '10', 2017, 'Libre Todo el dia', 43),
(514, '06', '10', 2017, 'Libre de 8:00 a 12:00', 57),
(516, '09', '10', 2017, 'Libre Todo el dia', 95),
(517, '10', '10', 2017, 'Libre Todo el dia', 95),
(518, '09', '10', 2017, 'Libre Todo el dia', 36),
(519, '09', '10', 2017, 'Libre Todo el dia', 103),
(520, '10', '10', 2017, 'Libre Todo el dia', 103),
(521, '11', '10', 2017, 'Libre Todo el dia', 103),
(522, '12', '10', 2017, 'Libre Todo el dia', 103),
(523, '13', '10', 2017, 'Libre Todo el dia', 103),
(524, '09', '10', 2017, 'Libre Todo el dia', 76),
(525, '09', '10', 2017, 'Libre Todo el dia', 57),
(526, '10', '10', 2017, 'Libre Todo el dia', 57),
(527, '11', '10', 2017, 'Libre Todo el dia', 57),
(528, '12', '10', 2017, 'Libre Todo el dia', 57),
(529, '13', '10', 2017, 'Libre Todo el dia', 57),
(530, '09', '10', 2017, 'Libre Todo el dia', 55),
(531, '10', '10', 2017, 'Libre Todo el dia', 96),
(532, '11', '10', 2017, 'Libre Todo el dia', 96),
(535, '11', '10', 2017, 'Libre Todo el dia', 36),
(536, '11', '10', 2017, 'Libre Todo el dia', 73),
(537, '12', '10', 2017, 'Libre Todo el dia', 73),
(538, '13', '10', 2017, 'Libre Todo el dia', 73),
(539, '14', '10', 2017, 'Libre Todo el dia', 73),
(540, '15', '10', 2017, 'Libre Todo el dia', 73),
(541, '12', '10', 2017, 'Libre Todo el dia', 96),
(542, '12', '10', 2017, 'Libre Todo el dia', 77),
(545, '13', '10', 2017, 'Libre Todo el dia', 96),
(546, '13', '10', 2017, 'Libre Todo el dia', 89),
(547, '13', '10', 2017, 'Libre Todo el dia', 77),
(548, '14', '10', 2017, 'Libre Todo el dia', 78),
(549, '15', '10', 2017, 'Libre Todo el dia', 78),
(550, '16', '10', 2017, 'Libre Todo el dia', 78),
(551, '17', '10', 2017, 'Libre Todo el dia', 78),
(552, '16', '10', 2017, 'Libre Todo el dia', 78),
(553, '18', '10', 2017, 'Libre Todo el dia', 78),
(554, '19', '10', 2017, 'Libre Todo el dia', 78),
(555, '20', '10', 2017, 'Libre Todo el dia', 78),
(556, '21', '10', 2017, 'Libre Todo el dia', 78),
(557, '22', '10', 2017, 'Libre Todo el dia', 78),
(558, '17', '10', 2017, 'Libre Todo el dia', 73),
(559, '18', '10', 2017, 'Libre Todo el dia', 73),
(560, '19', '10', 2017, 'Libre Todo el dia', 73),
(561, '20', '10', 2017, 'Libre Todo el dia', 73),
(562, '21', '10', 2017, 'Libre Todo el dia', 73),
(563, '17', '10', 2017, 'Libre Todo el dia', 85),
(564, '17', '10', 2017, 'Libre Todo el dia', 93),
(565, '18', '10', 2017, 'Libre Todo el dia', 93),
(566, '19', '10', 2017, 'Libre Todo el dia', 93),
(567, '20', '10', 2017, 'Libre Todo el dia', 93),
(568, '19', '10', 2017, 'Libre Todo el dia', 70),
(569, '19', '10', 2017, 'Libre Todo el dia', 55),
(570, '19', '10', 2017, 'Libre Todo el dia', 85),
(571, '20', '10', 2017, 'Libre Todo el dia', 85),
(572, '23', '10', 2017, 'Libre Todo el dia', 93),
(573, '24', '10', 2017, 'Libre Todo el dia', 93),
(574, '25', '10', 2017, 'Libre Todo el dia', 93),
(575, '26', '10', 2017, 'Libre Todo el dia', 93),
(576, '27', '10', 2017, 'Libre Todo el dia', 93),
(577, '23', '10', 2017, 'Libre Todo el dia', 73),
(578, '24', '10', 2017, 'Libre Todo el dia', 73),
(579, '25', '10', 2017, 'Libre Todo el dia', 73),
(580, '26', '10', 2017, 'Libre Todo el dia', 73),
(581, '27', '10', 2017, 'Libre Todo el dia', 73),
(582, '23', '10', 2017, 'Libre Todo el dia', 46),
(583, '23', '10', 2017, 'Libre Todo el dia', 85),
(584, '23', '10', 2017, 'Libre Todo el dia', 78),
(585, '24', '10', 2017, 'Libre Todo el dia', 78),
(586, '25', '10', 2017, 'Libre Todo el dia', 78),
(587, '26', '10', 2017, 'Libre Todo el dia', 78),
(588, '27', '10', 2017, 'Libre Todo el dia', 78),
(589, '24', '10', 2017, 'Libre de 8:00 a 12:00', 77),
(590, '24', '10', 2017, 'Libre Todo el dia', 47),
(591, '25', '10', 2017, 'Libre Todo el dia', 47),
(592, '26', '10', 2017, 'Libre Todo el dia', 47),
(593, '27', '10', 2017, 'Libre Todo el dia', 47),
(594, '27', '10', 2017, 'Libre Todo el dia', 46),
(595, '24', '10', 2017, 'Libre Todo el dia', 108),
(596, '24', '10', 2017, 'Libre Todo el dia', 68),
(597, '25', '10', 2017, 'Libre Todo el dia', 68),
(598, '26', '10', 2017, 'Libre Todo el dia', 68),
(599, '27', '10', 2017, 'Libre Todo el dia', 68),
(600, '28', '10', 2017, 'Libre Todo el dia', 68),
(601, '29', '10', 2017, 'Libre Todo el dia', 68),
(602, '30', '10', 2017, 'Libre Todo el dia', 68),
(603, '31', '10', 2017, 'Libre Todo el dia', 68),
(604, '24', '10', 2017, 'Libre Todo el dia', 45),
(605, '25', '10', 2017, 'Libre Todo el dia', 45),
(606, '26', '10', 2017, 'Libre Todo el dia', 45),
(607, '24', '10', 2017, 'Libre de 14:00 a 18:00', 74),
(608, '24', '10', 2017, 'Libre Todo el dia', 49),
(609, '25', '10', 2017, 'Libre Todo el dia', 49),
(610, '26', '10', 2017, 'Libre Todo el dia', 49),
(611, '27', '10', 2017, 'Libre Todo el dia', 49),
(612, '24', '10', 2017, 'Libre Todo el dia', 67),
(613, '25', '10', 2017, 'Libre Todo el dia', 67),
(614, '26', '10', 2017, 'Libre Todo el dia', 67),
(615, '27', '10', 2017, 'Libre Todo el dia', 67),
(616, '25', '10', 2017, 'Libre Todo el dia', 103),
(617, '24', '10', 2017, 'Libre Todo el dia', 42),
(618, '25', '10', 2017, 'Libre Todo el dia', 42),
(619, '26', '10', 2017, 'Libre Todo el dia', 42),
(620, '24', '10', 2017, 'Libre Todo el dia', 52),
(621, '24', '10', 2017, 'Libre Todo el dia', 83),
(622, '25', '10', 2017, 'Libre Todo el dia', 83),
(623, '26', '10', 2017, 'Libre Todo el dia', 83),
(624, '27', '10', 2017, 'Libre Todo el dia', 83),
(625, '24', '10', 2017, 'Libre Todo el dia', 86),
(626, '24', '10', 2017, 'Libre Todo el dia', 57),
(627, '25', '10', 2017, 'Libre Todo el dia', 89),
(628, '26', '10', 2017, 'Libre Todo el dia', 89),
(629, '25', '10', 2017, 'Libre Todo el dia', 98),
(630, '25', '10', 2017, 'Libre Todo el dia', 38),
(631, '26', '10', 2017, 'Libre Todo el dia', 38),
(632, '25', '10', 2017, 'Libre de 8:00 a 12:00', 85),
(633, '30', '10', 2017, 'Libre Todo el dia', 108),
(634, '31', '10', 2017, 'Libre Todo el dia', 108),
(635, '01', '11', 2017, 'Libre Todo el dia', 108),
(636, '02', '11', 2017, 'Libre Todo el dia', 108),
(638, '25', '10', 2017, 'Libre Todo el dia', 57),
(639, '25', '10', 2017, 'Libre Todo el dia', 86),
(640, '26', '10', 2017, 'Libre Todo el dia', 85),
(641, '26', '10', 2017, 'Libre Todo el dia', 80),
(642, '27', '10', 2017, 'Libre de 8:00 a 12:00', 55),
(643, '27', '10', 2017, 'Libre Todo el dia', 102),
(645, '30', '10', 2017, 'Libre Todo el dia', 93),
(646, '31', '10', 2017, 'Libre Todo el dia', 93),
(647, '01', '11', 2017, 'Libre Todo el dia', 93),
(648, '02', '11', 2017, 'Libre Todo el dia', 93),
(649, '03', '11', 2017, 'Libre Todo el dia', 93),
(650, '30', '10', 2017, 'Libre Todo el dia', 107),
(651, '31', '10', 2017, 'Libre Todo el dia', 107),
(652, '30', '10', 2017, 'Libre Todo el dia', 60),
(653, '31', '10', 2017, 'Libre Todo el dia', 60),
(654, '30', '10', 2017, 'Libre Todo el dia', 70),
(655, '31', '10', 2017, 'Libre Todo el dia', 70),
(656, '01', '11', 2017, 'Libre Todo el dia', 70),
(657, '02', '11', 2017, 'Libre Todo el dia', 70),
(658, '03', '11', 2017, 'Libre Todo el dia', 70),
(659, '04', '11', 2017, 'Libre Todo el dia', 70),
(663, '30', '10', 2017, 'Libre Todo el dia', 85),
(664, '30', '10', 2017, 'Libre de 8:00 a 12:00', 57),
(665, '30', '10', 2017, 'Libre Todo el dia', 105),
(666, '30', '10', 2017, 'Libre Todo el dia', 36),
(667, '31', '10', 2017, 'Libre Todo el dia', 73),
(668, '01', '11', 2017, 'Libre Todo el dia', 73),
(669, '02', '11', 2017, 'Libre Todo el dia', 73),
(670, '03', '11', 2017, 'Libre Todo el dia', 73),
(671, '31', '10', 2017, 'Libre Todo el dia', 55),
(672, '31', '10', 2017, 'Libre Todo el dia', 82),
(673, '31', '10', 2017, 'Libre Todo el dia', 89),
(674, '01', '11', 2017, 'Libre Todo el dia', 89),
(675, '02', '11', 2017, 'Libre Todo el dia', 89),
(676, '31', '10', 2017, 'Libre Todo el dia', 103),
(677, '01', '11', 2017, 'Libre de 8:00 a 12:00', 85),
(678, '01', '11', 2017, 'Libre Todo el dia', 98),
(681, '01', '11', 2017, 'Libre Todo el dia', 48),
(682, '02', '11', 2017, 'Libre Todo el dia', 49),
(683, '03', '11', 2017, 'Libre de 8:00 a 12:00', 49),
(684, '02', '11', 2017, 'Libre Todo el dia', 81),
(686, '02', '11', 2017, 'Libre de 8:00 a 12:00', 85),
(687, '02', '11', 2017, 'Libre Todo el dia', 92),
(688, '02', '11', 2017, 'Libre Todo el dia', 67),
(689, '02', '11', 2017, 'Libre Todo el dia', 47),
(690, '03', '11', 2017, 'Libre Todo el dia', 47),
(692, '03', '11', 2017, 'Libre Todo el dia', 45),
(693, '08', '11', 2017, 'Libre Todo el dia', 47),
(694, '03', '11', 2017, 'Libre Todo el dia', 107),
(695, '03', '11', 2017, 'Libre Todo el dia', 102),
(696, '07', '11', 2017, 'Libre Todo el dia', 93),
(697, '08', '11', 2017, 'Libre Todo el dia', 93),
(698, '09', '11', 2017, 'Libre Todo el dia', 93),
(699, '10', '11', 2017, 'Libre Todo el dia', 93),
(700, '11', '11', 2017, 'Libre Todo el dia', 93),
(701, '12', '11', 2017, 'Libre Todo el dia', 93),
(702, '13', '11', 2017, 'Libre Todo el dia', 93),
(703, '14', '11', 2017, 'Libre Todo el dia', 93),
(704, '15', '11', 2017, 'Libre Todo el dia', 93),
(705, '16', '11', 2017, 'Libre Todo el dia', 93),
(706, '17', '11', 2017, 'Libre Todo el dia', 93),
(707, '18', '11', 2017, 'Libre Todo el dia', 93),
(708, '19', '11', 2017, 'Libre Todo el dia', 93),
(709, '20', '11', 2017, 'Libre Todo el dia', 93),
(710, '21', '11', 2017, 'Libre Todo el dia', 93),
(711, '22', '11', 2017, 'Libre Todo el dia', 93),
(712, '23', '11', 2017, 'Libre Todo el dia', 93),
(713, '24', '11', 2017, 'Libre Todo el dia', 93),
(714, '25', '11', 2017, 'Libre Todo el dia', 93),
(715, '26', '11', 2017, 'Libre Todo el dia', 93),
(716, '27', '11', 2017, 'Libre Todo el dia', 93),
(717, '28', '11', 2017, 'Libre Todo el dia', 93),
(718, '04', '11', 2017, 'Libre de 8:00 a 12:00', 81),
(719, '04', '11', 2017, 'Libre de 14:00 a 18:00', 107),
(720, '07', '11', 2017, 'Libre de 8:00 a 12:00', 74),
(721, '07', '11', 2017, 'Libre Todo el dia', 73),
(722, '08', '11', 2017, 'Libre Todo el dia', 73),
(723, '09', '11', 2017, 'Libre Todo el dia', 73),
(724, '10', '11', 2017, 'Libre Todo el dia', 73),
(725, '09', '11', 2017, 'Libre Todo el dia', 108),
(726, '10', '11', 2017, 'Libre Todo el dia', 108),
(727, '16', '11', 2017, 'Libre Todo el dia', 108),
(728, '17', '11', 2017, 'Libre Todo el dia', 108),
(729, '16', '11', 2017, 'Libre Todo el dia', 92),
(730, '17', '11', 2017, 'Libre Todo el dia', 92),
(731, '08', '11', 2017, 'Libre Todo el dia', 90),
(732, '09', '11', 2017, 'Libre Todo el dia', 90),
(733, '10', '11', 2017, 'Libre Todo el dia', 90),
(734, '08', '11', 2017, 'Libre Todo el dia', 77),
(735, '09', '11', 2017, 'Libre Todo el dia', 77),
(736, '08', '11', 2017, 'Libre Todo el dia', 46),
(737, '09', '11', 2017, 'Libre Todo el dia', 46),
(738, '10', '11', 2017, 'Libre Todo el dia', 46),
(739, '08', '11', 2017, 'Libre Todo el dia', 85),
(740, '08', '11', 2017, 'Libre Todo el dia', 62),
(741, '08', '11', 2017, 'Libre de 8:00 a 12:00', 74),
(742, '08', '11', 2017, 'Libre Todo el dia', 81),
(743, '08', '11', 2017, 'Libre Todo el dia', 52),
(744, '09', '11', 2017, 'Libre Todo el dia', 52),
(745, '09', '11', 2017, 'Libre Todo el dia', 80),
(746, '09', '11', 2017, 'Libre de 14:00 a 18:00', 57),
(747, '10', '11', 2017, 'Libre Todo el dia', 44),
(748, '10', '11', 2017, 'Libre Todo el dia', 85),
(749, '10', '11', 2017, 'Libre Todo el dia', 68),
(750, '13', '11', 2017, 'Libre Todo el dia', 81),
(751, '14', '11', 2017, 'Libre Todo el dia', 81),
(752, '15', '11', 2017, 'Libre Todo el dia', 81),
(753, '16', '11', 2017, 'Libre Todo el dia', 81),
(754, '17', '11', 2017, 'Libre Todo el dia', 81),
(755, '14', '11', 2017, 'Libre Todo el dia', 107),
(756, '15', '11', 2017, 'Libre Todo el dia', 107),
(757, '16', '11', 2017, 'Libre Todo el dia', 107),
(758, '17', '11', 2017, 'Libre Todo el dia', 107),
(759, '18', '11', 2017, 'Libre Todo el dia', 107),
(760, '19', '11', 2017, 'Libre Todo el dia', 107),
(761, '14', '11', 2017, 'Libre Todo el dia', 85),
(762, '14', '11', 2017, 'Libre Todo el dia', 57),
(763, '14', '11', 2017, 'Libre Todo el dia', 73),
(764, '15', '11', 2017, 'Libre Todo el dia', 73),
(765, '16', '11', 2017, 'Libre Todo el dia', 73),
(766, '17', '11', 2017, 'Libre Todo el dia', 73),
(767, '15', '11', 2017, 'Libre Todo el dia', 98),
(768, '15', '11', 2017, 'Libre Todo el dia', 46),
(769, '15', '11', 2017, 'Libre Todo el dia', 57),
(770, '15', '11', 2017, 'Libre Todo el dia', 60),
(771, '16', '11', 2017, 'Libre Todo el dia', 60),
(772, '17', '11', 2017, 'Libre Todo el dia', 60),
(774, '16', '11', 2017, 'Libre Todo el dia', 55),
(775, '15', '11', 2017, 'Libre Todo el dia', 55),
(776, '16', '11', 2017, 'Libre Todo el dia', 57),
(777, '17', '11', 2017, 'Libre Todo el dia', 55),
(778, '20', '11', 2017, 'Libre Todo el dia', 98),
(779, '20', '11', 2017, 'Libre de 8:00 a 12:00', 57),
(781, '20', '11', 2017, 'Libre Todo el dia', 36),
(782, '21', '11', 2017, 'Libre de 8:00 a 12:00', 77),
(783, '21', '11', 2017, 'Libre Todo el dia', 73),
(784, '21', '11', 2017, 'Libre Todo el dia', 98),
(785, '21', '11', 2017, 'Libre Todo el dia', 80),
(786, '22', '11', 2017, 'Libre Todo el dia', 80),
(787, '21', '11', 2017, 'Libre de 14:00 a 18:00', 89),
(788, '22', '11', 2017, 'Libre Todo el dia', 89),
(789, '23', '11', 2017, 'Libre Todo el dia', 89),
(790, '24', '11', 2017, 'Libre Todo el dia', 89),
(791, '21', '11', 2017, 'Libre Todo el dia', 44),
(792, '22', '11', 2017, 'Libre de 8:00 a 12:00', 74),
(793, '22', '11', 2017, 'Libre Todo el dia', 107),
(794, '22', '11', 2017, 'Libre de 8:00 a 12:00', 46),
(795, '22', '11', 2017, 'Libre Todo el dia', 77),
(796, '22', '11', 2017, 'Libre de 8:00 a 12:00', 102),
(797, '22', '11', 2017, 'Libre Todo el dia', 73),
(798, '22', '11', 2017, 'Libre Todo el dia', 85),
(799, '22', '11', 2017, 'Libre Todo el dia', 98),
(800, '22', '11', 2017, 'Libre de 14:00 a 18:00', 55),
(801, '23', '11', 2017, 'Libre Todo el dia', 77),
(802, '24', '11', 2017, 'Libre Todo el dia', 46),
(803, '23', '11', 2017, 'Libre Todo el dia', 80),
(804, '24', '11', 2017, 'Libre Todo el dia', 98),
(805, '24', '11', 2017, 'Libre Todo el dia', 77),
(806, '24', '11', 2017, 'Libre Todo el dia', 80),
(807, '27', '11', 2017, 'Libre Todo el dia', 89),
(808, '27', '11', 2017, 'Libre de 8:00 a 12:00', 74),
(809, '27', '11', 2017, 'Libre Todo el dia', 73),
(810, '27', '11', 2017, 'Libre Todo el dia', 55),
(811, '27', '11', 2017, 'Libre Todo el dia', 47),
(812, '28', '11', 2017, 'Libre Todo el dia', 47),
(813, '27', '11', 2017, 'Libre Todo el dia', 36),
(814, '27', '11', 2017, 'Libre Todo el dia', 102),
(815, '27', '11', 2017, 'Libre Todo el dia', 86),
(816, '27', '11', 2017, 'Libre Todo el dia', 85),
(817, '28', '11', 2017, 'Libre Todo el dia', 85),
(818, '28', '11', 2017, 'Libre Todo el dia', 106),
(819, '28', '11', 2017, 'Libre Todo el dia', 36),
(820, '28', '11', 2017, 'Libre Todo el dia', 86),
(821, '28', '11', 2017, 'Libre Todo el dia', 44),
(822, '29', '11', 2017, 'Libre Todo el dia', 44),
(824, '30', '11', 2017, 'Libre Todo el dia', 68),
(825, '01', '12', 2017, 'Libre Todo el dia', 68),
(826, '29', '11', 2017, 'Libre Todo el dia', 98),
(827, '29', '11', 2017, 'Libre Todo el dia', 36),
(828, '29', '11', 2017, 'Libre de 8:00 a 12:00', 92),
(829, '29', '11', 2017, 'Libre Todo el dia', 86),
(830, '29', '11', 2017, 'Libre Todo el dia', 67),
(831, '30', '11', 2017, 'Libre Todo el dia', 67),
(832, '01', '12', 2017, 'Libre Todo el dia', 67),
(833, '02', '12', 2017, 'Libre Todo el dia', 67),
(834, '03', '12', 2017, 'Libre Todo el dia', 67),
(835, '04', '12', 2017, 'Libre Todo el dia', 67),
(836, '05', '12', 2017, 'Libre Todo el dia', 67),
(837, '29', '11', 2017, 'Libre Todo el dia', 70),
(838, '29', '11', 2017, 'Libre Todo el dia', 57),
(839, '30', '11', 2017, 'Libre Todo el dia', 57),
(840, '01', '12', 2017, 'Libre Todo el dia', 57),
(841, '29', '11', 2017, 'Libre Todo el dia', 85),
(842, '29', '11', 2017, 'Libre Todo el dia', 43),
(843, '30', '11', 2017, 'Libre Todo el dia', 43),
(844, '29', '11', 2017, 'Libre de 14:00 a 18:00', 68),
(845, '30', '11', 2017, 'Libre Todo el dia', 36),
(846, '30', '11', 2017, 'Libre Todo el dia', 86),
(847, '30', '11', 2017, 'Libre Todo el dia', 73),
(848, '04', '12', 2017, 'Libre Todo el dia', 108),
(849, '05', '12', 2017, 'Libre Todo el dia', 108),
(850, '06', '12', 2017, 'Libre Todo el dia', 108),
(851, '30', '11', 2017, 'Libre Todo el dia', 108),
(852, '01', '12', 2017, 'Libre de 8:00 a 12:00', 92),
(853, '01', '12', 2017, 'Libre Todo el dia', 86),
(854, '01', '12', 2017, 'Libre de 8:00 a 12:00', 55),
(855, '01', '12', 2017, 'Libre Todo el dia', 73),
(856, '01', '12', 2017, 'Libre Todo el dia', 36),
(857, '04', '12', 2017, 'Libre Todo el dia', 59),
(858, '04', '12', 2017, 'Libre Todo el dia', 55),
(859, '04', '12', 2017, 'Libre Todo el dia', 87),
(860, '04', '12', 2017, 'Libre Todo el dia', 90),
(861, '04', '12', 2017, 'Libre Todo el dia', 73),
(862, '04', '12', 2017, 'Libre Todo el dia', 95),
(863, '05', '12', 2017, 'Libre Todo el dia', 95),
(864, '04', '12', 2017, 'Libre Todo el dia', 56),
(865, '05', '12', 2017, 'Libre Todo el dia', 56),
(883, '05', '12', 2017, 'Libre Todo el dia', 93),
(884, '06', '12', 2017, 'Libre Todo el dia', 93),
(885, '07', '12', 2017, 'Libre Todo el dia', 93),
(886, '08', '12', 2017, 'Libre Todo el dia', 93),
(887, '09', '12', 2017, 'Libre Todo el dia', 93),
(888, '10', '12', 2017, 'Libre Todo el dia', 93),
(889, '11', '12', 2017, 'Libre Todo el dia', 93),
(890, '12', '12', 2017, 'Libre Todo el dia', 93),
(891, '13', '12', 2017, 'Libre Todo el dia', 93),
(892, '14', '12', 2017, 'Libre Todo el dia', 93),
(893, '15', '12', 2017, 'Libre Todo el dia', 93),
(894, '16', '12', 2017, 'Libre Todo el dia', 93),
(895, '17', '12', 2017, 'Libre Todo el dia', 93),
(896, '18', '12', 2017, 'Libre Todo el dia', 93),
(897, '19', '12', 2017, 'Libre Todo el dia', 93),
(901, '05', '12', 2017, 'Libre de 14:00 a 18:00', 77),
(903, '06', '12', 2017, 'Libre Todo el dia', 59),
(904, '06', '12', 2017, 'Libre de 8:00 a 12:00', 77),
(905, '06', '12', 2017, 'Libre Todo el dia', 73),
(906, '06', '12', 2017, 'Libre Todo el dia', 55),
(907, '06', '12', 2017, 'Libre Todo el dia', 98),
(908, '07', '12', 2017, 'Libre Todo el dia', 81),
(909, '07', '12', 2017, 'Libre Todo el dia', 107),
(910, '07', '12', 2017, 'Libre de 8:00 a 12:00', 57),
(911, '07', '12', 2017, 'Libre Todo el dia', 73),
(912, '07', '12', 2017, 'Libre de 8:00 a 12:00', 74),
(913, '07', '12', 2017, 'Libre Todo el dia', 55),
(914, '11', '12', 2017, 'Libre de 8:00 a 12:00', 84),
(915, '11', '12', 2017, 'Libre Todo el dia', 36),
(916, '12', '12', 2017, 'Libre Todo el dia', 98),
(917, '12', '12', 2017, 'Libre Todo el dia', 53),
(918, '12', '12', 2017, 'Libre Todo el dia', 73),
(919, '13', '12', 2017, 'Libre de 8:00 a 12:00', 74),
(920, '13', '12', 2017, 'Libre Todo el dia', 73),
(921, '13', '12', 2017, 'Libre Todo el dia', 70),
(922, '13', '12', 2017, 'Libre Todo el dia', 36),
(923, '13', '12', 2017, 'Libre de 14:00 a 18:00', 82),
(924, '13', '12', 2017, 'Libre Todo el dia', 53),
(925, '14', '12', 2017, 'Libre Todo el dia', 53),
(926, '14', '12', 2017, 'Libre Todo el dia', 98),
(927, '14', '12', 2017, 'Libre Todo el dia', 36),
(928, '14', '12', 2017, 'Libre Todo el dia', 70),
(929, '14', '12', 2017, 'Libre Todo el dia', 38),
(930, '15', '12', 2017, 'Libre Todo el dia', 38),
(931, '16', '12', 2017, 'Libre Todo el dia', 38),
(932, '17', '12', 2017, 'Libre Todo el dia', 38),
(933, '18', '12', 2017, 'Libre Todo el dia', 38),
(934, '19', '12', 2017, 'Libre Todo el dia', 38),
(935, '20', '12', 2017, 'Libre Todo el dia', 38),
(936, '21', '12', 2017, 'Libre Todo el dia', 38),
(937, '22', '12', 2017, 'Libre Todo el dia', 38),
(938, '23', '12', 2017, 'Libre Todo el dia', 38),
(939, '24', '12', 2017, 'Libre Todo el dia', 38),
(940, '25', '12', 2017, 'Libre Todo el dia', 38),
(941, '26', '12', 2017, 'Libre Todo el dia', 38),
(942, '27', '12', 2017, 'Libre Todo el dia', 38),
(943, '28', '12', 2017, 'Libre Todo el dia', 38),
(944, '29', '12', 2017, 'Libre Todo el dia', 38),
(945, '30', '12', 2017, 'Libre Todo el dia', 38),
(946, '31', '12', 2017, 'Libre Todo el dia', 38),
(947, '14', '12', 2017, 'Libre de 14:00 a 18:00', 74),
(948, '14', '12', 2017, 'Libre Todo el dia', 55),
(950, '15', '12', 2017, 'Libre Todo el dia', 77),
(951, '15', '12', 2017, 'Libre Todo el dia', 98),
(952, '15', '12', 2017, 'Libre Todo el dia', 70),
(953, '15', '12', 2017, 'Libre de 8:00 a 12:00', 57),
(954, '15', '12', 2017, 'Libre de 8:00 a 12:00', 53),
(955, '15', '12', 2017, 'Libre Todo el dia', 36),
(956, '15', '12', 2017, 'Libre de 14:00 a 18:00', 55),
(957, '18', '12', 2017, 'Libre Todo el dia', 107),
(958, '19', '12', 2017, 'Libre Todo el dia', 107),
(959, '20', '12', 2017, 'Libre Todo el dia', 107),
(960, '21', '12', 2017, 'Libre Todo el dia', 107),
(961, '22', '12', 2017, 'Libre Todo el dia', 107),
(962, '23', '12', 2017, 'Libre Todo el dia', 107),
(963, '24', '12', 2017, 'Libre Todo el dia', 107),
(964, '25', '12', 2017, 'Libre Todo el dia', 107),
(965, '26', '12', 2017, 'Libre Todo el dia', 107),
(966, '27', '12', 2017, 'Libre Todo el dia', 107),
(967, '28', '12', 2017, 'Libre Todo el dia', 107),
(968, '29', '12', 2017, 'Libre Todo el dia', 107),
(969, '30', '12', 2017, 'Libre Todo el dia', 107),
(970, '31', '12', 2017, 'Libre Todo el dia', 107),
(971, '18', '12', 2017, 'Libre Todo el dia', 73),
(972, '18', '12', 2017, 'Libre Todo el dia', 53),
(973, '19', '12', 2017, 'Libre Todo el dia', 53),
(974, '19', '12', 2017, 'Libre de 8:00 a 12:00', 77),
(975, '19', '12', 2017, 'Libre Todo el dia', 62),
(976, '19', '12', 2017, 'Libre de 8:00 a 12:00', 74),
(977, '19', '12', 2017, 'Libre Todo el dia', 36),
(978, '20', '12', 2017, 'Libre Todo el dia', 36),
(979, '21', '12', 2017, 'Libre Todo el dia', 36),
(980, '22', '12', 2017, 'Libre Todo el dia', 36),
(981, '20', '12', 2017, 'Libre Todo el dia', 53),
(984, '21', '12', 2017, 'Libre Todo el dia', 85),
(985, '22', '12', 2017, 'Libre Todo el dia', 85),
(986, '23', '12', 2017, 'Libre Todo el dia', 85),
(987, '24', '12', 2017, 'Libre Todo el dia', 85),
(988, '25', '12', 2017, 'Libre Todo el dia', 85),
(989, '26', '12', 2017, 'Libre Todo el dia', 85),
(990, '27', '12', 2017, 'Libre Todo el dia', 85),
(991, '28', '12', 2017, 'Libre Todo el dia', 85),
(992, '29', '12', 2017, 'Libre Todo el dia', 85),
(993, '30', '12', 2017, 'Libre Todo el dia', 85),
(994, '31', '12', 2017, 'Libre Todo el dia', 85),
(995, '20', '12', 2017, 'Libre de 8:00 a 12:00', 68),
(996, '20', '12', 2017, 'Libre Todo el dia', 62),
(997, '20', '12', 2017, 'Libre Todo el dia', 82),
(998, '20', '12', 2017, 'Libre Todo el dia', 77),
(999, '21', '12', 2017, 'Libre de 8:00 a 12:00', 89),
(1000, '21', '12', 2017, 'Libre Todo el dia', 81),
(1001, '22', '12', 2017, 'Libre Todo el dia', 81),
(1002, '23', '12', 2017, 'Libre Todo el dia', 81),
(1003, '24', '12', 2017, 'Libre Todo el dia', 81),
(1004, '25', '12', 2017, 'Libre Todo el dia', 81),
(1005, '26', '12', 2017, 'Libre Todo el dia', 81),
(1006, '27', '12', 2017, 'Libre Todo el dia', 81),
(1007, '28', '12', 2017, 'Libre Todo el dia', 81),
(1008, '29', '12', 2017, 'Libre Todo el dia', 81),
(1009, '30', '12', 2017, 'Libre Todo el dia', 81),
(1011, '21', '12', 2017, 'Libre Todo el dia', 98),
(1013, '21', '12', 2017, 'Libre Todo el dia', 62),
(1014, '26', '12', 2017, 'Libre Todo el dia', 103),
(1015, '27', '12', 2017, 'Libre Todo el dia', 103),
(1016, '28', '12', 2017, 'Libre Todo el dia', 103),
(1017, '29', '12', 2017, 'Libre Todo el dia', 103),
(1018, '30', '12', 2017, 'Libre Todo el dia', 103),
(1019, '31', '12', 2017, 'Libre Todo el dia', 103),
(1020, '21', '12', 2017, 'Libre Todo el dia', 82),
(1021, '26', '12', 2017, 'Libre Todo el dia', 77),
(1022, '27', '12', 2017, 'Libre Todo el dia', 77),
(1023, '28', '12', 2017, 'Libre Todo el dia', 77),
(1024, '29', '12', 2017, 'Libre Todo el dia', 77),
(1025, '30', '12', 2017, 'Libre Todo el dia', 77),
(1027, '26', '12', 2017, 'Libre Todo el dia', 44),
(1028, '27', '12', 2017, 'Libre Todo el dia', 44),
(1029, '28', '12', 2017, 'Libre Todo el dia', 44),
(1030, '29', '12', 2017, 'Libre Todo el dia', 44),
(1031, '30', '12', 2017, 'Libre Todo el dia', 44),
(1032, '31', '12', 2017, 'Libre Todo el dia', 44),
(1033, '26', '12', 2017, 'Libre Todo el dia', 98),
(1054, '26', '12', 2017, 'Libre Todo el dia', 36),
(1055, '27', '12', 2017, 'Libre Todo el dia', 36),
(1056, '28', '12', 2017, 'Libre Todo el dia', 36),
(1057, '29', '12', 2017, 'Libre Todo el dia', 36),
(1058, '27', '12', 2017, 'Libre Todo el dia', 98),
(1059, '27', '12', 2017, 'Libre Todo el dia', 92),
(1060, '28', '12', 2017, 'Libre Todo el dia', 92),
(1061, '29', '12', 2017, 'Libre Todo el dia', 92),
(1062, '30', '12', 2017, 'Libre Todo el dia', 92),
(1063, '31', '12', 2017, 'Libre Todo el dia', 92),
(1077, '28', '12', 2017, 'Libre de 8:00 a 12:00', 74),
(1078, '29', '12', 2017, 'Libre Todo el dia', 62),
(1079, '30', '12', 2017, 'Libre Todo el dia', 86),
(1080, '31', '12', 2017, 'Libre Todo el dia', 86),
(1172, '08', '01', 2018, 'Libre Todo el dia', 51),
(1173, '08', '01', 2018, 'Libre Todo el dia', 52),
(1174, '08', '01', 2018, 'Libre Todo el dia', 81),
(1175, '09', '01', 2018, 'Libre Todo el dia', 86),
(1176, '09', '01', 2018, 'Libre Todo el dia', 107),
(1177, '10', '01', 2018, 'Libre Todo el dia', 107),
(1178, '11', '01', 2018, 'Libre Todo el dia', 107),
(1179, '12', '01', 2018, 'Libre Todo el dia', 107),
(1180, '13', '01', 2018, 'Libre Todo el dia', 107),
(1181, '14', '01', 2018, 'Libre Todo el dia', 107),
(1182, '15', '01', 2018, 'Libre Todo el dia', 107),
(1183, '16', '01', 2018, 'Libre Todo el dia', 107),
(1184, '17', '01', 2018, 'Libre Todo el dia', 107),
(1185, '08', '01', 2018, 'Libre Todo el dia', 107),
(1186, '09', '01', 2018, 'Libre Todo el dia', 96),
(1187, '09', '01', 2018, 'Libre Todo el dia', 60),
(1188, '10', '01', 2018, 'Libre Todo el dia', 60),
(1189, '11', '01', 2018, 'Libre Todo el dia', 60),
(1190, '12', '01', 2018, 'Libre Todo el dia', 60),
(1191, '13', '01', 2018, 'Libre Todo el dia', 60),
(1192, '14', '01', 2018, 'Libre Todo el dia', 60),
(1193, '15', '01', 2018, 'Libre Todo el dia', 60),
(1194, '16', '01', 2018, 'Libre Todo el dia', 60),
(1195, '17', '01', 2018, 'Libre Todo el dia', 60),
(1196, '18', '01', 2018, 'Libre Todo el dia', 60),
(1197, '19', '01', 2018, 'Libre Todo el dia', 60),
(1198, '20', '01', 2018, 'Libre Todo el dia', 60),
(1199, '21', '01', 2018, 'Libre Todo el dia', 60),
(1200, '22', '01', 2018, 'Libre Todo el dia', 60),
(1201, '23', '01', 2018, 'Libre Todo el dia', 60),
(1202, '09', '01', 2018, 'Libre Todo el dia', 52),
(1203, '09', '01', 2018, 'Libre Todo el dia', 98),
(1204, '10', '01', 2018, 'Libre Todo el dia', 96),
(1205, '11', '01', 2018, 'Libre Todo el dia', 96),
(1206, '11', '01', 2018, 'Libre Todo el dia', 55),
(1207, '11', '01', 2018, 'Libre de 14:00 a 18:00', 51),
(1208, '12', '01', 2018, 'Libre Todo el dia', 96),
(1209, '13', '01', 2018, 'Libre Todo el dia', 47),
(1210, '14', '01', 2018, 'Libre Todo el dia', 47),
(1211, '15', '01', 2018, 'Libre Todo el dia', 47),
(1212, '16', '01', 2018, 'Libre Todo el dia', 47),
(1213, '17', '01', 2018, 'Libre Todo el dia', 47),
(1214, '18', '01', 2018, 'Libre Todo el dia', 47),
(1215, '19', '01', 2018, 'Libre Todo el dia', 47),
(1216, '20', '01', 2018, 'Libre Todo el dia', 47),
(1217, '21', '01', 2018, 'Libre Todo el dia', 47),
(1218, '22', '01', 2018, 'Libre Todo el dia', 47),
(1219, '23', '01', 2018, 'Libre Todo el dia', 47),
(1220, '24', '01', 2018, 'Libre Todo el dia', 47),
(1221, '25', '01', 2018, 'Libre Todo el dia', 47),
(1222, '26', '01', 2018, 'Libre Todo el dia', 47),
(1223, '27', '01', 2018, 'Libre Todo el dia', 47),
(1224, '28', '01', 2018, 'Libre Todo el dia', 47),
(1225, '29', '01', 2018, 'Libre Todo el dia', 47),
(1226, '30', '01', 2018, 'Libre Todo el dia', 47),
(1227, '15', '01', 2018, 'Libre Todo el dia', 36),
(1228, '15', '01', 2018, 'Libre Todo el dia', 96),
(1229, '16', '01', 2018, 'Libre Todo el dia', 73),
(1230, '17', '01', 2018, 'Libre de 14:00 a 18:00', 77),
(1231, '19', '01', 2018, 'Libre Todo el dia', 73),
(1232, '22', '01', 2018, 'Libre Todo el dia', 98),
(1233, '22', '01', 2018, 'Libre Todo el dia', 51),
(1234, '22', '01', 2018, 'Libre Todo el dia', 54),
(1235, '23', '01', 2018, 'Libre Todo el dia', 54),
(1239, '22', '01', 2018, 'Libre de 14:00 a 18:00', 55),
(1240, '23', '01', 2018, 'Libre Todo el dia', 44),
(1241, '23', '01', 2018, 'Libre Todo el dia', 51),
(1242, '23', '01', 2018, 'Libre Todo el dia', 36),
(1244, '24', '01', 2018, 'Libre Todo el dia', 57),
(1245, '25', '01', 2018, 'Libre Todo el dia', 57),
(1246, '25', '01', 2018, 'Libre de 8:00 a 12:00', 85),
(1247, '25', '01', 2018, 'Libre Todo el dia', 109),
(1248, '26', '01', 2018, 'Libre de 8:00 a 12:00', 74),
(1249, '26', '01', 2018, 'Libre Todo el dia', 51),
(1250, '26', '01', 2018, 'Libre Todo el dia', 67),
(1251, '26', '01', 2018, 'Libre Todo el dia', 109),
(1252, '26', '01', 2018, 'Libre Todo el dia', 70),
(1253, '30', '01', 2018, 'Libre de 8:00 a 12:00', 74),
(1254, '01', '02', 2018, 'Libre de 8:00 a 12:00', 74),
(1255, '01', '02', 2018, 'Libre de 14:00 a 18:00', 55),
(1256, '02', '02', 2018, 'Libre Todo el dia', 102),
(1257, '02', '02', 2018, 'Libre de 14:00 a 18:00', 55),
(1258, '05', '02', 2018, 'Libre Todo el dia', 59),
(1259, '06', '02', 2018, 'Libre Todo el dia', 59),
(1260, '05', '02', 2018, 'Libre Todo el dia', 36),
(1261, '06', '02', 2018, 'Libre Todo el dia', 67),
(1262, '06', '02', 2018, 'Libre de 14:00 a 18:00', 90),
(1263, '07', '02', 2018, 'Libre Todo el dia', 90),
(1264, '06', '02', 2018, 'Libre Todo el dia', 109),
(1265, '14', '02', 2018, 'Libre Todo el dia', 106),
(1266, '15', '02', 2018, 'Libre Todo el dia', 106),
(1267, '16', '02', 2018, 'Libre Todo el dia', 106),
(1268, '17', '02', 2018, 'Libre Todo el dia', 106),
(1269, '18', '02', 2018, 'Libre Todo el dia', 106),
(1270, '06', '02', 2018, 'Libre Todo el dia', 68),
(1271, '07', '02', 2018, 'Libre Todo el dia', 68),
(1272, '08', '02', 2018, 'Libre Todo el dia', 68),
(1273, '09', '02', 2018, 'Libre Todo el dia', 68),
(1274, '10', '02', 2018, 'Libre Todo el dia', 68),
(1275, '11', '02', 2018, 'Libre Todo el dia', 68),
(1276, '12', '02', 2018, 'Libre Todo el dia', 68),
(1277, '13', '02', 2018, 'Libre Todo el dia', 68),
(1278, '07', '02', 2018, 'Libre Todo el dia', 109),
(1279, '07', '02', 2018, 'Libre Todo el dia', 96),
(1280, '07', '02', 2018, 'Libre Todo el dia', 57),
(1281, '07', '02', 2018, 'Libre Todo el dia', 85),
(1282, '08', '02', 2018, 'Libre Todo el dia', 96),
(1283, '08', '02', 2018, 'Libre Todo el dia', 85),
(1284, '08', '02', 2018, 'Libre de 8:00 a 12:00', 77),
(1285, '08', '02', 2018, 'Libre Todo el dia', 98),
(1286, '08', '02', 2018, 'Libre Todo el dia', 109),
(1287, '09', '02', 2018, 'Libre de 8:00 a 12:00', 77),
(1288, '09', '02', 2018, 'Libre de 8:00 a 12:00', 85),
(1289, '09', '02', 2018, 'Libre Todo el dia', 109),
(1290, '09', '02', 2018, 'Libre Todo el dia', 46),
(1291, '14', '02', 2018, 'Libre de 8:00 a 12:00', 109),
(1292, '14', '02', 2018, 'Libre Todo el dia', 93),
(1293, '15', '02', 2018, 'Libre Todo el dia', 93),
(1294, '16', '02', 2018, 'Libre Todo el dia', 93),
(1295, '14', '02', 2018, 'Libre de 14:00 a 18:00', 55);
INSERT INTO `tb_calendario` (`id_calendario`, `dia`, `mes`, `anio`, `horario`, `id_espacio`) VALUES
(1296, '15', '02', 2018, 'Libre de 8:00 a 12:00', 74),
(1297, '15', '02', 2018, 'Libre Todo el dia', 98),
(1298, '15', '02', 2018, 'Libre Todo el dia', 85),
(1299, '16', '02', 2018, 'Libre Todo el dia', 98),
(1300, '16', '02', 2018, 'Libre Todo el dia', 54),
(1301, '16', '02', 2018, 'Libre de 14:00 a 18:00', 74),
(1302, '19', '02', 2018, 'Libre Todo el dia', 109),
(1303, '19', '02', 2018, 'Libre Todo el dia', 67),
(1304, '19', '02', 2018, 'Libre Todo el dia', 56),
(1305, '19', '02', 2018, 'Libre de 8:00 a 12:00', 55),
(1306, '19', '02', 2018, 'Libre Todo el dia', 47),
(1307, '20', '02', 2018, 'Libre Todo el dia', 47),
(1308, '21', '02', 2018, 'Libre Todo el dia', 47),
(1309, '22', '02', 2018, 'Libre Todo el dia', 47),
(1310, '23', '02', 2018, 'Libre Todo el dia', 47),
(1311, '24', '02', 2018, 'Libre Todo el dia', 47),
(1312, '20', '02', 2018, 'Libre Todo el dia', 83),
(1313, '20', '02', 2018, 'Libre Todo el dia', 85),
(1315, '20', '02', 2018, 'Libre Todo el dia', 67),
(1316, '20', '02', 2018, 'Libre Todo el dia', 109),
(1319, '21', '02', 2018, 'Libre Todo el dia', 96),
(1320, '21', '02', 2018, 'Libre de 8:00 a 12:00', 74),
(1321, '21', '02', 2018, 'Libre de 8:00 a 12:00', 77),
(1322, '21', '02', 2018, 'Libre Todo el dia', 98),
(1323, '21', '02', 2018, 'Libre Todo el dia', 49),
(1324, '27', '02', 2018, 'Libre Todo el dia', 49),
(1325, '28', '02', 2018, 'Libre Todo el dia', 49),
(1326, '21', '02', 2018, 'Libre Todo el dia', 59),
(1327, '21', '02', 2018, 'Libre de 14:00 a 18:00', 67),
(1328, '22', '02', 2018, 'Libre Todo el dia', 102),
(1329, '22', '02', 2018, 'Libre Todo el dia', 109),
(1330, '22', '02', 2018, 'Libre Todo el dia', 67),
(1331, '23', '02', 2018, 'Libre Todo el dia', 98),
(1332, '23', '02', 2018, 'Libre Todo el dia', 106),
(1333, '23', '02', 2018, 'Libre Todo el dia', 108),
(1334, '23', '02', 2018, 'Libre Todo el dia', 109),
(1335, '23', '02', 2018, 'Libre Todo el dia', 85),
(1336, '23', '02', 2018, 'Libre de 14:00 a 18:00', 55),
(1337, '26', '02', 2018, 'Libre de 8:00 a 12:00', 85),
(1338, '26', '02', 2018, 'Libre de 8:00 a 12:00', 74),
(1339, '26', '02', 2018, 'Libre Todo el dia', 109),
(1340, '26', '02', 2018, 'Libre de 14:00 a 18:00', 55),
(1341, '27', '02', 2018, 'Libre de 8:00 a 12:00', 74),
(1342, '27', '02', 2018, 'Libre Todo el dia', 91),
(1343, '28', '02', 2018, 'Libre Todo el dia', 91),
(1344, '01', '03', 2018, 'Libre Todo el dia', 91),
(1345, '02', '03', 2018, 'Libre Todo el dia', 91),
(1346, '03', '03', 2018, 'Libre Todo el dia', 91),
(1347, '04', '03', 2018, 'Libre Todo el dia', 91),
(1348, '05', '03', 2018, 'Libre Todo el dia', 91),
(1349, '06', '03', 2018, 'Libre Todo el dia', 91),
(1350, '07', '03', 2018, 'Libre Todo el dia', 91),
(1351, '08', '03', 2018, 'Libre Todo el dia', 91),
(1352, '09', '03', 2018, 'Libre Todo el dia', 91),
(1353, '10', '03', 2018, 'Libre Todo el dia', 91),
(1354, '11', '03', 2018, 'Libre Todo el dia', 91),
(1355, '12', '03', 2018, 'Libre Todo el dia', 91),
(1356, '13', '03', 2018, 'Libre Todo el dia', 91),
(1357, '14', '03', 2018, 'Libre Todo el dia', 91),
(1358, '15', '03', 2018, 'Libre Todo el dia', 91),
(1359, '16', '03', 2018, 'Libre Todo el dia', 91),
(1360, '17', '03', 2018, 'Libre Todo el dia', 91),
(1361, '18', '03', 2018, 'Libre Todo el dia', 91),
(1362, '19', '03', 2018, 'Libre Todo el dia', 91),
(1363, '20', '03', 2018, 'Libre Todo el dia', 91),
(1364, '21', '03', 2018, 'Libre Todo el dia', 91),
(1365, '22', '03', 2018, 'Libre Todo el dia', 91),
(1366, '23', '03', 2018, 'Libre Todo el dia', 91),
(1367, '24', '03', 2018, 'Libre Todo el dia', 91),
(1368, '27', '02', 2018, 'Libre Todo el dia', 38),
(1369, '27', '02', 2018, 'Libre Todo el dia', 48),
(1370, '28', '02', 2018, 'Libre Todo el dia', 48),
(1371, '01', '03', 2018, 'Libre Todo el dia', 48),
(1372, '02', '03', 2018, 'Libre Todo el dia', 48),
(1373, '28', '02', 2018, 'Libre Todo el dia', 107),
(1374, '28', '02', 2018, 'Libre Todo el dia', 83),
(1375, '27', '02', 2018, 'Libre Todo el dia', 89),
(1376, '27', '02', 2018, 'Libre Todo el dia', 108),
(1377, '27', '02', 2018, 'Libre Todo el dia', 84),
(1378, '27', '02', 2018, 'Libre Todo el dia', 61),
(1379, '28', '02', 2018, 'Libre Todo el dia', 61),
(1380, '27', '02', 2018, 'Libre de 14:00 a 18:00', 107),
(1381, '28', '02', 2018, 'Libre Todo el dia', 36),
(1382, '28', '02', 2018, 'Libre de 14:00 a 18:00', 55),
(1383, '01', '03', 2018, 'Libre Todo el dia', 109),
(1384, '02', '03', 2018, 'Libre de 14:00 a 18:00', 81),
(1385, '05', '03', 2018, 'Libre Todo el dia', 36),
(1386, '06', '03', 2018, 'Libre Todo el dia', 36),
(1387, '06', '03', 2018, 'Libre Todo el dia', 57),
(1388, '07', '03', 2018, 'Libre Todo el dia', 53),
(1389, '08', '03', 2018, 'Libre Todo el dia', 53),
(1390, '06', '03', 2018, 'Libre Todo el dia', 45),
(1391, '07', '03', 2018, 'Libre Todo el dia', 109),
(1392, '07', '03', 2018, 'Libre Todo el dia', 36),
(1393, '07', '03', 2018, 'Libre de 14:00 a 18:00', 55),
(1394, '08', '03', 2018, 'Libre Todo el dia', 67),
(1395, '09', '03', 2018, 'Libre Todo el dia', 107),
(1396, '09', '03', 2018, 'Libre Todo el dia', 93),
(1397, '09', '03', 2018, 'Libre Todo el dia', 81),
(1398, '09', '03', 2018, 'Libre Todo el dia', 54),
(1399, '09', '03', 2018, 'Libre Todo el dia', 84),
(1400, '12', '03', 2018, 'Libre Todo el dia', 75),
(1401, '12', '03', 2018, 'Libre Todo el dia', 107),
(1402, '12', '03', 2018, 'Libre Todo el dia', 60),
(1403, '12', '03', 2018, 'Libre de 8:00 a 12:00', 93),
(1404, '12', '03', 2018, 'Libre Todo el dia', 74),
(1405, '12', '03', 2018, 'Libre Todo el dia', 54),
(1406, '12', '03', 2018, 'Libre Todo el dia', 39),
(1407, '12', '03', 2018, 'Libre de 14:00 a 18:00', 55),
(1408, '13', '03', 2018, 'Libre Todo el dia', 57),
(1409, '13', '03', 2018, 'Libre Todo el dia', 109),
(1410, '13', '03', 2018, 'Libre Todo el dia', 36),
(1411, '14', '03', 2018, 'Libre Todo el dia', 98),
(1412, '14', '03', 2018, 'Libre Todo el dia', 109),
(1413, '14', '03', 2018, 'Libre Todo el dia', 54),
(1414, '14', '03', 2018, 'Libre Todo el dia', 73),
(1415, '15', '03', 2018, 'Libre Todo el dia', 73),
(1416, '16', '03', 2018, 'Libre Todo el dia', 73),
(1417, '17', '03', 2018, 'Libre Todo el dia', 73),
(1418, '18', '03', 2018, 'Libre Todo el dia', 73),
(1419, '19', '03', 2018, 'Libre Todo el dia', 73),
(1420, '20', '03', 2018, 'Libre Todo el dia', 73),
(1421, '21', '03', 2018, 'Libre Todo el dia', 73),
(1422, '22', '03', 2018, 'Libre Todo el dia', 73),
(1423, '23', '03', 2018, 'Libre Todo el dia', 73),
(1424, '24', '03', 2018, 'Libre Todo el dia', 73),
(1425, '25', '03', 2018, 'Libre Todo el dia', 73),
(1426, '26', '03', 2018, 'Libre Todo el dia', 73),
(1427, '27', '03', 2018, 'Libre Todo el dia', 73),
(1428, '28', '03', 2018, 'Libre Todo el dia', 73),
(1429, '29', '03', 2018, 'Libre Todo el dia', 73),
(1430, '30', '03', 2018, 'Libre Todo el dia', 73),
(1431, '31', '03', 2018, 'Libre Todo el dia', 73),
(1432, '01', '04', 2018, 'Libre Todo el dia', 73),
(1433, '02', '04', 2018, 'Libre Todo el dia', 73),
(1434, '03', '04', 2018, 'Libre Todo el dia', 73),
(1435, '04', '04', 2018, 'Libre Todo el dia', 73),
(1436, '05', '04', 2018, 'Libre Todo el dia', 73),
(1437, '06', '04', 2018, 'Libre Todo el dia', 73),
(1438, '07', '04', 2018, 'Libre Todo el dia', 73),
(1439, '08', '04', 2018, 'Libre Todo el dia', 73),
(1462, '01', '05', 2018, 'Libre Todo el dia', 73),
(1463, '02', '05', 2018, 'Libre Todo el dia', 73),
(1464, '03', '05', 2018, 'Libre Todo el dia', 73),
(1465, '04', '05', 2018, 'Libre Todo el dia', 73),
(1466, '05', '05', 2018, 'Libre Todo el dia', 73),
(1493, '01', '06', 2018, 'Libre Todo el dia', 73),
(1494, '02', '06', 2018, 'Libre Todo el dia', 73),
(1495, '03', '06', 2018, 'Libre Todo el dia', 73),
(1496, '04', '06', 2018, 'Libre Todo el dia', 73),
(1497, '05', '06', 2018, 'Libre Todo el dia', 73),
(1508, '14', '03', 2018, 'Libre Todo el dia', 108),
(1509, '15', '03', 2018, 'Libre Todo el dia', 108),
(1510, '16', '03', 2018, 'Libre de 8:00 a 12:00', 108),
(1511, '15', '03', 2018, 'Libre Todo el dia', 87),
(1512, '15', '03', 2018, 'Libre Todo el dia', 59),
(1513, '16', '03', 2018, 'Libre de 8:00 a 12:00', 59),
(1514, '15', '03', 2018, 'Libre Todo el dia', 55),
(1515, '15', '03', 2018, 'Libre Todo el dia', 45),
(1516, '16', '03', 2018, 'Libre de 8:00 a 12:00', 45),
(1517, '15', '03', 2018, 'Libre Todo el dia', 85),
(1518, '16', '03', 2018, 'Libre Todo el dia', 85),
(1519, '17', '03', 2018, 'Libre Todo el dia', 85),
(1520, '18', '03', 2018, 'Libre Todo el dia', 85),
(1521, '19', '03', 2018, 'Libre Todo el dia', 85),
(1522, '20', '03', 2018, 'Libre Todo el dia', 85),
(1523, '21', '03', 2018, 'Libre Todo el dia', 85),
(1524, '22', '03', 2018, 'Libre Todo el dia', 85),
(1526, '15', '03', 2018, 'Libre de 8:00 a 12:00', 109),
(1527, '15', '03', 2018, 'Libre Todo el dia', 67),
(1528, '15', '03', 2018, 'Libre Todo el dia', 36),
(1529, '15', '03', 2018, 'Libre de 14:00 a 18:00', 90),
(1530, '16', '03', 2018, 'Libre Todo el dia', 90),
(1531, '20', '03', 2018, 'Libre Todo el dia', 90),
(1532, '16', '03', 2018, 'Libre Todo el dia', 35),
(1533, '16', '03', 2018, 'Libre Todo el dia', 36),
(1534, '16', '03', 2018, 'Libre Todo el dia', 109),
(1535, '16', '03', 2018, 'Libre Todo el dia', 55),
(1536, '20', '03', 2018, 'Libre Todo el dia', 98),
(1537, '20', '03', 2018, 'Libre Todo el dia', 54),
(1539, '21', '03', 2018, 'Libre de 8:00 a 12:00', 68),
(1540, '21', '03', 2018, 'Libre Todo el dia', 55),
(1541, '21', '03', 2018, 'Libre Todo el dia', 57),
(1542, '21', '03', 2018, 'Libre Todo el dia', 45),
(1543, '22', '03', 2018, 'Libre Todo el dia', 45),
(1544, '23', '03', 2018, 'Libre Todo el dia', 45),
(1545, '21', '03', 2018, 'Libre Todo el dia', 54),
(1547, '22', '03', 2018, 'Libre Todo el dia', 109),
(1548, '22', '03', 2018, 'Libre Todo el dia', 54),
(1551, '24', '03', 2018, 'Libre Todo el dia', 109),
(1552, '25', '03', 2018, 'Libre Todo el dia', 109),
(1553, '26', '03', 2018, 'Libre Todo el dia', 109),
(1554, '27', '03', 2018, 'Libre Todo el dia', 109),
(1555, '28', '03', 2018, 'Libre Todo el dia', 109),
(1556, '29', '03', 2018, 'Libre Todo el dia', 109),
(1557, '30', '03', 2018, 'Libre Todo el dia', 109),
(1558, '31', '03', 2018, 'Libre Todo el dia', 109),
(1559, '23', '03', 2018, 'Libre Todo el dia', 54),
(1561, '26', '03', 2018, 'Libre Todo el dia', 67),
(1562, '26', '03', 2018, 'Libre Todo el dia', 54),
(1563, '27', '03', 2018, 'Libre Todo el dia', 36),
(1564, '27', '03', 2018, 'Libre Todo el dia', 67),
(1565, '27', '03', 2018, 'Libre Todo el dia', 107),
(1566, '27', '03', 2018, 'Libre Todo el dia', 81),
(1567, '27', '03', 2018, 'Libre Todo el dia', 60),
(1568, '28', '03', 2018, 'Libre Todo el dia', 60),
(1569, '27', '03', 2018, 'Libre Todo el dia', 54),
(1571, '28', '03', 2018, 'Libre Todo el dia', 67),
(1572, '28', '03', 2018, 'Libre Todo el dia', 36),
(1573, '01', '04', 2018, 'Libre Todo el dia', 109),
(1574, '02', '04', 2018, 'Libre Todo el dia', 109),
(1575, '03', '04', 2018, 'Libre Todo el dia', 109),
(1576, '04', '04', 2018, 'Libre Todo el dia', 109),
(1577, '05', '04', 2018, 'Libre Todo el dia', 109),
(1578, '06', '04', 2018, 'Libre Todo el dia', 109),
(1579, '07', '04', 2018, 'Libre Todo el dia', 109),
(1580, '08', '04', 2018, 'Libre Todo el dia', 109),
(1581, '09', '04', 2018, 'Libre Todo el dia', 109),
(1582, '10', '04', 2018, 'Libre Todo el dia', 109),
(1583, '02', '04', 2018, 'Libre Todo el dia', 36),
(1584, '02', '04', 2018, 'Libre Todo el dia', 54),
(1585, '03', '04', 2018, 'Libre Todo el dia', 54),
(1593, '02', '04', 2018, 'Libre de 14:00 a 18:00', 55),
(1595, '03', '04', 2018, 'Libre de 8:00 a 12:00', 85),
(1596, '03', '04', 2018, 'Libre Todo el dia', 55),
(1597, '04', '04', 2018, 'Libre Todo el dia', 38),
(1598, '04', '04', 2018, 'Libre Todo el dia', 61),
(1599, '05', '04', 2018, 'Libre Todo el dia', 61),
(1600, '06', '04', 2018, 'Libre Todo el dia', 61),
(1601, '07', '04', 2018, 'Libre Todo el dia', 61),
(1602, '08', '04', 2018, 'Libre Todo el dia', 61),
(1603, '09', '04', 2018, 'Libre Todo el dia', 61),
(1604, '10', '04', 2018, 'Libre Todo el dia', 61),
(1605, '11', '04', 2018, 'Libre Todo el dia', 61),
(1606, '12', '04', 2018, 'Libre Todo el dia', 61),
(1607, '13', '04', 2018, 'Libre Todo el dia', 61),
(1608, '14', '04', 2018, 'Libre Todo el dia', 61),
(1609, '15', '04', 2018, 'Libre Todo el dia', 61),
(1610, '16', '04', 2018, 'Libre Todo el dia', 61),
(1611, '17', '04', 2018, 'Libre Todo el dia', 61),
(1612, '18', '04', 2018, 'Libre Todo el dia', 61),
(1613, '19', '04', 2018, 'Libre Todo el dia', 61),
(1614, '20', '04', 2018, 'Libre Todo el dia', 61),
(1615, '21', '04', 2018, 'Libre Todo el dia', 61),
(1616, '22', '04', 2018, 'Libre Todo el dia', 61),
(1617, '23', '04', 2018, 'Libre Todo el dia', 61),
(1618, '24', '04', 2018, 'Libre Todo el dia', 61),
(1619, '25', '04', 2018, 'Libre Todo el dia', 61),
(1620, '26', '04', 2018, 'Libre Todo el dia', 61),
(1621, '27', '04', 2018, 'Libre Todo el dia', 61),
(1622, '28', '04', 2018, 'Libre Todo el dia', 61),
(1623, '29', '04', 2018, 'Libre Todo el dia', 61),
(1624, '30', '04', 2018, 'Libre Todo el dia', 61),
(1625, '04', '04', 2018, 'Libre Todo el dia', 68),
(1626, '04', '04', 2018, 'Libre de 14:00 a 18:00', 93),
(1627, '04', '04', 2018, 'Libre de 14:00 a 18:00', 55),
(1628, '05', '04', 2018, 'Libre de 8:00 a 12:00', 85),
(1629, '05', '04', 2018, 'Libre Todo el dia', 59),
(1630, '05', '04', 2018, 'Libre Todo el dia', 36),
(1631, '05', '04', 2018, 'Libre Todo el dia', 67),
(1632, '09', '04', 2018, 'Libre Todo el dia', 68),
(1633, '10', '04', 2018, 'Libre Todo el dia', 68),
(1634, '11', '04', 2018, 'Libre Todo el dia', 68),
(1635, '12', '04', 2018, 'Libre Todo el dia', 68),
(1636, '13', '04', 2018, 'Libre Todo el dia', 68),
(1637, '05', '04', 2018, 'Libre Todo el dia', 55),
(1638, '06', '04', 2018, 'Libre Todo el dia', 55),
(1639, '06', '04', 2018, 'Libre Todo el dia', 67),
(1640, '10', '04', 2018, 'Libre Todo el dia', 106),
(1641, '10', '04', 2018, 'Libre Todo el dia', 66),
(1642, '11', '04', 2018, 'Libre Todo el dia', 66),
(1643, '12', '04', 2018, 'Libre Todo el dia', 66),
(1644, '13', '04', 2018, 'Libre Todo el dia', 66),
(1645, '14', '04', 2018, 'Libre Todo el dia', 66),
(1646, '15', '04', 2018, 'Libre Todo el dia', 66),
(1647, '16', '04', 2018, 'Libre Todo el dia', 66),
(1648, '17', '04', 2018, 'Libre Todo el dia', 66),
(1649, '18', '04', 2018, 'Libre Todo el dia', 66),
(1650, '19', '04', 2018, 'Libre Todo el dia', 66),
(1651, '20', '04', 2018, 'Libre Todo el dia', 66),
(1652, '21', '04', 2018, 'Libre Todo el dia', 66),
(1653, '22', '04', 2018, 'Libre Todo el dia', 66),
(1654, '23', '04', 2018, 'Libre Todo el dia', 66),
(1655, '24', '04', 2018, 'Libre Todo el dia', 66),
(1656, '25', '04', 2018, 'Libre Todo el dia', 66),
(1657, '26', '04', 2018, 'Libre Todo el dia', 66),
(1658, '27', '04', 2018, 'Libre Todo el dia', 66),
(1659, '28', '04', 2018, 'Libre Todo el dia', 66),
(1660, '29', '04', 2018, 'Libre Todo el dia', 66),
(1661, '30', '04', 2018, 'Libre Todo el dia', 66),
(1662, '01', '05', 2018, 'Libre Todo el dia', 66),
(1663, '09', '04', 2018, 'Libre Todo el dia', 95),
(1664, '09', '04', 2018, 'Libre de 8:00 a 12:00', 107),
(1665, '09', '04', 2018, 'Libre Todo el dia', 55),
(1667, '09', '04', 2018, 'Libre Todo el dia', 98),
(1668, '10', '04', 2018, 'Libre Todo el dia', 95),
(1669, '10', '04', 2018, 'Libre Todo el dia', 55),
(1670, '10', '04', 2018, 'Libre de 14:00 a 18:00', 81),
(1671, '11', '04', 2018, 'Libre Todo el dia', 81),
(1672, '10', '04', 2018, 'Libre Todo el dia', 103),
(1673, '11', '04', 2018, 'Libre Todo el dia', 103),
(1674, '10', '04', 2018, 'Libre de 8:00 a 12:00', 56),
(1675, '11', '04', 2018, 'Libre Todo el dia', 109),
(1676, '12', '04', 2018, 'Libre Todo el dia', 109),
(1677, '13', '04', 2018, 'Libre Todo el dia', 109),
(1678, '14', '04', 2018, 'Libre Todo el dia', 109),
(1679, '15', '04', 2018, 'Libre Todo el dia', 109),
(1680, '11', '04', 2018, 'Libre Todo el dia', 53),
(1681, '11', '04', 2018, 'Libre Todo el dia', 70),
(1682, '12', '04', 2018, 'Libre Todo el dia', 70),
(1683, '13', '04', 2018, 'Libre Todo el dia', 70),
(1684, '11', '04', 2018, 'Libre Todo el dia', 78),
(1685, '12', '04', 2018, 'Libre Todo el dia', 78),
(1686, '13', '04', 2018, 'Libre Todo el dia', 78),
(1687, '11', '04', 2018, 'Libre Todo el dia', 49),
(1688, '12', '04', 2018, 'Libre Todo el dia', 49),
(1689, '13', '04', 2018, 'Libre Todo el dia', 49),
(1690, '11', '04', 2018, 'Libre Todo el dia', 46),
(1691, '12', '04', 2018, 'Libre Todo el dia', 46),
(1692, '11', '04', 2018, 'Libre Todo el dia', 96),
(1693, '11', '04', 2018, 'Libre Todo el dia', 85),
(1694, '11', '04', 2018, 'Libre Todo el dia', 47),
(1695, '12', '04', 2018, 'Libre Todo el dia', 47),
(1696, '13', '04', 2018, 'Libre Todo el dia', 47),
(1698, '12', '04', 2018, 'Libre Todo el dia', 99),
(1699, '12', '04', 2018, 'Libre Todo el dia', 67),
(1700, '13', '04', 2018, 'Libre Todo el dia', 67),
(1701, '14', '04', 2018, 'Libre Todo el dia', 67),
(1702, '15', '04', 2018, 'Libre Todo el dia', 67),
(1703, '12', '04', 2018, 'Libre Todo el dia', 38),
(1704, '12', '04', 2018, 'Libre Todo el dia', 86),
(1705, '12', '04', 2018, 'Libre Todo el dia', 104),
(1706, '13', '04', 2018, 'Libre Todo el dia', 51),
(1707, '13', '04', 2018, 'Libre Todo el dia', 99),
(1708, '13', '04', 2018, 'Libre Todo el dia', 38),
(1709, '13', '04', 2018, 'Libre de 8:00 a 12:00', 85),
(1711, '16', '04', 2018, 'Libre Todo el dia', 67),
(1712, '16', '04', 2018, 'Libre de 8:00 a 12:00', 50),
(1713, '16', '04', 2018, 'Libre Todo el dia', 55),
(1714, '16', '04', 2018, 'Libre Todo el dia', 96),
(1715, '16', '04', 2018, 'Libre de 14:00 a 18:00', 37),
(1716, '17', '04', 2018, 'Libre Todo el dia', 37),
(1717, '17', '04', 2018, 'Libre Todo el dia', 96),
(1718, '15', '04', 2018, 'Libre Todo el dia', 108),
(1719, '16', '04', 2018, 'Libre Todo el dia', 108),
(1720, '17', '04', 2018, 'Libre Todo el dia', 108),
(1721, '16', '04', 2018, 'Libre Todo el dia', 89),
(1722, '17', '04', 2018, 'Libre Todo el dia', 89),
(1723, '16', '04', 2018, 'Libre Todo el dia', 103),
(1724, '17', '04', 2018, 'Libre Todo el dia', 103),
(1725, '18', '04', 2018, 'Libre Todo el dia', 103),
(1726, '19', '04', 2018, 'Libre Todo el dia', 103),
(1727, '16', '04', 2018, 'Libre Todo el dia', 59),
(1728, '17', '04', 2018, 'Libre Todo el dia', 59),
(1729, '18', '04', 2018, 'Libre Todo el dia', 59),
(1730, '19', '04', 2018, 'Libre Todo el dia', 59),
(1731, '20', '04', 2018, 'Libre Todo el dia', 59),
(1732, '17', '04', 2018, 'Libre Todo el dia', 67),
(1733, '17', '04', 2018, 'Libre Todo el dia', 95),
(1735, '18', '04', 2018, 'Libre Todo el dia', 92),
(1736, '19', '04', 2018, 'Libre Todo el dia', 92),
(1737, '17', '04', 2018, 'Libre Todo el dia', 109),
(1738, '18', '04', 2018, 'Libre Todo el dia', 109),
(1739, '19', '04', 2018, 'Libre Todo el dia', 109),
(1740, '18', '04', 2018, 'Libre Todo el dia', 67),
(1741, '18', '04', 2018, 'Libre Todo el dia', 56),
(1742, '19', '04', 2018, 'Libre de 8:00 a 12:00', 107),
(1743, '19', '04', 2018, 'Libre Todo el dia', 67),
(1744, '19', '04', 2018, 'Libre de 8:00 a 12:00', 81),
(1745, '19', '04', 2018, 'Libre Todo el dia', 99),
(1746, '19', '04', 2018, 'Libre Todo el dia', 38),
(1747, '19', '04', 2018, 'Libre Todo el dia', 51),
(1748, '20', '04', 2018, 'Libre Todo el dia', 67),
(1749, '21', '04', 2018, 'Libre Todo el dia', 67),
(1750, '22', '04', 2018, 'Libre Todo el dia', 67),
(1751, '20', '04', 2018, 'Libre Todo el dia', 99),
(1752, '20', '04', 2018, 'Libre Todo el dia', 38),
(1753, '30', '04', 2018, 'Libre Todo el dia', 76),
(1754, '23', '04', 2018, 'Libre Todo el dia', 95),
(1755, '23', '04', 2018, 'Libre de 8:00 a 12:00', 85),
(1756, '23', '04', 2018, 'Libre Todo el dia', 67),
(1757, '23', '04', 2018, 'Libre Todo el dia', 51),
(1758, '23', '04', 2018, 'Libre Todo el dia', 83),
(1759, '24', '04', 2018, 'Libre Todo el dia', 83),
(1760, '23', '04', 2018, 'Libre de 14:00 a 18:00', 55),
(1761, '23', '04', 2018, 'Libre de 14:00 a 18:00', 50),
(1762, '24', '04', 2018, 'Libre Todo el dia', 50),
(1763, '25', '04', 2018, 'Libre Todo el dia', 50),
(1764, '26', '04', 2018, 'Libre Todo el dia', 50),
(1765, '27', '04', 2018, 'Libre de 8:00 a 12:00', 50),
(1766, '24', '04', 2018, 'Libre Todo el dia', 67),
(1768, '24', '04', 2018, 'Libre Todo el dia', 102),
(1769, '24', '04', 2018, 'Libre Todo el dia', 64),
(1770, '24', '04', 2018, 'Libre Todo el dia', 51),
(1776, '24', '04', 2018, 'Libre Todo el dia', 95),
(1781, '24', '04', 2018, 'Libre de 14:00 a 18:00', 85),
(1782, '24', '04', 2018, 'Libre de 14:00 a 18:00', 56),
(1783, '25', '04', 2018, 'Libre Todo el dia', 62),
(1784, '26', '04', 2018, 'Libre Todo el dia', 62),
(1785, '27', '04', 2018, 'Libre Todo el dia', 62),
(1786, '25', '04', 2018, 'Libre Todo el dia', 64),
(1787, '25', '04', 2018, 'Libre Todo el dia', 67),
(1789, '28', '04', 2018, 'Libre Todo el dia', 107),
(1791, '26', '04', 2018, 'Libre Todo el dia', 86),
(1792, '26', '04', 2018, 'Libre Todo el dia', 38),
(1793, '26', '04', 2018, 'Libre Todo el dia', 82),
(1794, '27', '04', 2018, 'Libre Todo el dia', 35),
(1795, '27', '04', 2018, 'Libre Todo el dia', 99),
(1796, '27', '04', 2018, 'Libre Todo el dia', 51),
(1797, '27', '04', 2018, 'Libre Todo el dia', 86),
(1798, '27', '04', 2018, 'Libre de 14:00 a 18:00', 93),
(1799, '30', '04', 2018, 'Libre Todo el dia', 81),
(1800, '04', '05', 2018, 'Libre Todo el dia', 45),
(1801, '05', '05', 2018, 'Libre Todo el dia', 45),
(1802, '06', '05', 2018, 'Libre Todo el dia', 45),
(1803, '07', '05', 2018, 'Libre Todo el dia', 45),
(1804, '08', '05', 2018, 'Libre Todo el dia', 45),
(1805, '09', '05', 2018, 'Libre Todo el dia', 45),
(1806, '10', '05', 2018, 'Libre Todo el dia', 45),
(1807, '11', '05', 2018, 'Libre Todo el dia', 45),
(1808, '12', '05', 2018, 'Libre Todo el dia', 45),
(1809, '13', '05', 2018, 'Libre Todo el dia', 45),
(1810, '14', '05', 2018, 'Libre Todo el dia', 45),
(1811, '15', '05', 2018, 'Libre Todo el dia', 45),
(1812, '16', '05', 2018, 'Libre Todo el dia', 45),
(1813, '17', '05', 2018, 'Libre Todo el dia', 45),
(1814, '18', '05', 2018, 'Libre Todo el dia', 45),
(1815, '03', '05', 2018, 'Libre de 14:00 a 18:00', 45),
(1816, '30', '04', 2018, 'Libre de 8:00 a 12:00', 50),
(1817, '30', '04', 2018, 'Libre Todo el dia', 107),
(1818, '30', '04', 2018, 'Libre de 8:00 a 12:00', 60),
(1819, '30', '04', 2018, 'Libre Todo el dia', 51),
(1820, '30', '04', 2018, 'Libre Todo el dia', 37),
(1821, '30', '04', 2018, 'Libre Todo el dia', 99),
(1822, '01', '05', 2018, 'Libre Todo el dia', 76),
(1823, '30', '04', 2018, 'Libre Todo el dia', 46),
(1824, '01', '05', 2018, 'Libre Todo el dia', 46),
(1825, '02', '05', 2018, 'Libre Todo el dia', 46),
(1826, '02', '05', 2018, 'Libre Todo el dia', 89),
(1827, '02', '05', 2018, 'Libre Todo el dia', 109),
(1828, '03', '05', 2018, 'Libre Todo el dia', 109),
(1829, '04', '05', 2018, 'Libre Todo el dia', 109),
(1830, '02', '05', 2018, 'Libre Todo el dia', 55),
(1831, '02', '05', 2018, 'Libre Todo el dia', 95),
(1832, '02', '05', 2018, 'Libre Todo el dia', 56),
(1833, '03', '05', 2018, 'Libre Todo el dia', 56),
(1834, '02', '05', 2018, 'Libre Todo el dia', 81),
(1835, '02', '05', 2018, 'Libre Todo el dia', 36),
(1836, '03', '05', 2018, 'Libre Todo el dia', 34),
(1837, '04', '05', 2018, 'Libre Todo el dia', 34),
(1838, '02', '05', 2018, 'Libre Todo el dia', 35),
(1839, '03', '05', 2018, 'Libre Todo el dia', 35),
(1840, '03', '05', 2018, 'Libre Todo el dia', 77),
(1841, '03', '05', 2018, 'Libre Todo el dia', 36),
(1842, '03', '05', 2018, 'Libre Todo el dia', 95),
(1843, '03', '05', 2018, 'Libre Todo el dia', 61),
(1844, '04', '05', 2018, 'Libre Todo el dia', 61),
(1845, '05', '05', 2018, 'Libre Todo el dia', 61),
(1846, '06', '05', 2018, 'Libre Todo el dia', 61),
(1847, '07', '05', 2018, 'Libre Todo el dia', 61),
(1848, '08', '05', 2018, 'Libre Todo el dia', 61),
(1849, '09', '05', 2018, 'Libre Todo el dia', 61),
(1850, '10', '05', 2018, 'Libre Todo el dia', 61),
(1851, '11', '05', 2018, 'Libre Todo el dia', 61),
(1852, '12', '05', 2018, 'Libre Todo el dia', 61),
(1853, '13', '05', 2018, 'Libre Todo el dia', 61),
(1854, '14', '05', 2018, 'Libre Todo el dia', 61),
(1855, '15', '05', 2018, 'Libre Todo el dia', 61),
(1856, '16', '05', 2018, 'Libre Todo el dia', 61),
(1857, '17', '05', 2018, 'Libre Todo el dia', 61),
(1858, '18', '05', 2018, 'Libre Todo el dia', 61),
(1859, '19', '05', 2018, 'Libre Todo el dia', 61),
(1860, '20', '05', 2018, 'Libre Todo el dia', 61),
(1861, '21', '05', 2018, 'Libre Todo el dia', 61),
(1862, '22', '05', 2018, 'Libre Todo el dia', 61),
(1863, '23', '05', 2018, 'Libre Todo el dia', 61),
(1864, '24', '05', 2018, 'Libre Todo el dia', 61),
(1865, '25', '05', 2018, 'Libre Todo el dia', 61),
(1866, '26', '05', 2018, 'Libre Todo el dia', 61),
(1867, '27', '05', 2018, 'Libre Todo el dia', 61),
(1868, '28', '05', 2018, 'Libre Todo el dia', 61),
(1869, '29', '05', 2018, 'Libre Todo el dia', 61),
(1870, '30', '05', 2018, 'Libre Todo el dia', 61),
(1871, '31', '05', 2018, 'Libre Todo el dia', 61),
(1872, '04', '05', 2018, 'Libre Todo el dia', 77),
(1873, '04', '05', 2018, 'Libre Todo el dia', 36),
(1874, '06', '05', 2018, 'Libre Todo el dia', 56),
(1875, '07', '05', 2018, 'Libre Todo el dia', 56),
(1880, '07', '05', 2018, 'Libre de 8:00 a 12:00', 109),
(1881, '07', '05', 2018, 'Libre Todo el dia', 64),
(1883, '08', '05', 2018, 'Libre Todo el dia', 60),
(1884, '08', '05', 2018, 'Libre de 8:00 a 12:00', 81),
(1885, '09', '05', 2018, 'Libre Todo el dia', 107),
(1886, '08', '05', 2018, 'Libre Todo el dia', 56),
(1887, '08', '05', 2018, 'Libre Todo el dia', 95),
(1888, '08', '05', 2018, 'Libre Todo el dia', 83),
(1889, '08', '05', 2018, 'Libre Todo el dia', 74),
(1890, '09', '05', 2018, 'Libre Todo el dia', 74),
(1891, '10', '05', 2018, 'Libre Todo el dia', 74),
(1892, '11', '05', 2018, 'Libre Todo el dia', 74),
(1893, '09', '05', 2018, 'Libre Todo el dia', 56),
(1894, '09', '05', 2018, 'Libre Todo el dia', 83),
(1895, '09', '05', 2018, 'Libre Todo el dia', 95),
(1896, '09', '05', 2018, 'Libre Todo el dia', 38),
(1897, '09', '05', 2018, 'Libre de 14:00 a 18:00', 68),
(1898, '10', '05', 2018, 'Libre Todo el dia', 68),
(1899, '10', '05', 2018, 'Libre Todo el dia', 95),
(1900, '10', '05', 2018, 'Libre Todo el dia', 36),
(1901, '11', '05', 2018, 'Libre Todo el dia', 36),
(1902, '10', '05', 2018, 'Libre Todo el dia', 38),
(1903, '11', '05', 2018, 'Libre Todo el dia', 38),
(1904, '11', '05', 2018, 'Libre Todo el dia', 95),
(1906, '11', '05', 2018, 'Libre de 14:00 a 18:00', 85),
(1907, '15', '05', 2018, 'Libre de 8:00 a 12:00', 85),
(1909, '15', '05', 2018, 'Libre Todo el dia', 95),
(1910, '16', '05', 2018, 'Libre Todo el dia', 95),
(1911, '17', '05', 2018, 'Libre Todo el dia', 95),
(1913, '15', '05', 2018, 'Libre Todo el dia', 70),
(1914, '16', '05', 2018, 'Libre Todo el dia', 70),
(1916, '15', '05', 2018, 'Libre Todo el dia', 34),
(1917, '17', '05', 2018, 'Libre de 8:00 a 12:00', 34),
(1918, '15', '05', 2018, 'Libre Todo el dia', 59),
(1919, '16', '05', 2018, 'Libre Todo el dia', 59),
(1920, '17', '05', 2018, 'Libre Todo el dia', 59),
(1935, '01', '06', 2018, 'Libre Todo el dia', 59),
(1936, '02', '06', 2018, 'Libre Todo el dia', 59),
(1937, '03', '06', 2018, 'Libre Todo el dia', 59),
(1938, '04', '06', 2018, 'Libre Todo el dia', 59),
(1939, '05', '06', 2018, 'Libre Todo el dia', 59),
(1940, '06', '06', 2018, 'Libre Todo el dia', 59),
(1941, '07', '06', 2018, 'Libre Todo el dia', 59),
(1952, '17', '05', 2018, 'Libre Todo el dia', 93),
(1953, '16', '05', 2018, 'Libre Todo el dia', 98),
(1954, '16', '05', 2018, 'Libre de 8:00 a 12:00', 85),
(1955, '16', '05', 2018, 'Libre de 14:00 a 18:00', 55),
(1957, '17', '05', 2018, 'Libre Todo el dia', 55),
(1958, '17', '05', 2018, 'Libre Todo el dia', 87),
(1959, '17', '05', 2018, 'Libre Todo el dia', 108),
(1960, '18', '05', 2018, 'Libre Todo el dia', 106),
(1961, '18', '05', 2018, 'Libre Todo el dia', 109),
(1962, '18', '05', 2018, 'Libre Todo el dia', 76),
(1963, '21', '05', 2018, 'Libre Todo el dia', 82),
(1964, '22', '05', 2018, 'Libre Todo el dia', 82),
(1965, '23', '05', 2018, 'Libre Todo el dia', 82),
(1966, '24', '05', 2018, 'Libre Todo el dia', 82),
(1967, '25', '05', 2018, 'Libre Todo el dia', 82),
(1968, '18', '05', 2018, 'Libre Todo el dia', 95),
(1969, '18', '05', 2018, 'Libre de 14:00 a 18:00', 55),
(1973, '21', '05', 2018, 'Libre Todo el dia', 109),
(1974, '21', '05', 2018, 'Libre Todo el dia', 95),
(1975, '21', '05', 2018, 'Libre Todo el dia', 56),
(1976, '21', '05', 2018, 'Libre Todo el dia', 38),
(1977, '22', '05', 2018, 'Libre Todo el dia', 38),
(1978, '21', '05', 2018, 'Libre Todo el dia', 108),
(1979, '22', '05', 2018, 'Libre Todo el dia', 108),
(1980, '23', '05', 2018, 'Libre Todo el dia', 108),
(1981, '24', '05', 2018, 'Libre Todo el dia', 108),
(1982, '25', '05', 2018, 'Libre Todo el dia', 108),
(1983, '21', '05', 2018, 'Libre de 14:00 a 18:00', 55),
(1984, '21', '05', 2018, 'Libre Todo el dia', 74),
(1985, '22', '05', 2018, 'Libre Todo el dia', 42),
(1986, '23', '05', 2018, 'Libre Todo el dia', 42),
(1987, '22', '05', 2018, 'Libre Todo el dia', 95),
(1988, '22', '05', 2018, 'Libre Todo el dia', 98),
(1989, '22', '05', 2018, 'Libre de 8:00 a 12:00', 85),
(1990, '22', '05', 2018, 'Libre de 14:00 a 18:00', 74),
(1991, '24', '05', 2018, 'Libre Todo el dia', 106),
(1992, '25', '05', 2018, 'Libre Todo el dia', 106),
(1993, '23', '05', 2018, 'Libre Todo el dia', 95),
(1994, '23', '05', 2018, 'Libre Todo el dia', 109),
(1995, '23', '05', 2018, 'Libre Todo el dia', 98),
(1996, '24', '05', 2018, 'Libre Todo el dia', 98),
(1997, '25', '05', 2018, 'Libre Todo el dia', 98),
(1998, '23', '05', 2018, 'Libre de 14:00 a 18:00', 55),
(2000, '24', '05', 2018, 'Libre Todo el dia', 57),
(2001, '25', '05', 2018, 'Libre Todo el dia', 57),
(2002, '24', '05', 2018, 'Libre Todo el dia', 95),
(2003, '24', '05', 2018, 'Libre Todo el dia', 38),
(2004, '24', '05', 2018, 'Libre Todo el dia', 51),
(2005, '24', '05', 2018, 'Libre Todo el dia', 36),
(2006, '25', '05', 2018, 'Libre Todo el dia', 36),
(2007, '24', '05', 2018, 'Libre de 8:00 a 12:00', 85),
(2010, '25', '05', 2018, 'Libre de 8:00 a 12:00', 109),
(2011, '25', '05', 2018, 'Libre Todo el dia', 38),
(2012, '25', '05', 2018, 'Libre Todo el dia', 74),
(2013, '28', '05', 2018, 'Libre Todo el dia', 74),
(2014, '29', '05', 2018, 'Libre Todo el dia', 74),
(2015, '30', '05', 2018, 'Libre Todo el dia', 74),
(2016, '31', '05', 2018, 'Libre Todo el dia', 74),
(2017, '01', '06', 2018, 'Libre Todo el dia', 74),
(2018, '02', '06', 2018, 'Libre Todo el dia', 74),
(2019, '03', '06', 2018, 'Libre Todo el dia', 74),
(2020, '04', '06', 2018, 'Libre Todo el dia', 74),
(2022, '25', '05', 2018, 'Libre Todo el dia', 49),
(2023, '25', '05', 2018, 'Libre Todo el dia', 56),
(2024, '25', '05', 2018, 'Libre Todo el dia', 85),
(2025, '25', '05', 2018, 'Libre de 14:00 a 18:00', 93),
(2026, '29', '05', 2018, 'Libre Todo el dia', 103),
(2027, '31', '05', 2018, 'Libre Todo el dia', 103),
(2028, '01', '06', 2018, 'Libre Todo el dia', 103),
(2029, '02', '06', 2018, 'Libre Todo el dia', 103),
(2030, '03', '06', 2018, 'Libre Todo el dia', 103),
(2031, '04', '06', 2018, 'Libre Todo el dia', 103),
(2032, '05', '06', 2018, 'Libre Todo el dia', 103),
(2033, '18', '06', 2018, 'Libre Todo el dia', 103),
(2034, '19', '06', 2018, 'Libre Todo el dia', 103),
(2035, '20', '06', 2018, 'Libre Todo el dia', 103),
(2036, '21', '06', 2018, 'Libre Todo el dia', 103),
(2037, '22', '06', 2018, 'Libre Todo el dia', 103),
(2038, '23', '06', 2018, 'Libre Todo el dia', 103),
(2039, '24', '06', 2018, 'Libre Todo el dia', 103),
(2040, '25', '06', 2018, 'Libre Todo el dia', 103),
(2041, '26', '06', 2018, 'Libre Todo el dia', 103),
(2042, '27', '06', 2018, 'Libre Todo el dia', 103),
(2046, '01', '07', 2018, 'Libre Todo el dia', 103),
(2047, '02', '07', 2018, 'Libre Todo el dia', 103),
(2048, '03', '07', 2018, 'Libre Todo el dia', 103),
(2049, '04', '07', 2018, 'Libre Todo el dia', 103),
(2050, '05', '07', 2018, 'Libre Todo el dia', 103),
(2051, '06', '07', 2018, 'Libre Todo el dia', 103),
(2052, '07', '07', 2018, 'Libre Todo el dia', 103),
(2053, '08', '07', 2018, 'Libre Todo el dia', 103),
(2054, '09', '07', 2018, 'Libre Todo el dia', 103),
(2055, '10', '07', 2018, 'Libre Todo el dia', 103),
(2056, '11', '07', 2018, 'Libre Todo el dia', 103),
(2057, '12', '07', 2018, 'Libre Todo el dia', 103),
(2058, '13', '07', 2018, 'Libre Todo el dia', 103),
(2059, '28', '05', 2018, 'Libre Todo el dia', 56),
(2060, '29', '05', 2018, 'Libre Todo el dia', 56),
(2061, '30', '05', 2018, 'Libre Todo el dia', 56),
(2062, '31', '05', 2018, 'Libre Todo el dia', 56),
(2063, '01', '06', 2018, 'Libre Todo el dia', 56),
(2066, '28', '05', 2018, 'Libre Todo el dia', 49),
(2067, '29', '05', 2018, 'Libre Todo el dia', 49),
(2068, '30', '05', 2018, 'Libre Todo el dia', 49),
(2069, '28', '05', 2018, 'Libre Todo el dia', 57),
(2070, '28', '05', 2018, 'Libre Todo el dia', 85),
(2071, '28', '05', 2018, 'Libre de 14:00 a 18:00', 81),
(2073, '28', '05', 2018, 'Libre de 14:00 a 18:00', 55),
(2074, '02', '06', 2018, 'Libre Todo el dia', 81),
(2076, '29', '05', 2018, 'Libre Todo el dia', 36),
(2077, '29', '05', 2018, 'Libre Todo el dia', 85),
(2078, '30', '05', 2018, 'Libre de 8:00 a 12:00', 85),
(2079, '30', '05', 2018, 'Libre Todo el dia', 95),
(2080, '30', '05', 2018, 'Libre Todo el dia', 36),
(2081, '30', '05', 2018, 'Libre Todo el dia', 109),
(2082, '31', '05', 2018, 'Libre Todo el dia', 106),
(2083, '31', '05', 2018, 'Libre Todo el dia', 95),
(2085, '01', '06', 2018, 'Libre Todo el dia', 70),
(2086, '01', '06', 2018, 'Libre Todo el dia', 87),
(2087, '01', '06', 2018, 'Libre Todo el dia', 95),
(2088, '05', '06', 2018, 'Libre Todo el dia', 56),
(2089, '01', '06', 2018, 'Libre de 8:00 a 12:00', 85),
(2090, '05', '06', 2018, 'Libre Todo el dia', 76),
(2091, '06', '06', 2018, 'Libre Todo el dia', 76),
(2092, '07', '06', 2018, 'Libre Todo el dia', 76),
(2093, '08', '06', 2018, 'Libre Todo el dia', 76),
(2094, '05', '06', 2018, 'Libre Todo el dia', 106),
(2095, '05', '06', 2018, 'Libre Todo el dia', 68),
(2096, '06', '06', 2018, 'Libre Todo el dia', 92),
(2097, '07', '06', 2018, 'Libre Todo el dia', 92),
(2098, '08', '06', 2018, 'Libre Todo el dia', 92),
(2099, '05', '06', 2018, 'Libre Todo el dia', 77),
(2100, '05', '06', 2018, 'Libre Todo el dia', 78),
(2101, '06', '06', 2018, 'Libre Todo el dia', 78),
(2102, '07', '06', 2018, 'Libre Todo el dia', 78),
(2103, '08', '06', 2018, 'Libre Todo el dia', 78),
(2104, '05', '06', 2018, 'Libre Todo el dia', 85),
(2106, '06', '06', 2018, 'Libre de 8:00 a 12:00', 56),
(2107, '06', '06', 2018, 'Libre de 14:00 a 18:00', 93),
(2108, '07', '06', 2018, 'Libre Todo el dia', 93),
(2109, '06', '06', 2018, 'Libre de 14:00 a 18:00', 45),
(2110, '07', '06', 2018, 'Libre Todo el dia', 45),
(2111, '06', '06', 2018, 'Libre de 14:00 a 18:00', 55),
(2112, '07', '06', 2018, 'Libre Todo el dia', 55),
(2113, '07', '06', 2018, 'Libre Todo el dia', 87),
(2114, '08', '06', 2018, 'Libre Todo el dia', 56),
(2115, '09', '06', 2018, 'Libre Todo el dia', 56),
(2116, '10', '06', 2018, 'Libre Todo el dia', 56),
(2117, '11', '06', 2018, 'Libre Todo el dia', 56),
(2118, '12', '06', 2018, 'Libre Todo el dia', 56),
(2119, '13', '06', 2018, 'Libre Todo el dia', 56),
(2120, '14', '06', 2018, 'Libre Todo el dia', 56),
(2121, '15', '06', 2018, 'Libre Todo el dia', 56),
(2122, '16', '06', 2018, 'Libre Todo el dia', 56),
(2123, '17', '06', 2018, 'Libre Todo el dia', 56),
(2124, '18', '06', 2018, 'Libre Todo el dia', 56),
(2125, '19', '06', 2018, 'Libre Todo el dia', 56),
(2126, '20', '06', 2018, 'Libre Todo el dia', 56),
(2127, '21', '06', 2018, 'Libre Todo el dia', 56),
(2128, '22', '06', 2018, 'Libre Todo el dia', 56),
(2129, '23', '06', 2018, 'Libre Todo el dia', 56),
(2130, '24', '06', 2018, 'Libre Todo el dia', 56),
(2131, '25', '06', 2018, 'Libre Todo el dia', 56),
(2132, '26', '06', 2018, 'Libre Todo el dia', 56),
(2133, '27', '06', 2018, 'Libre Todo el dia', 56),
(2134, '28', '06', 2018, 'Libre Todo el dia', 56),
(2135, '29', '06', 2018, 'Libre Todo el dia', 56),
(2136, '07', '06', 2018, 'Libre Todo el dia', 99),
(2137, '07', '06', 2018, 'Libre Todo el dia', 86),
(2138, '07', '06', 2018, 'Libre de 8:00 a 12:00', 82),
(2139, '07', '06', 2018, 'Libre Todo el dia', 57),
(2140, '08', '06', 2018, 'Libre Todo el dia', 57),
(2141, '07', '06', 2018, 'Libre de 14:00 a 18:00', 56),
(2142, '08', '06', 2018, 'Libre Todo el dia', 85),
(2143, '08', '06', 2018, 'Libre Todo el dia', 86),
(2144, '12', '06', 2018, 'Libre Todo el dia', 89),
(2145, '13', '06', 2018, 'Libre Todo el dia', 89),
(2146, '12', '06', 2018, 'Libre Todo el dia', 109),
(2147, '12', '06', 2018, 'Libre Todo el dia', 57),
(2148, '12', '06', 2018, 'Libre de 14:00 a 18:00', 84),
(2149, '13', '06', 2018, 'Libre de 8:00 a 12:00', 77),
(2150, '14', '06', 2018, 'Libre Todo el dia', 82),
(2151, '15', '06', 2018, 'Libre Todo el dia', 82),
(2152, '14', '06', 2018, 'Libre Todo el dia', 81),
(2154, '16', '06', 2018, 'Libre Todo el dia', 81),
(2155, '17', '06', 2018, 'Libre Todo el dia', 81),
(2156, '18', '06', 2018, 'Libre Todo el dia', 81),
(2157, '19', '06', 2018, 'Libre Todo el dia', 81),
(2158, '20', '06', 2018, 'Libre Todo el dia', 81),
(2159, '21', '06', 2018, 'Libre Todo el dia', 81),
(2160, '22', '06', 2018, 'Libre Todo el dia', 81),
(2161, '23', '06', 2018, 'Libre Todo el dia', 81),
(2162, '24', '06', 2018, 'Libre Todo el dia', 81),
(2163, '25', '06', 2018, 'Libre Todo el dia', 81),
(2164, '26', '06', 2018, 'Libre Todo el dia', 81),
(2165, '27', '06', 2018, 'Libre Todo el dia', 81),
(2166, '28', '06', 2018, 'Libre Todo el dia', 81),
(2167, '29', '06', 2018, 'Libre Todo el dia', 81),
(2168, '14', '06', 2018, 'Libre Todo el dia', 85),
(2169, '14', '06', 2018, 'Libre Todo el dia', 77),
(2170, '14', '06', 2018, 'Libre Todo el dia', 38),
(2171, '14', '06', 2018, 'Libre de 14:00 a 18:00', 55),
(2172, '14', '06', 2018, 'Libre Todo el dia', 45),
(2173, '15', '06', 2018, 'Libre Todo el dia', 45),
(2174, '14', '06', 2018, 'Libre Todo el dia', 47),
(2175, '15', '06', 2018, 'Libre Todo el dia', 47),
(2176, '15', '06', 2018, 'Libre Todo el dia', 49),
(2177, '15', '06', 2018, 'Libre de 8:00 a 12:00', 77),
(2178, '15', '06', 2018, 'Libre de 8:00 a 12:00', 85),
(2179, '15', '06', 2018, 'Libre Todo el dia', 57),
(2180, '15', '06', 2018, 'Libre de 8:00 a 12:00', 93),
(2181, '15', '06', 2018, 'Libre Todo el dia', 36),
(2182, '15', '06', 2018, 'Libre Todo el dia', 89),
(2183, '18', '06', 2018, 'Libre Todo el dia', 89),
(2184, '19', '06', 2018, 'Libre Todo el dia', 89),
(2185, '20', '06', 2018, 'Libre Todo el dia', 89),
(2186, '15', '06', 2018, 'Libre Todo el dia', 38),
(2187, '18', '06', 2018, 'Libre Todo el dia', 109),
(2188, '18', '06', 2018, 'Libre Todo el dia', 36),
(2189, '19', '06', 2018, 'Libre Todo el dia', 36),
(2190, '20', '06', 2018, 'Libre Todo el dia', 36),
(2191, '21', '06', 2018, 'Libre Todo el dia', 36),
(2192, '18', '06', 2018, 'Libre Todo el dia', 95),
(2193, '18', '06', 2018, 'Libre de 14:00 a 18:00', 55),
(2194, '20', '06', 2018, 'Libre Todo el dia', 98),
(2195, '20', '06', 2018, 'Libre Todo el dia', 108),
(2196, '21', '06', 2018, 'Libre Todo el dia', 108),
(2197, '21', '06', 2018, 'Libre Todo el dia', 49),
(2198, '21', '06', 2018, 'Libre Todo el dia', 38),
(2199, '21', '06', 2018, 'Libre Todo el dia', 93),
(2200, '21', '06', 2018, 'Libre Todo el dia', 47),
(2201, '22', '06', 2018, 'Libre Todo el dia', 85),
(2202, '23', '06', 2018, 'Libre Todo el dia', 85),
(2203, '24', '06', 2018, 'Libre Todo el dia', 85),
(2204, '25', '06', 2018, 'Libre Todo el dia', 85),
(2205, '26', '06', 2018, 'Libre Todo el dia', 85),
(2206, '27', '06', 2018, 'Libre Todo el dia', 85),
(2207, '28', '06', 2018, 'Libre Todo el dia', 85),
(2208, '29', '06', 2018, 'Libre Todo el dia', 85),
(2209, '30', '06', 2018, 'Libre Todo el dia', 85),
(2210, '01', '07', 2018, 'Libre Todo el dia', 85),
(2211, '02', '07', 2018, 'Libre Todo el dia', 85),
(2212, '03', '07', 2018, 'Libre Todo el dia', 85),
(2223, '22', '06', 2018, 'Libre Todo el dia', 38),
(2224, '22', '06', 2018, 'Libre Todo el dia', 61),
(2226, '22', '06', 2018, 'Libre de 14:00 a 18:00', 77),
(2227, '22', '06', 2018, 'Libre de 14:00 a 18:00', 68),
(2228, '25', '06', 2018, 'Libre de 8:00 a 12:00', 77),
(2229, '25', '06', 2018, 'Libre Todo el dia', 38),
(2230, '25', '06', 2018, 'Libre Todo el dia', 93),
(2231, '26', '06', 2018, 'Libre Todo el dia', 38),
(2232, '26', '06', 2018, 'Libre Todo el dia', 93),
(2233, '26', '06', 2018, 'Libre Todo el dia', 70),
(2234, '27', '06', 2018, 'Libre Todo el dia', 95),
(2235, '27', '06', 2018, 'Libre de 8:00 a 12:00', 77),
(2236, '27', '06', 2018, 'Libre Todo el dia', 70),
(2237, '28', '06', 2018, 'Libre Todo el dia', 70),
(2238, '29', '06', 2018, 'Libre Todo el dia', 70),
(2239, '29', '06', 2018, 'Libre Todo el dia', 106),
(2240, '28', '06', 2018, 'Libre Todo el dia', 38),
(2241, '29', '06', 2018, 'Libre Todo el dia', 84),
(2242, '30', '06', 2018, 'Libre Todo el dia', 84),
(2243, '01', '07', 2018, 'Libre Todo el dia', 84),
(2244, '02', '07', 2018, 'Libre Todo el dia', 84),
(2245, '03', '07', 2018, 'Libre Todo el dia', 84),
(2246, '04', '07', 2018, 'Libre Todo el dia', 84),
(2247, '05', '07', 2018, 'Libre Todo el dia', 84),
(2248, '06', '07', 2018, 'Libre Todo el dia', 84),
(2249, '07', '07', 2018, 'Libre Todo el dia', 84),
(2250, '08', '07', 2018, 'Libre Todo el dia', 84),
(2251, '09', '07', 2018, 'Libre Todo el dia', 84),
(2252, '10', '07', 2018, 'Libre Todo el dia', 84),
(2253, '11', '07', 2018, 'Libre Todo el dia', 84),
(2254, '12', '07', 2018, 'Libre Todo el dia', 84),
(2255, '13', '07', 2018, 'Libre Todo el dia', 84),
(2256, '14', '07', 2018, 'Libre Todo el dia', 84),
(2257, '15', '07', 2018, 'Libre Todo el dia', 84),
(2258, '16', '07', 2018, 'Libre Todo el dia', 84),
(2259, '17', '07', 2018, 'Libre Todo el dia', 84),
(2266, '03', '07', 2018, 'Libre Todo el dia', 77),
(2267, '03', '07', 2018, 'Libre Todo el dia', 70),
(2268, '04', '07', 2018, 'Libre Todo el dia', 70),
(2269, '05', '07', 2018, 'Libre Todo el dia', 70),
(2270, '06', '07', 2018, 'Libre Todo el dia', 70),
(2271, '04', '07', 2018, 'Libre Todo el dia', 38),
(2272, '04', '07', 2018, 'Libre Todo el dia', 77),
(2273, '05', '07', 2018, 'Libre Todo el dia', 77),
(2274, '06', '07', 2018, 'Libre Todo el dia', 77),
(2275, '04', '07', 2018, 'Libre Todo el dia', 85),
(2276, '04', '07', 2018, 'Libre Todo el dia', 60),
(2277, '05', '07', 2018, 'Libre Todo el dia', 60),
(2278, '04', '07', 2018, 'Libre Todo el dia', 104),
(2279, '05', '07', 2018, 'Libre Todo el dia', 81),
(2280, '05', '07', 2018, 'Libre Todo el dia', 38),
(2281, '05', '07', 2018, 'Libre de 14:00 a 18:00', 55),
(2282, '05', '07', 2018, 'Libre Todo el dia', 46),
(2283, '06', '07', 2018, 'Libre Todo el dia', 46),
(2284, '06', '07', 2018, 'Libre Todo el dia', 109),
(2286, '06', '07', 2018, 'Libre Todo el dia', 38),
(2287, '09', '07', 2018, 'Libre de 8:00 a 12:00', 93),
(2288, '09', '07', 2018, 'Libre Todo el dia', 74),
(2289, '09', '07', 2018, 'Libre Todo el dia', 77),
(2290, '09', '07', 2018, 'Libre Todo el dia', 70),
(2291, '09', '07', 2018, 'Libre Todo el dia', 85),
(2292, '10', '07', 2018, 'Libre Todo el dia', 77),
(2293, '10', '07', 2018, 'Libre Todo el dia', 38),
(2294, '10', '07', 2018, 'Libre Todo el dia', 70),
(2297, '11', '07', 2018, 'Libre Todo el dia', 107),
(2298, '11', '07', 2018, 'Libre Todo el dia', 49),
(2299, '11', '07', 2018, 'Libre Todo el dia', 77),
(2300, '11', '07', 2018, 'Libre Todo el dia', 85),
(2301, '11', '07', 2018, 'Libre Todo el dia', 38),
(2302, '11', '07', 2018, 'Libre Todo el dia', 98),
(2303, '12', '07', 2018, 'Libre Todo el dia', 98),
(2304, '13', '07', 2018, 'Libre Todo el dia', 98),
(2305, '14', '07', 2018, 'Libre Todo el dia', 98),
(2306, '15', '07', 2018, 'Libre Todo el dia', 98),
(2307, '16', '07', 2018, 'Libre Todo el dia', 98),
(2308, '17', '07', 2018, 'Libre Todo el dia', 98),
(2309, '18', '07', 2018, 'Libre Todo el dia', 98),
(2310, '19', '07', 2018, 'Libre Todo el dia', 98),
(2311, '12', '07', 2018, 'Libre de 14:00 a 18:00', 81),
(2312, '12', '07', 2018, 'Libre Todo el dia', 77),
(2313, '13', '07', 2018, 'Libre Todo el dia', 77),
(2314, '12', '07', 2018, 'Libre Todo el dia', 59),
(2315, '12', '07', 2018, 'Libre Todo el dia', 55),
(2316, '12', '07', 2018, 'Libre Todo el dia', 89),
(2317, '12', '07', 2018, 'Libre Todo el dia', 49),
(2318, '12', '07', 2018, 'Libre Todo el dia', 85),
(2319, '13', '07', 2018, 'Libre de 8:00 a 12:00', 39),
(2320, '13', '07', 2018, 'Libre Todo el dia', 49),
(2321, '13', '07', 2018, 'Libre de 14:00 a 18:00', 55),
(2322, '16', '07', 2018, 'Libre Todo el dia', 56),
(2323, '17', '07', 2018, 'Libre Todo el dia', 56),
(2324, '18', '07', 2018, 'Libre Todo el dia', 56),
(2325, '16', '07', 2018, 'Libre Todo el dia', 89),
(2326, '17', '07', 2018, 'Libre Todo el dia', 89),
(2327, '18', '07', 2018, 'Libre Todo el dia', 89),
(2328, '19', '07', 2018, 'Libre Todo el dia', 89),
(2329, '16', '07', 2018, 'Libre Todo el dia', 55),
(2330, '16', '07', 2018, 'Libre Todo el dia', 85),
(2331, '16', '07', 2018, 'Libre Todo el dia', 38),
(2332, '17', '07', 2018, 'Libre Todo el dia', 59),
(2333, '18', '07', 2018, 'Libre Todo el dia', 59),
(2334, '19', '07', 2018, 'Libre Todo el dia', 59),
(2335, '17', '07', 2018, 'Libre de 8:00 a 12:00', 109),
(2336, '17', '07', 2018, 'Libre Todo el dia', 36),
(2337, '17', '07', 2018, 'Libre Todo el dia', 95),
(2338, '19', '07', 2018, 'Libre Todo el dia', 56),
(2339, '18', '07', 2018, 'Libre Todo el dia', 95),
(2340, '18', '07', 2018, 'Libre Todo el dia', 77),
(2341, '18', '07', 2018, 'Libre Todo el dia', 38),
(2342, '19', '07', 2018, 'Libre de 8:00 a 12:00', 109),
(2343, '19', '07', 2018, 'Libre Todo el dia', 87),
(2344, '20', '07', 2018, 'Libre Todo el dia', 87),
(2345, '21', '07', 2018, 'Libre Todo el dia', 87),
(2346, '22', '07', 2018, 'Libre Todo el dia', 87),
(2347, '23', '07', 2018, 'Libre Todo el dia', 87),
(2348, '24', '07', 2018, 'Libre Todo el dia', 87),
(2349, '25', '07', 2018, 'Libre Todo el dia', 87),
(2350, '26', '07', 2018, 'Libre Todo el dia', 87),
(2351, '27', '07', 2018, 'Libre Todo el dia', 87),
(2352, '28', '07', 2018, 'Libre Todo el dia', 87),
(2353, '29', '07', 2018, 'Libre Todo el dia', 87),
(2354, '30', '07', 2018, 'Libre Todo el dia', 87),
(2355, '31', '07', 2018, 'Libre Todo el dia', 87),
(2356, '23', '07', 2018, 'Libre de 8:00 a 12:00', 56),
(2357, '23', '07', 2018, 'Libre de 8:00 a 12:00', 77),
(2358, '23', '07', 2018, 'Libre Todo el dia', 36),
(2359, '23', '07', 2018, 'Libre Todo el dia', 38),
(2360, '23', '07', 2018, 'Libre Todo el dia', 61),
(2361, '24', '07', 2018, 'Libre Todo el dia', 61),
(2362, '25', '07', 2018, 'Libre Todo el dia', 61),
(2363, '26', '07', 2018, 'Libre Todo el dia', 61),
(2364, '27', '07', 2018, 'Libre Todo el dia', 61),
(2365, '28', '07', 2018, 'Libre Todo el dia', 61),
(2366, '29', '07', 2018, 'Libre Todo el dia', 61),
(2367, '30', '07', 2018, 'Libre Todo el dia', 61),
(2368, '31', '07', 2018, 'Libre Todo el dia', 61),
(2369, '23', '07', 2018, 'Libre de 14:00 a 18:00', 74),
(2370, '23', '07', 2018, 'Libre Todo el dia', 92),
(2371, '24', '07', 2018, 'Libre Todo el dia', 92),
(2372, '24', '07', 2018, 'Libre Todo el dia', 85),
(2373, '24', '07', 2018, 'Libre de 8:00 a 12:00', 74),
(2374, '24', '07', 2018, 'Libre Todo el dia', 109),
(2375, '24', '07', 2018, 'Libre Todo el dia', 49),
(2376, '24', '07', 2018, 'Libre Todo el dia', 38),
(2377, '24', '07', 2018, 'Libre Todo el dia', 36),
(2378, '24', '07', 2018, 'Libre de 14:00 a 18:00', 93),
(2379, '24', '07', 2018, 'Libre de 14:00 a 18:00', 81),
(2380, '28', '07', 2018, 'Libre Todo el dia', 106),
(2381, '29', '07', 2018, 'Libre Todo el dia', 106),
(2382, '30', '07', 2018, 'Libre Todo el dia', 106),
(2383, '31', '07', 2018, 'Libre Todo el dia', 106),
(2384, '01', '08', 2018, 'Libre Todo el dia', 106),
(2385, '02', '08', 2018, 'Libre Todo el dia', 106),
(2386, '03', '08', 2018, 'Libre Todo el dia', 106),
(2387, '04', '08', 2018, 'Libre Todo el dia', 106),
(2388, '05', '08', 2018, 'Libre Todo el dia', 106),
(2389, '06', '08', 2018, 'Libre Todo el dia', 106),
(2390, '07', '08', 2018, 'Libre Todo el dia', 106),
(2391, '08', '08', 2018, 'Libre Todo el dia', 106),
(2392, '09', '08', 2018, 'Libre Todo el dia', 106),
(2393, '10', '08', 2018, 'Libre Todo el dia', 106),
(2394, '11', '08', 2018, 'Libre Todo el dia', 106),
(2395, '25', '07', 2018, 'Libre Todo el dia', 95),
(2396, '25', '07', 2018, 'Libre de 8:00 a 12:00', 74),
(2397, '25', '07', 2018, 'Libre Todo el dia', 109),
(2398, '25', '07', 2018, 'Libre Todo el dia', 36),
(2399, '25', '07', 2018, 'Libre Todo el dia', 49),
(2400, '25', '07', 2018, 'Libre de 14:00 a 18:00', 55),
(2401, '25', '07', 2018, 'Libre de 14:00 a 18:00', 81),
(2402, '26', '07', 2018, 'Libre Todo el dia', 81),
(2403, '26', '07', 2018, 'Libre Todo el dia', 106),
(2404, '26', '07', 2018, 'Libre Todo el dia', 109),
(2405, '26', '07', 2018, 'Libre Todo el dia', 98),
(2406, '26', '07', 2018, 'Libre Todo el dia', 56),
(2407, '26', '07', 2018, 'Libre de 8:00 a 12:00', 74),
(2408, '27', '07', 2018, 'Libre Todo el dia', 98),
(2409, '26', '07', 2018, 'Libre Todo el dia', 49),
(2410, '27', '07', 2018, 'Libre Todo el dia', 107),
(2411, '27', '07', 2018, 'Libre Todo el dia', 70),
(2412, '27', '07', 2018, 'Libre Todo el dia', 49),
(2413, '30', '07', 2018, 'Libre Todo el dia', 93),
(2414, '31', '07', 2018, 'Libre Todo el dia', 93),
(2415, '30', '07', 2018, 'Libre Todo el dia', 85),
(2416, '30', '07', 2018, 'Libre Todo el dia', 95),
(2417, '30', '07', 2018, 'Libre Todo el dia', 109),
(2418, '30', '07', 2018, 'Libre Todo el dia', 49),
(2419, '31', '07', 2018, 'Libre Todo el dia', 49),
(2420, '30', '07', 2018, 'Libre Todo el dia', 64),
(2421, '04', '08', 2018, 'Libre Todo el dia', 81),
(2422, '30', '07', 2018, 'Libre de 14:00 a 18:00', 55),
(2423, '31', '07', 2018, 'Libre Todo el dia', 107),
(2424, '01', '08', 2018, 'Libre Todo el dia', 107),
(2425, '02', '08', 2018, 'Libre Todo el dia', 107),
(2426, '03', '08', 2018, 'Libre Todo el dia', 107),
(2427, '04', '08', 2018, 'Libre Todo el dia', 107),
(2428, '05', '08', 2018, 'Libre Todo el dia', 107),
(2429, '06', '08', 2018, 'Libre Todo el dia', 107),
(2430, '07', '08', 2018, 'Libre Todo el dia', 107),
(2431, '01', '08', 2018, 'Libre Todo el dia', 89),
(2432, '02', '08', 2018, 'Libre Todo el dia', 89),
(2433, '31', '07', 2018, 'Libre Todo el dia', 85),
(2434, '01', '08', 2018, 'Libre Todo el dia', 85),
(2435, '02', '08', 2018, 'Libre Todo el dia', 85),
(2436, '03', '08', 2018, 'Libre Todo el dia', 85),
(2437, '31', '07', 2018, 'Libre Todo el dia', 38),
(2438, '01', '08', 2018, 'Libre Todo el dia', 38),
(2439, '02', '08', 2018, 'Libre Todo el dia', 38),
(2440, '01', '08', 2018, 'Libre de 8:00 a 12:00', 93),
(2441, '01', '08', 2018, 'Libre Todo el dia', 56),
(2442, '02', '08', 2018, 'Libre Todo el dia', 56),
(2443, '03', '08', 2018, 'Libre Todo el dia', 56),
(2444, '01', '08', 2018, 'Libre Todo el dia', 62),
(2445, '01', '08', 2018, 'Libre Todo el dia', 64),
(2446, '01', '08', 2018, 'Libre Todo el dia', 109),
(2447, '02', '08', 2018, 'Libre de 8:00 a 12:00', 81),
(2448, '02', '08', 2018, 'Libre Todo el dia', 109),
(2449, '02', '08', 2018, 'Libre Todo el dia', 62),
(2450, '03', '08', 2018, 'Libre Todo el dia', 64),
(2451, '03', '08', 2018, 'Libre Todo el dia', 109),
(2453, '03', '08', 2018, 'Libre Todo el dia', 82),
(2454, '06', '08', 2018, 'Libre Todo el dia', 64),
(2455, '06', '08', 2018, 'Libre Todo el dia', 84),
(2456, '06', '08', 2018, 'Libre Todo el dia', 47),
(2457, '07', '08', 2018, 'Libre Todo el dia', 47),
(2458, '08', '08', 2018, 'Libre Todo el dia', 47),
(2459, '09', '08', 2018, 'Libre Todo el dia', 47),
(2461, '08', '08', 2018, 'Libre de 8:00 a 12:00', 55),
(2462, '08', '08', 2018, 'Libre Todo el dia', 64),
(2463, '09', '08', 2018, 'Libre Todo el dia', 55),
(2464, '09', '08', 2018, 'Libre Todo el dia', 89),
(2465, '10', '08', 2018, 'Libre de 8:00 a 12:00', 81);
INSERT INTO `tb_calendario` (`id_calendario`, `dia`, `mes`, `anio`, `horario`, `id_espacio`) VALUES
(2466, '10', '08', 2018, 'Libre Todo el dia', 55),
(2467, '10', '08', 2018, 'Libre Todo el dia', 107),
(2468, '13', '08', 2018, 'Libre Todo el dia', 107),
(2469, '14', '08', 2018, 'Libre Todo el dia', 107),
(2470, '15', '08', 2018, 'Libre Todo el dia', 107),
(2471, '16', '08', 2018, 'Libre Todo el dia', 107),
(2472, '17', '08', 2018, 'Libre Todo el dia', 107),
(2473, '10', '08', 2018, 'Libre Todo el dia', 64),
(2474, '13', '08', 2018, 'Libre Todo el dia', 45),
(2475, '14', '08', 2018, 'Libre Todo el dia', 45),
(2476, '15', '08', 2018, 'Libre Todo el dia', 45),
(2477, '16', '08', 2018, 'Libre Todo el dia', 45),
(2478, '17', '08', 2018, 'Libre Todo el dia', 45),
(2479, '13', '08', 2018, 'Libre Todo el dia', 81),
(2480, '14', '08', 2018, 'Libre Todo el dia', 81),
(2481, '15', '08', 2018, 'Libre Todo el dia', 81),
(2482, '16', '08', 2018, 'Libre Todo el dia', 81),
(2483, '17', '08', 2018, 'Libre Todo el dia', 81),
(2484, '13', '08', 2018, 'Libre Todo el dia', 60),
(2485, '14', '08', 2018, 'Libre Todo el dia', 60),
(2486, '15', '08', 2018, 'Libre Todo el dia', 60),
(2487, '16', '08', 2018, 'Libre Todo el dia', 60),
(2488, '17', '08', 2018, 'Libre Todo el dia', 60),
(2489, '12', '08', 2018, 'Libre Todo el dia', 109),
(2490, '13', '08', 2018, 'Libre Todo el dia', 109),
(2491, '14', '08', 2018, 'Libre Todo el dia', 109),
(2492, '15', '08', 2018, 'Libre Todo el dia', 109),
(2493, '16', '08', 2018, 'Libre Todo el dia', 109),
(2494, '17', '08', 2018, 'Libre Todo el dia', 109),
(2495, '13', '08', 2018, 'Libre Todo el dia', 59),
(2496, '13', '08', 2018, 'Libre Todo el dia', 89),
(2497, '14', '08', 2018, 'Libre Todo el dia', 89),
(2498, '15', '08', 2018, 'Libre Todo el dia', 46),
(2499, '16', '08', 2018, 'Libre Todo el dia', 46),
(2500, '14', '08', 2018, 'Libre Todo el dia', 93),
(2501, '15', '08', 2018, 'Libre Todo el dia', 93),
(2502, '14', '08', 2018, 'Libre Todo el dia', 74),
(2503, '14', '08', 2018, 'Libre Todo el dia', 82),
(2504, '15', '08', 2018, 'Libre Todo el dia', 82),
(2505, '15', '08', 2018, 'Libre Todo el dia', 56),
(2506, '16', '08', 2018, 'Libre Todo el dia', 56),
(2507, '16', '08', 2018, 'Libre Todo el dia', 35),
(2508, '17', '08', 2018, 'Libre Todo el dia', 35),
(2509, '16', '08', 2018, 'Libre de 8:00 a 12:00', 82),
(2510, '16', '08', 2018, 'Libre Todo el dia', 50),
(2511, '16', '08', 2018, 'Libre Todo el dia', 57),
(2512, '17', '08', 2018, 'Libre de 14:00 a 18:00', 55),
(2513, '21', '08', 2018, 'Libre Todo el dia', 85),
(2514, '21', '08', 2018, 'Libre Todo el dia', 77),
(2515, '22', '08', 2018, 'Libre Todo el dia', 77),
(2516, '21', '08', 2018, 'Libre Todo el dia', 36),
(2517, '21', '08', 2018, 'Libre Todo el dia', 92),
(2518, '22', '08', 2018, 'Libre Todo el dia', 92),
(2519, '23', '08', 2018, 'Libre Todo el dia', 83),
(2520, '23', '08', 2018, 'Libre de 8:00 a 12:00', 76),
(2521, '23', '08', 2018, 'Libre Todo el dia', 89),
(2522, '24', '08', 2018, 'Libre Todo el dia', 89),
(2523, '23', '08', 2018, 'Libre Todo el dia', 109),
(2524, '23', '08', 2018, 'Libre Todo el dia', 36),
(2525, '24', '08', 2018, 'Libre de 8:00 a 12:00', 109),
(2526, '24', '08', 2018, 'Libre de 8:00 a 12:00', 92),
(2527, '24', '08', 2018, 'Libre de 14:00 a 18:00', 93),
(2529, '27', '08', 2018, 'Libre Todo el dia', 36),
(2530, '27', '08', 2018, 'Libre de 8:00 a 12:00', 41),
(2531, '28', '08', 2018, 'Libre Todo el dia', 41),
(2532, '28', '08', 2018, 'Libre Todo el dia', 108),
(2533, '28', '08', 2018, 'Libre Todo el dia', 95),
(2534, '28', '08', 2018, 'Libre Todo el dia', 85),
(2535, '28', '08', 2018, 'Libre Todo el dia', 55),
(2536, '29', '08', 2018, 'Libre Todo el dia', 55),
(2537, '07', '09', 2018, 'Libre Todo el dia', 68),
(2538, '01', '10', 2018, 'Libre Todo el dia', 68),
(2539, '02', '10', 2018, 'Libre Todo el dia', 68),
(2540, '03', '10', 2018, 'Libre Todo el dia', 68),
(2541, '04', '10', 2018, 'Libre Todo el dia', 68),
(2542, '05', '10', 2018, 'Libre Todo el dia', 68),
(2543, '06', '10', 2018, 'Libre Todo el dia', 68),
(2544, '07', '10', 2018, 'Libre Todo el dia', 68),
(2545, '08', '10', 2018, 'Libre Todo el dia', 68),
(2546, '09', '10', 2018, 'Libre Todo el dia', 68),
(2547, '10', '10', 2018, 'Libre Todo el dia', 68),
(2548, '11', '10', 2018, 'Libre Todo el dia', 68),
(2549, '12', '10', 2018, 'Libre Todo el dia', 68),
(2550, '13', '10', 2018, 'Libre Todo el dia', 68),
(2551, '14', '10', 2018, 'Libre Todo el dia', 68),
(2552, '15', '10', 2018, 'Libre Todo el dia', 68),
(2553, '16', '10', 2018, 'Libre Todo el dia', 68),
(2554, '17', '10', 2018, 'Libre Todo el dia', 68),
(2555, '18', '10', 2018, 'Libre Todo el dia', 68),
(2556, '19', '10', 2018, 'Libre Todo el dia', 68),
(2557, '19', '11', 2018, 'Libre Todo el dia', 68),
(2558, '20', '11', 2018, 'Libre Todo el dia', 68),
(2559, '21', '11', 2018, 'Libre Todo el dia', 68),
(2560, '22', '11', 2018, 'Libre Todo el dia', 68),
(2561, '23', '11', 2018, 'Libre Todo el dia', 68),
(2562, '24', '11', 2018, 'Libre Todo el dia', 68),
(2563, '25', '11', 2018, 'Libre Todo el dia', 68),
(2565, '29', '08', 2018, 'Libre Todo el dia', 50),
(2566, '30', '08', 2018, 'Libre Todo el dia', 50),
(2567, '31', '08', 2018, 'Libre Todo el dia', 50),
(2568, '01', '09', 2018, 'Libre Todo el dia', 50),
(2569, '02', '09', 2018, 'Libre Todo el dia', 50),
(2598, '01', '10', 2018, 'Libre Todo el dia', 50),
(2599, '02', '10', 2018, 'Libre Todo el dia', 50),
(2608, '29', '08', 2018, 'Libre Todo el dia', 109),
(2609, '29', '08', 2018, 'Libre Todo el dia', 89),
(2610, '30', '08', 2018, 'Libre Todo el dia', 89),
(2611, '30', '08', 2018, 'Libre Todo el dia', 109),
(2612, '31', '08', 2018, 'Libre Todo el dia', 109),
(2613, '29', '08', 2018, 'Libre de 8:00 a 12:00', 85),
(2614, '29', '08', 2018, 'Libre Todo el dia', 48),
(2615, '30', '08', 2018, 'Libre Todo el dia', 48),
(2616, '31', '08', 2018, 'Libre Todo el dia', 48),
(2617, '30', '08', 2018, 'Libre Todo el dia', 36),
(2618, '31', '08', 2018, 'Libre Todo el dia', 83),
(2619, '31', '08', 2018, 'Libre Todo el dia', 85),
(2620, '03', '09', 2018, 'Libre Todo el dia', 56),
(2621, '03', '09', 2018, 'Libre Todo el dia', 57),
(2623, '03', '09', 2018, 'Libre Todo el dia', 93),
(2624, '03', '09', 2018, 'Libre de 8:00 a 12:00', 109),
(2625, '03', '09', 2018, 'Libre Todo el dia', 36),
(2626, '03', '09', 2018, 'Libre Todo el dia', 83),
(2627, '04', '09', 2018, 'Libre de 8:00 a 12:00', 89),
(2628, '04', '09', 2018, 'Libre Todo el dia', 74),
(2629, '04', '09', 2018, 'Libre Todo el dia', 95),
(2630, '04', '09', 2018, 'Libre Todo el dia', 85),
(2631, '04', '09', 2018, 'Libre Todo el dia', 103),
(2632, '05', '09', 2018, 'Libre Todo el dia', 103),
(2633, '06', '09', 2018, 'Libre Todo el dia', 103),
(2634, '04', '09', 2018, 'Libre de 14:00 a 18:00', 93),
(2635, '05', '09', 2018, 'Libre Todo el dia', 93),
(2636, '06', '09', 2018, 'Libre Todo el dia', 93),
(2637, '07', '09', 2018, 'Libre Todo el dia', 93),
(2638, '05', '09', 2018, 'Libre Todo el dia', 85),
(2639, '05', '09', 2018, 'Libre de 8:00 a 12:00', 109),
(2640, '05', '09', 2018, 'Libre Todo el dia', 81),
(2641, '06', '09', 2018, 'Libre Todo el dia', 81),
(2642, '07', '09', 2018, 'Libre Todo el dia', 81),
(2643, '05', '09', 2018, 'Libre Todo el dia', 55),
(2644, '05', '09', 2018, 'Libre Todo el dia', 36),
(2645, '06', '09', 2018, 'Libre Todo el dia', 68),
(2646, '06', '09', 2018, 'Libre Todo el dia', 95),
(2647, '06', '09', 2018, 'Libre Todo el dia', 85),
(2648, '06', '09', 2018, 'Libre Todo el dia', 109),
(2649, '10', '09', 2018, 'Libre Todo el dia', 93),
(2650, '11', '09', 2018, 'Libre Todo el dia', 93),
(2651, '12', '09', 2018, 'Libre Todo el dia', 93),
(2652, '13', '09', 2018, 'Libre Todo el dia', 93),
(2653, '14', '09', 2018, 'Libre Todo el dia', 93),
(2654, '07', '09', 2018, 'Libre Todo el dia', 85),
(2655, '07', '09', 2018, 'Libre Todo el dia', 109),
(2656, '07', '09', 2018, 'Libre Todo el dia', 83),
(2657, '10', '09', 2018, 'Libre Todo el dia', 46),
(2658, '11', '09', 2018, 'Libre Todo el dia', 46),
(2659, '12', '09', 2018, 'Libre Todo el dia', 46),
(2660, '13', '09', 2018, 'Libre Todo el dia', 46),
(2661, '14', '09', 2018, 'Libre Todo el dia', 46),
(2662, '10', '09', 2018, 'Libre Todo el dia', 56),
(2663, '11', '09', 2018, 'Libre Todo el dia', 56),
(2664, '12', '09', 2018, 'Libre Todo el dia', 56),
(2665, '10', '09', 2018, 'Libre Todo el dia', 85),
(2666, '10', '09', 2018, 'Libre de 14:00 a 18:00', 89),
(2667, '11', '09', 2018, 'Libre Todo el dia', 89),
(2668, '12', '09', 2018, 'Libre Todo el dia', 89),
(2669, '10', '09', 2018, 'Libre Todo el dia', 74),
(2670, '10', '09', 2018, 'Libre de 14:00 a 18:00', 55),
(2671, '11', '09', 2018, 'Libre Todo el dia', 107),
(2672, '11', '09', 2018, 'Libre Todo el dia', 81),
(2673, '11', '09', 2018, 'Libre Todo el dia', 109),
(2674, '11', '09', 2018, 'Libre de 14:00 a 18:00', 85),
(2675, '11', '09', 2018, 'Libre Todo el dia', 41),
(2676, '12', '09', 2018, 'Libre Todo el dia', 41),
(2677, '13', '09', 2018, 'Libre Todo el dia', 41),
(2678, '14', '09', 2018, 'Libre Todo el dia', 41),
(2679, '12', '09', 2018, 'Libre Todo el dia', 86),
(2680, '12', '09', 2018, 'Libre Todo el dia', 48),
(2681, '12', '09', 2018, 'Libre Todo el dia', 85),
(2682, '12', '09', 2018, 'Libre Todo el dia', 109),
(2683, '12', '09', 2018, 'Libre Todo el dia', 55),
(2684, '13', '09', 2018, 'Libre Todo el dia', 83),
(2685, '12', '09', 2018, 'Libre de 14:00 a 18:00', 83),
(2686, '13', '09', 2018, 'Libre Todo el dia', 92),
(2687, '14', '09', 2018, 'Libre Todo el dia', 92),
(2688, '13', '09', 2018, 'Libre Todo el dia', 109),
(2689, '13', '09', 2018, 'Libre Todo el dia', 96),
(2690, '14', '09', 2018, 'Libre Todo el dia', 96),
(2691, '13', '09', 2018, 'Libre Todo el dia', 106),
(2692, '13', '09', 2018, 'Libre Todo el dia', 70),
(2693, '13', '09', 2018, 'Libre Todo el dia', 104),
(2694, '13', '09', 2018, 'Libre Todo el dia', 78),
(2695, '14', '09', 2018, 'Libre de 8:00 a 12:00', 78),
(2696, '13', '09', 2018, 'Libre de 14:00 a 18:00', 85),
(2697, '13', '09', 2018, 'Libre de 14:00 a 18:00', 55),
(2698, '14', '09', 2018, 'Libre Todo el dia', 56),
(2699, '13', '09', 2018, 'Libre Todo el dia', 95),
(2700, '14', '09', 2018, 'Libre Todo el dia', 95),
(2701, '14', '09', 2018, 'Libre Todo el dia', 109),
(2702, '15', '09', 2018, 'Libre Todo el dia', 109),
(2703, '16', '09', 2018, 'Libre Todo el dia', 109),
(2704, '17', '09', 2018, 'Libre Todo el dia', 109),
(2705, '18', '09', 2018, 'Libre Todo el dia', 109),
(2706, '19', '09', 2018, 'Libre Todo el dia', 109),
(2707, '20', '09', 2018, 'Libre Todo el dia', 109),
(2708, '21', '09', 2018, 'Libre Todo el dia', 109),
(2709, '22', '09', 2018, 'Libre Todo el dia', 109),
(2710, '23', '09', 2018, 'Libre Todo el dia', 109),
(2711, '24', '09', 2018, 'Libre Todo el dia', 109),
(2712, '25', '09', 2018, 'Libre Todo el dia', 109),
(2713, '26', '09', 2018, 'Libre Todo el dia', 109),
(2714, '27', '09', 2018, 'Libre Todo el dia', 109),
(2715, '28', '09', 2018, 'Libre Todo el dia', 109),
(2716, '17', '09', 2018, 'Libre de 8:00 a 12:00', 93),
(2717, '17', '09', 2018, 'Libre Todo el dia', 36),
(2718, '17', '09', 2018, 'Libre Todo el dia', 89),
(2719, '18', '09', 2018, 'Libre Todo el dia', 56),
(2720, '18', '09', 2018, 'Libre Todo el dia', 76),
(2721, '18', '09', 2018, 'Libre Todo el dia', 98),
(2722, '18', '09', 2018, 'Libre Todo el dia', 48),
(2723, '18', '09', 2018, 'Libre de 8:00 a 12:00', 85),
(2724, '18', '09', 2018, 'Libre Todo el dia', 36),
(2725, '18', '09', 2018, 'Libre de 14:00 a 18:00', 55),
(2726, '19', '09', 2018, 'Libre Todo el dia', 56),
(2727, '19', '09', 2018, 'Libre Todo el dia', 77),
(2728, '19', '09', 2018, 'Libre Todo el dia', 95),
(2729, '19', '09', 2018, 'Libre Todo el dia', 89),
(2730, '19', '09', 2018, 'Libre Todo el dia', 74),
(2731, '20', '09', 2018, 'Libre Todo el dia', 89),
(2732, '21', '09', 2018, 'Libre de 8:00 a 12:00', 89),
(2733, '19', '09', 2018, 'Libre Todo el dia', 55),
(2734, '19', '09', 2018, 'Libre Todo el dia', 86),
(2735, '20', '09', 2018, 'Libre Todo el dia', 86),
(2736, '21', '09', 2018, 'Libre Todo el dia', 86),
(2737, '19', '09', 2018, 'Libre Todo el dia', 36),
(2738, '20', '09', 2018, 'Libre Todo el dia', 107),
(2739, '20', '09', 2018, 'Libre Todo el dia', 98),
(2740, '21', '09', 2018, 'Libre Todo el dia', 98),
(2741, '20', '09', 2018, 'Libre Todo el dia', 77),
(2742, '21', '09', 2018, 'Libre Todo el dia', 56),
(2743, '21', '09', 2018, 'Libre de 8:00 a 12:00', 77),
(2744, '21', '09', 2018, 'Libre Todo el dia', 46),
(2745, '24', '09', 2018, 'Libre Todo el dia', 46),
(2746, '21', '09', 2018, 'Libre Todo el dia', 74),
(2747, '22', '09', 2018, 'Libre Todo el dia', 108),
(2748, '23', '09', 2018, 'Libre Todo el dia', 108),
(2749, '24', '09', 2018, 'Libre Todo el dia', 108),
(2750, '25', '09', 2018, 'Libre Todo el dia', 108),
(2751, '26', '09', 2018, 'Libre Todo el dia', 108),
(2752, '27', '09', 2018, 'Libre Todo el dia', 108),
(2755, '22', '09', 2018, 'Libre Todo el dia', 107),
(2756, '24', '09', 2018, 'Libre Todo el dia', 55),
(2757, '25', '09', 2018, 'Libre Todo el dia', 55),
(2758, '26', '09', 2018, 'Libre Todo el dia', 55),
(2759, '27', '09', 2018, 'Libre Todo el dia', 55),
(2762, '01', '10', 2018, 'Libre Todo el dia', 108),
(2763, '02', '10', 2018, 'Libre Todo el dia', 108),
(2764, '03', '10', 2018, 'Libre Todo el dia', 108),
(2765, '04', '10', 2018, 'Libre Todo el dia', 108),
(2766, '05', '10', 2018, 'Libre Todo el dia', 108),
(2767, '06', '10', 2018, 'Libre Todo el dia', 108),
(2768, '07', '10', 2018, 'Libre Todo el dia', 108),
(2769, '08', '10', 2018, 'Libre Todo el dia', 108),
(2770, '09', '10', 2018, 'Libre Todo el dia', 108),
(2771, '10', '10', 2018, 'Libre Todo el dia', 108),
(2772, '11', '10', 2018, 'Libre Todo el dia', 108),
(2773, '12', '10', 2018, 'Libre Todo el dia', 108),
(2774, '13', '10', 2018, 'Libre Todo el dia', 108),
(2775, '14', '10', 2018, 'Libre Todo el dia', 108),
(2776, '15', '10', 2018, 'Libre Todo el dia', 108),
(2777, '16', '10', 2018, 'Libre Todo el dia', 108),
(2778, '17', '10', 2018, 'Libre Todo el dia', 108),
(2779, '18', '10', 2018, 'Libre Todo el dia', 108),
(2780, '19', '10', 2018, 'Libre Todo el dia', 108),
(2781, '20', '10', 2018, 'Libre Todo el dia', 108),
(2782, '21', '10', 2018, 'Libre Todo el dia', 108),
(2791, '28', '09', 2018, 'Libre Todo el dia', 108),
(2792, '24', '09', 2018, 'Libre Todo el dia', 87),
(2793, '24', '09', 2018, 'Libre de 14:00 a 18:00', 85),
(2794, '24', '09', 2018, 'Libre Todo el dia', 97),
(2795, '24', '09', 2018, 'Libre Todo el dia', 89),
(2796, '24', '09', 2018, 'Libre Todo el dia', 57),
(2797, '25', '09', 2018, 'Libre Todo el dia', 57),
(2799, '25', '09', 2018, 'Libre Todo el dia', 56),
(2800, '25', '09', 2018, 'Libre Todo el dia', 93),
(2801, '25', '09', 2018, 'Libre Todo el dia', 77),
(2802, '25', '09', 2018, 'Libre Todo el dia', 106),
(2803, '25', '09', 2018, 'Libre Todo el dia', 74),
(2804, '25', '09', 2018, 'Libre de 8:00 a 12:00', 85),
(2805, '25', '09', 2018, 'Libre Todo el dia', 36),
(2806, '26', '09', 2018, 'Libre Todo el dia', 36),
(2807, '27', '09', 2018, 'Libre Todo el dia', 36),
(2808, '29', '09', 2018, 'Libre Todo el dia', 109),
(2809, '30', '09', 2018, 'Libre Todo el dia', 109),
(2810, '27', '09', 2018, 'Libre Todo el dia', 93),
(2811, '28', '09', 2018, 'Libre Todo el dia', 93),
(2812, '26', '09', 2018, 'Libre Todo el dia', 95),
(2813, '26', '09', 2018, 'Libre Todo el dia', 59),
(2814, '27', '09', 2018, 'Libre Todo el dia', 59),
(2815, '28', '09', 2018, 'Libre Todo el dia', 59),
(2816, '29', '09', 2018, 'Libre Todo el dia', 59),
(2817, '30', '09', 2018, 'Libre Todo el dia', 59),
(2818, '26', '09', 2018, 'Libre Todo el dia', 74),
(2819, '26', '09', 2018, 'Libre de 8:00 a 12:00', 85),
(2820, '27', '09', 2018, 'Libre Todo el dia', 107),
(2821, '27', '09', 2018, 'Libre Todo el dia', 41),
(2822, '28', '09', 2018, 'Libre Todo el dia', 41),
(2823, '27', '09', 2018, 'Libre Todo el dia', 106),
(2824, '28', '09', 2018, 'Libre Todo el dia', 85),
(2825, '28', '09', 2018, 'Libre Todo el dia', 37),
(2826, '28', '09', 2018, 'Libre Todo el dia', 56),
(2827, '01', '10', 2018, 'Libre Todo el dia', 56),
(2828, '28', '09', 2018, 'Libre Todo el dia', 38),
(2829, '29', '09', 2018, 'Libre Todo el dia', 107),
(2830, '01', '10', 2018, 'Libre Todo el dia', 46),
(2831, '02', '10', 2018, 'Libre Todo el dia', 46),
(2832, '01', '10', 2018, 'Libre Todo el dia', 85),
(2833, '02', '10', 2018, 'Libre Todo el dia', 85),
(2834, '01', '10', 2018, 'Libre de 8:00 a 12:00', 77),
(2835, '03', '10', 2018, 'Libre Todo el dia', 106),
(2836, '04', '10', 2018, 'Libre Todo el dia', 106),
(2837, '01', '10', 2018, 'Libre Todo el dia', 109),
(2838, '02', '10', 2018, 'Libre Todo el dia', 109),
(2839, '03', '10', 2018, 'Libre Todo el dia', 109),
(2840, '04', '10', 2018, 'Libre Todo el dia', 109),
(2841, '01', '10', 2018, 'Libre Todo el dia', 103),
(2842, '02', '10', 2018, 'Libre Todo el dia', 103),
(2843, '01', '10', 2018, 'Libre Todo el dia', 49),
(2844, '02', '10', 2018, 'Libre Todo el dia', 49),
(2845, '03', '10', 2018, 'Libre Todo el dia', 49),
(2846, '04', '10', 2018, 'Libre Todo el dia', 49),
(2847, '05', '10', 2018, 'Libre Todo el dia', 49),
(2848, '02', '10', 2018, 'Libre Todo el dia', 95),
(2849, '02', '10', 2018, 'Libre Todo el dia', 106),
(2850, '02', '10', 2018, 'Libre de 8:00 a 12:00', 77),
(2851, '02', '10', 2018, 'Libre Todo el dia', 82),
(2852, '03', '10', 2018, 'Libre Todo el dia', 82),
(2853, '04', '10', 2018, 'Libre Todo el dia', 82),
(2854, '05', '10', 2018, 'Libre Todo el dia', 82),
(2855, '06', '10', 2018, 'Libre Todo el dia', 82),
(2856, '07', '10', 2018, 'Libre Todo el dia', 82),
(2857, '08', '10', 2018, 'Libre Todo el dia', 82),
(2858, '09', '10', 2018, 'Libre Todo el dia', 82),
(2859, '10', '10', 2018, 'Libre Todo el dia', 82),
(2860, '11', '10', 2018, 'Libre Todo el dia', 82),
(2861, '12', '10', 2018, 'Libre Todo el dia', 82),
(2862, '13', '10', 2018, 'Libre Todo el dia', 82),
(2863, '14', '10', 2018, 'Libre Todo el dia', 82),
(2864, '15', '10', 2018, 'Libre Todo el dia', 82),
(2865, '16', '10', 2018, 'Libre Todo el dia', 82),
(2866, '17', '10', 2018, 'Libre Todo el dia', 82),
(2867, '18', '10', 2018, 'Libre Todo el dia', 82),
(2868, '19', '10', 2018, 'Libre Todo el dia', 82),
(2869, '20', '10', 2018, 'Libre Todo el dia', 82),
(2870, '21', '10', 2018, 'Libre Todo el dia', 82),
(2871, '02', '10', 2018, 'Libre Todo el dia', 55),
(2872, '02', '10', 2018, 'Libre Todo el dia', 76),
(2873, '03', '10', 2018, 'Libre Todo el dia', 76),
(2874, '04', '10', 2018, 'Libre Todo el dia', 76),
(2875, '05', '10', 2018, 'Libre Todo el dia', 76),
(2876, '06', '10', 2018, 'Libre Todo el dia', 76),
(2877, '07', '10', 2018, 'Libre Todo el dia', 76),
(2878, '08', '10', 2018, 'Libre Todo el dia', 76),
(2880, '10', '10', 2018, 'Libre Todo el dia', 76),
(2881, '11', '10', 2018, 'Libre Todo el dia', 76),
(2882, '02', '10', 2018, 'Libre de 14:00 a 18:00', 81),
(2883, '03', '10', 2018, 'Libre Todo el dia', 81),
(2884, '04', '10', 2018, 'Libre Todo el dia', 81),
(2885, '02', '10', 2018, 'Libre Todo el dia', 47),
(2886, '03', '10', 2018, 'Libre Todo el dia', 47),
(2887, '04', '10', 2018, 'Libre Todo el dia', 47),
(2888, '05', '10', 2018, 'Libre Todo el dia', 47),
(2889, '06', '10', 2018, 'Libre Todo el dia', 47),
(2890, '07', '10', 2018, 'Libre Todo el dia', 47),
(2891, '08', '10', 2018, 'Libre Todo el dia', 47),
(2892, '09', '10', 2018, 'Libre Todo el dia', 47),
(2893, '10', '10', 2018, 'Libre Todo el dia', 47),
(2894, '11', '10', 2018, 'Libre Todo el dia', 47),
(2895, '03', '10', 2018, 'Libre Todo el dia', 95),
(2896, '03', '10', 2018, 'Libre Todo el dia', 55),
(2897, '04', '10', 2018, 'Libre Todo el dia', 85),
(2898, '04', '10', 2018, 'Libre Todo el dia', 83),
(2901, '05', '10', 2018, 'Libre Todo el dia', 74),
(2902, '05', '10', 2018, 'Libre Todo el dia', 84),
(2903, '05', '10', 2018, 'Libre Todo el dia', 38),
(2905, '08', '10', 2018, 'Libre Todo el dia', 109),
(2906, '09', '10', 2018, 'Libre Todo el dia', 109),
(2907, '10', '10', 2018, 'Libre Todo el dia', 109),
(2908, '11', '10', 2018, 'Libre Todo el dia', 109),
(2909, '12', '10', 2018, 'Libre Todo el dia', 109),
(2910, '13', '10', 2018, 'Libre Todo el dia', 109),
(2911, '14', '10', 2018, 'Libre Todo el dia', 109),
(2912, '15', '10', 2018, 'Libre Todo el dia', 109),
(2913, '16', '10', 2018, 'Libre Todo el dia', 109),
(2914, '17', '10', 2018, 'Libre Todo el dia', 109),
(2915, '18', '10', 2018, 'Libre Todo el dia', 109),
(2916, '19', '10', 2018, 'Libre Todo el dia', 109),
(2917, '20', '10', 2018, 'Libre Todo el dia', 109),
(2918, '21', '10', 2018, 'Libre Todo el dia', 109),
(2919, '22', '10', 2018, 'Libre Todo el dia', 109),
(2920, '23', '10', 2018, 'Libre Todo el dia', 109),
(2921, '24', '10', 2018, 'Libre Todo el dia', 109),
(2924, '27', '10', 2018, 'Libre Todo el dia', 109),
(2925, '28', '10', 2018, 'Libre Todo el dia', 109),
(2926, '29', '10', 2018, 'Libre Todo el dia', 109),
(2927, '30', '10', 2018, 'Libre Todo el dia', 109),
(2928, '31', '10', 2018, 'Libre Todo el dia', 109),
(2929, '08', '10', 2018, 'Libre Todo el dia', 67),
(2930, '08', '10', 2018, 'Libre Todo el dia', 77),
(2931, '09', '10', 2018, 'Libre Todo el dia', 77),
(2932, '10', '10', 2018, 'Libre Todo el dia', 77),
(2933, '11', '10', 2018, 'Libre Todo el dia', 77),
(2934, '12', '10', 2018, 'Libre Todo el dia', 77),
(2935, '08', '10', 2018, 'Libre Todo el dia', 95),
(2936, '08', '10', 2018, 'Libre Todo el dia', 85),
(2937, '08', '10', 2018, 'Libre Todo el dia', 38),
(2938, '09', '10', 2018, 'Libre Todo el dia', 67),
(2939, '09', '10', 2018, 'Libre Todo el dia', 49),
(2940, '10', '10', 2018, 'Libre Todo el dia', 49),
(2941, '11', '10', 2018, 'Libre Todo el dia', 49),
(2942, '10', '10', 2018, 'Libre Todo el dia', 67),
(2943, '11', '10', 2018, 'Libre Todo el dia', 67),
(2944, '09', '10', 2018, 'Libre Todo el dia', 103),
(2945, '09', '10', 2018, 'Libre Todo el dia', 91),
(2946, '10', '10', 2018, 'Libre Todo el dia', 91),
(2947, '11', '10', 2018, 'Libre Todo el dia', 91),
(2948, '12', '10', 2018, 'Libre Todo el dia', 91),
(2949, '13', '10', 2018, 'Libre Todo el dia', 91),
(2950, '14', '10', 2018, 'Libre Todo el dia', 91),
(2951, '15', '10', 2018, 'Libre Todo el dia', 91),
(2952, '16', '10', 2018, 'Libre Todo el dia', 91),
(2953, '17', '10', 2018, 'Libre Todo el dia', 91),
(2954, '18', '10', 2018, 'Libre Todo el dia', 91),
(2955, '19', '10', 2018, 'Libre Todo el dia', 91),
(2956, '20', '10', 2018, 'Libre Todo el dia', 91),
(2957, '21', '10', 2018, 'Libre Todo el dia', 91),
(2958, '22', '10', 2018, 'Libre Todo el dia', 91),
(2959, '23', '10', 2018, 'Libre Todo el dia', 91),
(2960, '24', '10', 2018, 'Libre Todo el dia', 91),
(2961, '25', '10', 2018, 'Libre Todo el dia', 91),
(2962, '26', '10', 2018, 'Libre Todo el dia', 91),
(2963, '27', '10', 2018, 'Libre Todo el dia', 91),
(2964, '28', '10', 2018, 'Libre Todo el dia', 91),
(2965, '29', '10', 2018, 'Libre Todo el dia', 91),
(2966, '30', '10', 2018, 'Libre Todo el dia', 91),
(2967, '31', '10', 2018, 'Libre Todo el dia', 91),
(2968, '01', '11', 2018, 'Libre Todo el dia', 91),
(2969, '02', '11', 2018, 'Libre Todo el dia', 91),
(2970, '03', '11', 2018, 'Libre Todo el dia', 91),
(2971, '04', '11', 2018, 'Libre Todo el dia', 91),
(2972, '05', '11', 2018, 'Libre Todo el dia', 91),
(2973, '06', '11', 2018, 'Libre Todo el dia', 91),
(2974, '07', '11', 2018, 'Libre Todo el dia', 91),
(2975, '08', '11', 2018, 'Libre Todo el dia', 91),
(2976, '09', '11', 2018, 'Libre Todo el dia', 91),
(2977, '10', '11', 2018, 'Libre Todo el dia', 91),
(2978, '11', '11', 2018, 'Libre Todo el dia', 91),
(2979, '12', '11', 2018, 'Libre Todo el dia', 91),
(2980, '13', '11', 2018, 'Libre Todo el dia', 91),
(2981, '14', '11', 2018, 'Libre Todo el dia', 91),
(2982, '15', '11', 2018, 'Libre Todo el dia', 91),
(2983, '16', '11', 2018, 'Libre Todo el dia', 91),
(2984, '17', '11', 2018, 'Libre Todo el dia', 91),
(2985, '18', '11', 2018, 'Libre Todo el dia', 91),
(2986, '19', '11', 2018, 'Libre Todo el dia', 91),
(2987, '20', '11', 2018, 'Libre Todo el dia', 91),
(2988, '21', '11', 2018, 'Libre Todo el dia', 91),
(2989, '22', '11', 2018, 'Libre Todo el dia', 91),
(2990, '23', '11', 2018, 'Libre Todo el dia', 91),
(2991, '24', '11', 2018, 'Libre Todo el dia', 91),
(2992, '25', '11', 2018, 'Libre Todo el dia', 91),
(2993, '26', '11', 2018, 'Libre Todo el dia', 91),
(2994, '27', '11', 2018, 'Libre Todo el dia', 91),
(2995, '28', '11', 2018, 'Libre Todo el dia', 91),
(2996, '29', '11', 2018, 'Libre Todo el dia', 91),
(2997, '30', '11', 2018, 'Libre Todo el dia', 91),
(2998, '09', '10', 2018, 'Libre Todo el dia', 38),
(2999, '09', '10', 2018, 'Libre Todo el dia', 86),
(3000, '09', '10', 2018, 'Libre de 8:00 a 12:00', 93),
(3001, '09', '10', 2018, 'Libre Todo el dia', 95),
(3002, '09', '10', 2018, 'Libre Todo el dia', 36),
(3003, '10', '10', 2018, 'Libre Todo el dia', 38),
(3004, '10', '10', 2018, 'Libre Todo el dia', 46),
(3005, '10', '10', 2018, 'Libre Todo el dia', 95),
(3006, '10', '10', 2018, 'Libre Todo el dia', 87),
(3007, '11', '10', 2018, 'Libre Todo el dia', 106),
(3008, '11', '10', 2018, 'Libre Todo el dia', 107),
(3009, '11', '10', 2018, 'Libre Todo el dia', 46),
(3010, '12', '10', 2018, 'Libre Todo el dia', 46),
(3011, '11', '10', 2018, 'Libre Todo el dia', 95),
(3012, '11', '10', 2018, 'Libre de 14:00 a 18:00', 93),
(3013, '12', '10', 2018, 'Libre Todo el dia', 38),
(3015, '12', '10', 2018, 'Libre Todo el dia', 95),
(3016, '12', '10', 2018, 'Libre Todo el dia', 49),
(3017, '12', '10', 2018, 'Libre Todo el dia', 37),
(3018, '13', '10', 2018, 'Libre Todo el dia', 37),
(3019, '14', '10', 2018, 'Libre Todo el dia', 37),
(3020, '15', '10', 2018, 'Libre Todo el dia', 37),
(3021, '16', '10', 2018, 'Libre Todo el dia', 37),
(3022, '12', '10', 2018, 'Libre Todo el dia', 56),
(3023, '16', '10', 2018, 'Libre Todo el dia', 95),
(3024, '16', '10', 2018, 'Libre Todo el dia', 60),
(3025, '16', '10', 2018, 'Libre Todo el dia', 59),
(3026, '16', '10', 2018, 'Libre de 14:00 a 18:00', 55),
(3027, '17', '10', 2018, 'Libre Todo el dia', 36),
(3028, '17', '10', 2018, 'Libre de 14:00 a 18:00', 89),
(3029, '17', '10', 2018, 'Libre Todo el dia', 56),
(3030, '18', '10', 2018, 'Libre Todo el dia', 56),
(3031, '19', '10', 2018, 'Libre Todo el dia', 56),
(3032, '17', '10', 2018, 'Libre Todo el dia', 59),
(3033, '18', '10', 2018, 'Libre Todo el dia', 59),
(3034, '18', '10', 2018, 'Libre Todo el dia', 93),
(3035, '18', '10', 2018, 'Libre Todo el dia', 107),
(3036, '18', '10', 2018, 'Libre Todo el dia', 85),
(3037, '19', '10', 2018, 'Libre Todo el dia', 85),
(3038, '20', '10', 2018, 'Libre Todo el dia', 85),
(3039, '21', '10', 2018, 'Libre Todo el dia', 85),
(3040, '22', '10', 2018, 'Libre Todo el dia', 85),
(3041, '23', '10', 2018, 'Libre Todo el dia', 85),
(3042, '24', '10', 2018, 'Libre Todo el dia', 85),
(3043, '25', '10', 2018, 'Libre Todo el dia', 85),
(3044, '26', '10', 2018, 'Libre Todo el dia', 85),
(3045, '27', '10', 2018, 'Libre Todo el dia', 85),
(3046, '28', '10', 2018, 'Libre Todo el dia', 85),
(3047, '29', '10', 2018, 'Libre Todo el dia', 85),
(3048, '30', '10', 2018, 'Libre Todo el dia', 85),
(3049, '31', '10', 2018, 'Libre Todo el dia', 85),
(3050, '01', '11', 2018, 'Libre Todo el dia', 85),
(3051, '02', '11', 2018, 'Libre Todo el dia', 85),
(3052, '18', '10', 2018, 'Libre Todo el dia', 67),
(3053, '18', '10', 2018, 'Libre Todo el dia', 64),
(3054, '19', '10', 2018, 'Libre Todo el dia', 59),
(3055, '19', '10', 2018, 'Libre de 8:00 a 12:00', 77),
(3056, '22', '10', 2018, 'Libre Todo el dia', 81),
(3057, '23', '10', 2018, 'Libre Todo el dia', 81),
(3058, '24', '10', 2018, 'Libre Todo el dia', 81),
(3059, '25', '10', 2018, 'Libre Todo el dia', 81),
(3060, '26', '10', 2018, 'Libre Todo el dia', 81),
(3061, '22', '10', 2018, 'Libre Todo el dia', 107),
(3062, '23', '10', 2018, 'Libre Todo el dia', 107),
(3063, '24', '10', 2018, 'Libre Todo el dia', 107),
(3064, '25', '10', 2018, 'Libre Todo el dia', 107),
(3065, '26', '10', 2018, 'Libre Todo el dia', 107),
(3066, '22', '10', 2018, 'Libre de 14:00 a 18:00', 89),
(3067, '22', '10', 2018, 'Libre Todo el dia', 59),
(3068, '23', '10', 2018, 'Libre Todo el dia', 89),
(3069, '24', '10', 2018, 'Libre Todo el dia', 89),
(3070, '25', '10', 2018, 'Libre Todo el dia', 89),
(3071, '22', '10', 2018, 'Libre Todo el dia', 103),
(3072, '23', '10', 2018, 'Libre Todo el dia', 103),
(3073, '24', '10', 2018, 'Libre Todo el dia', 103),
(3074, '25', '10', 2018, 'Libre Todo el dia', 103),
(3075, '26', '10', 2018, 'Libre Todo el dia', 103),
(3076, '27', '10', 2018, 'Libre Todo el dia', 103),
(3077, '28', '10', 2018, 'Libre Todo el dia', 103),
(3078, '29', '10', 2018, 'Libre Todo el dia', 103),
(3079, '30', '10', 2018, 'Libre Todo el dia', 103),
(3080, '31', '10', 2018, 'Libre Todo el dia', 103),
(3081, '01', '11', 2018, 'Libre Todo el dia', 103),
(3082, '02', '11', 2018, 'Libre Todo el dia', 103),
(3083, '03', '11', 2018, 'Libre Todo el dia', 103),
(3084, '04', '11', 2018, 'Libre Todo el dia', 103),
(3085, '03', '11', 2018, 'Libre Todo el dia', 85),
(3086, '04', '11', 2018, 'Libre Todo el dia', 85),
(3087, '22', '10', 2018, 'Libre Todo el dia', 35),
(3088, '23', '10', 2018, 'Libre Todo el dia', 35),
(3089, '24', '10', 2018, 'Libre Todo el dia', 35),
(3090, '25', '10', 2018, 'Libre Todo el dia', 35),
(3091, '26', '10', 2018, 'Libre Todo el dia', 35),
(3092, '27', '10', 2018, 'Libre Todo el dia', 35),
(3093, '28', '10', 2018, 'Libre Todo el dia', 35),
(3094, '29', '10', 2018, 'Libre Todo el dia', 35),
(3095, '30', '10', 2018, 'Libre Todo el dia', 35),
(3096, '31', '10', 2018, 'Libre Todo el dia', 35),
(3097, '01', '11', 2018, 'Libre Todo el dia', 35),
(3098, '02', '11', 2018, 'Libre Todo el dia', 35),
(3099, '24', '10', 2018, 'Libre Todo el dia', 49),
(3100, '22', '10', 2018, 'Libre Todo el dia', 98),
(3101, '23', '10', 2018, 'Libre Todo el dia', 98),
(3102, '24', '10', 2018, 'Libre Todo el dia', 98),
(3103, '25', '10', 2018, 'Libre Todo el dia', 98),
(3104, '26', '10', 2018, 'Libre Todo el dia', 98),
(3105, '27', '10', 2018, 'Libre Todo el dia', 98),
(3106, '28', '10', 2018, 'Libre Todo el dia', 98),
(3107, '29', '10', 2018, 'Libre Todo el dia', 98),
(3108, '30', '10', 2018, 'Libre Todo el dia', 98),
(3109, '31', '10', 2018, 'Libre Todo el dia', 98),
(3110, '01', '11', 2018, 'Libre Todo el dia', 98),
(3111, '23', '10', 2018, 'Libre Todo el dia', 67),
(3112, '23', '10', 2018, 'Libre Todo el dia', 46),
(3113, '24', '10', 2018, 'Libre Todo el dia', 46),
(3114, '25', '10', 2018, 'Libre Todo el dia', 46),
(3115, '26', '10', 2018, 'Libre Todo el dia', 46),
(3116, '23', '10', 2018, 'Libre de 14:00 a 18:00', 93),
(3117, '24', '10', 2018, 'Libre Todo el dia', 67),
(3118, '24', '10', 2018, 'Libre de 14:00 a 18:00', 37),
(3119, '25', '10', 2018, 'Libre Todo el dia', 86),
(3120, '25', '10', 2018, 'Libre Todo el dia', 47),
(3121, '29', '10', 2018, 'Libre Todo el dia', 76),
(3122, '29', '10', 2018, 'Libre Todo el dia', 77),
(3123, '29', '10', 2018, 'Libre Todo el dia', 48),
(3124, '30', '10', 2018, 'Libre Todo el dia', 74),
(3125, '30', '10', 2018, 'Libre Todo el dia', 51),
(3126, '30', '10', 2018, 'Libre Todo el dia', 106),
(3127, '30', '10', 2018, 'Libre Todo el dia', 59),
(3129, '01', '11', 2018, 'Libre Todo el dia', 59),
(3130, '31', '10', 2018, 'Libre Todo el dia', 73),
(3131, '01', '11', 2018, 'Libre Todo el dia', 73),
(3132, '02', '11', 2018, 'Libre Todo el dia', 73),
(3133, '03', '11', 2018, 'Libre Todo el dia', 73),
(3134, '31', '10', 2018, 'Libre Todo el dia', 55),
(3135, '01', '11', 2018, 'Libre Todo el dia', 106),
(3136, '31', '10', 2018, 'Libre Todo el dia', 36),
(3137, '01', '11', 2018, 'Libre Todo el dia', 77),
(3138, '01', '11', 2018, 'Libre Todo el dia', 89),
(3139, '01', '11', 2018, 'Libre Todo el dia', 109),
(3140, '02', '11', 2018, 'Libre Todo el dia', 109),
(3141, '03', '11', 2018, 'Libre Todo el dia', 109),
(3142, '04', '11', 2018, 'Libre Todo el dia', 109),
(3154, '02', '11', 2018, 'Libre Todo el dia', 95),
(3155, '02', '11', 2018, 'Libre de 8:00 a 12:00', 93),
(3156, '02', '11', 2018, 'Libre Todo el dia', 74),
(3157, '02', '11', 2018, 'Libre Todo el dia', 77),
(3158, '06', '11', 2018, 'Libre Todo el dia', 93),
(3159, '07', '11', 2018, 'Libre Todo el dia', 93),
(3160, '08', '11', 2018, 'Libre Todo el dia', 93),
(3161, '09', '11', 2018, 'Libre Todo el dia', 93),
(3162, '10', '11', 2018, 'Libre Todo el dia', 93),
(3163, '11', '11', 2018, 'Libre Todo el dia', 93),
(3164, '12', '11', 2018, 'Libre Todo el dia', 93),
(3165, '13', '11', 2018, 'Libre Todo el dia', 93),
(3166, '14', '11', 2018, 'Libre Todo el dia', 93),
(3167, '15', '11', 2018, 'Libre Todo el dia', 93),
(3168, '16', '11', 2018, 'Libre Todo el dia', 93),
(3169, '17', '11', 2018, 'Libre Todo el dia', 93),
(3170, '18', '11', 2018, 'Libre Todo el dia', 93),
(3171, '19', '11', 2018, 'Libre Todo el dia', 93),
(3172, '20', '11', 2018, 'Libre Todo el dia', 93),
(3173, '21', '11', 2018, 'Libre Todo el dia', 93),
(3174, '22', '11', 2018, 'Libre Todo el dia', 93),
(3175, '23', '11', 2018, 'Libre Todo el dia', 93),
(3176, '24', '11', 2018, 'Libre Todo el dia', 93),
(3177, '25', '11', 2018, 'Libre Todo el dia', 93),
(3178, '26', '11', 2018, 'Libre Todo el dia', 93),
(3179, '27', '11', 2018, 'Libre Todo el dia', 93),
(3180, '28', '11', 2018, 'Libre Todo el dia', 93),
(3181, '29', '11', 2018, 'Libre Todo el dia', 93),
(3182, '06', '11', 2018, 'Libre Todo el dia', 83),
(3183, '07', '11', 2018, 'Libre Todo el dia', 83),
(3184, '08', '11', 2018, 'Libre Todo el dia', 83),
(3185, '09', '11', 2018, 'Libre Todo el dia', 83),
(3186, '06', '11', 2018, 'Libre Todo el dia', 73),
(3187, '07', '11', 2018, 'Libre Todo el dia', 73),
(3188, '08', '11', 2018, 'Libre Todo el dia', 73),
(3189, '09', '11', 2018, 'Libre Todo el dia', 73),
(3204, '07', '11', 2018, 'Libre Todo el dia', 109),
(3205, '08', '11', 2018, 'Libre Todo el dia', 109),
(3206, '09', '11', 2018, 'Libre Todo el dia', 109),
(3207, '10', '11', 2018, 'Libre Todo el dia', 109),
(3208, '07', '11', 2018, 'Libre de 8:00 a 12:00', 77),
(3209, '01', '12', 2018, 'Libre Todo el dia', 91),
(3210, '02', '12', 2018, 'Libre Todo el dia', 91),
(3211, '03', '12', 2018, 'Libre Todo el dia', 91),
(3212, '04', '12', 2018, 'Libre Todo el dia', 91),
(3213, '05', '12', 2018, 'Libre Todo el dia', 91),
(3214, '06', '12', 2018, 'Libre Todo el dia', 91),
(3215, '07', '12', 2018, 'Libre Todo el dia', 91),
(3216, '08', '12', 2018, 'Libre Todo el dia', 91),
(3217, '09', '12', 2018, 'Libre Todo el dia', 91),
(3218, '10', '12', 2018, 'Libre Todo el dia', 91),
(3219, '11', '12', 2018, 'Libre Todo el dia', 91),
(3223, '15', '12', 2018, 'Libre Todo el dia', 91),
(3224, '16', '12', 2018, 'Libre Todo el dia', 91),
(3225, '17', '12', 2018, 'Libre Todo el dia', 91),
(3226, '18', '12', 2018, 'Libre Todo el dia', 91),
(3227, '19', '12', 2018, 'Libre Todo el dia', 91),
(3228, '20', '12', 2018, 'Libre Todo el dia', 91),
(3229, '21', '12', 2018, 'Libre Todo el dia', 91),
(3230, '22', '12', 2018, 'Libre Todo el dia', 91),
(3231, '23', '12', 2018, 'Libre Todo el dia', 91),
(3232, '24', '12', 2018, 'Libre Todo el dia', 91),
(3233, '25', '12', 2018, 'Libre Todo el dia', 91),
(3234, '26', '12', 2018, 'Libre Todo el dia', 91),
(3235, '27', '12', 2018, 'Libre Todo el dia', 91),
(3236, '28', '12', 2018, 'Libre Todo el dia', 91),
(3237, '29', '12', 2018, 'Libre Todo el dia', 91),
(3238, '30', '12', 2018, 'Libre Todo el dia', 91),
(3239, '31', '12', 2018, 'Libre Todo el dia', 91),
(3240, '08', '11', 2018, 'Libre Todo el dia', 56),
(3241, '09', '11', 2018, 'Libre Todo el dia', 56),
(3242, '08', '11', 2018, 'Libre Todo el dia', 51),
(3243, '08', '11', 2018, 'Libre Todo el dia', 38),
(3244, '08', '11', 2018, 'Libre Todo el dia', 74),
(3245, '09', '11', 2018, 'Libre Todo el dia', 77),
(3246, '14', '11', 2018, 'Libre Todo el dia', 106),
(3247, '13', '11', 2018, 'Libre Todo el dia', 77),
(3248, '13', '11', 2018, 'Libre Todo el dia', 89),
(3249, '14', '11', 2018, 'Libre Todo el dia', 89),
(3250, '13', '11', 2018, 'Libre Todo el dia', 55),
(3251, '14', '11', 2018, 'Libre Todo el dia', 56),
(3252, '15', '11', 2018, 'Libre Todo el dia', 56),
(3253, '16', '11', 2018, 'Libre Todo el dia', 56),
(3258, '14', '11', 2018, 'Libre Todo el dia', 55),
(3259, '15', '11', 2018, 'Libre de 8:00 a 12:00', 55),
(3260, '15', '11', 2018, 'Libre Todo el dia', 109),
(3261, '16', '11', 2018, 'Libre Todo el dia', 109),
(3262, '16', '11', 2018, 'Libre Todo el dia', 74),
(3263, '16', '11', 2018, 'Libre Todo el dia', 89),
(3264, '17', '11', 2018, 'Libre Todo el dia', 89),
(3265, '18', '11', 2018, 'Libre Todo el dia', 89),
(3266, '19', '11', 2018, 'Libre Todo el dia', 89),
(3267, '20', '11', 2018, 'Libre Todo el dia', 89),
(3268, '21', '11', 2018, 'Libre Todo el dia', 89),
(3269, '22', '11', 2018, 'Libre Todo el dia', 89),
(3270, '23', '11', 2018, 'Libre Todo el dia', 89),
(3271, '24', '11', 2018, 'Libre Todo el dia', 89),
(3272, '25', '11', 2018, 'Libre Todo el dia', 89),
(3273, '26', '11', 2018, 'Libre Todo el dia', 89),
(3274, '16', '11', 2018, 'Libre de 8:00 a 12:00', 68),
(3275, '19', '11', 2018, 'Libre Todo el dia', 56),
(3276, '19', '11', 2018, 'Libre de 8:00 a 12:00', 77),
(3277, '19', '11', 2018, 'Libre Todo el dia', 55),
(3279, '20', '11', 2018, 'Libre Todo el dia', 76),
(3280, '20', '11', 2018, 'Libre Todo el dia', 56),
(3281, '20', '11', 2018, 'Libre Todo el dia', 85),
(3282, '21', '11', 2018, 'Libre Todo el dia', 85),
(3283, '22', '11', 2018, 'Libre Todo el dia', 85),
(3284, '23', '11', 2018, 'Libre Todo el dia', 85),
(3285, '21', '11', 2018, 'Libre Todo el dia', 35),
(3286, '22', '11', 2018, 'Libre Todo el dia', 35),
(3287, '23', '11', 2018, 'Libre Todo el dia', 35),
(3288, '24', '11', 2018, 'Libre Todo el dia', 35),
(3289, '25', '11', 2018, 'Libre Todo el dia', 35),
(3290, '26', '11', 2018, 'Libre Todo el dia', 35),
(3291, '27', '11', 2018, 'Libre Todo el dia', 35),
(3292, '28', '11', 2018, 'Libre Todo el dia', 35),
(3293, '29', '11', 2018, 'Libre Todo el dia', 35),
(3294, '30', '11', 2018, 'Libre Todo el dia', 35),
(3295, '22', '11', 2018, 'Libre Todo el dia', 55),
(3296, '22', '11', 2018, 'Libre Todo el dia', 74),
(3297, '22', '11', 2018, 'Libre de 8:00 a 12:00', 107),
(3298, '22', '11', 2018, 'Libre de 8:00 a 12:00', 82),
(3299, '22', '11', 2018, 'Libre Todo el dia', 108),
(3300, '22', '11', 2018, 'Libre Todo el dia', 109),
(3301, '26', '11', 2018, 'Libre Todo el dia', 108),
(3302, '27', '11', 2018, 'Libre Todo el dia', 108),
(3303, '28', '11', 2018, 'Libre Todo el dia', 108),
(3304, '29', '11', 2018, 'Libre Todo el dia', 108),
(3305, '23', '11', 2018, 'Libre Todo el dia', 55),
(3306, '23', '11', 2018, 'Libre Todo el dia', 74),
(3307, '23', '11', 2018, 'Libre Todo el dia', 79),
(3308, '24', '11', 2018, 'Libre Todo el dia', 79),
(3309, '25', '11', 2018, 'Libre Todo el dia', 79),
(3310, '26', '11', 2018, 'Libre Todo el dia', 79),
(3311, '27', '11', 2018, 'Libre Todo el dia', 79),
(3312, '28', '11', 2018, 'Libre Todo el dia', 79),
(3313, '29', '11', 2018, 'Libre Todo el dia', 79),
(3314, '23', '11', 2018, 'Libre Todo el dia', 92),
(3315, '23', '11', 2018, 'Libre Todo el dia', 109),
(3316, '26', '11', 2018, 'Libre Todo el dia', 109),
(3317, '27', '11', 2018, 'Libre Todo el dia', 109),
(3318, '28', '11', 2018, 'Libre Todo el dia', 109),
(3319, '29', '11', 2018, 'Libre Todo el dia', 109),
(3320, '30', '11', 2018, 'Libre Todo el dia', 109),
(3321, '26', '11', 2018, 'Libre Todo el dia', 98),
(3322, '27', '11', 2018, 'Libre Todo el dia', 98),
(3323, '26', '11', 2018, 'Libre Todo el dia', 55),
(3324, '26', '11', 2018, 'Libre Todo el dia', 76),
(3325, '26', '11', 2018, 'Libre Todo el dia', 86),
(3326, '26', '11', 2018, 'Libre Todo el dia', 85),
(3327, '27', '11', 2018, 'Libre Todo el dia', 85),
(3328, '28', '11', 2018, 'Libre Todo el dia', 85),
(3329, '29', '11', 2018, 'Libre Todo el dia', 85),
(3330, '30', '11', 2018, 'Libre Todo el dia', 85),
(3331, '27', '11', 2018, 'Libre de 8:00 a 12:00', 77),
(3332, '27', '11', 2018, 'Libre Todo el dia', 56),
(3333, '30', '11', 2018, 'Libre Todo el dia', 93),
(3334, '28', '11', 2018, 'Libre Todo el dia', 56),
(3335, '29', '11', 2018, 'Libre Todo el dia', 56),
(3336, '30', '11', 2018, 'Libre Todo el dia', 56),
(3337, '28', '11', 2018, 'Libre Todo el dia', 59),
(3338, '29', '11', 2018, 'Libre Todo el dia', 59),
(3339, '30', '11', 2018, 'Libre Todo el dia', 59),
(3340, '28', '11', 2018, 'Libre de 14:00 a 18:00', 68),
(3341, '30', '11', 2018, 'Libre Todo el dia', 108),
(3342, '30', '11', 2018, 'Libre Todo el dia', 47),
(3343, '30', '11', 2018, 'Libre Todo el dia', 106),
(3345, '03', '12', 2018, 'Libre Todo el dia', 56),
(3346, '04', '12', 2018, 'Libre Todo el dia', 56),
(3347, '05', '12', 2018, 'Libre Todo el dia', 56),
(3348, '06', '12', 2018, 'Libre Todo el dia', 56),
(3349, '07', '12', 2018, 'Libre Todo el dia', 56),
(3350, '03', '12', 2018, 'Libre Todo el dia', 85),
(3351, '04', '12', 2018, 'Libre Todo el dia', 85),
(3352, '05', '12', 2018, 'Libre Todo el dia', 85),
(3353, '06', '12', 2018, 'Libre Todo el dia', 85),
(3354, '07', '12', 2018, 'Libre Todo el dia', 85),
(3355, '03', '12', 2018, 'Libre Todo el dia', 55),
(3356, '04', '12', 2018, 'Libre Todo el dia', 55),
(3357, '05', '12', 2018, 'Libre Todo el dia', 55),
(3358, '06', '12', 2018, 'Libre Todo el dia', 55),
(3359, '07', '12', 2018, 'Libre Todo el dia', 55),
(3360, '04', '12', 2018, 'Libre Todo el dia', 79),
(3361, '04', '12', 2018, 'Libre Todo el dia', 74),
(3362, '04', '12', 2018, 'Libre Todo el dia', 92),
(3363, '04', '12', 2018, 'Libre Todo el dia', 47),
(3364, '05', '12', 2018, 'Libre Todo el dia', 70),
(3365, '05', '12', 2018, 'Libre Todo el dia', 109),
(3366, '07', '12', 2018, 'Libre Todo el dia', 98),
(3367, '07', '12', 2018, 'Libre Todo el dia', 81),
(3368, '10', '12', 2018, 'Libre Todo el dia', 55),
(3369, '11', '12', 2018, 'Libre Todo el dia', 55),
(3370, '12', '12', 2018, 'Libre Todo el dia', 55),
(3371, '13', '12', 2018, 'Libre Todo el dia', 55),
(3372, '14', '12', 2018, 'Libre Todo el dia', 55),
(3373, '15', '12', 2018, 'Libre Todo el dia', 55),
(3374, '11', '12', 2018, 'Libre Todo el dia', 109),
(3375, '11', '12', 2018, 'Libre Todo el dia', 85),
(3376, '11', '12', 2018, 'Libre de 8:00 a 12:00', 77),
(3377, '11', '12', 2018, 'Libre Todo el dia', 79),
(3378, '12', '12', 2018, 'Libre Todo el dia', 79),
(3379, '13', '12', 2018, 'Libre Todo el dia', 79),
(3380, '11', '12', 2018, 'Libre Todo el dia', 56),
(3381, '12', '12', 2018, 'Libre Todo el dia', 46),
(3382, '13', '12', 2018, 'Libre Todo el dia', 56),
(3383, '13', '12', 2018, 'Libre Todo el dia', 36),
(3384, '13', '12', 2018, 'Libre Todo el dia', 46),
(3385, '14', '12', 2018, 'Libre Todo el dia', 46),
(3386, '13', '12', 2018, 'Libre Todo el dia', 85),
(3387, '14', '12', 2018, 'Libre Todo el dia', 85),
(3388, '15', '12', 2018, 'Libre Todo el dia', 85),
(3389, '16', '12', 2018, 'Libre Todo el dia', 85),
(3390, '17', '12', 2018, 'Libre Todo el dia', 85),
(3391, '18', '12', 2018, 'Libre Todo el dia', 85),
(3392, '19', '12', 2018, 'Libre Todo el dia', 85),
(3393, '14', '12', 2018, 'Libre Todo el dia', 56),
(3394, '17', '12', 2018, 'Libre Todo el dia', 56),
(3395, '14', '12', 2018, 'Libre Todo el dia', 106),
(3396, '17', '12', 2018, 'Libre Todo el dia', 84),
(3397, '17', '12', 2018, 'Libre Todo el dia', 108),
(3398, '18', '12', 2018, 'Libre Todo el dia', 108),
(3399, '19', '12', 2018, 'Libre Todo el dia', 108),
(3400, '20', '12', 2018, 'Libre Todo el dia', 108),
(3401, '21', '12', 2018, 'Libre Todo el dia', 108),
(3402, '22', '12', 2018, 'Libre Todo el dia', 108),
(3403, '23', '12', 2018, 'Libre Todo el dia', 108),
(3404, '24', '12', 2018, 'Libre Todo el dia', 108),
(3405, '25', '12', 2018, 'Libre Todo el dia', 108),
(3406, '17', '12', 2018, 'Libre Todo el dia', 79),
(3407, '17', '12', 2018, 'Libre Todo el dia', 37),
(3408, '18', '12', 2018, 'Libre Todo el dia', 37),
(3409, '19', '12', 2018, 'Libre Todo el dia', 37),
(3410, '20', '12', 2018, 'Libre Todo el dia', 37),
(3411, '21', '12', 2018, 'Libre Todo el dia', 37),
(3412, '22', '12', 2018, 'Libre Todo el dia', 37),
(3413, '23', '12', 2018, 'Libre Todo el dia', 37),
(3414, '24', '12', 2018, 'Libre Todo el dia', 37),
(3415, '25', '12', 2018, 'Libre Todo el dia', 37),
(3416, '26', '12', 2018, 'Libre Todo el dia', 37),
(3417, '27', '12', 2018, 'Libre Todo el dia', 37),
(3418, '28', '12', 2018, 'Libre Todo el dia', 37),
(3419, '29', '12', 2018, 'Libre Todo el dia', 37),
(3420, '30', '12', 2018, 'Libre Todo el dia', 37),
(3421, '31', '12', 2018, 'Libre Todo el dia', 37),
(3422, '18', '12', 2018, 'Libre Todo el dia', 55),
(3423, '19', '12', 2018, 'Libre Todo el dia', 55),
(3424, '20', '12', 2018, 'Libre Todo el dia', 55),
(3425, '21', '12', 2018, 'Libre Todo el dia', 55),
(3426, '18', '12', 2018, 'Libre de 8:00 a 12:00', 77),
(3427, '18', '12', 2018, 'Libre Todo el dia', 87),
(3428, '18', '12', 2018, 'Libre Todo el dia', 79),
(3429, '19', '12', 2018, 'Libre Todo el dia', 56),
(3430, '19', '12', 2018, 'Libre Todo el dia', 84),
(3431, '19', '12', 2018, 'Libre Todo el dia', 79),
(3432, '20', '12', 2018, 'Libre Todo el dia', 79),
(3433, '21', '12', 2018, 'Libre Todo el dia', 79),
(3434, '19', '12', 2018, 'Libre de 8:00 a 12:00', 109),
(3435, '19', '12', 2018, 'Libre Todo el dia', 70),
(3436, '20', '12', 2018, 'Libre Todo el dia', 70),
(3437, '21', '12', 2018, 'Libre Todo el dia', 70),
(3438, '20', '12', 2018, 'Libre Todo el dia', 87),
(3442, '20', '12', 2018, 'Libre de 8:00 a 12:00', 107),
(3443, '26', '12', 2018, 'Libre Todo el dia', 107),
(3444, '27', '12', 2018, 'Libre Todo el dia', 107),
(3445, '26', '12', 2018, 'Libre Todo el dia', 46),
(3446, '27', '12', 2018, 'Libre Todo el dia', 46),
(3447, '28', '12', 2018, 'Libre Todo el dia', 46),
(3448, '29', '12', 2018, 'Libre Todo el dia', 46),
(3449, '30', '12', 2018, 'Libre Todo el dia', 46),
(3450, '31', '12', 2018, 'Libre Todo el dia', 46),
(3451, '26', '12', 2018, 'Libre Todo el dia', 77),
(3452, '27', '12', 2018, 'Libre Todo el dia', 77),
(3453, '28', '12', 2018, 'Libre Todo el dia', 77),
(3454, '29', '12', 2018, 'Libre Todo el dia', 77),
(3455, '30', '12', 2018, 'Libre Todo el dia', 77),
(3456, '31', '12', 2018, 'Libre Todo el dia', 77),
(3457, '27', '12', 2018, 'Libre Todo el dia', 106),
(3458, '26', '12', 2018, 'Libre Todo el dia', 47),
(3459, '27', '12', 2018, 'Libre Todo el dia', 47),
(3460, '28', '12', 2018, 'Libre Todo el dia', 47),
(3461, '29', '12', 2018, 'Libre Todo el dia', 47),
(3462, '30', '12', 2018, 'Libre Todo el dia', 47),
(3463, '31', '12', 2018, 'Libre Todo el dia', 47),
(3464, '26', '12', 2018, 'Libre Todo el dia', 56),
(3465, '27', '12', 2018, 'Libre Todo el dia', 56),
(3466, '28', '12', 2018, 'Libre Todo el dia', 56),
(3467, '26', '12', 2018, 'Libre Todo el dia', 70),
(3468, '27', '12', 2018, 'Libre de 14:00 a 18:00', 70),
(3470, '28', '12', 2018, 'Libre Todo el dia', 70),
(3472, '29', '12', 2018, 'Libre Todo el dia', 109),
(3473, '30', '12', 2018, 'Libre Todo el dia', 109),
(3474, '31', '12', 2018, 'Libre Todo el dia', 109),
(3475, '28', '12', 2018, 'Libre de 8:00 a 12:00', 109),
(3476, '28', '12', 2018, 'Libre Todo el dia', 45),
(3477, '29', '12', 2018, 'Libre Todo el dia', 45),
(3478, '30', '12', 2018, 'Libre Todo el dia', 45),
(3479, '31', '12', 2018, 'Libre Todo el dia', 45),
(3480, '02', '01', 2019, 'Libre Todo el dia', 109),
(3481, '03', '01', 2019, 'Libre Todo el dia', 109),
(3482, '04', '01', 2019, 'Libre Todo el dia', 109),
(3483, '05', '01', 2019, 'Libre Todo el dia', 109),
(3484, '06', '01', 2019, 'Libre Todo el dia', 109),
(3485, '07', '01', 2019, 'Libre Todo el dia', 109),
(3486, '08', '01', 2019, 'Libre Todo el dia', 109),
(3487, '09', '01', 2019, 'Libre Todo el dia', 109),
(3488, '10', '01', 2019, 'Libre Todo el dia', 109),
(3489, '11', '01', 2019, 'Libre Todo el dia', 109),
(3490, '12', '01', 2019, 'Libre Todo el dia', 109),
(3491, '13', '01', 2019, 'Libre Todo el dia', 109),
(3492, '14', '01', 2019, 'Libre Todo el dia', 109),
(3493, '15', '01', 2019, 'Libre Todo el dia', 109),
(3494, '16', '01', 2019, 'Libre Todo el dia', 109),
(3495, '17', '01', 2019, 'Libre Todo el dia', 109),
(3496, '02', '01', 2019, 'Libre Todo el dia', 77),
(3497, '03', '01', 2019, 'Libre Todo el dia', 77),
(3498, '04', '01', 2019, 'Libre Todo el dia', 77),
(3499, '05', '01', 2019, 'Libre Todo el dia', 77),
(3500, '06', '01', 2019, 'Libre Todo el dia', 77),
(3501, '07', '01', 2019, 'Libre Todo el dia', 77),
(3502, '08', '01', 2019, 'Libre Todo el dia', 77),
(3503, '09', '01', 2019, 'Libre Todo el dia', 77),
(3504, '10', '01', 2019, 'Libre Todo el dia', 77),
(3505, '11', '01', 2019, 'Libre Todo el dia', 77),
(3506, '12', '01', 2019, 'Libre Todo el dia', 77),
(3507, '13', '01', 2019, 'Libre Todo el dia', 77),
(3508, '14', '01', 2019, 'Libre Todo el dia', 77),
(3509, '15', '01', 2019, 'Libre Todo el dia', 77),
(3510, '16', '01', 2019, 'Libre Todo el dia', 77),
(3512, '02', '01', 2019, 'Libre Todo el dia', 46),
(3513, '03', '01', 2019, 'Libre Todo el dia', 46),
(3514, '04', '01', 2019, 'Libre Todo el dia', 46),
(3515, '02', '01', 2019, 'Libre Todo el dia', 79),
(3516, '03', '01', 2019, 'Libre Todo el dia', 79),
(3517, '04', '01', 2019, 'Libre Todo el dia', 79),
(3518, '05', '01', 2019, 'Libre Todo el dia', 79),
(3519, '06', '01', 2019, 'Libre Todo el dia', 79),
(3520, '07', '01', 2019, 'Libre Todo el dia', 79),
(3522, '02', '01', 2019, 'Libre Todo el dia', 60),
(3523, '03', '01', 2019, 'Libre Todo el dia', 60),
(3524, '04', '01', 2019, 'Libre Todo el dia', 60),
(3525, '03', '01', 2019, 'Libre Todo el dia', 106),
(3526, '04', '01', 2019, 'Libre Todo el dia', 106),
(3527, '05', '01', 2019, 'Libre Todo el dia', 106),
(3528, '06', '01', 2019, 'Libre Todo el dia', 106),
(3529, '07', '01', 2019, 'Libre Todo el dia', 106),
(3530, '08', '01', 2019, 'Libre Todo el dia', 106),
(3531, '09', '01', 2019, 'Libre Todo el dia', 106),
(3532, '10', '01', 2019, 'Libre Todo el dia', 106),
(3533, '11', '01', 2019, 'Libre Todo el dia', 106),
(3534, '02', '01', 2019, 'Libre Todo el dia', 56),
(3535, '03', '01', 2019, 'Libre Todo el dia', 56),
(3536, '04', '01', 2019, 'Libre Todo el dia', 56),
(3537, '05', '01', 2019, 'Libre Todo el dia', 56),
(3538, '06', '01', 2019, 'Libre Todo el dia', 56),
(3539, '07', '01', 2019, 'Libre Todo el dia', 56),
(3540, '08', '01', 2019, 'Libre Todo el dia', 56),
(3541, '09', '01', 2019, 'Libre Todo el dia', 56),
(3542, '10', '01', 2019, 'Libre Todo el dia', 56),
(3543, '02', '01', 2019, 'Libre Todo el dia', 89),
(3544, '03', '01', 2019, 'Libre Todo el dia', 89),
(3545, '02', '01', 2019, 'Libre Todo el dia', 45),
(3546, '03', '01', 2019, 'Libre Todo el dia', 45),
(3547, '04', '01', 2019, 'Libre Todo el dia', 45),
(3548, '05', '01', 2019, 'Libre Todo el dia', 45),
(3549, '02', '01', 2019, 'Libre Todo el dia', 65),
(3550, '04', '01', 2019, 'Libre Todo el dia', 65),
(3551, '05', '01', 2019, 'Libre Todo el dia', 65),
(3552, '06', '01', 2019, 'Libre Todo el dia', 65),
(3553, '07', '01', 2019, 'Libre Todo el dia', 65),
(3554, '08', '01', 2019, 'Libre Todo el dia', 65),
(3555, '09', '01', 2019, 'Libre Todo el dia', 65),
(3556, '10', '01', 2019, 'Libre Todo el dia', 65),
(3557, '11', '01', 2019, 'Libre Todo el dia', 65),
(3558, '12', '01', 2019, 'Libre Todo el dia', 65),
(3559, '13', '01', 2019, 'Libre Todo el dia', 65),
(3560, '14', '01', 2019, 'Libre Todo el dia', 65),
(3561, '15', '01', 2019, 'Libre Todo el dia', 65),
(3562, '04', '01', 2019, 'Libre Todo el dia', 35),
(3563, '05', '01', 2019, 'Libre Todo el dia', 35),
(3564, '06', '01', 2019, 'Libre Todo el dia', 35),
(3565, '07', '01', 2019, 'Libre Todo el dia', 35),
(3566, '08', '01', 2019, 'Libre Todo el dia', 35),
(3567, '09', '01', 2019, 'Libre Todo el dia', 35),
(3568, '10', '01', 2019, 'Libre Todo el dia', 35),
(3569, '11', '01', 2019, 'Libre Todo el dia', 35),
(3570, '12', '01', 2019, 'Libre Todo el dia', 35),
(3571, '13', '01', 2019, 'Libre Todo el dia', 35),
(3572, '14', '01', 2019, 'Libre Todo el dia', 35),
(3573, '15', '01', 2019, 'Libre Todo el dia', 35),
(3574, '16', '01', 2019, 'Libre Todo el dia', 35),
(3575, '17', '01', 2019, 'Libre Todo el dia', 35);
INSERT INTO `tb_calendario` (`id_calendario`, `dia`, `mes`, `anio`, `horario`, `id_espacio`) VALUES
(3576, '18', '01', 2019, 'Libre Todo el dia', 35),
(3577, '19', '01', 2019, 'Libre Todo el dia', 35),
(3578, '20', '01', 2019, 'Libre Todo el dia', 35),
(3579, '21', '01', 2019, 'Libre Todo el dia', 35),
(3580, '22', '01', 2019, 'Libre Todo el dia', 35),
(3581, '23', '01', 2019, 'Libre Todo el dia', 35),
(3582, '08', '01', 2019, 'Libre de 8:00 a 12:00', 45),
(3583, '09', '01', 2019, 'Libre de 8:00 a 12:00', 45),
(3584, '10', '01', 2019, 'Libre de 8:00 a 12:00', 45),
(3585, '11', '01', 2019, 'Libre de 8:00 a 12:00', 45),
(3586, '08', '01', 2019, 'Libre Todo el dia', 86),
(3587, '08', '01', 2019, 'Libre Todo el dia', 47),
(3588, '09', '01', 2019, 'Libre Todo el dia', 47),
(3589, '10', '01', 2019, 'Libre Todo el dia', 47),
(3590, '11', '01', 2019, 'Libre Todo el dia', 47),
(3591, '09', '01', 2019, 'Libre Todo el dia', 79),
(3592, '09', '01', 2019, 'Libre Todo el dia', 86),
(3593, '10', '01', 2019, 'Libre Todo el dia', 86),
(3594, '11', '01', 2019, 'Libre Todo el dia', 70),
(3595, '11', '01', 2019, 'Libre Todo el dia', 68),
(3596, '14', '01', 2019, 'Libre de 8:00 a 12:00', 45),
(3597, '15', '01', 2019, 'Libre de 8:00 a 12:00', 45),
(3598, '16', '01', 2019, 'Libre de 8:00 a 12:00', 45),
(3599, '17', '01', 2019, 'Libre de 8:00 a 12:00', 45),
(3601, '15', '01', 2019, 'Libre Todo el dia', 79),
(3602, '17', '01', 2019, 'Libre Todo el dia', 56),
(3603, '21', '01', 2019, 'Libre Todo el dia', 91),
(3604, '21', '01', 2019, 'Libre Todo el dia', 98),
(3605, '21', '01', 2019, 'Libre de 8:00 a 12:00', 45),
(3606, '21', '01', 2019, 'Libre de 14:00 a 18:00', 70),
(3607, '21', '01', 2019, 'Libre Todo el dia', 109),
(3608, '22', '01', 2019, 'Libre Todo el dia', 109),
(3609, '23', '01', 2019, 'Libre Todo el dia', 109),
(3610, '24', '01', 2019, 'Libre Todo el dia', 109),
(3611, '25', '01', 2019, 'Libre Todo el dia', 109),
(3612, '22', '01', 2019, 'Libre Todo el dia', 91),
(3613, '22', '01', 2019, 'Libre Todo el dia', 56),
(3614, '22', '01', 2019, 'Libre de 8:00 a 12:00', 77),
(3615, '22', '01', 2019, 'Libre de 8:00 a 12:00', 68),
(3616, '22', '01', 2019, 'Libre de 8:00 a 12:00', 45),
(3617, '06', '02', 2019, 'Libre Todo el dia', 81),
(3639, '17', '03', 2019, 'Libre Todo el dia', 81),
(3646, '19', '03', 2019, 'Libre de 8:00 a 12:00', 64),
(3647, '19', '03', 2019, 'Libre de 14:00 a 18:00', 60),
(3648, '19', '03', 2019, 'Libre de 8:00 a 12:00', 61),
(3649, '19', '03', 2019, 'Libre de 14:00 a 18:00', 81),
(3650, '25', '03', 2019, 'Libre Todo el dia', 35),
(3652, '25', '03', 2019, 'Libre de 8:00 a 12:00', 81),
(3653, '26', '03', 2019, 'Libre Todo el dia', 108),
(3654, '26', '03', 2019, 'Libre de 8:00 a 12:00', 60),
(3658, '07', '04', 2019, 'Libre de 8:00 a 12:00', 64),
(3659, '07', '04', 2019, 'Libre de 8:00 a 12:00', 35),
(3660, '07', '04', 2019, 'Libre Todo el dia', 108),
(3667, '19', '04', 2019, 'Libre Todo el dia', 81),
(3668, '20', '04', 2019, 'Libre Todo el dia', 81),
(3669, '18', '04', 2019, 'Libre Todo el dia', 81),
(3678, '24', '04', 2019, 'Libre Todo el dia', 81),
(3680, '18', '06', 2019, 'Libre Todo el dia', 81),
(3681, '19', '06', 2019, 'Libre Todo el dia', 81),
(3682, '19', '06', 2019, 'Libre de 8:00 a 12:00', 108),
(3683, '20', '06', 2019, 'Libre de 8:00 a 12:00', 108),
(3685, '21', '06', 2019, 'Libre de 14:00 a 18:00', 81),
(3688, '24', '06', 2019, 'Libre de 8:00 a 12:00', 81),
(3689, '24', '06', 2019, 'Libre de 14:00 a 18:00', 35),
(3690, '26', '06', 2019, 'Libre Todo el dia', 81),
(3691, '28', '06', 2019, 'Libre Todo el dia', 81),
(3693, '02', '07', 2019, 'Libre Todo el dia', 81),
(3694, '11', '07', 2019, 'Libre Todo el dia', 81),
(3695, '11', '07', 2019, 'Libre Todo el dia', 108),
(3696, '02', '08', 2019, 'Libre de 14:00 a 18:00', 81),
(3697, '04', '08', 2019, 'Libre Todo el dia', 81),
(3698, '04', '10', 2019, 'Libre Todo el dia', 81),
(3699, '10', '10', 2019, 'Libre Todo el dia', 81),
(3700, '11', '10', 2019, 'Libre Todo el dia', 103),
(3702, '10', '10', 2019, 'Libre Todo el dia', 74),
(3718, '12', '10', 2019, 'Libre Todo el dia', 81),
(3719, '13', '10', 2019, 'Libre Todo el dia', 81),
(3720, '14', '10', 2019, 'Libre Todo el dia', 81),
(3721, '15', '10', 2019, 'Libre Todo el dia', 81),
(3722, '16', '10', 2019, 'Libre Todo el dia', 81),
(3723, '17', '10', 2019, 'Libre Todo el dia', 81),
(3724, '18', '10', 2019, 'Libre Todo el dia', 81),
(3725, '19', '10', 2019, 'Libre Todo el dia', 81),
(3727, '21', '10', 2019, 'Libre de 8:00 a 12:00', 81),
(3728, '14', '10', 2019, 'Libre Todo el dia', 107),
(3729, '04', '12', 2019, 'Libre Todo el dia', 40),
(3730, '04', '12', 2019, 'Libre de 14:00 a 18:00', 81),
(3731, '04', '12', 2019, 'Libre Todo el dia', 53);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_edificio`
--

CREATE TABLE `tb_edificio` (
  `id_edificio` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `ciudad` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_edificio`
--

INSERT INTO `tb_edificio` (`id_edificio`, `nombre`, `direccion`, `ciudad`, `telefono`, `estado`) VALUES
(1, 'Transelca', 'Carrera 53 No 110 esquina, Piso 18', 'Barranquilla', '3855017', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_espacio`
--

CREATE TABLE `tb_espacio` (
  `id_espacio` int(11) NOT NULL,
  `numero` varchar(45) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_piso` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_espacio`
--

INSERT INTO `tb_espacio` (`id_espacio`, `numero`, `estado`, `id_piso`, `id_usuario`) VALUES
(34, '423', 1, 6, 71),
(35, '500A', 1, 7, 176),
(36, '515', 1, 7, 75),
(37, '501', 3, 7, NULL),
(38, '502', 1, 7, 69),
(39, '540A', 1, 7, 73),
(40, '517A', 1, 7, 68),
(41, '602B', 1, 8, 72),
(42, '523', 1, 7, 70),
(43, '407', 1, 6, 76),
(44, '419', 1, 6, 78),
(45, '415', 1, 6, 77),
(46, '413', 1, 6, 81),
(47, '518', 1, 7, 79),
(48, '528', 1, 7, 82),
(49, '519', 1, 7, 83),
(50, '539A', 1, 7, 80),
(51, '404', 1, 6, 84),
(52, '604A', 1, 8, 85),
(53, '408', 1, 6, 86),
(54, '405', 1, 6, 87),
(55, '410', 1, 6, 90),
(56, '538A', 1, 7, 89),
(57, '513', 1, 7, 88),
(58, '537B', 1, 7, 94),
(59, '521', 1, 7, 93),
(60, '401B', 1, 6, 91),
(61, '424', 1, 6, 92),
(62, '503', 1, 7, 96),
(63, '418', 1, 6, 97),
(64, '403', 1, 6, 145),
(65, '510', 1, 7, 99),
(66, '520', 1, 7, 100),
(67, '524', 1, 7, 98),
(68, '412', 1, 6, 102),
(69, '522', 1, 7, 103),
(70, '509', 1, 7, 104),
(71, '530', 1, 7, 101),
(72, '539B', 1, 7, 109),
(73, '437', 1, 6, 113),
(74, '526', 1, 7, 106),
(75, '536A', 1, 7, 110),
(76, '507', 1, 7, 114),
(77, '416', 1, 6, 112),
(78, '525', 1, 7, 115),
(79, '540B', 1, 7, 111),
(80, '527', 1, 7, 108),
(81, '422', 1, 6, 107),
(82, '439', 1, 6, 105),
(83, '529', 1, 7, 116),
(84, '504', 1, 7, 119),
(85, '421', 1, 6, 118),
(86, '514', 1, 7, 117),
(87, '411', 1, 6, 120),
(88, '532', 1, 7, 123),
(89, '440', 1, 6, 124),
(90, '406', 1, 7, 122),
(91, '601', 1, 8, 121),
(92, '603', 1, 8, 125),
(93, '409', 1, 6, 126),
(94, '536B', 1, 7, 129),
(95, '508', 1, 7, 128),
(96, '438', 1, 6, 131),
(97, '537A', 1, 7, 130),
(98, '402', 1, 6, 127),
(99, '511', 1, 7, 132),
(100, '517B', 1, 7, 133),
(101, '538B', 1, 7, 137),
(102, '604B', 1, 8, 136),
(103, '420', 1, 6, 134),
(104, '531', 1, 7, 139),
(105, '602A', 1, 8, 138),
(106, '516', 1, 7, 135),
(107, '506', 1, 7, 140),
(108, '414', 1, 6, 141),
(109, '505', 1, 7, 155);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_millas`
--

CREATE TABLE `tb_millas` (
  `id_millas` int(11) NOT NULL,
  `numero_millas` varchar(45) DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `motivo` varchar(45) DEFAULT NULL,
  `tb_usuario_id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tb_millas`
--

INSERT INTO `tb_millas` (`id_millas`, `numero_millas`, `fecha`, `motivo`, `tb_usuario_id_usuario`) VALUES
(66, '100', '2019-06-18 19:06:21', 'Liberacion', 107),
(67, '100', '2019-06-18 19:06:29', 'Liberacion', 107),
(68, '-100', '2019-06-18 19:11:01', 'Eliminacion de espacio', 107),
(69, '100', '2019-06-19 08:48:30', 'Liberacion', 107),
(70, '100', '2019-06-19 09:12:50', 'Liberacion', 141),
(71, '100', '2019-06-19 09:20:38', 'Liberacion', 141),
(72, '100', '2019-06-21 11:56:59', 'Liberacion', 107),
(73, '-100', '2019-06-21 12:12:57', 'Eliminacion de espacio', 107),
(74, '100', '2019-06-21 12:13:06', 'Liberacion', 107),
(75, '100', '2019-06-24 10:55:58', 'Liberacion', 107),
(76, '100', '2019-06-24 10:57:44', 'Liberacion', 67),
(77, '-100', '2019-06-24 11:01:34', 'Eliminacion de espacio', 67),
(78, '-100', '2019-06-24 11:01:58', 'Eliminacion de espacio', 107),
(79, '100', '2019-06-24 11:02:07', 'Liberacion', 107),
(80, '100', '2019-06-24 11:02:24', 'Liberacion', 67),
(81, '100', '2019-06-26 08:47:12', 'Liberacion', 107),
(82, '100', '2019-06-28 09:10:24', 'Liberacion', 107),
(83, '100', '2019-07-02 10:11:03', 'Liberacion', 107),
(84, '-100', '2019-07-02 10:11:37', 'Eliminacion de espacio', 107),
(85, '100', '2019-07-02 16:10:18', 'Liberacion', 107),
(86, '100', '2019-07-11 09:48:24', 'Liberacion', 107),
(87, '100', '2019-07-11 10:42:25', 'Liberacion', 141),
(88, '100', '2019-08-02 09:16:00', 'Liberacion', 107),
(89, '-100', '2019-10-10 21:34:32', 'Eliminacion de espacio', 106),
(90, '-100', '2019-10-12 15:44:22', 'Eliminacion de espacio', 107),
(91, '-100', '2019-10-12 15:45:25', 'Eliminacion de espacio', 107),
(92, '-100', '2019-10-12 15:45:37', 'Eliminacion de espacio', 107),
(93, '-100', '2019-10-12 15:46:26', 'Eliminacion de espacio', 107),
(94, '-100', '2019-10-12 15:50:29', 'Eliminacion de espacio', 107),
(95, '-100', '2019-10-12 15:51:55', 'Eliminacion de espacio', 107),
(96, '-100', '2019-10-12 15:53:13', 'Eliminacion de espacio', 107),
(97, '-100', '2019-10-12 15:53:56', 'Eliminacion de espacio', 107),
(98, '-100', '2019-10-12 16:01:54', 'Eliminacion de espacio', 107),
(99, '-100', '2019-10-12 16:08:58', 'Eliminacion de espacio', 107),
(100, '-100', '2019-10-12 16:10:08', 'Eliminacion de espacio', 107),
(101, '-100', '2019-10-12 16:11:00', 'Eliminacion de espacio', 107),
(102, '-100', '2019-10-12 16:11:44', 'Eliminacion de espacio', 107),
(103, '-100', '2019-10-12 16:12:24', 'Eliminacion de espacio', 107),
(104, '100', '2019-10-12 16:12:30', 'Liberacion', 107),
(105, '100', '2019-10-12 16:13:07', 'Liberacion', 107),
(106, '100', '2019-10-12 16:13:07', 'Liberacion', 107),
(107, '100', '2019-10-12 16:13:07', 'Liberacion', 107),
(108, '100', '2019-10-12 16:13:07', 'Liberacion', 107),
(109, '100', '2019-10-12 16:13:07', 'Liberacion', 107),
(110, '100', '2019-10-12 16:13:08', 'Liberacion', 107),
(111, '100', '2019-10-12 17:03:23', 'Liberacion', 107),
(112, '100', '2019-10-12 17:48:18', 'Liberacion', 107),
(113, '100', '2019-10-14 17:37:47', 'Liberacion', 107),
(114, '-100', '2019-10-14 17:38:46', 'Eliminacion de espacio', 107),
(115, '100', '2019-10-14 18:07:05', 'Liberacion', 140),
(116, '100', '2019-12-04 14:28:12', 'Liberacion', 68),
(117, '100', '2019-12-04 14:38:48', 'Liberacion', 107),
(118, '100', '2019-12-04 14:45:57', 'Liberacion', 86);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_millas_redimidas`
--

CREATE TABLE `tb_millas_redimidas` (
  `id_redimidas` int(11) NOT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('SOLICITADA','APROVADA','RECHAZADA','ELIMINADA') DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_productos_millas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tb_millas_redimidas`
--

INSERT INTO `tb_millas_redimidas` (`id_redimidas`, `fecha`, `estado`, `id_usuario`, `id_productos_millas`) VALUES
(1, '2019-02-15 16:52:29', 'SOLICITADA', 75, 1),
(2, '2019-02-17 14:45:45', 'SOLICITADA', 75, 1),
(3, '2019-02-17 14:46:51', 'SOLICITADA', 75, 1),
(4, '2019-02-17 14:50:12', 'SOLICITADA', 75, 1),
(5, '2019-02-17 14:50:28', 'SOLICITADA', 75, 1),
(6, '2019-02-17 14:51:52', 'SOLICITADA', 75, 1),
(7, '2019-02-17 14:52:25', 'SOLICITADA', 75, 1),
(8, '2019-02-17 14:53:01', 'SOLICITADA', 75, 1),
(9, '2019-02-17 14:54:32', 'SOLICITADA', 75, 1),
(10, '2019-02-17 14:55:52', 'SOLICITADA', 75, 1),
(11, '2019-02-17 14:57:46', 'SOLICITADA', 75, 1),
(12, '2019-02-17 14:58:22', 'SOLICITADA', 75, 1),
(13, '2019-02-17 15:00:58', 'SOLICITADA', 75, 1),
(14, '2019-02-17 15:01:21', 'SOLICITADA', 75, 1),
(15, '2019-02-17 15:01:49', 'SOLICITADA', 75, 1),
(16, '2019-02-17 15:02:16', 'SOLICITADA', 75, 1),
(17, '2019-02-17 15:02:49', 'SOLICITADA', 75, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_novedades`
--

CREATE TABLE `tb_novedades` (
  `id_novedad` int(11) NOT NULL,
  `titulo` varchar(45) DEFAULT NULL,
  `descripcion` varchar(245) DEFAULT NULL,
  `estado` enum('ENVIADA','EN REVISION','MAS INFO','RESUELTA') DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `opcional` varchar(45) DEFAULT NULL,
  `iduser` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_novedades`
--

INSERT INTO `tb_novedades` (`id_novedad`, `titulo`, `descripcion`, `estado`, `fecha_creacion`, `opcional`, `iduser`) VALUES
(1, 'sa', 'sad', 'ENVIADA', '2018-01-08 17:16:34', 'as', 1),
(13, 'Novedad error inicio', 'Descripcion de novedad error ', 'ENVIADA', '2018-01-09 02:23:12', 'op', 107),
(21, 'Error al liberar el equipo', 'No deja liberar', 'ENVIADA', '2018-01-18 19:38:55', 'op', 107);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_parametros`
--

CREATE TABLE `tb_parametros` (
  `id_parametros` int(11) NOT NULL,
  `hora_asignacion` varchar(45) DEFAULT NULL,
  `hora_reservas` varchar(45) DEFAULT NULL,
  `modo_liberacion` varchar(45) DEFAULT NULL,
  `millas` varchar(45) DEFAULT NULL,
  `registro` varchar(45) DEFAULT NULL,
  `registro_usuario` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tb_parametros`
--

INSERT INTO `tb_parametros` (`id_parametros`, `hora_asignacion`, `hora_reservas`, `modo_liberacion`, `millas`, `registro`, `registro_usuario`) VALUES
(1, '3', '8', 'NO', 'SI', 'NO', 'NO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_piso`
--

CREATE TABLE `tb_piso` (
  `id_piso` int(11) NOT NULL,
  `numero` varchar(45) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_bloque` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_piso`
--

INSERT INTO `tb_piso` (`id_piso`, `numero`, `estado`, `id_bloque`) VALUES
(6, '4', 1, 2),
(7, '5', 1, 2),
(8, '6', 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_productos_millas`
--

CREATE TABLE `tb_productos_millas` (
  `id_productos_millas` int(11) NOT NULL,
  `nombre` varchar(65) DEFAULT NULL,
  `descripcion` varchar(245) DEFAULT NULL,
  `estado` enum('ACTIVO','INACTIVO') DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_limite` datetime DEFAULT NULL,
  `costo_millas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tb_productos_millas`
--

INSERT INTO `tb_productos_millas` (`id_productos_millas`, `nombre`, `descripcion`, `estado`, `fecha_creacion`, `fecha_limite`, `costo_millas`) VALUES
(1, 'Dia libre', 'OPor 10 millas descanza', 'ACTIVO', '2019-02-15 16:52:15', '2019-02-22 00:00:00', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_reservas`
--

CREATE TABLE `tb_reservas` (
  `id_reserva` int(11) NOT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `jornada` varchar(45) DEFAULT NULL,
  `tb_usuario_id_usuario` int(11) NOT NULL,
  `estado` varchar(45) NOT NULL,
  `prioridad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tb_reservas`
--

INSERT INTO `tb_reservas` (`id_reserva`, `fecha_creacion`, `jornada`, `tb_usuario_id_usuario`, `estado`, `prioridad`) VALUES
(35, '2019-12-04 14:36:48', 'TARDE', 74, 'ELIMINADA', 3),
(36, '2019-12-04 14:36:50', 'MAÃ‘ANA', 67, 'ASIGNADO', 3),
(37, '2019-12-04 14:37:36', 'TODO EL DIA', 95, 'ELIMINADA', 3),
(38, '2019-12-04 14:39:43', 'TARDE', 95, 'ELIMINADA', 3),
(39, '2019-12-04 14:44:08', 'MAÃ‘ANA', 74, 'ASIGNADO', 3),
(40, '2019-12-04 14:47:41', 'TODO EL DIA', 95, 'ELIMINADA', 3),
(41, '2019-12-04 15:10:40', 'TODO EL DIA', 95, 'ELIMINADA', 3),
(42, '2019-12-04 15:13:30', 'TODO EL DIA', 95, 'ELIMINADA', 3),
(43, '2019-12-04 15:15:03', 'TODO EL DIA', 95, 'ELIMINADA', 3),
(44, '2019-12-04 15:31:43', 'TODO EL DIA', 95, 'ELIMINADA', 3),
(45, '2019-12-04 15:33:15', 'TODO EL DIA', 95, 'ASIGNADO', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_respuestas`
--

CREATE TABLE `tb_respuestas` (
  `id_respuesta` int(11) NOT NULL,
  `mensaje` varchar(245) DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('ELIMINADO','ACTIVA') DEFAULT NULL,
  `quien_envia` varchar(45) NOT NULL,
  `id_novedad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_respuestas`
--

INSERT INTO `tb_respuestas` (`id_respuesta`, `mensaje`, `fecha`, `estado`, `quien_envia`, `id_novedad`) VALUES
(1, 'dsfsd es que no sirve dkljhksjd cvksjdck sdhcdskj ckjsdhc sdhvksjd ckjsdh vkjsh vjksdhvkj shdvdsiuvkjsdhcklsd ckjs dhckjvlshdkjcvhskjdhcvkjlsdhvkjlsdvkjsvkjsdhvls', '2018-01-08 17:17:50', 'ACTIVA', 'nose', 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_temp_usuario`
--

CREATE TABLE `tb_temp_usuario` (
  `id_temp` int(11) NOT NULL,
  `fecha` varchar(75) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_espacio` int(11) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Disparadores `tb_temp_usuario`
--
DELIMITER $$
CREATE TRIGGER `vaciar` BEFORE DELETE ON `tb_temp_usuario` FOR EACH ROW INSERT INTO tb_temp_usuario_logs VALUES (old.id_temp, old.fecha, old.estado, old.id_usuario, old.id_espacio, old.date)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_temp_usuario_logs`
--

CREATE TABLE `tb_temp_usuario_logs` (
  `id_temp_log` int(11) NOT NULL,
  `fecha` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `estado` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_espacio` int(11) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tb_temp_usuario_logs`
--

INSERT INTO `tb_temp_usuario_logs` (`id_temp_log`, `fecha`, `estado`, `id_usuario`, `id_espacio`, `date`) VALUES
(47, '11/08/2017', '1', 149, 54, '2019-08-02 09:06:48'),
(53, '11/08/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(54, '11/08/2017', '1', 144, 53, '2019-08-02 09:06:48'),
(55, '14/08/2017', '1', 129, 54, '2019-08-02 09:06:48'),
(56, '14/08/2017', '1', 143, 53, '2019-08-02 09:06:48'),
(65, '15/08/2017', '1', 72, 43, '2019-08-02 09:06:48'),
(66, '15/08/2017', '1', 72, 89, '2019-08-02 09:06:48'),
(63, '15/08/2017', '1', 149, 102, '2019-08-02 09:06:48'),
(69, '15/08/2017', '1', 149, 89, '2019-08-02 09:06:48'),
(70, '15/08/2017', '1', 149, 102, '2019-08-02 09:06:48'),
(58, '15/08/2017', '1', 129, 45, '2019-08-02 09:06:48'),
(59, '15/08/2017', '1', 129, 73, '2019-08-02 09:06:48'),
(60, '15/08/2017', '1', 129, 54, '2019-08-02 09:06:48'),
(61, '15/08/2017', '1', 129, 53, '2019-08-02 09:06:48'),
(62, '15/08/2017', '1', 110, 85, '2019-08-02 09:06:48'),
(64, '15/08/2017', '1', 143, 93, '2019-08-02 09:06:48'),
(67, '15/08/2017', '1', 146, 43, '2019-08-02 09:06:48'),
(68, '15/08/2017', '1', 72, 90, '2019-08-02 09:06:48'),
(57, '15/08/2017', '1', 136, 82, '2019-08-02 09:06:48'),
(71, '16/08/2017', '1', 143, 36, '2019-08-02 09:06:48'),
(72, '16/08/2017', '1', 129, 80, '2019-08-02 09:06:48'),
(77, '16/08/2017', '1', 138, 54, '2019-08-02 09:06:48'),
(73, '16/08/2017', '1', 146, 93, '2019-08-02 09:06:48'),
(85, '17/08/2017', '1', 144, 80, '2019-08-02 09:06:48'),
(82, '17/08/2017', '1', 146, 36, '2019-08-02 09:06:48'),
(74, '16/08/2017', '1', 149, 85, '2019-08-02 09:06:48'),
(75, '16/08/2017', '1', 72, 82, '2019-08-02 09:06:48'),
(76, '16/08/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(78, '16/08/2017', '1', 129, 53, '2019-08-02 09:06:48'),
(79, '17/08/2017', '1', 136, 54, '2019-08-02 09:06:48'),
(80, '17/08/2017', '1', 129, 103, '2019-08-02 09:06:48'),
(81, '17/08/2017', '1', 72, 89, '2019-08-02 09:06:48'),
(83, '17/08/2017', '1', 143, 90, '2019-08-02 09:06:48'),
(84, '17/08/2017', '1', 149, 81, '2019-08-02 09:06:48'),
(86, '17/08/2017', '1', 129, 44, '2019-08-02 09:06:48'),
(90, '18/08/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(94, '18/08/2017', '1', 148, 57, '2019-08-02 09:06:48'),
(87, '18/08/2017', '1', 136, 84, '2019-08-02 09:06:48'),
(88, '18/08/2017', '1', 129, 54, '2019-08-02 09:06:48'),
(89, '18/08/2017', '1', 143, 90, '2019-08-02 09:06:48'),
(91, '18/08/2017', '1', 72, 89, '2019-08-02 09:06:48'),
(92, '18/08/2017', '1', 149, 85, '2019-08-02 09:06:48'),
(93, '18/08/2017', '1', 144, 107, '2019-08-02 09:06:48'),
(95, '22/08/2017', '1', 149, 81, '2019-08-02 09:06:48'),
(96, '22/08/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(97, '22/08/2017', '1', 143, 54, '2019-08-02 09:06:48'),
(98, '22/08/2017', '1', 148, 34, '2019-08-02 09:06:48'),
(99, '22/08/2017', '1', 144, 74, '2019-08-02 09:06:48'),
(100, '22/08/2017', '1', 142, 55, '2019-08-02 09:06:48'),
(106, '23/08/2017', '1', 144, 39, '2019-08-02 09:06:48'),
(108, '23/08/2017', '1', 144, 34, '2019-08-02 09:06:48'),
(107, '23/08/2017', '1', 72, 89, '2019-08-02 09:06:48'),
(101, '23/08/2017', '1', 136, 54, '2019-08-02 09:06:48'),
(103, '23/08/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(111, '24/08/2017', '1', 136, 54, '2019-08-02 09:06:48'),
(118, '24/08/2017', '1', 144, 107, '2019-08-02 09:06:48'),
(112, '24/08/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(104, '23/08/2017', '1', 143, 93, '2019-08-02 09:06:48'),
(116, '24/08/2017', '1', 143, 54, '2019-08-02 09:06:48'),
(102, '23/08/2017', '1', 149, 81, '2019-08-02 09:06:48'),
(105, '23/08/2017', '1', 148, 55, '2019-08-02 09:06:48'),
(109, '23/08/2017', '1', 138, 98, '2019-08-02 09:06:48'),
(110, '23/08/2017', '1', 142, 89, '2019-08-02 09:06:48'),
(113, '24/08/2017', '1', 142, 73, '2019-08-02 09:06:48'),
(114, '24/08/2017', '1', 138, 47, '2019-08-02 09:06:48'),
(115, '24/08/2017', '1', 149, 36, '2019-08-02 09:06:48'),
(117, '24/08/2017', '1', 148, 69, '2019-08-02 09:06:48'),
(121, '25/08/2017', '1', 148, 89, '2019-08-02 09:06:48'),
(119, '25/08/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(122, '25/08/2017', '1', 143, 93, '2019-08-02 09:06:48'),
(125, '26/08/2017', '1', 143, 80, '2019-08-02 09:06:48'),
(126, '26/08/2017', '1', 143, 80, '2019-08-02 09:06:48'),
(127, '26/08/2017', '1', 143, 80, '2019-08-02 09:06:48'),
(128, '26/08/2017', '1', 143, 80, '2019-08-02 09:06:48'),
(120, '25/08/2017', '1', 142, 54, '2019-08-02 09:06:48'),
(123, '25/08/2017', '1', 148, 73, '2019-08-02 09:06:48'),
(124, '25/08/2017', '1', 144, 81, '2019-08-02 09:06:48'),
(129, '28/08/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(130, '28/08/2017', '1', 142, 54, '2019-08-02 09:06:48'),
(131, '28/08/2017', '1', 149, 81, '2019-08-02 09:06:48'),
(132, '28/08/2017', '1', 143, 43, '2019-08-02 09:06:48'),
(133, '28/08/2017', '1', 144, 89, '2019-08-02 09:06:48'),
(138, '29/08/2017', '1', 138, 89, '2019-08-02 09:06:48'),
(136, '29/08/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(134, '29/08/2017', '1', 149, 81, '2019-08-02 09:06:48'),
(135, '29/08/2017', '1', 143, 43, '2019-08-02 09:06:48'),
(137, '29/08/2017', '1', 142, 108, '2019-08-02 09:06:48'),
(139, '29/08/2017', '1', 144, 89, '2019-08-02 09:06:48'),
(141, '30/08/2017', '1', 142, 108, '2019-08-02 09:06:48'),
(142, '30/08/2017', '1', 143, 43, '2019-08-02 09:06:48'),
(144, '30/08/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(140, '30/08/2017', '1', 136, 89, '2019-08-02 09:06:48'),
(143, '30/08/2017', '1', 149, 96, '2019-08-02 09:06:48'),
(145, '30/08/2017', '1', 142, 98, '2019-08-02 09:06:48'),
(146, '30/08/2017', '1', 144, 37, '2019-08-02 09:06:48'),
(149, '31/08/2017', '1', 143, 108, '2019-08-02 09:06:48'),
(150, '31/08/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(147, '31/08/2017', '1', 149, 43, '2019-08-02 09:06:48'),
(148, '31/08/2017', '1', 136, 89, '2019-08-02 09:06:48'),
(151, '31/08/2017', '1', 144, 37, '2019-08-02 09:06:48'),
(152, '31/08/2017', '1', 143, 85, '2019-08-02 09:06:48'),
(153, '31/08/2017', '1', 142, 98, '2019-08-02 09:06:48'),
(154, '31/08/2017', '1', 72, 108, '2019-08-02 09:06:48'),
(158, '01/09/2017', '1', 144, 36, '2019-08-02 09:06:48'),
(155, '01/09/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(156, '01/09/2017', '1', 143, 43, '2019-08-02 09:06:48'),
(157, '01/09/2017', '1', 149, 85, '2019-08-02 09:06:48'),
(1, '04/09/2017', '1', 143, 108, '2019-08-02 09:06:48'),
(7, '04/09/2017', '1', 145, 86, '2019-08-02 09:06:48'),
(3, '04/09/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(8, '04/09/2017', '1', 145, 97, '2019-08-02 09:06:48'),
(4, '04/09/2017', '1', 143, 108, '2019-08-02 09:06:48'),
(2, '04/09/2017', '1', 148, 43, '2019-08-02 09:06:48'),
(5, '04/09/2017', '1', 142, 82, '2019-08-02 09:06:48'),
(6, '04/09/2017', '1', 149, 36, '2019-08-02 09:06:48'),
(9, '05/09/2017', '1', 145, 80, '2019-08-02 09:06:48'),
(11, '05/09/2017', '1', 146, 43, '2019-08-02 09:06:48'),
(14, '05/09/2017', '1', 142, 53, '2019-08-02 09:06:48'),
(10, '05/09/2017', '1', 149, 108, '2019-08-02 09:06:48'),
(12, '05/09/2017', '1', 72, 85, '2019-08-02 09:06:48'),
(13, '05/09/2017', '1', 145, 80, '2019-08-02 09:06:48'),
(15, '05/09/2017', '1', 110, 81, '2019-08-02 09:06:48'),
(16, '05/09/2017', '1', 144, 47, '2019-08-02 09:06:48'),
(20, '06/09/2017', '1', 146, 108, '2019-08-02 09:06:48'),
(21, '06/09/2017', '1', 146, 108, '2019-08-02 09:06:48'),
(22, '06/09/2017', '1', 146, 47, '2019-08-02 09:06:48'),
(24, '06/09/2017', '1', 72, 108, '2019-08-02 09:06:48'),
(27, '06/09/2017', '1', 143, 36, '2019-08-02 09:06:48'),
(29, '06/09/2017', '1', 143, 93, '2019-08-02 09:06:48'),
(30, '06/09/2017', '1', 143, 93, '2019-08-02 09:06:48'),
(31, '06/09/2017', '1', 143, 36, '2019-08-02 09:06:48'),
(17, '06/09/2017', '1', 142, 43, '2019-08-02 09:06:48'),
(18, '06/09/2017', '1', 136, 53, '2019-08-02 09:06:48'),
(19, '06/09/2017', '1', 145, 81, '2019-08-02 09:06:48'),
(23, '06/09/2017', '1', 110, 47, '2019-08-02 09:06:48'),
(25, '06/09/2017', '1', 72, 108, '2019-08-02 09:06:48'),
(26, '06/09/2017', '1', 149, 85, '2019-08-02 09:06:48'),
(28, '06/09/2017', '1', 110, 49, '2019-08-02 09:06:48'),
(32, '07/09/2017', '1', 143, 46, '2019-08-02 09:06:48'),
(33, '07/09/2017', '1', 142, 53, '2019-08-02 09:06:48'),
(34, '07/09/2017', '1', 143, 108, '2019-08-02 09:06:48'),
(41, '08/09/2017', '1', 143, 53, '2019-08-02 09:06:48'),
(35, '07/09/2017', '1', 145, 46, '2019-08-02 09:06:48'),
(36, '07/09/2017', '1', 136, 85, '2019-08-02 09:06:48'),
(37, '07/09/2017', '1', 148, 103, '2019-08-02 09:06:48'),
(38, '07/09/2017', '1', 138, 43, '2019-08-02 09:06:48'),
(39, '07/09/2017', '1', 149, 55, '2019-08-02 09:06:48'),
(40, '07/09/2017', '1', 144, 93, '2019-08-02 09:06:48'),
(50, '08/09/2017', '1', 109, 47, '2019-08-02 09:06:48'),
(43, '08/09/2017', '1', 146, 106, '2019-08-02 09:06:48'),
(42, '08/09/2017', '1', 143, 53, '2019-08-02 09:06:48'),
(44, '08/09/2017', '1', 145, 108, '2019-08-02 09:06:48'),
(45, '08/09/2017', '1', 143, 77, '2019-08-02 09:06:48'),
(46, '08/09/2017', '1', 143, 44, '2019-08-02 09:06:48'),
(47, '08/09/2017', '1', 148, 68, '2019-08-02 09:06:48'),
(48, '08/09/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(49, '08/09/2017', '1', 149, 85, '2019-08-02 09:06:48'),
(51, '08/09/2017', '1', 138, 81, '2019-08-02 09:06:48'),
(52, '08/09/2017', '1', 144, 43, '2019-08-02 09:06:48'),
(53, '11/09/2017', '1', 146, 82, '2019-08-02 09:06:48'),
(56, '11/09/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(61, '12/09/2017', '1', 143, 82, '2019-08-02 09:06:48'),
(55, '11/09/2017', '1', 142, 55, '2019-08-02 09:06:48'),
(64, '12/09/2017', '1', 142, 82, '2019-08-02 09:06:48'),
(54, '11/09/2017', '1', 110, 53, '2019-08-02 09:06:48'),
(57, '11/09/2017', '1', 144, 85, '2019-08-02 09:06:48'),
(58, '11/09/2017', '1', 145, 86, '2019-08-02 09:06:48'),
(59, '11/09/2017', '1', 72, 43, '2019-08-02 09:06:48'),
(70, '12/09/2017', '1', 142, 102, '2019-08-02 09:06:48'),
(69, '12/09/2017', '1', 110, 53, '2019-08-02 09:06:48'),
(60, '12/09/2017', '1', 146, 46, '2019-08-02 09:06:48'),
(62, '12/09/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(63, '12/09/2017', '1', 136, 89, '2019-08-02 09:06:48'),
(65, '12/09/2017', '1', 149, 35, '2019-08-02 09:06:48'),
(66, '12/09/2017', '1', 148, 55, '2019-08-02 09:06:48'),
(67, '12/09/2017', '1', 72, 82, '2019-08-02 09:06:48'),
(68, '12/09/2017', '1', 109, 43, '2019-08-02 09:06:48'),
(71, '12/09/2017', '1', 110, 102, '2019-08-02 09:06:48'),
(72, '13/09/2017', '1', 143, 53, '2019-08-02 09:06:48'),
(73, '13/09/2017', '1', 136, 46, '2019-08-02 09:06:48'),
(74, '13/09/2017', '1', 149, 55, '2019-08-02 09:06:48'),
(75, '13/09/2017', '1', 72, 89, '2019-08-02 09:06:48'),
(76, '13/09/2017', '1', 142, 73, '2019-08-02 09:06:48'),
(77, '13/09/2017', '1', 110, 102, '2019-08-02 09:06:48'),
(80, '14/09/2017', '1', 136, 73, '2019-08-02 09:06:48'),
(82, '14/09/2017', '1', 149, 62, '2019-08-02 09:06:48'),
(81, '14/09/2017', '1', 148, 73, '2019-08-02 09:06:48'),
(78, '14/09/2017', '1', 146, 53, '2019-08-02 09:06:48'),
(79, '14/09/2017', '1', 152, 55, '2019-08-02 09:06:48'),
(83, '14/09/2017', '1', 143, 43, '2019-08-02 09:06:48'),
(84, '14/09/2017', '1', 94, 85, '2019-08-02 09:06:48'),
(86, '15/09/2017', '1', 143, 55, '2019-08-02 09:06:48'),
(87, '15/09/2017', '1', 152, 53, '2019-08-02 09:06:48'),
(91, '15/09/2017', '1', 152, 53, '2019-08-02 09:06:48'),
(85, '15/09/2017', '1', 146, 43, '2019-08-02 09:06:48'),
(88, '15/09/2017', '1', 136, 73, '2019-08-02 09:06:48'),
(89, '15/09/2017', '1', 72, 85, '2019-08-02 09:06:48'),
(90, '15/09/2017', '1', 143, 55, '2019-08-02 09:06:48'),
(92, '15/09/2017', '1', 144, 53, '2019-08-02 09:06:48'),
(93, '18/09/2017', '1', 152, 106, '2019-08-02 09:06:48'),
(99, '18/09/2017', '1', 148, 106, '2019-08-02 09:06:48'),
(94, '18/09/2017', '1', 142, 89, '2019-08-02 09:06:48'),
(95, '18/09/2017', '1', 129, 98, '2019-08-02 09:06:48'),
(96, '18/09/2017', '1', 138, 59, '2019-08-02 09:06:48'),
(97, '18/09/2017', '1', 143, 43, '2019-08-02 09:06:48'),
(98, '18/09/2017', '1', 145, 36, '2019-08-02 09:06:48'),
(100, '18/09/2017', '1', 144, 106, '2019-08-02 09:06:48'),
(101, '18/09/2017', '1', 152, 73, '2019-08-02 09:06:48'),
(107, '19/09/2017', '1', 152, 85, '2019-08-02 09:06:48'),
(103, '19/09/2017', '1', 142, 89, '2019-08-02 09:06:48'),
(102, '19/09/2017', '1', 146, 47, '2019-08-02 09:06:48'),
(104, '19/09/2017', '1', 129, 43, '2019-08-02 09:06:48'),
(105, '19/09/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(106, '19/09/2017', '1', 145, 106, '2019-08-02 09:06:48'),
(108, '19/09/2017', '1', 130, 59, '2019-08-02 09:06:48'),
(109, '19/09/2017', '1', 144, 85, '2019-08-02 09:06:48'),
(110, '19/09/2017', '1', 142, 89, '2019-08-02 09:06:48'),
(111, '20/09/2017', '1', 146, 47, '2019-08-02 09:06:48'),
(112, '20/09/2017', '1', 142, 89, '2019-08-02 09:06:48'),
(113, '20/09/2017', '1', 143, 59, '2019-08-02 09:06:48'),
(114, '20/09/2017', '1', 136, 106, '2019-08-02 09:06:48'),
(115, '20/09/2017', '1', 109, 86, '2019-08-02 09:06:48'),
(122, '21/09/2017', '1', 145, 85, '2019-08-02 09:06:48'),
(123, '21/09/2017', '1', 144, 85, '2019-08-02 09:06:48'),
(120, '21/09/2017', '1', 136, 106, '2019-08-02 09:06:48'),
(116, '21/09/2017', '1', 146, 47, '2019-08-02 09:06:48'),
(117, '21/09/2017', '1', 143, 60, '2019-08-02 09:06:48'),
(118, '21/09/2017', '1', 138, 36, '2019-08-02 09:06:48'),
(119, '21/09/2017', '1', 152, 89, '2019-08-02 09:06:48'),
(121, '21/09/2017', '1', 142, 53, '2019-08-02 09:06:48'),
(124, '21/09/2017', '1', 145, 86, '2019-08-02 09:06:48'),
(125, '22/09/2017', '1', 144, 106, '2019-08-02 09:06:48'),
(128, '22/09/2017', '1', 152, 36, '2019-08-02 09:06:48'),
(126, '22/09/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(127, '22/09/2017', '1', 138, 60, '2019-08-02 09:06:48'),
(129, '22/09/2017', '1', 146, 47, '2019-08-02 09:06:48'),
(130, '22/09/2017', '1', 142, 43, '2019-08-02 09:06:48'),
(131, '22/09/2017', '1', 144, 85, '2019-08-02 09:06:48'),
(133, '25/09/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(132, '25/09/2017', '1', 142, 43, '2019-08-02 09:06:48'),
(134, '25/09/2017', '1', 145, 86, '2019-08-02 09:06:48'),
(135, '25/09/2017', '1', 144, 81, '2019-08-02 09:06:48'),
(143, '26/09/2017', '1', 72, 81, '2019-08-02 09:06:48'),
(136, '26/09/2017', '1', 142, 73, '2019-08-02 09:06:48'),
(137, '26/09/2017', '1', 129, 44, '2019-08-02 09:06:48'),
(138, '26/09/2017', '1', 143, 85, '2019-08-02 09:06:48'),
(139, '26/09/2017', '1', 136, 103, '2019-08-02 09:06:48'),
(140, '26/09/2017', '1', 144, 106, '2019-08-02 09:06:48'),
(141, '26/09/2017', '1', 143, 47, '2019-08-02 09:06:48'),
(142, '26/09/2017', '1', 143, 95, '2019-08-02 09:06:48'),
(144, '27/09/2017', '1', 146, 81, '2019-08-02 09:06:48'),
(145, '27/09/2017', '1', 142, 73, '2019-08-02 09:06:48'),
(146, '27/09/2017', '1', 136, 106, '2019-08-02 09:06:48'),
(147, '27/09/2017', '1', 129, 103, '2019-08-02 09:06:48'),
(148, '27/09/2017', '1', 143, 85, '2019-08-02 09:06:48'),
(149, '27/09/2017', '1', 72, 44, '2019-08-02 09:06:48'),
(150, '27/09/2017', '1', 149, 95, '2019-08-02 09:06:48'),
(151, '27/09/2017', '1', 109, 47, '2019-08-02 09:06:48'),
(152, '28/09/2017', '1', 149, 73, '2019-08-02 09:06:48'),
(153, '28/09/2017', '1', 142, 57, '2019-08-02 09:06:48'),
(154, '28/09/2017', '1', 145, 86, '2019-08-02 09:06:48'),
(155, '28/09/2017', '1', 109, 36, '2019-08-02 09:06:48'),
(156, '29/09/2017', '1', 144, 73, '2019-08-02 09:06:48'),
(157, '29/09/2017', '1', 144, 73, '2019-08-02 09:06:48'),
(158, '29/09/2017', '1', 142, 36, '2019-08-02 09:06:48'),
(159, '02/10/2017', '1', 142, 90, '2019-08-02 09:06:48'),
(160, '02/10/2017', '1', 136, 85, '2019-08-02 09:06:48'),
(161, '02/10/2017', '1', 145, 59, '2019-08-02 09:06:48'),
(162, '02/10/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(163, '02/10/2017', '1', 138, 45, '2019-08-02 09:06:48'),
(170, '03/10/2017', '1', 110, 55, '2019-08-02 09:06:48'),
(169, '03/10/2017', '1', 138, 77, '2019-08-02 09:06:48'),
(164, '03/10/2017', '1', 144, 73, '2019-08-02 09:06:48'),
(165, '03/10/2017', '1', 146, 59, '2019-08-02 09:06:48'),
(166, '03/10/2017', '1', 142, 93, '2019-08-02 09:06:48'),
(167, '03/10/2017', '1', 143, 45, '2019-08-02 09:06:48'),
(168, '03/10/2017', '1', 145, 90, '2019-08-02 09:06:48'),
(171, '03/10/2017', '1', 110, 87, '2019-08-02 09:06:48'),
(172, '03/10/2017', '1', 149, 55, '2019-08-02 09:06:48'),
(173, '03/10/2017', '1', 138, 82, '2019-08-02 09:06:48'),
(174, '04/10/2017', '1', 146, 59, '2019-08-02 09:06:48'),
(175, '04/10/2017', '1', 144, 73, '2019-08-02 09:06:48'),
(176, '04/10/2017', '1', 142, 46, '2019-08-02 09:06:48'),
(177, '04/10/2017', '1', 143, 85, '2019-08-02 09:06:48'),
(178, '04/10/2017', '1', 145, 38, '2019-08-02 09:06:48'),
(179, '04/10/2017', '1', 110, 70, '2019-08-02 09:06:48'),
(182, '05/10/2017', '1', 136, 46, '2019-08-02 09:06:48'),
(180, '05/10/2017', '1', 146, 59, '2019-08-02 09:06:48'),
(181, '05/10/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(183, '05/10/2017', '1', 110, 85, '2019-08-02 09:06:48'),
(184, '05/10/2017', '1', 144, 43, '2019-08-02 09:06:48'),
(185, '05/10/2017', '1', 142, 46, '2019-08-02 09:06:48'),
(187, '06/10/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(186, '06/10/2017', '1', 146, 59, '2019-08-02 09:06:48'),
(188, '06/10/2017', '1', 142, 46, '2019-08-02 09:06:48'),
(189, '06/10/2017', '1', 136, 57, '2019-08-02 09:06:48'),
(190, '09/10/2017', '1', 146, 95, '2019-08-02 09:06:48'),
(192, '09/10/2017', '1', 152, 36, '2019-08-02 09:06:48'),
(194, '09/10/2017', '1', 143, 57, '2019-08-02 09:06:48'),
(191, '09/10/2017', '1', 149, 103, '2019-08-02 09:06:48'),
(193, '09/10/2017', '1', 129, 76, '2019-08-02 09:06:48'),
(198, '10/10/2017', '1', 145, 103, '2019-08-02 09:06:48'),
(196, '10/10/2017', '1', 146, 95, '2019-08-02 09:06:48'),
(195, '10/10/2017', '1', 143, 57, '2019-08-02 09:06:48'),
(197, '10/10/2017', '1', 136, 96, '2019-08-02 09:06:48'),
(200, '11/10/2017', '1', 145, 103, '2019-08-02 09:06:48'),
(199, '11/10/2017', '1', 146, 57, '2019-08-02 09:06:48'),
(201, '11/10/2017', '1', 148, 96, '2019-08-02 09:06:48'),
(202, '11/10/2017', '1', 129, 36, '2019-08-02 09:06:48'),
(203, '11/10/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(204, '12/10/2017', '1', 145, 103, '2019-08-02 09:06:48'),
(205, '12/10/2017', '1', 136, 57, '2019-08-02 09:06:48'),
(206, '12/10/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(207, '12/10/2017', '1', 152, 96, '2019-08-02 09:06:48'),
(208, '12/10/2017', '1', 129, 77, '2019-08-02 09:06:48'),
(213, '13/10/2017', '1', 129, 73, '2019-08-02 09:06:48'),
(214, '13/10/2017', '1', 146, 57, '2019-08-02 09:06:48'),
(215, '14/10/2017', '1', 145, 78, '2019-08-02 09:06:48'),
(209, '13/10/2017', '1', 143, 103, '2019-08-02 09:06:48'),
(210, '13/10/2017', '1', 136, 89, '2019-08-02 09:06:48'),
(211, '13/10/2017', '1', 152, 96, '2019-08-02 09:06:48'),
(212, '13/10/2017', '1', 144, 77, '2019-08-02 09:06:48'),
(216, '17/10/2017', '1', 146, 78, '2019-08-02 09:06:48'),
(217, '17/10/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(218, '17/10/2017', '1', 110, 93, '2019-08-02 09:06:48'),
(219, '17/10/2017', '1', 144, 85, '2019-08-02 09:06:48'),
(220, '18/10/2017', '1', 110, 78, '2019-08-02 09:06:48'),
(221, '18/10/2017', '1', 149, 93, '2019-08-02 09:06:48'),
(222, '18/10/2017', '1', 152, 73, '2019-08-02 09:06:48'),
(226, '19/10/2017', '1', 143, 78, '2019-08-02 09:06:48'),
(229, '19/10/2017', '1', 138, 85, '2019-08-02 09:06:48'),
(230, '19/10/2017', '1', 146, 85, '2019-08-02 09:06:48'),
(223, '19/10/2017', '1', 110, 70, '2019-08-02 09:06:48'),
(224, '19/10/2017', '1', 136, 73, '2019-08-02 09:06:48'),
(225, '19/10/2017', '1', 148, 93, '2019-08-02 09:06:48'),
(227, '19/10/2017', '1', 143, 78, '2019-08-02 09:06:48'),
(228, '19/10/2017', '1', 152, 55, '2019-08-02 09:06:48'),
(232, '20/10/2017', '1', 142, 93, '2019-08-02 09:06:48'),
(231, '20/10/2017', '1', 136, 85, '2019-08-02 09:06:48'),
(233, '20/10/2017', '1', 149, 73, '2019-08-02 09:06:48'),
(234, '20/10/2017', '1', 149, 78, '2019-08-02 09:06:48'),
(235, '20/10/2017', '1', 142, 93, '2019-08-02 09:06:48'),
(236, '23/10/2017', '1', 136, 93, '2019-08-02 09:06:48'),
(237, '23/10/2017', '1', 146, 73, '2019-08-02 09:06:48'),
(238, '23/10/2017', '1', 142, 46, '2019-08-02 09:06:48'),
(239, '23/10/2017', '1', 152, 93, '2019-08-02 09:06:48'),
(240, '23/10/2017', '1', 143, 85, '2019-08-02 09:06:48'),
(244, '24/10/2017', '1', 149, 77, '2019-08-02 09:06:48'),
(245, '24/10/2017', '1', 152, 77, '2019-08-02 09:06:48'),
(247, '24/10/2017', '1', 152, 77, '2019-08-02 09:06:48'),
(249, '24/10/2017', '1', 145, 86, '2019-08-02 09:06:48'),
(241, '24/10/2017', '1', 146, 78, '2019-08-02 09:06:48'),
(242, '24/10/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(243, '24/10/2017', '1', 142, 93, '2019-08-02 09:06:48'),
(246, '24/10/2017', '1', 149, 47, '2019-08-02 09:06:48'),
(248, '24/10/2017', '1', 152, 108, '2019-08-02 09:06:48'),
(250, '25/10/2017', '1', 146, 78, '2019-08-02 09:06:48'),
(251, '25/10/2017', '1', 149, 103, '2019-08-02 09:06:48'),
(252, '25/10/2017', '1', 148, 45, '2019-08-02 09:06:48'),
(253, '25/10/2017', '1', 142, 68, '2019-08-02 09:06:48'),
(254, '25/10/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(255, '25/10/2017', '1', 145, 86, '2019-08-02 09:06:48'),
(256, '25/10/2017', '1', 144, 38, '2019-08-02 09:06:48'),
(257, '26/10/2017', '1', 149, 93, '2019-08-02 09:06:48'),
(258, '26/10/2017', '1', 146, 78, '2019-08-02 09:06:48'),
(259, '26/10/2017', '1', 142, 89, '2019-08-02 09:06:48'),
(260, '26/10/2017', '1', 143, 49, '2019-08-02 09:06:48'),
(261, '26/10/2017', '1', 152, 83, '2019-08-02 09:06:48'),
(262, '26/10/2017', '1', 152, 42, '2019-08-02 09:06:48'),
(263, '26/10/2017', '1', 152, 67, '2019-08-02 09:06:48'),
(264, '26/10/2017', '1', 152, 47, '2019-08-02 09:06:48'),
(265, '26/10/2017', '1', 152, 85, '2019-08-02 09:06:48'),
(266, '26/10/2017', '1', 148, 80, '2019-08-02 09:06:48'),
(267, '26/10/2017', '1', 144, 68, '2019-08-02 09:06:48'),
(273, '27/10/2017', '1', 143, 55, '2019-08-02 09:06:48'),
(275, '27/10/2017', '1', 110, 55, '2019-08-02 09:06:48'),
(276, '27/10/2017', '1', 110, 55, '2019-08-02 09:06:48'),
(277, '27/10/2017', '1', 110, 55, '2019-08-02 09:06:48'),
(272, '27/10/2017', '1', 145, 78, '2019-08-02 09:06:48'),
(268, '27/10/2017', '1', 72, 68, '2019-08-02 09:06:48'),
(269, '27/10/2017', '1', 142, 46, '2019-08-02 09:06:48'),
(270, '27/10/2017', '1', 149, 93, '2019-08-02 09:06:48'),
(271, '27/10/2017', '1', 152, 73, '2019-08-02 09:06:48'),
(274, '27/10/2017', '1', 143, 49, '2019-08-02 09:06:48'),
(280, '30/10/2017', '1', 142, 108, '2019-08-02 09:06:48'),
(285, '30/10/2017', '1', 145, 57, '2019-08-02 09:06:48'),
(279, '30/10/2017', '1', 143, 68, '2019-08-02 09:06:48'),
(278, '30/10/2017', '1', 146, 93, '2019-08-02 09:06:48'),
(281, '30/10/2017', '1', 148, 108, '2019-08-02 09:06:48'),
(282, '30/10/2017', '1', 110, 107, '2019-08-02 09:06:48'),
(283, '30/10/2017', '1', 149, 85, '2019-08-02 09:06:48'),
(284, '30/10/2017', '1', 136, 36, '2019-08-02 09:06:48'),
(289, '31/10/2017', '1', 143, 68, '2019-08-02 09:06:48'),
(286, '31/10/2017', '1', 146, 70, '2019-08-02 09:06:48'),
(287, '31/10/2017', '1', 142, 108, '2019-08-02 09:06:48'),
(288, '31/10/2017', '1', 149, 93, '2019-08-02 09:06:48'),
(290, '31/10/2017', '1', 145, 107, '2019-08-02 09:06:48'),
(291, '31/10/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(292, '31/10/2017', '1', 110, 68, '2019-08-02 09:06:48'),
(293, '31/10/2017', '1', 109, 55, '2019-08-02 09:06:48'),
(294, '31/10/2017', '1', 144, 60, '2019-08-02 09:06:48'),
(299, '01/11/2017', '1', 152, 108, '2019-08-02 09:06:48'),
(295, '01/11/2017', '1', 146, 70, '2019-08-02 09:06:48'),
(296, '01/11/2017', '1', 142, 89, '2019-08-02 09:06:48'),
(297, '01/11/2017', '1', 149, 93, '2019-08-02 09:06:48'),
(298, '01/11/2017', '1', 136, 73, '2019-08-02 09:06:48'),
(300, '01/11/2017', '1', 148, 85, '2019-08-02 09:06:48'),
(301, '01/11/2017', '1', 110, 98, '2019-08-02 09:06:48'),
(302, '01/11/2017', '1', 145, 74, '2019-08-02 09:06:48'),
(303, '01/11/2017', '1', 144, 108, '2019-08-02 09:06:48'),
(311, '02/11/2017', '1', 145, 85, '2019-08-02 09:06:48'),
(308, '02/11/2017', '1', 149, 93, '2019-08-02 09:06:48'),
(304, '02/11/2017', '1', 146, 49, '2019-08-02 09:06:48'),
(305, '02/11/2017', '1', 142, 89, '2019-08-02 09:06:48'),
(306, '02/11/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(307, '02/11/2017', '1', 110, 70, '2019-08-02 09:06:48'),
(309, '02/11/2017', '1', 152, 108, '2019-08-02 09:06:48'),
(310, '02/11/2017', '1', 136, 81, '2019-08-02 09:06:48'),
(312, '02/11/2017', '1', 145, 67, '2019-08-02 09:06:48'),
(313, '02/11/2017', '1', 109, 92, '2019-08-02 09:06:48'),
(314, '02/11/2017', '1', 148, 85, '2019-08-02 09:06:48'),
(315, '02/11/2017', '1', 144, 47, '2019-08-02 09:06:48'),
(319, '03/11/2017', '1', 142, 108, '2019-08-02 09:06:48'),
(323, '03/11/2017', '1', 142, 108, '2019-08-02 09:06:48'),
(324, '03/11/2017', '1', 149, 108, '2019-08-02 09:06:48'),
(317, '03/11/2017', '1', 146, 47, '2019-08-02 09:06:48'),
(316, '03/11/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(318, '03/11/2017', '1', 145, 70, '2019-08-02 09:06:48'),
(320, '03/11/2017', '1', 110, 93, '2019-08-02 09:06:48'),
(321, '03/11/2017', '1', 136, 45, '2019-08-02 09:06:48'),
(322, '03/11/2017', '1', 152, 49, '2019-08-02 09:06:48'),
(325, '03/11/2017', '1', 142, 107, '2019-08-02 09:06:48'),
(3, '07/11/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(1, '07/11/2017', '1', 142, 93, '2019-08-02 09:06:48'),
(2, '07/11/2017', '1', 129, 74, '2019-08-02 09:06:48'),
(5, '08/11/2017', '1', 129, 47, '2019-08-02 09:06:48'),
(8, '08/11/2017', '1', 145, 90, '2019-08-02 09:06:48'),
(4, '07/11/2017', '1', 152, 93, '2019-08-02 09:06:48'),
(6, '08/11/2017', '1', 142, 73, '2019-08-02 09:06:48'),
(7, '08/11/2017', '1', 136, 77, '2019-08-02 09:06:48'),
(9, '08/11/2017', '1', 152, 46, '2019-08-02 09:06:48'),
(10, '08/11/2017', '1', 143, 85, '2019-08-02 09:06:48'),
(11, '08/11/2017', '1', 149, 62, '2019-08-02 09:06:48'),
(14, '09/11/2017', '1', 149, 93, '2019-08-02 09:06:48'),
(13, '09/11/2017', '1', 145, 90, '2019-08-02 09:06:48'),
(12, '09/11/2017', '1', 142, 73, '2019-08-02 09:06:48'),
(15, '09/11/2017', '1', 149, 93, '2019-08-02 09:06:48'),
(16, '09/11/2017', '1', 143, 77, '2019-08-02 09:06:48'),
(17, '09/11/2017', '1', 144, 46, '2019-08-02 09:06:48'),
(18, '10/11/2017', '1', 142, 46, '2019-08-02 09:06:48'),
(22, '10/11/2017', '1', 146, 93, '2019-08-02 09:06:48'),
(19, '10/11/2017', '1', 145, 90, '2019-08-02 09:06:48'),
(20, '10/11/2017', '1', 152, 108, '2019-08-02 09:06:48'),
(21, '10/11/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(23, '10/11/2017', '1', 142, 46, '2019-08-02 09:06:48'),
(24, '10/11/2017', '1', 144, 68, '2019-08-02 09:06:48'),
(25, '14/11/2017', '1', 146, 107, '2019-08-02 09:06:48'),
(26, '14/11/2017', '1', 149, 81, '2019-08-02 09:06:48'),
(27, '14/11/2017', '1', 154, 93, '2019-08-02 09:06:48'),
(28, '14/11/2017', '1', 142, 85, '2019-08-02 09:06:48'),
(29, '14/11/2017', '1', 145, 57, '2019-08-02 09:06:48'),
(30, '14/11/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(37, '15/11/2017', '1', 143, 46, '2019-08-02 09:06:48'),
(31, '15/11/2017', '1', 146, 107, '2019-08-02 09:06:48'),
(36, '15/11/2017', '1', 145, 57, '2019-08-02 09:06:48'),
(32, '15/11/2017', '1', 136, 73, '2019-08-02 09:06:48'),
(33, '15/11/2017', '1', 152, 93, '2019-08-02 09:06:48'),
(34, '15/11/2017', '1', 149, 81, '2019-08-02 09:06:48'),
(35, '15/11/2017', '1', 142, 98, '2019-08-02 09:06:48'),
(39, '16/11/2017', '1', 143, 55, '2019-08-02 09:06:48'),
(38, '16/11/2017', '1', 146, 107, '2019-08-02 09:06:48'),
(40, '16/11/2017', '1', 142, 93, '2019-08-02 09:06:48'),
(41, '16/11/2017', '1', 149, 81, '2019-08-02 09:06:48'),
(42, '16/11/2017', '1', 144, 73, '2019-08-02 09:06:48'),
(43, '16/11/2017', '1', 152, 108, '2019-08-02 09:06:48'),
(47, '17/11/2017', '1', 152, 73, '2019-08-02 09:06:48'),
(46, '17/11/2017', '1', 143, 92, '2019-08-02 09:06:48'),
(44, '17/11/2017', '1', 149, 60, '2019-08-02 09:06:48'),
(45, '17/11/2017', '1', 146, 107, '2019-08-02 09:06:48'),
(48, '17/11/2017', '1', 142, 93, '2019-08-02 09:06:48'),
(49, '17/11/2017', '1', 138, 108, '2019-08-02 09:06:48'),
(50, '17/11/2017', '1', 144, 81, '2019-08-02 09:06:48'),
(52, '20/11/2017', '1', 146, 98, '2019-08-02 09:06:48'),
(51, '20/11/2017', '1', 136, 93, '2019-08-02 09:06:48'),
(53, '20/11/2017', '1', 152, 57, '2019-08-02 09:06:48'),
(54, '20/11/2017', '1', 145, 36, '2019-08-02 09:06:48'),
(59, '21/11/2017', '1', 152, 44, '2019-08-02 09:06:48'),
(55, '21/11/2017', '1', 129, 93, '2019-08-02 09:06:48'),
(56, '21/11/2017', '1', 146, 77, '2019-08-02 09:06:48'),
(57, '21/11/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(58, '21/11/2017', '1', 146, 89, '2019-08-02 09:06:48'),
(60, '21/11/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(61, '21/11/2017', '1', 146, 98, '2019-08-02 09:06:48'),
(63, '22/11/2017', '1', 146, 80, '2019-08-02 09:06:48'),
(62, '22/11/2017', '1', 149, 93, '2019-08-02 09:06:48'),
(64, '22/11/2017', '1', 143, 77, '2019-08-02 09:06:48'),
(65, '22/11/2017', '1', 129, 107, '2019-08-02 09:06:48'),
(67, '23/11/2017', '1', 149, 93, '2019-08-02 09:06:48'),
(69, '23/11/2017', '1', 152, 93, '2019-08-02 09:06:48'),
(66, '23/11/2017', '1', 146, 89, '2019-08-02 09:06:48'),
(68, '23/11/2017', '1', 143, 77, '2019-08-02 09:06:48'),
(70, '23/11/2017', '1', 144, 80, '2019-08-02 09:06:48'),
(73, '24/11/2017', '1', 72, 46, '2019-08-02 09:06:48'),
(74, '24/11/2017', '1', 152, 46, '2019-08-02 09:06:48'),
(71, '24/11/2017', '1', 146, 93, '2019-08-02 09:06:48'),
(72, '24/11/2017', '1', 144, 89, '2019-08-02 09:06:48'),
(75, '24/11/2017', '1', 143, 98, '2019-08-02 09:06:48'),
(76, '24/11/2017', '1', 149, 46, '2019-08-02 09:06:48'),
(77, '27/11/2017', '1', 143, 93, '2019-08-02 09:06:48'),
(78, '27/11/2017', '1', 142, 89, '2019-08-02 09:06:48'),
(79, '27/11/2017', '1', 152, 74, '2019-08-02 09:06:48'),
(80, '27/11/2017', '1', 149, 73, '2019-08-02 09:06:48'),
(81, '27/11/2017', '1', 129, 55, '2019-08-02 09:06:48'),
(82, '27/11/2017', '1', 145, 36, '2019-08-02 09:06:48'),
(83, '27/11/2017', '1', 144, 47, '2019-08-02 09:06:48'),
(84, '27/11/2017', '1', 138, 86, '2019-08-02 09:06:48'),
(88, '28/11/2017', '1', 149, 47, '2019-08-02 09:06:48'),
(91, '28/11/2017', '1', 138, 86, '2019-08-02 09:06:48'),
(85, '28/11/2017', '1', 142, 93, '2019-08-02 09:06:48'),
(86, '28/11/2017', '1', 146, 106, '2019-08-02 09:06:48'),
(87, '28/11/2017', '1', 143, 85, '2019-08-02 09:06:48'),
(89, '28/11/2017', '1', 149, 47, '2019-08-02 09:06:48'),
(90, '28/11/2017', '1', 145, 36, '2019-08-02 09:06:48'),
(92, '28/11/2017', '1', 152, 44, '2019-08-02 09:06:48'),
(94, '29/11/2017', '1', 142, 68, '2019-08-02 09:06:48'),
(93, '29/11/2017', '1', 143, 44, '2019-08-02 09:06:48'),
(95, '29/11/2017', '1', 152, 98, '2019-08-02 09:06:48'),
(96, '29/11/2017', '1', 145, 36, '2019-08-02 09:06:48'),
(97, '29/11/2017', '1', 149, 86, '2019-08-02 09:06:48'),
(98, '29/11/2017', '1', 142, 92, '2019-08-02 09:06:48'),
(99, '29/11/2017', '1', 146, 67, '2019-08-02 09:06:48'),
(100, '29/11/2017', '1', 110, 70, '2019-08-02 09:06:48'),
(101, '29/11/2017', '1', 143, 43, '2019-08-02 09:06:48'),
(102, '29/11/2017', '1', 144, 57, '2019-08-02 09:06:48'),
(103, '30/11/2017', '1', 110, 43, '2019-08-02 09:06:48'),
(104, '30/11/2017', '1', 146, 67, '2019-08-02 09:06:48'),
(105, '30/11/2017', '1', 142, 57, '2019-08-02 09:06:48'),
(106, '30/11/2017', '1', 152, 68, '2019-08-02 09:06:48'),
(107, '30/11/2017', '1', 145, 36, '2019-08-02 09:06:48'),
(108, '30/11/2017', '1', 149, 86, '2019-08-02 09:06:48'),
(109, '30/11/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(113, '01/12/2017', '1', 142, 92, '2019-08-02 09:06:48'),
(110, '01/12/2017', '1', 149, 68, '2019-08-02 09:06:48'),
(111, '01/12/2017', '1', 110, 67, '2019-08-02 09:06:48'),
(112, '01/12/2017', '1', 146, 57, '2019-08-02 09:06:48'),
(114, '01/12/2017', '1', 143, 86, '2019-08-02 09:06:48'),
(115, '01/12/2017', '1', 145, 36, '2019-08-02 09:06:48'),
(116, '01/12/2017', '1', 142, 73, '2019-08-02 09:06:48'),
(119, '04/12/2017', '1', 142, 87, '2019-08-02 09:06:48'),
(123, '04/12/2017', '1', 152, 87, '2019-08-02 09:06:48'),
(124, '04/12/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(118, '04/12/2017', '1', 146, 67, '2019-08-02 09:06:48'),
(117, '04/12/2017', '1', 149, 55, '2019-08-02 09:06:48'),
(120, '04/12/2017', '1', 142, 90, '2019-08-02 09:06:48'),
(121, '04/12/2017', '1', 145, 59, '2019-08-02 09:06:48'),
(122, '04/12/2017', '1', 136, 108, '2019-08-02 09:06:48'),
(125, '04/12/2017', '1', 110, 56, '2019-08-02 09:06:48'),
(126, '05/12/2017', '1', 143, 95, '2019-08-02 09:06:48'),
(127, '05/12/2017', '1', 146, 67, '2019-08-02 09:06:48'),
(128, '05/12/2017', '1', 136, 56, '2019-08-02 09:06:48'),
(129, '05/12/2017', '1', 142, 108, '2019-08-02 09:06:48'),
(130, '05/12/2017', '1', 149, 93, '2019-08-02 09:06:48'),
(133, '06/12/2017', '1', 136, 89, '2019-08-02 09:06:48'),
(135, '06/12/2017', '1', 144, 73, '2019-08-02 09:06:48'),
(132, '06/12/2017', '1', 143, 108, '2019-08-02 09:06:48'),
(138, '06/12/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(131, '06/12/2017', '1', 152, 93, '2019-08-02 09:06:48'),
(134, '06/12/2017', '1', 142, 55, '2019-08-02 09:06:48'),
(136, '06/12/2017', '1', 136, 98, '2019-08-02 09:06:48'),
(137, '06/12/2017', '1', 144, 59, '2019-08-02 09:06:48'),
(139, '07/12/2017', '1', 142, 93, '2019-08-02 09:06:48'),
(140, '07/12/2017', '1', 143, 81, '2019-08-02 09:06:48'),
(141, '07/12/2017', '1', 146, 107, '2019-08-02 09:06:48'),
(142, '11/12/2017', '1', 152, 93, '2019-08-02 09:06:48'),
(143, '11/12/2017', '1', 142, 84, '2019-08-02 09:06:48'),
(144, '11/12/2017', '1', 145, 36, '2019-08-02 09:06:48'),
(145, 'Prueba', '1', 67, 35, '2019-08-02 09:06:48'),
(147, '12/12/2017', '1', 142, 98, '2019-08-02 09:06:48'),
(146, '12/12/2017', '1', 146, 93, '2019-08-02 09:06:48'),
(148, '12/12/2017', '1', 152, 53, '2019-08-02 09:06:48'),
(149, '12/12/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(150, '13/12/2017', '1', 146, 93, '2019-08-02 09:06:48'),
(151, '13/12/2017', '1', 110, 74, '2019-08-02 09:06:48'),
(152, '13/12/2017', '1', 149, 73, '2019-08-02 09:06:48'),
(153, '13/12/2017', '1', 145, 36, '2019-08-02 09:06:48'),
(154, '13/12/2017', '1', 143, 70, '2019-08-02 09:06:48'),
(155, '13/12/2017', '1', 144, 82, '2019-08-02 09:06:48'),
(156, '13/12/2017', '1', 142, 53, '2019-08-02 09:06:48'),
(157, '14/12/2017', '1', 152, 93, '2019-08-02 09:06:48'),
(158, '14/12/2017', '1', 142, 53, '2019-08-02 09:06:48'),
(159, '14/12/2017', '1', 146, 98, '2019-08-02 09:06:48'),
(160, '14/12/2017', '1', 145, 36, '2019-08-02 09:06:48'),
(161, '14/12/2017', '1', 110, 70, '2019-08-02 09:06:48'),
(162, '14/12/2017', '1', 143, 38, '2019-08-02 09:06:48'),
(165, '15/12/2017', '1', 152, 53, '2019-08-02 09:06:48'),
(169, '15/12/2017', '1', 149, 57, '2019-08-02 09:06:48'),
(171, '15/12/2017', '1', 149, 53, '2019-08-02 09:06:48'),
(163, '15/12/2017', '1', 146, 38, '2019-08-02 09:06:48'),
(164, '15/12/2017', '1', 142, 93, '2019-08-02 09:06:48'),
(166, '15/12/2017', '1', 136, 77, '2019-08-02 09:06:48'),
(167, '15/12/2017', '1', 110, 98, '2019-08-02 09:06:48'),
(168, '15/12/2017', '1', 143, 70, '2019-08-02 09:06:48'),
(170, '15/12/2017', '1', 145, 36, '2019-08-02 09:06:48'),
(172, '15/12/2017', '1', 144, 55, '2019-08-02 09:06:48'),
(173, '18/12/2017', '1', 152, 93, '2019-08-02 09:06:48'),
(174, '18/12/2017', '1', 142, 38, '2019-08-02 09:06:48'),
(175, '18/12/2017', '1', 146, 107, '2019-08-02 09:06:48'),
(176, '18/12/2017', '1', 143, 73, '2019-08-02 09:06:48'),
(177, '18/12/2017', '1', 144, 53, '2019-08-02 09:06:48'),
(178, '18/12/2017', '1', 152, 93, '2019-08-02 09:06:48'),
(181, '19/12/2017', '1', 143, 93, '2019-08-02 09:06:48'),
(179, '18/12/2017', '1', 146, 107, '2019-08-02 09:06:48'),
(180, '19/12/2017', '1', 146, 38, '2019-08-02 09:06:48'),
(182, '19/12/2017', '1', 142, 53, '2019-08-02 09:06:48'),
(183, '19/12/2017', '1', 143, 93, '2019-08-02 09:06:48'),
(184, '19/12/2017', '1', 152, 77, '2019-08-02 09:06:48'),
(185, '19/12/2017', '1', 149, 62, '2019-08-02 09:06:48'),
(186, '19/12/2017', '1', 144, 74, '2019-08-02 09:06:48'),
(187, '20/12/2017', '1', 152, 107, '2019-08-02 09:06:48'),
(188, '20/12/2017', '1', 142, 53, '2019-08-02 09:06:48'),
(189, '20/12/2017', '1', 146, 36, '2019-08-02 09:06:48'),
(190, '20/12/2017', '1', 143, 38, '2019-08-02 09:06:48'),
(192, '21/12/2017', '1', 143, 85, '2019-08-02 09:06:48'),
(191, '21/12/2017', '1', 146, 36, '2019-08-02 09:06:48'),
(193, '21/12/2017', '1', 142, 38, '2019-08-02 09:06:48'),
(194, '21/12/2017', '1', 143, 85, '2019-08-02 09:06:48'),
(195, '21/12/2017', '1', 152, 98, '2019-08-02 09:06:48'),
(200, '26/12/2017', '1', 142, 77, '2019-08-02 09:06:48'),
(199, '26/12/2017', '1', 143, 85, '2019-08-02 09:06:48'),
(204, '26/12/2017', '1', 147, 85, '2019-08-02 09:06:48'),
(196, '26/12/2017', '1', 146, 107, '2019-08-02 09:06:48'),
(197, '26/12/2017', '1', 152, 103, '2019-08-02 09:06:48'),
(198, '26/12/2017', '1', 144, 38, '2019-08-02 09:06:48'),
(201, '26/12/2017', '1', 142, 81, '2019-08-02 09:06:48'),
(202, '26/12/2017', '1', 143, 77, '2019-08-02 09:06:48'),
(203, '26/12/2017', '1', 94, 98, '2019-08-02 09:06:48'),
(205, '26/12/2017', '1', 146, 38, '2019-08-02 09:06:48'),
(209, '27/12/2017', '1', 146, 107, '2019-08-02 09:06:48'),
(210, '27/12/2017', '1', 144, 36, '2019-08-02 09:06:48'),
(206, '27/12/2017', '1', 152, 103, '2019-08-02 09:06:48'),
(207, '27/12/2017', '1', 142, 81, '2019-08-02 09:06:48'),
(208, '27/12/2017', '1', 138, 85, '2019-08-02 09:06:48'),
(211, '27/12/2017', '1', 143, 77, '2019-08-02 09:06:48'),
(212, '27/12/2017', '1', 144, 107, '2019-08-02 09:06:48'),
(213, '27/12/2017', '1', 149, 98, '2019-08-02 09:06:48'),
(214, '28/12/2017', '1', 147, 92, '2019-08-02 09:06:48'),
(215, '28/12/2017', '1', 142, 81, '2019-08-02 09:06:48'),
(216, '28/12/2017', '1', 146, 107, '2019-08-02 09:06:48'),
(217, '28/12/2017', '1', 152, 103, '2019-08-02 09:06:48'),
(218, '28/12/2017', '1', 143, 77, '2019-08-02 09:06:48'),
(219, '28/12/2017', '1', 138, 85, '2019-08-02 09:06:48'),
(220, '28/12/2017', '1', 149, 44, '2019-08-02 09:06:48'),
(221, '28/12/2017', '1', 144, 36, '2019-08-02 09:06:48'),
(222, '29/12/2017', '1', 147, 107, '2019-08-02 09:06:48'),
(228, '29/12/2017', '1', 143, 77, '2019-08-02 09:06:48'),
(227, '29/12/2017', '1', 147, 92, '2019-08-02 09:06:48'),
(223, '29/12/2017', '1', 152, 103, '2019-08-02 09:06:48'),
(224, '29/12/2017', '1', 142, 81, '2019-08-02 09:06:48'),
(225, '29/12/2017', '1', 146, 36, '2019-08-02 09:06:48'),
(226, '29/12/2017', '1', 138, 85, '2019-08-02 09:06:48'),
(229, '29/12/2017', '1', 149, 44, '2019-08-02 09:06:48'),
(230, '02/01/2018', '1', 147, 77, '2019-08-02 09:06:48'),
(232, '03/01/2018', '1', 143, 96, '2019-08-02 09:06:48'),
(234, '03/01/2018', '1', 147, 81, '2019-08-02 09:06:48'),
(231, '03/01/2018', '1', 146, 77, '2019-08-02 09:06:48'),
(233, '03/01/2018', '1', 144, 96, '2019-08-02 09:06:48'),
(235, '04/01/2018', '1', 136, 96, '2019-08-02 09:06:48'),
(236, '04/01/2018', '1', 142, 87, '2019-08-02 09:06:48'),
(237, '04/01/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(238, '05/01/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(239, '05/01/2018', '1', 136, 96, '2019-08-02 09:06:48'),
(240, '08/01/2018', '1', 110, 107, '2019-08-02 09:06:48'),
(241, '09/01/2018', '1', 152, 86, '2019-08-02 09:06:48'),
(242, '09/01/2018', '1', 142, 107, '2019-08-02 09:06:48'),
(243, '09/01/2018', '1', 136, 96, '2019-08-02 09:06:48'),
(244, '09/01/2018', '1', 146, 60, '2019-08-02 09:06:48'),
(245, '09/01/2018', '1', 147, 52, '2019-08-02 09:06:48'),
(246, '09/01/2018', '1', 144, 98, '2019-08-02 09:06:48'),
(247, '10/01/2018', '1', 152, 60, '2019-08-02 09:06:48'),
(248, '10/01/2018', '1', 146, 107, '2019-08-02 09:06:48'),
(249, '10/01/2018', '1', 142, 96, '2019-08-02 09:06:48'),
(251, '11/01/2018', '1', 146, 107, '2019-08-02 09:06:48'),
(250, '11/01/2018', '1', 142, 60, '2019-08-02 09:06:48'),
(252, '11/01/2018', '1', 152, 107, '2019-08-02 09:06:48'),
(253, '11/01/2018', '1', 136, 96, '2019-08-02 09:06:48'),
(254, '11/01/2018', '1', 110, 55, '2019-08-02 09:06:48'),
(255, '11/01/2018', '1', 144, 51, '2019-08-02 09:06:48'),
(256, '12/01/2018', '1', 152, 60, '2019-08-02 09:06:48'),
(257, '12/01/2018', '1', 142, 107, '2019-08-02 09:06:48'),
(258, '12/01/2018', '1', 136, 96, '2019-08-02 09:06:48'),
(259, '14/01/2018', '1', 136, 107, '2019-08-02 09:06:48'),
(260, '15/01/2018', '1', 146, 47, '2019-08-02 09:06:48'),
(261, '15/01/2018', '1', 143, 60, '2019-08-02 09:06:48'),
(262, '15/01/2018', '1', 145, 36, '2019-08-02 09:06:48'),
(263, '15/01/2018', '1', 136, 96, '2019-08-02 09:06:48'),
(265, '16/01/2018', '1', 152, 60, '2019-08-02 09:06:48'),
(264, '16/01/2018', '1', 146, 47, '2019-08-02 09:06:48'),
(266, '16/01/2018', '1', 142, 107, '2019-08-02 09:06:48'),
(267, '16/01/2018', '1', 143, 73, '2019-08-02 09:06:48'),
(268, '16/01/2018', '1', 144, 60, '2019-08-02 09:06:48'),
(270, '17/01/2018', '1', 144, 107, '2019-08-02 09:06:48'),
(269, '17/01/2018', '1', 152, 60, '2019-08-02 09:06:48'),
(271, '17/01/2018', '1', 142, 47, '2019-08-02 09:06:48'),
(272, '17/01/2018', '1', 144, 107, '2019-08-02 09:06:48'),
(273, '17/01/2018', '1', 143, 77, '2019-08-02 09:06:48'),
(275, '18/01/2018', '1', 143, 60, '2019-08-02 09:06:48'),
(274, '18/01/2018', '1', 146, 47, '2019-08-02 09:06:48'),
(276, '18/01/2018', '1', 142, 60, '2019-08-02 09:06:48'),
(277, '19/01/2018', '1', 146, 47, '2019-08-02 09:06:48'),
(278, '19/01/2018', '1', 152, 60, '2019-08-02 09:06:48'),
(279, '19/01/2018', '1', 143, 73, '2019-08-02 09:06:48'),
(280, '21/01/2018', '1', 136, 60, '2019-08-02 09:06:48'),
(283, '22/01/2018', '1', 136, 51, '2019-08-02 09:06:48'),
(282, '22/01/2018', '1', 152, 98, '2019-08-02 09:06:48'),
(281, '22/01/2018', '1', 110, 47, '2019-08-02 09:06:48'),
(284, '22/01/2018', '1', 136, 54, '2019-08-02 09:06:48'),
(289, '23/01/2018', '1', 143, 51, '2019-08-02 09:06:48'),
(290, '23/01/2018', '1', 142, 36, '2019-08-02 09:06:48'),
(288, '23/01/2018', '1', 136, 44, '2019-08-02 09:06:48'),
(291, '24/01/2018', '1', 136, 57, '2019-08-02 09:06:48'),
(293, '25/01/2018', '1', 138, 85, '2019-08-02 09:06:48'),
(294, '25/01/2018', '1', 142, 85, '2019-08-02 09:06:48'),
(295, '25/01/2018', '1', 142, 85, '2019-08-02 09:06:48'),
(286, '23/01/2018', '1', 146, 47, '2019-08-02 09:06:48'),
(296, '25/01/2018', '1', 146, 85, '2019-08-02 09:06:48'),
(297, '25/01/2018', '1', 144, 85, '2019-08-02 09:06:48'),
(285, '23/01/2018', '1', 152, 54, '2019-08-02 09:06:48'),
(287, '23/01/2018', '1', 110, 60, '2019-08-02 09:06:48'),
(292, '24/01/2018', '1', 136, 57, '2019-08-02 09:06:48'),
(298, '25/01/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(299, '26/01/2018', '1', 146, 47, '2019-08-02 09:06:48'),
(300, '26/01/2018', '1', 152, 74, '2019-08-02 09:06:48'),
(301, '26/01/2018', '1', 110, 51, '2019-08-02 09:06:48'),
(302, '26/01/2018', '1', 138, 109, '2019-08-02 09:06:48'),
(303, '26/01/2018', '1', 144, 70, '2019-08-02 09:06:48'),
(304, '29/01/2018', '1', 110, 47, '2019-08-02 09:06:48'),
(305, '30/01/2018', '1', 145, 47, '2019-08-02 09:06:48'),
(306, '01/02/2018', '1', 152, 74, '2019-08-02 09:06:48'),
(307, '01/02/2018', '1', 152, 55, '2019-08-02 09:06:48'),
(309, '02/02/2018', '1', 147, 55, '2019-08-02 09:06:48'),
(308, '02/02/2018', '1', 152, 102, '2019-08-02 09:06:48'),
(310, '05/02/2018', '1', 152, 59, '2019-08-02 09:06:48'),
(311, '05/02/2018', '1', 109, 36, '2019-08-02 09:06:48'),
(312, '06/02/2018', '1', 136, 59, '2019-08-02 09:06:48'),
(313, '06/02/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(316, '07/02/2018', '1', 136, 109, '2019-08-02 09:06:48'),
(317, '07/02/2018', '1', 136, 109, '2019-08-02 09:06:48'),
(320, '07/02/2018', '1', 147, 96, '2019-08-02 09:06:48'),
(322, '07/02/2018', '1', 147, 96, '2019-08-02 09:06:48'),
(323, '07/02/2018', '1', 147, 96, '2019-08-02 09:06:48'),
(314, '07/02/2018', '1', 142, 90, '2019-08-02 09:06:48'),
(315, '07/02/2018', '1', 152, 68, '2019-08-02 09:06:48'),
(318, '07/02/2018', '1', 109, 57, '2019-08-02 09:06:48'),
(319, '07/02/2018', '1', 110, 85, '2019-08-02 09:06:48'),
(321, '07/02/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(326, '08/02/2018', '1', 147, 85, '2019-08-02 09:06:48'),
(328, '08/02/2018', '1', 109, 77, '2019-08-02 09:06:48'),
(324, '08/02/2018', '1', 110, 68, '2019-08-02 09:06:48'),
(325, '08/02/2018', '1', 152, 96, '2019-08-02 09:06:48'),
(327, '08/02/2018', '1', 146, 98, '2019-08-02 09:06:48'),
(329, '08/02/2018', '1', 142, 85, '2019-08-02 09:06:48'),
(330, '08/02/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(331, '09/02/2018', '1', 136, 77, '2019-08-02 09:06:48'),
(332, '09/02/2018', '1', 147, 109, '2019-08-02 09:06:48'),
(333, '09/02/2018', '1', 110, 85, '2019-08-02 09:06:48'),
(334, '09/02/2018', '1', 136, 46, '2019-08-02 09:06:48'),
(335, '14/02/2018', '1', 152, 106, '2019-08-02 09:06:48'),
(336, '14/02/2018', '1', 136, 93, '2019-08-02 09:06:48'),
(337, '14/02/2018', '1', 138, 109, '2019-08-02 09:06:48'),
(338, '15/02/2018', '1', 146, 93, '2019-08-02 09:06:48'),
(339, '15/02/2018', '1', 152, 106, '2019-08-02 09:06:48'),
(340, '15/02/2018', '1', 138, 98, '2019-08-02 09:06:48'),
(341, '15/02/2018', '1', 152, 85, '2019-08-02 09:06:48'),
(342, '16/02/2018', '1', 152, 106, '2019-08-02 09:06:48'),
(343, '16/02/2018', '1', 146, 93, '2019-08-02 09:06:48'),
(344, '16/02/2018', '1', 129, 98, '2019-08-02 09:06:48'),
(345, '16/02/2018', '1', 136, 54, '2019-08-02 09:06:48'),
(346, '19/02/2018', '1', 152, 109, '2019-08-02 09:06:48'),
(350, '19/02/2018', '1', 110, 109, '2019-08-02 09:06:48'),
(353, '20/02/2018', '1', 136, 85, '2019-08-02 09:06:48'),
(347, '19/02/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(348, '19/02/2018', '1', 145, 56, '2019-08-02 09:06:48'),
(349, '19/02/2018', '1', 152, 55, '2019-08-02 09:06:48'),
(351, '20/02/2018', '1', 110, 47, '2019-08-02 09:06:48'),
(352, '20/02/2018', '1', 152, 83, '2019-08-02 09:06:48'),
(354, '20/02/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(355, '20/02/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(358, '21/02/2018', '1', 136, 96, '2019-08-02 09:06:48'),
(357, '21/02/2018', '1', 147, 67, '2019-08-02 09:06:48'),
(360, '21/02/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(356, '21/02/2018', '1', 110, 47, '2019-08-02 09:06:48'),
(359, '21/02/2018', '1', 109, 74, '2019-08-02 09:06:48'),
(361, '21/02/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(362, '21/02/2018', '1', 144, 98, '2019-08-02 09:06:48'),
(363, '22/02/2018', '1', 110, 47, '2019-08-02 09:06:48'),
(364, '22/02/2018', '1', 110, 47, '2019-08-02 09:06:48'),
(365, '22/02/2018', '1', 152, 102, '2019-08-02 09:06:48'),
(366, '22/02/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(367, '22/02/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(368, '23/02/2018', '1', 152, 47, '2019-08-02 09:06:48'),
(369, '23/02/2018', '1', 144, 98, '2019-08-02 09:06:48'),
(370, '23/02/2018', '1', 110, 109, '2019-08-02 09:06:48'),
(373, '26/02/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(374, '26/02/2018', '1', 142, 109, '2019-08-02 09:06:48'),
(371, '26/02/2018', '1', 146, 85, '2019-08-02 09:06:48'),
(372, '26/02/2018', '1', 152, 74, '2019-08-02 09:06:48'),
(375, '26/02/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(378, '27/02/2018', '1', 152, 91, '2019-08-02 09:06:48'),
(379, '27/02/2018', '1', 152, 38, '2019-08-02 09:06:48'),
(376, '27/02/2018', '1', 142, 49, '2019-08-02 09:06:48'),
(383, '27/02/2018', '1', 110, 107, '2019-08-02 09:06:48'),
(377, '27/02/2018', '1', 148, 74, '2019-08-02 09:06:48'),
(380, '27/02/2018', '1', 144, 91, '2019-08-02 09:06:48'),
(381, '27/02/2018', '1', 85, 84, '2019-08-02 09:06:48'),
(382, '27/02/2018', '1', 143, 48, '2019-08-02 09:06:48'),
(384, '27/02/2018', '1', 73, 108, '2019-08-02 09:06:48'),
(391, '28/02/2018', '1', 147, 48, '2019-08-02 09:06:48'),
(385, '28/02/2018', '1', 146, 83, '2019-08-02 09:06:48'),
(386, '28/02/2018', '1', 142, 49, '2019-08-02 09:06:48'),
(387, '28/02/2018', '1', 138, 61, '2019-08-02 09:06:48'),
(388, '28/02/2018', '1', 129, 91, '2019-08-02 09:06:48'),
(389, '28/02/2018', '1', 145, 36, '2019-08-02 09:06:48'),
(390, '28/02/2018', '1', 144, 107, '2019-08-02 09:06:48'),
(392, '28/02/2018', '1', 148, 48, '2019-08-02 09:06:48'),
(393, '28/02/2018', '1', 152, 55, '2019-08-02 09:06:48'),
(394, '01/03/2018', '1', 142, 48, '2019-08-02 09:06:48'),
(395, '01/03/2018', '1', 136, 91, '2019-08-02 09:06:48'),
(396, '01/03/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(397, '02/03/2018', '1', 146, 48, '2019-08-02 09:06:48'),
(398, '02/03/2018', '1', 129, 91, '2019-08-02 09:06:48'),
(399, '02/03/2018', '1', 144, 81, '2019-08-02 09:06:48'),
(400, '05/03/2018', '1', 146, 91, '2019-08-02 09:06:48'),
(402, '05/03/2018', '1', 146, 91, '2019-08-02 09:06:48'),
(401, '05/03/2018', '1', 145, 36, '2019-08-02 09:06:48'),
(403, '06/03/2018', '1', 146, 91, '2019-08-02 09:06:48'),
(404, '06/03/2018', '1', 145, 36, '2019-08-02 09:06:48'),
(405, '06/03/2018', '1', 144, 57, '2019-08-02 09:06:48'),
(406, '07/03/2018', '1', 146, 91, '2019-08-02 09:06:48'),
(408, '07/03/2018', '1', 136, 91, '2019-08-02 09:06:48'),
(411, '07/03/2018', '1', 144, 91, '2019-08-02 09:06:48'),
(409, '07/03/2018', '1', 156, 109, '2019-08-02 09:06:48'),
(407, '07/03/2018', '1', 146, 53, '2019-08-02 09:06:48'),
(410, '07/03/2018', '1', 145, 36, '2019-08-02 09:06:48'),
(412, '07/03/2018', '1', 144, 91, '2019-08-02 09:06:48'),
(413, '08/03/2018', '1', 149, 53, '2019-08-02 09:06:48'),
(414, '08/03/2018', '1', 145, 91, '2019-08-02 09:06:48'),
(415, '08/03/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(418, '09/03/2018', '1', 157, 81, '2019-08-02 09:06:48'),
(416, '09/03/2018', '1', 146, 107, '2019-08-02 09:06:48'),
(417, '09/03/2018', '1', 148, 93, '2019-08-02 09:06:48'),
(419, '09/03/2018', '1', 144, 91, '2019-08-02 09:06:48'),
(421, '12/03/2018', '1', 145, 75, '2019-08-02 09:06:48'),
(425, '12/03/2018', '1', 147, 93, '2019-08-02 09:06:48'),
(426, '12/03/2018', '1', 157, 54, '2019-08-02 09:06:48'),
(420, '12/03/2018', '1', 146, 107, '2019-08-02 09:06:48'),
(428, '13/03/2018', '1', 147, 57, '2019-08-02 09:06:48'),
(429, '13/03/2018', '1', 147, 57, '2019-08-02 09:06:48'),
(422, '12/03/2018', '1', 145, 75, '2019-08-02 09:06:48'),
(423, '12/03/2018', '1', 148, 91, '2019-08-02 09:06:48'),
(424, '12/03/2018', '1', 149, 60, '2019-08-02 09:06:48'),
(427, '12/03/2018', '1', 109, 74, '2019-08-02 09:06:48'),
(430, '13/03/2018', '1', 146, 57, '2019-08-02 09:06:48'),
(431, '13/03/2018', '1', 109, 91, '2019-08-02 09:06:48'),
(432, '13/03/2018', '1', 149, 109, '2019-08-02 09:06:48'),
(433, '13/03/2018', '1', 145, 36, '2019-08-02 09:06:48'),
(434, '14/03/2018', '1', 146, 91, '2019-08-02 09:06:48'),
(435, '14/03/2018', '1', 149, 98, '2019-08-02 09:06:48'),
(436, '14/03/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(437, '14/03/2018', '1', 148, 108, '2019-08-02 09:06:48'),
(445, '15/03/2018', '1', 80, 67, '2019-08-02 09:06:48'),
(438, '14/03/2018', '1', 148, 108, '2019-08-02 09:06:48'),
(440, '15/03/2018', '1', 148, 73, '2019-08-02 09:06:48'),
(439, '15/03/2018', '1', 146, 59, '2019-08-02 09:06:48'),
(441, '15/03/2018', '1', 147, 109, '2019-08-02 09:06:48'),
(442, '15/03/2018', '1', 145, 36, '2019-08-02 09:06:48'),
(443, '15/03/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(444, '15/03/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(446, '15/03/2018', '1', 148, 73, '2019-08-02 09:06:48'),
(449, '16/03/2018', '1', 145, 45, '2019-08-02 09:06:48'),
(451, '16/03/2018', '1', 147, 35, '2019-08-02 09:06:48'),
(452, '16/03/2018', '1', 147, 73, '2019-08-02 09:06:48'),
(455, '16/03/2018', '1', 156, 109, '2019-08-02 09:06:48'),
(450, '16/03/2018', '1', 149, 108, '2019-08-02 09:06:48'),
(457, '16/03/2018', '1', 144, 73, '2019-08-02 09:06:48'),
(453, '16/03/2018', '1', 147, 85, '2019-08-02 09:06:48'),
(448, '16/03/2018', '1', 148, 90, '2019-08-02 09:06:48'),
(460, '17/03/2018', '1', 148, 73, '2019-08-02 09:06:48'),
(447, '16/03/2018', '1', 146, 91, '2019-08-02 09:06:48'),
(454, '16/03/2018', '1', 145, 36, '2019-08-02 09:06:48'),
(456, '16/03/2018', '1', 156, 109, '2019-08-02 09:06:48'),
(458, '16/03/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(459, '16/03/2018', '1', 147, 85, '2019-08-02 09:06:48'),
(461, '20/03/2018', '1', 145, 85, '2019-08-02 09:06:48');
INSERT INTO `tb_temp_usuario_logs` (`id_temp_log`, `fecha`, `estado`, `id_usuario`, `id_espacio`, `date`) VALUES
(462, '20/03/2018', '1', 136, 91, '2019-08-02 09:06:48'),
(463, '20/03/2018', '1', 146, 73, '2019-08-02 09:06:48'),
(464, '20/03/2018', '1', 144, 90, '2019-08-02 09:06:48'),
(465, '20/03/2018', '1', 148, 98, '2019-08-02 09:06:48'),
(470, '21/03/2018', '1', 147, 55, '2019-08-02 09:06:48'),
(466, '21/03/2018', '1', 146, 73, '2019-08-02 09:06:48'),
(467, '21/03/2018', '1', 145, 85, '2019-08-02 09:06:48'),
(468, '21/03/2018', '1', 136, 91, '2019-08-02 09:06:48'),
(469, '21/03/2018', '1', 148, 68, '2019-08-02 09:06:48'),
(471, '21/03/2018', '1', 144, 57, '2019-08-02 09:06:48'),
(472, '21/03/2018', '1', 147, 55, '2019-08-02 09:06:48'),
(476, '22/03/2018', '1', 149, 68, '2019-08-02 09:06:48'),
(478, '22/03/2018', '1', 156, 68, '2019-08-02 09:06:48'),
(479, '22/03/2018', '1', 147, 68, '2019-08-02 09:06:48'),
(473, '22/03/2018', '1', 148, 73, '2019-08-02 09:06:48'),
(474, '22/03/2018', '1', 145, 85, '2019-08-02 09:06:48'),
(475, '22/03/2018', '1', 146, 45, '2019-08-02 09:06:48'),
(477, '22/03/2018', '1', 149, 91, '2019-08-02 09:06:48'),
(480, '22/03/2018', '1', 147, 109, '2019-08-02 09:06:48'),
(481, '22/03/2018', '1', 144, 54, '2019-08-02 09:06:48'),
(482, '22/03/2018', '1', 148, 73, '2019-08-02 09:06:48'),
(484, '23/03/2018', '1', 148, 91, '2019-08-02 09:06:48'),
(487, '25/03/2018', '1', 72, 41, '2019-08-02 09:06:48'),
(488, '25/03/2018', '1', 72, 109, '2019-08-02 09:06:48'),
(489, '25/03/2018', '1', 72, 109, '2019-08-02 09:06:48'),
(490, '26/03/2018', '1', 136, 109, '2019-08-02 09:06:48'),
(493, '26/03/2018', '1', 109, 54, '2019-08-02 09:06:48'),
(483, '23/03/2018', '1', 146, 45, '2019-08-02 09:06:48'),
(485, '23/03/2018', '1', 148, 73, '2019-08-02 09:06:48'),
(486, '23/03/2018', '1', 145, 91, '2019-08-02 09:06:48'),
(491, '26/03/2018', '1', 156, 109, '2019-08-02 09:06:48'),
(492, '26/03/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(494, '27/03/2018', '1', 148, 73, '2019-08-02 09:06:48'),
(495, '27/03/2018', '1', 149, 109, '2019-08-02 09:06:48'),
(496, '27/03/2018', '1', 144, 36, '2019-08-02 09:06:48'),
(497, '27/03/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(498, '28/03/2018', '1', 147, 109, '2019-08-02 09:06:48'),
(499, '28/03/2018', '1', 147, 109, '2019-08-02 09:06:48'),
(500, '31/03/2018', '1', 158, 109, '2019-08-02 09:06:48'),
(501, '02/04/2018', '1', 146, 109, '2019-08-02 09:06:48'),
(502, '02/04/2018', '1', 147, 73, '2019-08-02 09:06:48'),
(503, '02/04/2018', '1', 130, 36, '2019-08-02 09:06:48'),
(504, '02/04/2018', '1', 149, 54, '2019-08-02 09:06:48'),
(505, '02/04/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(508, '03/04/2018', '1', 110, 109, '2019-08-02 09:06:48'),
(506, '02/04/2018', '1', 148, 73, '2019-08-02 09:06:48'),
(510, '03/04/2018', '1', 148, 85, '2019-08-02 09:06:48'),
(507, '03/04/2018', '1', 146, 54, '2019-08-02 09:06:48'),
(509, '03/04/2018', '1', 110, 109, '2019-08-02 09:06:48'),
(511, '03/04/2018', '1', 148, 85, '2019-08-02 09:06:48'),
(512, '03/04/2018', '1', 149, 73, '2019-08-02 09:06:48'),
(513, '03/04/2018', '1', 157, 55, '2019-08-02 09:06:48'),
(516, '04/04/2018', '1', 145, 73, '2019-08-02 09:06:48'),
(518, '04/04/2018', '1', 149, 73, '2019-08-02 09:06:48'),
(515, '04/04/2018', '1', 146, 54, '2019-08-02 09:06:48'),
(514, '04/04/2018', '1', 110, 109, '2019-08-02 09:06:48'),
(517, '04/04/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(519, '04/04/2018', '1', 149, 61, '2019-08-02 09:06:48'),
(520, '04/04/2018', '1', 146, 73, '2019-08-02 09:06:48'),
(521, '04/04/2018', '1', 156, 68, '2019-08-02 09:06:48'),
(522, '05/04/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(523, '05/04/2018', '1', 157, 73, '2019-08-02 09:06:48'),
(524, '05/04/2018', '1', 149, 61, '2019-08-02 09:06:48'),
(525, '05/04/2018', '1', 110, 59, '2019-08-02 09:06:48'),
(526, '05/04/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(527, '06/04/2018', '1', 110, 109, '2019-08-02 09:06:48'),
(528, '06/04/2018', '1', 149, 61, '2019-08-02 09:06:48'),
(529, '06/04/2018', '1', 147, 73, '2019-08-02 09:06:48'),
(530, '06/04/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(531, '06/04/2018', '1', 156, 55, '2019-08-02 09:06:48'),
(538, '09/04/2018', '1', 146, 55, '2019-08-02 09:06:48'),
(537, '09/04/2018', '1', 129, 107, '2019-08-02 09:06:48'),
(539, '09/04/2018', '1', 129, 107, '2019-08-02 09:06:48'),
(532, '08/04/2018', '1', 148, 73, '2019-08-02 09:06:48'),
(533, '09/04/2018', '1', 148, 61, '2019-08-02 09:06:48'),
(534, '09/04/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(535, '09/04/2018', '1', 149, 68, '2019-08-02 09:06:48'),
(536, '09/04/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(540, '09/04/2018', '1', 129, 61, '2019-08-02 09:06:48'),
(541, '10/04/2018', '1', 146, 68, '2019-08-02 09:06:48'),
(542, '10/04/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(543, '10/04/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(544, '10/04/2018', '1', 149, 66, '2019-08-02 09:06:48'),
(545, '10/04/2018', '1', 156, 106, '2019-08-02 09:06:48'),
(546, '10/04/2018', '1', 129, 55, '2019-08-02 09:06:48'),
(547, '10/04/2018', '1', 144, 103, '2019-08-02 09:06:48'),
(548, '10/04/2018', '1', 129, 55, '2019-08-02 09:06:48'),
(549, '11/04/2018', '1', 146, 68, '2019-08-02 09:06:48'),
(550, '11/04/2018', '1', 149, 61, '2019-08-02 09:06:48'),
(551, '11/04/2018', '1', 129, 66, '2019-08-02 09:06:48'),
(552, '11/04/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(553, '11/04/2018', '1', 142, 81, '2019-08-02 09:06:48'),
(554, '12/04/2018', '1', 142, 61, '2019-08-02 09:06:48'),
(555, '12/04/2018', '1', 146, 78, '2019-08-02 09:06:48'),
(556, '12/04/2018', '1', 129, 66, '2019-08-02 09:06:48'),
(557, '12/04/2018', '1', 149, 68, '2019-08-02 09:06:48'),
(558, '12/04/2018', '1', 157, 47, '2019-08-02 09:06:48'),
(559, '12/04/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(560, '12/04/2018', '1', 147, 109, '2019-08-02 09:06:48'),
(563, '13/04/2018', '1', 129, 66, '2019-08-02 09:06:48'),
(565, '13/04/2018', '1', 129, 66, '2019-08-02 09:06:48'),
(561, '13/04/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(562, '13/04/2018', '1', 142, 68, '2019-08-02 09:06:48'),
(564, '13/04/2018', '1', 147, 70, '2019-08-02 09:06:48'),
(566, '13/04/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(571, '16/04/2018', '1', 147, 96, '2019-08-02 09:06:48'),
(567, '16/04/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(568, '16/04/2018', '1', 145, 66, '2019-08-02 09:06:48'),
(569, '16/04/2018', '1', 149, 67, '2019-08-02 09:06:48'),
(570, '16/04/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(576, '17/04/2018', '1', 157, 103, '2019-08-02 09:06:48'),
(572, '17/04/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(573, '17/04/2018', '1', 145, 66, '2019-08-02 09:06:48'),
(574, '17/04/2018', '1', 110, 67, '2019-08-02 09:06:48'),
(575, '17/04/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(577, '17/04/2018', '1', 130, 59, '2019-08-02 09:06:48'),
(578, '17/04/2018', '1', 157, 96, '2019-08-02 09:06:48'),
(579, '18/04/2018', '1', 110, 59, '2019-08-02 09:06:48'),
(580, '18/04/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(581, '18/04/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(582, '18/04/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(583, '18/04/2018', '1', 157, 66, '2019-08-02 09:06:48'),
(584, '18/04/2018', '1', 130, 67, '2019-08-02 09:06:48'),
(585, '18/04/2018', '1', 144, 92, '2019-08-02 09:06:48'),
(586, '18/04/2018', '1', 147, 56, '2019-08-02 09:06:48'),
(588, '19/04/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(589, '19/04/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(587, '19/04/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(590, '19/04/2018', '1', 157, 66, '2019-08-02 09:06:48'),
(591, '19/04/2018', '1', 130, 99, '2019-08-02 09:06:48'),
(592, '19/04/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(593, '19/04/2018', '1', 110, 67, '2019-08-02 09:06:48'),
(594, '19/04/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(596, '20/04/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(595, '20/04/2018', '1', 110, 59, '2019-08-02 09:06:48'),
(597, '20/04/2018', '1', 130, 99, '2019-08-02 09:06:48'),
(598, '20/04/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(599, '23/04/2018', '1', 142, 61, '2019-08-02 09:06:48'),
(600, '23/04/2018', '1', 145, 66, '2019-08-02 09:06:48'),
(601, '23/04/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(602, '23/04/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(603, '23/04/2018', '1', 157, 67, '2019-08-02 09:06:48'),
(604, '24/04/2018', '1', 142, 61, '2019-08-02 09:06:48'),
(605, '24/04/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(606, '24/04/2018', '1', 145, 66, '2019-08-02 09:06:48'),
(607, '24/04/2018', '1', 149, 83, '2019-08-02 09:06:48'),
(608, '24/04/2018', '1', 156, 50, '2019-08-02 09:06:48'),
(609, '24/04/2018', '1', 143, 64, '2019-08-02 09:06:48'),
(610, '24/04/2018', '1', 148, 102, '2019-08-02 09:06:48'),
(611, '24/04/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(616, '25/04/2018', '1', 143, 64, '2019-08-02 09:06:48'),
(612, '25/04/2018', '1', 146, 62, '2019-08-02 09:06:48'),
(613, '25/04/2018', '1', 142, 61, '2019-08-02 09:06:48'),
(614, '25/04/2018', '1', 148, 66, '2019-08-02 09:06:48'),
(615, '25/04/2018', '1', 129, 67, '2019-08-02 09:06:48'),
(617, '25/04/2018', '1', 149, 64, '2019-08-02 09:06:48'),
(618, '25/04/2018', '1', 144, 50, '2019-08-02 09:06:48'),
(620, '26/04/2018', '1', 145, 66, '2019-08-02 09:06:48'),
(625, '26/04/2018', '1', 147, 82, '2019-08-02 09:06:48'),
(624, '26/04/2018', '1', 149, 50, '2019-08-02 09:06:48'),
(622, '26/04/2018', '1', 156, 62, '2019-08-02 09:06:48'),
(619, '26/04/2018', '1', 148, 61, '2019-08-02 09:06:48'),
(621, '26/04/2018', '1', 145, 86, '2019-08-02 09:06:48'),
(623, '26/04/2018', '1', 129, 66, '2019-08-02 09:06:48'),
(626, '26/04/2018', '1', 144, 38, '2019-08-02 09:06:48'),
(630, '27/04/2018', '1', 156, 66, '2019-08-02 09:06:48'),
(635, '27/04/2018', '1', 147, 66, '2019-08-02 09:06:48'),
(627, '27/04/2018', '1', 142, 61, '2019-08-02 09:06:48'),
(628, '27/04/2018', '1', 148, 35, '2019-08-02 09:06:48'),
(629, '27/04/2018', '1', 146, 62, '2019-08-02 09:06:48'),
(631, '27/04/2018', '1', 129, 50, '2019-08-02 09:06:48'),
(632, '27/04/2018', '1', 149, 99, '2019-08-02 09:06:48'),
(633, '27/04/2018', '1', 144, 51, '2019-08-02 09:06:48'),
(634, '27/04/2018', '1', 145, 86, '2019-08-02 09:06:48'),
(641, '30/04/2018', '1', 148, 37, '2019-08-02 09:06:48'),
(636, '30/04/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(637, '30/04/2018', '1', 149, 81, '2019-08-02 09:06:48'),
(638, '30/04/2018', '1', 157, 76, '2019-08-02 09:06:48'),
(639, '30/04/2018', '1', 110, 66, '2019-08-02 09:06:48'),
(640, '30/04/2018', '1', 130, 107, '2019-08-02 09:06:48'),
(642, '30/04/2018', '1', 144, 46, '2019-08-02 09:06:48'),
(643, '02/05/2018', '1', 146, 73, '2019-08-02 09:06:48'),
(648, '02/05/2018', '1', 147, 55, '2019-08-02 09:06:48'),
(644, '02/05/2018', '1', 146, 46, '2019-08-02 09:06:48'),
(645, '02/05/2018', '1', 148, 73, '2019-08-02 09:06:48'),
(646, '02/05/2018', '1', 149, 89, '2019-08-02 09:06:48'),
(647, '02/05/2018', '1', 130, 109, '2019-08-02 09:06:48'),
(649, '02/05/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(650, '02/05/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(651, '02/05/2018', '1', 145, 56, '2019-08-02 09:06:48'),
(656, '03/05/2018', '1', 149, 45, '2019-08-02 09:06:48'),
(657, '03/05/2018', '1', 144, 73, '2019-08-02 09:06:48'),
(652, '03/05/2018', '1', 148, 35, '2019-08-02 09:06:48'),
(653, '03/05/2018', '1', 110, 109, '2019-08-02 09:06:48'),
(654, '03/05/2018', '1', 145, 56, '2019-08-02 09:06:48'),
(655, '03/05/2018', '1', 146, 34, '2019-08-02 09:06:48'),
(658, '03/05/2018', '1', 130, 36, '2019-08-02 09:06:48'),
(659, '03/05/2018', '1', 149, 77, '2019-08-02 09:06:48'),
(660, '03/05/2018', '1', 144, 95, '2019-08-02 09:06:48'),
(661, '04/05/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(662, '04/05/2018', '1', 110, 109, '2019-08-02 09:06:48'),
(663, '04/05/2018', '1', 148, 73, '2019-08-02 09:06:48'),
(664, '04/05/2018', '1', 145, 34, '2019-08-02 09:06:48'),
(665, '04/05/2018', '1', 147, 45, '2019-08-02 09:06:48'),
(666, '04/05/2018', '1', 149, 77, '2019-08-02 09:06:48'),
(667, '04/05/2018', '1', 157, 36, '2019-08-02 09:06:48'),
(668, '07/05/2018', '1', 142, 61, '2019-08-02 09:06:48'),
(669, '07/05/2018', '1', 145, 56, '2019-08-02 09:06:48'),
(670, '07/05/2018', '1', 146, 45, '2019-08-02 09:06:48'),
(671, '07/05/2018', '1', 129, 95, '2019-08-02 09:06:48'),
(672, '07/05/2018', '1', 149, 64, '2019-08-02 09:06:48'),
(677, '08/05/2018', '1', 89, 56, '2019-08-02 09:06:48'),
(674, '08/05/2018', '1', 145, 45, '2019-08-02 09:06:48'),
(673, '08/05/2018', '1', 142, 61, '2019-08-02 09:06:48'),
(675, '08/05/2018', '1', 148, 60, '2019-08-02 09:06:48'),
(676, '08/05/2018', '1', 146, 81, '2019-08-02 09:06:48'),
(678, '08/05/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(679, '08/05/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(680, '08/05/2018', '1', 129, 83, '2019-08-02 09:06:48'),
(681, '08/05/2018', '1', 145, 45, '2019-08-02 09:06:48'),
(682, '08/05/2018', '1', 149, 74, '2019-08-02 09:06:48'),
(687, '09/05/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(683, '09/05/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(684, '09/05/2018', '1', 144, 107, '2019-08-02 09:06:48'),
(685, '09/05/2018', '1', 142, 45, '2019-08-02 09:06:48'),
(686, '09/05/2018', '1', 149, 74, '2019-08-02 09:06:48'),
(688, '09/05/2018', '1', 129, 83, '2019-08-02 09:06:48'),
(689, '09/05/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(690, '09/05/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(691, '10/05/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(692, '10/05/2018', '1', 142, 45, '2019-08-02 09:06:48'),
(693, '10/05/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(694, '10/05/2018', '1', 156, 74, '2019-08-02 09:06:48'),
(695, '10/05/2018', '1', 149, 68, '2019-08-02 09:06:48'),
(696, '10/05/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(697, '10/05/2018', '1', 129, 36, '2019-08-02 09:06:48'),
(698, '11/05/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(699, '11/05/2018', '1', 142, 45, '2019-08-02 09:06:48'),
(700, '11/05/2018', '1', 148, 36, '2019-08-02 09:06:48'),
(701, '11/05/2018', '1', 156, 74, '2019-08-02 09:06:48'),
(702, '11/05/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(703, '11/05/2018', '1', 109, 38, '2019-08-02 09:06:48'),
(704, '15/05/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(705, '15/05/2018', '1', 110, 45, '2019-08-02 09:06:48'),
(706, '15/05/2018', '1', 145, 85, '2019-08-02 09:06:48'),
(707, '15/05/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(708, '15/05/2018', '1', 109, 70, '2019-08-02 09:06:48'),
(709, '15/05/2018', '1', 149, 34, '2019-08-02 09:06:48'),
(710, '16/05/2018', '1', 146, 45, '2019-08-02 09:06:48'),
(711, '16/05/2018', '1', 110, 59, '2019-08-02 09:06:48'),
(712, '16/05/2018', '1', 145, 95, '2019-08-02 09:06:48'),
(713, '16/05/2018', '1', 149, 61, '2019-08-02 09:06:48'),
(714, '16/05/2018', '1', 156, 70, '2019-08-02 09:06:48'),
(715, '16/05/2018', '1', 147, 98, '2019-08-02 09:06:48'),
(716, '16/05/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(723, '17/05/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(717, '17/05/2018', '1', 110, 59, '2019-08-02 09:06:48'),
(718, '17/05/2018', '1', 146, 108, '2019-08-02 09:06:48'),
(719, '17/05/2018', '1', 145, 95, '2019-08-02 09:06:48'),
(720, '17/05/2018', '1', 147, 93, '2019-08-02 09:06:48'),
(721, '17/05/2018', '1', 149, 61, '2019-08-02 09:06:48'),
(722, '17/05/2018', '1', 156, 87, '2019-08-02 09:06:48'),
(724, '17/05/2018', '1', 144, 45, '2019-08-02 09:06:48'),
(725, '17/05/2018', '1', 148, 55, '2019-08-02 09:06:48'),
(726, '18/05/2018', '1', 110, 95, '2019-08-02 09:06:48'),
(727, '18/05/2018', '1', 148, 61, '2019-08-02 09:06:48'),
(728, '18/05/2018', '1', 145, 106, '2019-08-02 09:06:48'),
(729, '18/05/2018', '1', 146, 45, '2019-08-02 09:06:48'),
(730, '18/05/2018', '1', 130, 109, '2019-08-02 09:06:48'),
(731, '18/05/2018', '1', 110, 76, '2019-08-02 09:06:48'),
(732, '18/05/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(733, '18/05/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(734, '21/05/2018', '1', 129, 82, '2019-08-02 09:06:48'),
(735, '21/05/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(736, '21/05/2018', '1', 157, 109, '2019-08-02 09:06:48'),
(737, '21/05/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(738, '21/05/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(739, '21/05/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(740, '21/05/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(747, '22/05/2018', '1', 109, 85, '2019-08-02 09:06:48'),
(741, '22/05/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(742, '22/05/2018', '1', 148, 82, '2019-08-02 09:06:48'),
(743, '22/05/2018', '1', 149, 38, '2019-08-02 09:06:48'),
(744, '22/05/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(745, '22/05/2018', '1', 156, 42, '2019-08-02 09:06:48'),
(746, '22/05/2018', '1', 129, 98, '2019-08-02 09:06:48'),
(748, '22/05/2018', '1', 109, 85, '2019-08-02 09:06:48'),
(749, '22/05/2018', '1', 144, 108, '2019-08-02 09:06:48'),
(750, '23/05/2018', '1', 146, 82, '2019-08-02 09:06:48'),
(751, '23/05/2018', '1', 148, 61, '2019-08-02 09:06:48'),
(752, '23/05/2018', '1', 129, 108, '2019-08-02 09:06:48'),
(753, '23/05/2018', '1', 149, 42, '2019-08-02 09:06:48'),
(754, '23/05/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(755, '23/05/2018', '1', 129, 98, '2019-08-02 09:06:48'),
(756, '23/05/2018', '1', 129, 109, '2019-08-02 09:06:48'),
(759, '24/05/2018', '1', 149, 61, '2019-08-02 09:06:48'),
(758, '24/05/2018', '1', 129, 106, '2019-08-02 09:06:48'),
(757, '24/05/2018', '1', 146, 82, '2019-08-02 09:06:48'),
(760, '24/05/2018', '1', 142, 98, '2019-08-02 09:06:48'),
(761, '24/05/2018', '1', 148, 108, '2019-08-02 09:06:48'),
(762, '24/05/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(763, '24/05/2018', '1', 80, 57, '2019-08-02 09:06:48'),
(764, '24/05/2018', '1', 154, 38, '2019-08-02 09:06:48'),
(770, '25/05/2018', '1', 147, 36, '2019-08-02 09:06:48'),
(765, '25/05/2018', '1', 146, 82, '2019-08-02 09:06:48'),
(766, '25/05/2018', '1', 142, 108, '2019-08-02 09:06:48'),
(767, '25/05/2018', '1', 129, 57, '2019-08-02 09:06:48'),
(768, '25/05/2018', '1', 148, 98, '2019-08-02 09:06:48'),
(769, '25/05/2018', '1', 149, 61, '2019-08-02 09:06:48'),
(771, '25/05/2018', '1', 147, 36, '2019-08-02 09:06:48'),
(772, '25/05/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(773, '25/05/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(774, '25/05/2018', '1', 144, 106, '2019-08-02 09:06:48'),
(775, '25/05/2018', '1', 129, 49, '2019-08-02 09:06:48'),
(776, '28/05/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(777, '28/05/2018', '1', 110, 74, '2019-08-02 09:06:48'),
(778, '28/05/2018', '1', 130, 56, '2019-08-02 09:06:48'),
(779, '28/05/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(780, '28/05/2018', '1', 80, 81, '2019-08-02 09:06:48'),
(781, '28/05/2018', '1', 145, 57, '2019-08-02 09:06:48'),
(782, '28/05/2018', '1', 144, 49, '2019-08-02 09:06:48'),
(783, '29/05/2018', '1', 145, 74, '2019-08-02 09:06:48'),
(784, '29/05/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(785, '29/05/2018', '1', 110, 49, '2019-08-02 09:06:48'),
(786, '29/05/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(787, '29/05/2018', '1', 130, 56, '2019-08-02 09:06:48'),
(794, '30/05/2018', '1', 154, 36, '2019-08-02 09:06:48'),
(788, '30/05/2018', '1', 145, 74, '2019-08-02 09:06:48'),
(789, '30/05/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(790, '30/05/2018', '1', 110, 49, '2019-08-02 09:06:48'),
(791, '30/05/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(792, '30/05/2018', '1', 130, 95, '2019-08-02 09:06:48'),
(793, '30/05/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(795, '31/05/2018', '1', 145, 74, '2019-08-02 09:06:48'),
(796, '31/05/2018', '1', 146, 61, '2019-08-02 09:06:48'),
(797, '31/05/2018', '1', 110, 106, '2019-08-02 09:06:48'),
(798, '31/05/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(799, '31/05/2018', '1', 130, 56, '2019-08-02 09:06:48'),
(800, '31/05/2018', '1', 144, 95, '2019-08-02 09:06:48'),
(804, '01/06/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(801, '01/06/2018', '1', 145, 74, '2019-08-02 09:06:48'),
(802, '01/06/2018', '1', 146, 59, '2019-08-02 09:06:48'),
(803, '01/06/2018', '1', 130, 56, '2019-08-02 09:06:48'),
(805, '01/06/2018', '1', 144, 95, '2019-08-02 09:06:48'),
(806, '01/06/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(807, '04/06/2018', '1', 72, 103, '2019-08-02 09:06:48'),
(808, '04/06/2018', '1', 72, 59, '2019-08-02 09:06:48'),
(813, '05/06/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(814, '05/06/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(809, '05/06/2018', '1', 142, 68, '2019-08-02 09:06:48'),
(810, '05/06/2018', '1', 145, 76, '2019-08-02 09:06:48'),
(811, '05/06/2018', '1', 146, 73, '2019-08-02 09:06:48'),
(812, '05/06/2018', '1', 129, 59, '2019-08-02 09:06:48'),
(815, '05/06/2018', '1', 109, 106, '2019-08-02 09:06:48'),
(816, '06/06/2018', '1', 142, 59, '2019-08-02 09:06:48'),
(817, '06/06/2018', '1', 145, 76, '2019-08-02 09:06:48'),
(818, '06/06/2018', '1', 146, 78, '2019-08-02 09:06:48'),
(819, '06/06/2018', '1', 129, 92, '2019-08-02 09:06:48'),
(820, '06/06/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(821, '06/06/2018', '1', 149, 45, '2019-08-02 09:06:48'),
(822, '07/06/2018', '1', 142, 45, '2019-08-02 09:06:48'),
(823, '07/06/2018', '1', 156, 78, '2019-08-02 09:06:48'),
(824, '07/06/2018', '1', 146, 93, '2019-08-02 09:06:48'),
(825, '07/06/2018', '1', 149, 55, '2019-08-02 09:06:48'),
(826, '07/06/2018', '1', 129, 99, '2019-08-02 09:06:48'),
(827, '07/06/2018', '1', 145, 86, '2019-08-02 09:06:48'),
(830, '08/06/2018', '1', 146, 56, '2019-08-02 09:06:48'),
(828, '08/06/2018', '1', 142, 59, '2019-08-02 09:06:48'),
(829, '08/06/2018', '1', 156, 78, '2019-08-02 09:06:48'),
(831, '08/06/2018', '1', 146, 92, '2019-08-02 09:06:48'),
(832, '08/06/2018', '1', 129, 76, '2019-08-02 09:06:48'),
(833, '08/06/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(834, '08/06/2018', '1', 142, 57, '2019-08-02 09:06:48'),
(835, '08/06/2018', '1', 145, 86, '2019-08-02 09:06:48'),
(838, '12/06/2018', '1', 157, 109, '2019-08-02 09:06:48'),
(836, '12/06/2018', '1', 145, 56, '2019-08-02 09:06:48'),
(837, '12/06/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(839, '12/06/2018', '1', 157, 57, '2019-08-02 09:06:48'),
(840, '12/06/2018', '1', 130, 109, '2019-08-02 09:06:48'),
(841, '12/06/2018', '1', 149, 84, '2019-08-02 09:06:48'),
(842, '13/06/2018', '1', 145, 56, '2019-08-02 09:06:48'),
(843, '13/06/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(844, '13/06/2018', '1', 149, 77, '2019-08-02 09:06:48'),
(845, '14/06/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(846, '14/06/2018', '1', 146, 82, '2019-08-02 09:06:48'),
(847, '14/06/2018', '1', 149, 81, '2019-08-02 09:06:48'),
(848, '14/06/2018', '1', 110, 85, '2019-08-02 09:06:48'),
(849, '14/06/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(851, '15/06/2018', '1', 110, 49, '2019-08-02 09:06:48'),
(856, '15/06/2018', '1', 130, 77, '2019-08-02 09:06:48'),
(852, '15/06/2018', '1', 110, 47, '2019-08-02 09:06:48'),
(854, '15/06/2018', '1', 156, 49, '2019-08-02 09:06:48'),
(850, '15/06/2018', '1', 145, 56, '2019-08-02 09:06:48'),
(853, '15/06/2018', '1', 146, 82, '2019-08-02 09:06:48'),
(855, '15/06/2018', '1', 149, 45, '2019-08-02 09:06:48'),
(857, '15/06/2018', '1', 130, 36, '2019-08-02 09:06:48'),
(858, '15/06/2018', '1', 156, 57, '2019-08-02 09:06:48'),
(859, '18/06/2018', '1', 145, 56, '2019-08-02 09:06:48'),
(860, '18/06/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(861, '18/06/2018', '1', 148, 103, '2019-08-02 09:06:48'),
(862, '18/06/2018', '1', 149, 81, '2019-08-02 09:06:48'),
(863, '18/06/2018', '1', 129, 109, '2019-08-02 09:06:48'),
(864, '18/06/2018', '1', 156, 95, '2019-08-02 09:06:48'),
(865, '18/06/2018', '1', 144, 36, '2019-08-02 09:06:48'),
(866, '18/06/2018', '1', 142, 55, '2019-08-02 09:06:48'),
(867, '19/06/2018', '1', 142, 103, '2019-08-02 09:06:48'),
(868, '19/06/2018', '1', 145, 36, '2019-08-02 09:06:48'),
(869, '19/06/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(870, '19/06/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(871, '19/06/2018', '1', 148, 81, '2019-08-02 09:06:48'),
(872, '20/06/2018', '1', 142, 89, '2019-08-02 09:06:48'),
(873, '20/06/2018', '1', 145, 36, '2019-08-02 09:06:48'),
(874, '20/06/2018', '1', 146, 103, '2019-08-02 09:06:48'),
(875, '20/06/2018', '1', 148, 81, '2019-08-02 09:06:48'),
(876, '20/06/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(877, '20/06/2018', '1', 129, 98, '2019-08-02 09:06:48'),
(878, '21/06/2018', '1', 146, 103, '2019-08-02 09:06:48'),
(879, '21/06/2018', '1', 148, 81, '2019-08-02 09:06:48'),
(880, '21/06/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(881, '21/06/2018', '1', 154, 38, '2019-08-02 09:06:48'),
(882, '21/06/2018', '1', 144, 93, '2019-08-02 09:06:48'),
(883, '22/06/2018', '1', 142, 81, '2019-08-02 09:06:48'),
(884, '22/06/2018', '1', 146, 85, '2019-08-02 09:06:48'),
(885, '22/06/2018', '1', 148, 103, '2019-08-02 09:06:48'),
(886, '22/06/2018', '1', 157, 56, '2019-08-02 09:06:48'),
(887, '22/06/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(888, '22/06/2018', '1', 149, 61, '2019-08-02 09:06:48'),
(889, '25/06/2018', '1', 145, 56, '2019-08-02 09:06:48'),
(892, '25/06/2018', '1', 157, 103, '2019-08-02 09:06:48'),
(893, '25/06/2018', '1', 144, 77, '2019-08-02 09:06:48'),
(896, '25/06/2018', '1', 157, 93, '2019-08-02 09:06:48'),
(898, '25/06/2018', '1', 157, 77, '2019-08-02 09:06:48'),
(890, '25/06/2018', '1', 148, 81, '2019-08-02 09:06:48'),
(891, '25/06/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(894, '25/06/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(895, '25/06/2018', '1', 159, 56, '2019-08-02 09:06:48'),
(897, '25/06/2018', '1', 144, 103, '2019-08-02 09:06:48'),
(899, '26/06/2018', '1', 148, 81, '2019-08-02 09:06:48'),
(900, '26/06/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(901, '26/06/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(902, '26/06/2018', '1', 157, 103, '2019-08-02 09:06:48'),
(903, '26/06/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(904, '26/06/2018', '1', 130, 70, '2019-08-02 09:06:48'),
(907, '27/06/2018', '1', 130, 103, '2019-08-02 09:06:48'),
(905, '27/06/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(906, '27/06/2018', '1', 148, 81, '2019-08-02 09:06:48'),
(908, '27/06/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(909, '27/06/2018', '1', 130, 95, '2019-08-02 09:06:48'),
(910, '27/06/2018', '1', 157, 103, '2019-08-02 09:06:48'),
(911, '27/06/2018', '1', 144, 70, '2019-08-02 09:06:48'),
(912, '28/06/2018', '1', 130, 56, '2019-08-02 09:06:48'),
(913, '28/06/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(914, '28/06/2018', '1', 144, 70, '2019-08-02 09:06:48'),
(915, '28/06/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(916, '29/06/2018', '1', 130, 70, '2019-08-02 09:06:48'),
(917, '29/06/2018', '1', 130, 70, '2019-08-02 09:06:48'),
(918, '29/06/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(919, '29/06/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(920, '29/06/2018', '1', 144, 84, '2019-08-02 09:06:48'),
(921, '03/07/2018', '1', 142, 85, '2019-08-02 09:06:48'),
(922, '03/07/2018', '1', 157, 103, '2019-08-02 09:06:48'),
(923, '03/07/2018', '1', 149, 84, '2019-08-02 09:06:48'),
(924, '03/07/2018', '1', 159, 77, '2019-08-02 09:06:48'),
(925, '03/07/2018', '1', 144, 70, '2019-08-02 09:06:48'),
(926, '04/07/2018', '1', 142, 103, '2019-08-02 09:06:48'),
(927, '04/07/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(928, '04/07/2018', '1', 157, 77, '2019-08-02 09:06:48'),
(929, '04/07/2018', '1', 159, 84, '2019-08-02 09:06:48'),
(930, '04/07/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(931, '04/07/2018', '1', 144, 60, '2019-08-02 09:06:48'),
(932, '05/07/2018', '1', 142, 81, '2019-08-02 09:06:48'),
(933, '05/07/2018', '1', 146, 103, '2019-08-02 09:06:48'),
(934, '05/07/2018', '1', 159, 60, '2019-08-02 09:06:48'),
(935, '05/07/2018', '1', 149, 84, '2019-08-02 09:06:48'),
(936, '05/07/2018', '1', 157, 77, '2019-08-02 09:06:48'),
(937, '05/07/2018', '1', 144, 70, '2019-08-02 09:06:48'),
(938, '05/07/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(939, '06/07/2018', '1', 142, 103, '2019-08-02 09:06:48'),
(940, '06/07/2018', '1', 146, 77, '2019-08-02 09:06:48'),
(941, '06/07/2018', '1', 159, 46, '2019-08-02 09:06:48'),
(942, '06/07/2018', '1', 157, 109, '2019-08-02 09:06:48'),
(943, '06/07/2018', '1', 149, 84, '2019-08-02 09:06:48'),
(944, '06/07/2018', '1', 144, 70, '2019-08-02 09:06:48'),
(945, '06/07/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(946, '09/07/2018', '1', 146, 103, '2019-08-02 09:06:48'),
(947, '09/07/2018', '1', 156, 84, '2019-08-02 09:06:48'),
(948, '09/07/2018', '1', 157, 74, '2019-08-02 09:06:48'),
(949, '09/07/2018', '1', 129, 70, '2019-08-02 09:06:48'),
(950, '09/07/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(951, '10/07/2018', '1', 146, 103, '2019-08-02 09:06:48'),
(952, '10/07/2018', '1', 130, 84, '2019-08-02 09:06:48'),
(953, '10/07/2018', '1', 157, 77, '2019-08-02 09:06:48'),
(954, '10/07/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(955, '10/07/2018', '1', 129, 70, '2019-08-02 09:06:48'),
(958, '11/07/2018', '1', 157, 81, '2019-08-02 09:06:48'),
(962, '11/07/2018', '1', 144, 77, '2019-08-02 09:06:48'),
(960, '11/07/2018', '1', 129, 49, '2019-08-02 09:06:48'),
(956, '11/07/2018', '1', 146, 103, '2019-08-02 09:06:48'),
(957, '11/07/2018', '1', 130, 84, '2019-08-02 09:06:48'),
(959, '11/07/2018', '1', 157, 107, '2019-08-02 09:06:48'),
(961, '11/07/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(963, '11/07/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(966, '12/07/2018', '1', 130, 98, '2019-08-02 09:06:48'),
(969, '12/07/2018', '1', 148, 98, '2019-08-02 09:06:48'),
(964, '12/07/2018', '1', 156, 84, '2019-08-02 09:06:48'),
(965, '12/07/2018', '1', 146, 103, '2019-08-02 09:06:48'),
(967, '12/07/2018', '1', 157, 77, '2019-08-02 09:06:48'),
(968, '12/07/2018', '1', 130, 59, '2019-08-02 09:06:48'),
(970, '12/07/2018', '1', 129, 49, '2019-08-02 09:06:48'),
(971, '13/07/2018', '1', 146, 103, '2019-08-02 09:06:48'),
(972, '13/07/2018', '1', 130, 84, '2019-08-02 09:06:48'),
(973, '13/07/2018', '1', 156, 98, '2019-08-02 09:06:48'),
(974, '13/07/2018', '1', 147, 77, '2019-08-02 09:06:48'),
(975, '13/07/2018', '1', 129, 49, '2019-08-02 09:06:48'),
(976, '16/07/2018', '1', 142, 98, '2019-08-02 09:06:48'),
(977, '16/07/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(978, '16/07/2018', '1', 157, 84, '2019-08-02 09:06:48'),
(979, '16/07/2018', '1', 110, 56, '2019-08-02 09:06:48'),
(980, '16/07/2018', '1', 147, 55, '2019-08-02 09:06:48'),
(981, '16/07/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(982, '16/07/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(983, '17/07/2018', '1', 142, 89, '2019-08-02 09:06:48'),
(984, '17/07/2018', '1', 145, 84, '2019-08-02 09:06:48'),
(985, '17/07/2018', '1', 146, 98, '2019-08-02 09:06:48'),
(986, '17/07/2018', '1', 110, 56, '2019-08-02 09:06:48'),
(987, '17/07/2018', '1', 157, 59, '2019-08-02 09:06:48'),
(988, '17/07/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(989, '17/07/2018', '1', 144, 36, '2019-08-02 09:06:48'),
(991, '18/07/2018', '1', 145, 56, '2019-08-02 09:06:48'),
(990, '18/07/2018', '1', 142, 89, '2019-08-02 09:06:48'),
(992, '18/07/2018', '1', 110, 59, '2019-08-02 09:06:48'),
(993, '18/07/2018', '1', 146, 98, '2019-08-02 09:06:48'),
(994, '18/07/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(995, '18/07/2018', '1', 157, 56, '2019-08-02 09:06:48'),
(996, '18/07/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(997, '18/07/2018', '1', 144, 77, '2019-08-02 09:06:48'),
(998, '19/07/2018', '1', 142, 89, '2019-08-02 09:06:48'),
(999, '19/07/2018', '1', 146, 98, '2019-08-02 09:06:48'),
(1000, '19/07/2018', '1', 110, 59, '2019-08-02 09:06:48'),
(1001, '19/07/2018', '1', 157, 56, '2019-08-02 09:06:48'),
(1002, '23/07/2018', '1', 145, 87, '2019-08-02 09:06:48'),
(1003, '23/07/2018', '1', 146, 56, '2019-08-02 09:06:48'),
(1004, '23/07/2018', '1', 157, 77, '2019-08-02 09:06:48'),
(1005, '23/07/2018', '1', 130, 36, '2019-08-02 09:06:48'),
(1006, '23/07/2018', '1', 129, 38, '2019-08-02 09:06:48'),
(1012, '24/07/2018', '1', 156, 74, '2019-08-02 09:06:48'),
(1007, '24/07/2018', '1', 145, 61, '2019-08-02 09:06:48'),
(1009, '24/07/2018', '1', 130, 92, '2019-08-02 09:06:48'),
(1008, '24/07/2018', '1', 146, 87, '2019-08-02 09:06:48'),
(1010, '24/07/2018', '1', 157, 85, '2019-08-02 09:06:48'),
(1011, '24/07/2018', '1', 149, 109, '2019-08-02 09:06:48'),
(1013, '24/07/2018', '1', 156, 49, '2019-08-02 09:06:48'),
(1014, '24/07/2018', '1', 129, 74, '2019-08-02 09:06:48'),
(1015, '24/07/2018', '1', 159, 61, '2019-08-02 09:06:48'),
(1016, '24/07/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(1017, '24/07/2018', '1', 129, 92, '2019-08-02 09:06:48'),
(1018, '24/07/2018', '1', 130, 36, '2019-08-02 09:06:48'),
(1020, '25/07/2018', '1', 130, 87, '2019-08-02 09:06:48'),
(1019, '25/07/2018', '1', 156, 61, '2019-08-02 09:06:48'),
(1021, '25/07/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(1022, '25/07/2018', '1', 157, 74, '2019-08-02 09:06:48'),
(1023, '25/07/2018', '1', 146, 109, '2019-08-02 09:06:48'),
(1024, '25/07/2018', '1', 130, 36, '2019-08-02 09:06:48'),
(1025, '25/07/2018', '1', 129, 49, '2019-08-02 09:06:48'),
(1026, '26/07/2018', '1', 146, 81, '2019-08-02 09:06:48'),
(1027, '26/07/2018', '1', 156, 106, '2019-08-02 09:06:48'),
(1028, '26/07/2018', '1', 130, 87, '2019-08-02 09:06:48'),
(1029, '26/07/2018', '1', 157, 61, '2019-08-02 09:06:48'),
(1030, '26/07/2018', '1', 149, 109, '2019-08-02 09:06:48'),
(1031, '26/07/2018', '1', 159, 98, '2019-08-02 09:06:48'),
(1032, '26/07/2018', '1', 129, 49, '2019-08-02 09:06:48'),
(1037, '27/07/2018', '1', 159, 70, '2019-08-02 09:06:48'),
(1033, '27/07/2018', '1', 145, 61, '2019-08-02 09:06:48'),
(1034, '27/07/2018', '1', 146, 87, '2019-08-02 09:06:48'),
(1035, '27/07/2018', '1', 156, 98, '2019-08-02 09:06:48'),
(1036, '27/07/2018', '1', 157, 107, '2019-08-02 09:06:48'),
(1038, '27/07/2018', '1', 129, 49, '2019-08-02 09:06:48'),
(1039, '29/07/2018', '1', 136, 87, '2019-08-02 09:06:48'),
(1040, '29/07/2018', '1', 136, 106, '2019-08-02 09:06:48'),
(1041, '30/07/2018', '1', 145, 61, '2019-08-02 09:06:48'),
(1042, '30/07/2018', '1', 149, 93, '2019-08-02 09:06:48'),
(1043, '30/07/2018', '1', 148, 87, '2019-08-02 09:06:48'),
(1044, '30/07/2018', '1', 144, 106, '2019-08-02 09:06:48'),
(1045, '30/07/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(1046, '30/07/2018', '1', 110, 85, '2019-08-02 09:06:48'),
(6, '31/07/2018', '1', 136, 87, '2019-08-02 09:06:48'),
(1, '31/07/2018', '1', 148, 61, '2019-08-02 09:06:48'),
(5, '31/07/2018', '1', 149, 93, '2019-08-02 09:06:48'),
(11, '01/08/2018', '1', 149, 64, '2019-08-02 09:06:48'),
(7, '31/07/2018', '1', 144, 87, '2019-08-02 09:06:48'),
(12, '01/08/2018', '1', 144, 64, '2019-08-02 09:06:48'),
(3, '31/07/2018', '1', 110, 107, '2019-08-02 09:06:48'),
(13, '01/08/2018', '1', 110, 56, '2019-08-02 09:06:48'),
(14, '01/08/2018', '1', 110, 107, '2019-08-02 09:06:48'),
(9, '01/08/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(4, '31/07/2018', '1', 156, 106, '2019-08-02 09:06:48'),
(8, '31/07/2018', '1', 148, 85, '2019-08-02 09:06:48'),
(15, '01/08/2018', '1', 110, 107, '2019-08-02 09:06:48'),
(16, '01/08/2018', '1', 110, 106, '2019-08-02 09:06:48'),
(2, '01/08/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(10, '01/08/2018', '1', 147, 62, '2019-08-02 09:06:48'),
(17, '01/08/2018', '1', 110, 107, '2019-08-02 09:06:48'),
(18, '02/08/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(19, '02/08/2018', '1', 157, 85, '2019-08-02 09:06:48'),
(20, '02/08/2018', '1', 156, 106, '2019-08-02 09:06:48'),
(21, '02/08/2018', '1', 148, 38, '2019-08-02 09:06:48'),
(22, '02/08/2018', '1', 147, 107, '2019-08-02 09:06:48'),
(23, '02/08/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(24, '03/08/2018', '1', 145, 56, '2019-08-02 09:06:48'),
(25, '03/08/2018', '1', 146, 85, '2019-08-02 09:06:48'),
(26, '03/08/2018', '1', 110, 107, '2019-08-02 09:06:48'),
(27, '03/08/2018', '1', 156, 106, '2019-08-02 09:06:48'),
(28, '03/08/2018', '1', 157, 64, '2019-08-02 09:06:48'),
(29, '03/08/2018', '1', 144, 82, '2019-08-02 09:06:48'),
(30, '06/08/2018', '1', 146, 106, '2019-08-02 09:06:48'),
(31, '06/08/2018', '1', 129, 107, '2019-08-02 09:06:48'),
(32, '06/08/2018', '1', 156, 64, '2019-08-02 09:06:48'),
(33, '06/08/2018', '1', 157, 84, '2019-08-02 09:06:48'),
(34, '06/08/2018', '1', 147, 47, '2019-08-02 09:06:48'),
(37, '08/08/2018', '1', 157, 55, '2019-08-02 09:06:48'),
(35, '08/08/2018', '1', 145, 106, '2019-08-02 09:06:48'),
(36, '08/08/2018', '1', 146, 47, '2019-08-02 09:06:48'),
(38, '08/08/2018', '1', 129, 64, '2019-08-02 09:06:48'),
(39, '08/08/2018', '1', 129, 55, '2019-08-02 09:06:48'),
(43, '09/08/2018', '1', 147, 89, '2019-08-02 09:06:48'),
(40, '09/08/2018', '1', 145, 106, '2019-08-02 09:06:48'),
(41, '09/08/2018', '1', 146, 47, '2019-08-02 09:06:48'),
(42, '09/08/2018', '1', 129, 55, '2019-08-02 09:06:48'),
(44, '09/08/2018', '1', 156, 89, '2019-08-02 09:06:48'),
(45, '10/08/2018', '1', 145, 106, '2019-08-02 09:06:48'),
(46, '10/08/2018', '1', 129, 81, '2019-08-02 09:06:48'),
(47, '10/08/2018', '1', 157, 55, '2019-08-02 09:06:48'),
(48, '10/08/2018', '1', 146, 107, '2019-08-02 09:06:48'),
(49, '10/08/2018', '1', 148, 64, '2019-08-02 09:06:48'),
(54, '13/08/2018', '1', 147, 107, '2019-08-02 09:06:48'),
(50, '13/08/2018', '1', 145, 81, '2019-08-02 09:06:48'),
(51, '13/08/2018', '1', 130, 109, '2019-08-02 09:06:48'),
(52, '13/08/2018', '1', 146, 45, '2019-08-02 09:06:48'),
(53, '13/08/2018', '1', 159, 60, '2019-08-02 09:06:48'),
(55, '13/08/2018', '1', 80, 59, '2019-08-02 09:06:48'),
(56, '13/08/2018', '1', 148, 89, '2019-08-02 09:06:48'),
(63, '14/08/2018', '1', 80, 74, '2019-08-02 09:06:48'),
(57, '14/08/2018', '1', 145, 81, '2019-08-02 09:06:48'),
(58, '14/08/2018', '1', 146, 93, '2019-08-02 09:06:48'),
(59, '14/08/2018', '1', 130, 109, '2019-08-02 09:06:48'),
(60, '14/08/2018', '1', 159, 60, '2019-08-02 09:06:48'),
(61, '14/08/2018', '1', 148, 89, '2019-08-02 09:06:48'),
(62, '14/08/2018', '1', 147, 107, '2019-08-02 09:06:48'),
(65, '15/08/2018', '1', 130, 60, '2019-08-02 09:06:48'),
(64, '15/08/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(66, '15/08/2018', '1', 159, 93, '2019-08-02 09:06:48'),
(67, '15/08/2018', '1', 148, 82, '2019-08-02 09:06:48'),
(68, '15/08/2018', '1', 130, 56, '2019-08-02 09:06:48'),
(69, '15/08/2018', '1', 80, 107, '2019-08-02 09:06:48'),
(70, '16/08/2018', '1', 130, 109, '2019-08-02 09:06:48'),
(71, '16/08/2018', '1', 136, 46, '2019-08-02 09:06:48'),
(72, '16/08/2018', '1', 159, 45, '2019-08-02 09:06:48'),
(73, '16/08/2018', '1', 130, 56, '2019-08-02 09:06:48'),
(74, '16/08/2018', '1', 148, 81, '2019-08-02 09:06:48'),
(75, '16/08/2018', '1', 147, 107, '2019-08-02 09:06:48'),
(76, '16/08/2018', '1', 80, 109, '2019-08-02 09:06:48'),
(78, '17/08/2018', '1', 156, 109, '2019-08-02 09:06:48'),
(77, '17/08/2018', '1', 145, 81, '2019-08-02 09:06:48'),
(79, '17/08/2018', '1', 156, 107, '2019-08-02 09:06:48'),
(80, '17/08/2018', '1', 130, 109, '2019-08-02 09:06:48'),
(81, '17/08/2018', '1', 136, 45, '2019-08-02 09:06:48'),
(82, '17/08/2018', '1', 159, 60, '2019-08-02 09:06:48'),
(83, '17/08/2018', '1', 147, 35, '2019-08-02 09:06:48'),
(87, '21/08/2018', '1', 129, 92, '2019-08-02 09:06:48'),
(84, '21/08/2018', '1', 159, 77, '2019-08-02 09:06:48'),
(85, '21/08/2018', '1', 145, 36, '2019-08-02 09:06:48'),
(86, '21/08/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(88, '21/08/2018', '1', 136, 92, '2019-08-02 09:06:48'),
(89, '22/08/2018', '1', 145, 77, '2019-08-02 09:06:48'),
(90, '22/08/2018', '1', 136, 92, '2019-08-02 09:06:48'),
(94, '23/08/2018', '1', 156, 76, '2019-08-02 09:06:48'),
(96, '23/08/2018', '1', 147, 76, '2019-08-02 09:06:48'),
(91, '23/08/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(92, '23/08/2018', '1', 136, 83, '2019-08-02 09:06:48'),
(93, '23/08/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(95, '23/08/2018', '1', 156, 36, '2019-08-02 09:06:48'),
(98, '24/08/2018', '1', 149, 109, '2019-08-02 09:06:48'),
(97, '24/08/2018', '1', 145, 89, '2019-08-02 09:06:48'),
(99, '24/08/2018', '1', 129, 92, '2019-08-02 09:06:48'),
(101, '27/08/2018', '1', 136, 41, '2019-08-02 09:06:48'),
(100, '27/08/2018', '1', 146, 36, '2019-08-02 09:06:48'),
(102, '27/08/2018', '1', 146, 36, '2019-08-02 09:06:48'),
(103, '28/08/2018', '1', 136, 41, '2019-08-02 09:06:48'),
(104, '28/08/2018', '1', 146, 108, '2019-08-02 09:06:48'),
(105, '28/08/2018', '1', 156, 95, '2019-08-02 09:06:48'),
(106, '28/08/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(107, '28/08/2018', '1', 159, 55, '2019-08-02 09:06:48'),
(108, '29/08/2018', '1', 146, 55, '2019-08-02 09:06:48'),
(109, '29/08/2018', '1', 156, 50, '2019-08-02 09:06:48'),
(110, '30/08/2018', '1', 136, 109, '2019-08-02 09:06:48'),
(111, '30/08/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(112, '30/08/2018', '1', 148, 48, '2019-08-02 09:06:48'),
(113, '30/08/2018', '1', 110, 50, '2019-08-02 09:06:48'),
(114, '31/08/2018', '1', 136, 109, '2019-08-02 09:06:48'),
(115, '31/08/2018', '1', 146, 48, '2019-08-02 09:06:48'),
(116, '31/08/2018', '1', 110, 50, '2019-08-02 09:06:48'),
(117, '31/08/2018', '1', 109, 83, '2019-08-02 09:06:48'),
(118, '31/08/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(119, '03/09/2018', '1', 136, 50, '2019-08-02 09:06:48'),
(120, '03/09/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(121, '03/09/2018', '1', 146, 57, '2019-08-02 09:06:48'),
(122, '03/09/2018', '1', 142, 109, '2019-08-02 09:06:48'),
(123, '03/09/2018', '1', 129, 93, '2019-08-02 09:06:48'),
(124, '03/09/2018', '1', 130, 36, '2019-08-02 09:06:48'),
(125, '03/09/2018', '1', 109, 83, '2019-08-02 09:06:48'),
(129, '04/09/2018', '1', 159, 85, '2019-08-02 09:06:48'),
(131, '04/09/2018', '1', 149, 93, '2019-08-02 09:06:48'),
(132, '04/09/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(126, '04/09/2018', '1', 136, 89, '2019-08-02 09:06:48'),
(127, '04/09/2018', '1', 146, 74, '2019-08-02 09:06:48'),
(128, '04/09/2018', '1', 156, 95, '2019-08-02 09:06:48'),
(130, '04/09/2018', '1', 85, 103, '2019-08-02 09:06:48'),
(133, '04/09/2018', '1', 149, 93, '2019-08-02 09:06:48'),
(134, '04/09/2018', '1', 144, 85, '2019-08-02 09:06:48'),
(135, '05/09/2018', '1', 145, 103, '2019-08-02 09:06:48'),
(136, '05/09/2018', '1', 146, 93, '2019-08-02 09:06:48'),
(137, '05/09/2018', '1', 156, 85, '2019-08-02 09:06:48'),
(138, '05/09/2018', '1', 149, 109, '2019-08-02 09:06:48'),
(139, '05/09/2018', '1', 144, 81, '2019-08-02 09:06:48'),
(140, '05/09/2018', '1', 149, 55, '2019-08-02 09:06:48'),
(141, '05/09/2018', '1', 130, 36, '2019-08-02 09:06:48'),
(144, '06/09/2018', '1', 130, 81, '2019-08-02 09:06:48'),
(142, '06/09/2018', '1', 146, 68, '2019-08-02 09:06:48'),
(143, '06/09/2018', '1', 159, 93, '2019-08-02 09:06:48'),
(145, '06/09/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(146, '06/09/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(147, '06/09/2018', '1', 144, 85, '2019-08-02 09:06:48'),
(150, '07/09/2018', '1', 156, 81, '2019-08-02 09:06:48'),
(148, '06/09/2018', '1', 146, 93, '2019-08-02 09:06:48'),
(149, '07/09/2018', '1', 136, 68, '2019-08-02 09:06:48'),
(151, '07/09/2018', '1', 156, 81, '2019-08-02 09:06:48'),
(152, '07/09/2018', '1', 160, 85, '2019-08-02 09:06:48'),
(153, '07/09/2018', '1', 149, 109, '2019-08-02 09:06:48'),
(154, '07/09/2018', '1', 144, 83, '2019-08-02 09:06:48'),
(157, '10/09/2018', '1', 110, 56, '2019-08-02 09:06:48'),
(155, '10/09/2018', '1', 146, 46, '2019-08-02 09:06:48'),
(156, '10/09/2018', '1', 142, 93, '2019-08-02 09:06:48'),
(158, '10/09/2018', '1', 110, 85, '2019-08-02 09:06:48'),
(159, '10/09/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(160, '10/09/2018', '1', 157, 89, '2019-08-02 09:06:48'),
(161, '10/09/2018', '1', 156, 74, '2019-08-02 09:06:48'),
(162, '10/09/2018', '1', 157, 89, '2019-08-02 09:06:48'),
(163, '11/09/2018', '1', 136, 46, '2019-08-02 09:06:48'),
(164, '11/09/2018', '1', 146, 93, '2019-08-02 09:06:48'),
(165, '11/09/2018', '1', 142, 56, '2019-08-02 09:06:48'),
(166, '11/09/2018', '1', 149, 107, '2019-08-02 09:06:48'),
(167, '11/09/2018', '1', 156, 81, '2019-08-02 09:06:48'),
(168, '11/09/2018', '1', 160, 109, '2019-08-02 09:06:48'),
(171, '12/09/2018', '1', 142, 46, '2019-08-02 09:06:48'),
(176, '12/09/2018', '1', 142, 85, '2019-08-02 09:06:48'),
(169, '12/09/2018', '1', 136, 93, '2019-08-02 09:06:48'),
(170, '12/09/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(172, '12/09/2018', '1', 110, 86, '2019-08-02 09:06:48'),
(173, '12/09/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(174, '12/09/2018', '1', 157, 48, '2019-08-02 09:06:48'),
(175, '12/09/2018', '1', 156, 41, '2019-08-02 09:06:48'),
(177, '12/09/2018', '1', 142, 109, '2019-08-02 09:06:48'),
(178, '13/09/2018', '1', 136, 41, '2019-08-02 09:06:48'),
(179, '13/09/2018', '1', 110, 93, '2019-08-02 09:06:48'),
(180, '13/09/2018', '1', 159, 46, '2019-08-02 09:06:48'),
(181, '13/09/2018', '1', 149, 83, '2019-08-02 09:06:48'),
(182, '13/09/2018', '1', 157, 92, '2019-08-02 09:06:48'),
(183, '13/09/2018', '1', 142, 109, '2019-08-02 09:06:48'),
(184, '14/09/2018', '1', 136, 93, '2019-08-02 09:06:48'),
(185, '14/09/2018', '1', 146, 96, '2019-08-02 09:06:48'),
(186, '14/09/2018', '1', 142, 95, '2019-08-02 09:06:48'),
(187, '14/09/2018', '1', 159, 46, '2019-08-02 09:06:48'),
(188, '14/09/2018', '1', 110, 92, '2019-08-02 09:06:48'),
(189, '14/09/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(190, '14/09/2018', '1', 144, 41, '2019-08-02 09:06:48'),
(191, '14/09/2018', '1', 156, 109, '2019-08-02 09:06:48'),
(192, '15/09/2018', '1', 159, 109, '2019-08-02 09:06:48'),
(193, '17/09/2018', '1', 136, 109, '2019-08-02 09:06:48'),
(194, '17/09/2018', '1', 146, 93, '2019-08-02 09:06:48'),
(195, '17/09/2018', '1', 130, 36, '2019-08-02 09:06:48'),
(196, '17/09/2018', '1', 149, 89, '2019-08-02 09:06:48'),
(197, '18/09/2018', '1', 136, 109, '2019-08-02 09:06:48'),
(198, '18/09/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(199, '18/09/2018', '1', 147, 109, '2019-08-02 09:06:48'),
(200, '18/09/2018', '1', 144, 76, '2019-08-02 09:06:48'),
(201, '18/09/2018', '1', 130, 36, '2019-08-02 09:06:48'),
(202, '19/09/2018', '1', 130, 109, '2019-08-02 09:06:48'),
(203, '19/09/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(204, '19/09/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(205, '19/09/2018', '1', 156, 74, '2019-08-02 09:06:48'),
(206, '19/09/2018', '1', 129, 77, '2019-08-02 09:06:48'),
(207, '19/09/2018', '1', 144, 89, '2019-08-02 09:06:48'),
(208, '19/09/2018', '1', 130, 36, '2019-08-02 09:06:48'),
(209, '20/09/2018', '1', 130, 86, '2019-08-02 09:06:48'),
(210, '20/09/2018', '1', 129, 109, '2019-08-02 09:06:48'),
(211, '20/09/2018', '1', 149, 77, '2019-08-02 09:06:48'),
(212, '20/09/2018', '1', 144, 89, '2019-08-02 09:06:48'),
(213, '20/09/2018', '1', 147, 107, '2019-08-02 09:06:48'),
(216, '21/09/2018', '1', 149, 98, '2019-08-02 09:06:48'),
(218, '21/09/2018', '1', 73, 56, '2019-08-02 09:06:48'),
(214, '21/09/2018', '1', 130, 86, '2019-08-02 09:06:48'),
(215, '21/09/2018', '1', 129, 109, '2019-08-02 09:06:48'),
(217, '21/09/2018', '1', 149, 98, '2019-08-02 09:06:48'),
(219, '21/09/2018', '1', 144, 46, '2019-08-02 09:06:48'),
(220, '22/09/2018', '1', 161, 109, '2019-08-02 09:06:48'),
(221, '22/09/2018', '1', 161, 108, '2019-08-02 09:06:48'),
(222, '22/09/2018', '1', 161, 109, '2019-08-02 09:06:48'),
(223, '24/09/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(224, '24/09/2018', '1', 146, 46, '2019-08-02 09:06:48'),
(225, '24/09/2018', '1', 157, 108, '2019-08-02 09:06:48'),
(226, '24/09/2018', '1', 159, 55, '2019-08-02 09:06:48'),
(227, '24/09/2018', '1', 149, 87, '2019-08-02 09:06:48'),
(228, '24/09/2018', '1', 110, 57, '2019-08-02 09:06:48'),
(229, '25/09/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(230, '25/09/2018', '1', 110, 57, '2019-08-02 09:06:48'),
(231, '25/09/2018', '1', 142, 108, '2019-08-02 09:06:48'),
(232, '25/09/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(233, '25/09/2018', '1', 147, 55, '2019-08-02 09:06:48'),
(234, '25/09/2018', '1', 149, 93, '2019-08-02 09:06:48'),
(237, '26/09/2018', '1', 149, 55, '2019-08-02 09:06:48'),
(235, '26/09/2018', '1', 157, 108, '2019-08-02 09:06:48'),
(236, '26/09/2018', '1', 156, 36, '2019-08-02 09:06:48'),
(238, '26/09/2018', '1', 160, 109, '2019-08-02 09:06:48'),
(239, '26/09/2018', '1', 146, 95, '2019-08-02 09:06:48'),
(240, '26/09/2018', '1', 147, 59, '2019-08-02 09:06:48'),
(241, '26/09/2018', '1', 110, 74, '2019-08-02 09:06:48'),
(242, '26/09/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(243, '27/09/2018', '1', 146, 55, '2019-08-02 09:06:48'),
(244, '27/09/2018', '1', 156, 109, '2019-08-02 09:06:48'),
(245, '27/09/2018', '1', 159, 93, '2019-08-02 09:06:48'),
(246, '27/09/2018', '1', 149, 108, '2019-08-02 09:06:48'),
(247, '27/09/2018', '1', 147, 107, '2019-08-02 09:06:48'),
(248, '27/09/2018', '1', 160, 36, '2019-08-02 09:06:48'),
(249, '27/09/2018', '1', 144, 59, '2019-08-02 09:06:48'),
(254, '28/09/2018', '1', 149, 41, '2019-08-02 09:06:48'),
(253, '28/09/2018', '1', 159, 59, '2019-08-02 09:06:48'),
(250, '28/09/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(251, '28/09/2018', '1', 157, 108, '2019-08-02 09:06:48'),
(252, '28/09/2018', '1', 146, 93, '2019-08-02 09:06:48'),
(255, '28/09/2018', '1', 110, 85, '2019-08-02 09:06:48'),
(256, '28/09/2018', '1', 147, 37, '2019-08-02 09:06:48'),
(257, '28/09/2018', '1', 149, 38, '2019-08-02 09:06:48'),
(258, '29/09/2018', '1', 161, 109, '2019-08-02 09:06:48'),
(259, '01/10/2018', '1', 146, 46, '2019-08-02 09:06:48'),
(260, '01/10/2018', '1', 130, 56, '2019-08-02 09:06:48'),
(261, '01/10/2018', '1', 149, 68, '2019-08-02 09:06:48'),
(262, '01/10/2018', '1', 147, 108, '2019-08-02 09:06:48'),
(263, '01/10/2018', '1', 129, 50, '2019-08-02 09:06:48'),
(264, '01/10/2018', '1', 144, 85, '2019-08-02 09:06:48'),
(265, '01/10/2018', '1', 129, 77, '2019-08-02 09:06:48'),
(266, '01/10/2018', '1', 129, 109, '2019-08-02 09:06:48'),
(267, '02/10/2018', '1', 146, 68, '2019-08-02 09:06:48'),
(268, '02/10/2018', '1', 130, 50, '2019-08-02 09:06:48'),
(269, '02/10/2018', '1', 156, 109, '2019-08-02 09:06:48'),
(270, '02/10/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(271, '02/10/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(272, '02/10/2018', '1', 144, 85, '2019-08-02 09:06:48'),
(273, '02/10/2018', '1', 162, 82, '2019-08-02 09:06:48'),
(274, '03/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(275, '03/10/2018', '1', 146, 82, '2019-08-02 09:06:48'),
(276, '03/10/2018', '1', 130, 106, '2019-08-02 09:06:48'),
(277, '03/10/2018', '1', 156, 76, '2019-08-02 09:06:48'),
(278, '03/10/2018', '1', 149, 81, '2019-08-02 09:06:48'),
(279, '03/10/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(280, '03/10/2018', '1', 144, 68, '2019-08-02 09:06:48'),
(281, '04/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(282, '04/10/2018', '1', 130, 106, '2019-08-02 09:06:48'),
(283, '04/10/2018', '1', 136, 82, '2019-08-02 09:06:48'),
(284, '04/10/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(285, '04/10/2018', '1', 144, 68, '2019-08-02 09:06:48'),
(290, '05/10/2018', '1', 144, 108, '2019-08-02 09:06:48'),
(288, '05/10/2018', '1', 156, 49, '2019-08-02 09:06:48'),
(286, '05/10/2018', '1', 145, 76, '2019-08-02 09:06:48'),
(287, '05/10/2018', '1', 130, 47, '2019-08-02 09:06:48'),
(289, '05/10/2018', '1', 149, 68, '2019-08-02 09:06:48'),
(291, '08/10/2018', '1', 145, 76, '2019-08-02 09:06:48'),
(292, '08/10/2018', '1', 146, 82, '2019-08-02 09:06:48'),
(293, '08/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(294, '08/10/2018', '1', 149, 68, '2019-08-02 09:06:48'),
(295, '08/10/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(296, '08/10/2018', '1', 156, 76, '2019-08-02 09:06:48'),
(297, '08/10/2018', '1', 110, 47, '2019-08-02 09:06:48'),
(298, '08/10/2018', '1', 160, 77, '2019-08-02 09:06:48'),
(299, '09/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(300, '09/10/2018', '1', 145, 86, '2019-08-02 09:06:48'),
(301, '09/10/2018', '1', 110, 47, '2019-08-02 09:06:48'),
(302, '09/10/2018', '1', 149, 68, '2019-08-02 09:06:48'),
(303, '09/10/2018', '1', 142, 82, '2019-08-02 09:06:48'),
(304, '09/10/2018', '1', 147, 95, '2019-08-02 09:06:48');
INSERT INTO `tb_temp_usuario_logs` (`id_temp_log`, `fecha`, `estado`, `id_usuario`, `id_espacio`, `date`) VALUES
(305, '10/10/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(306, '10/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(307, '10/10/2018', '1', 110, 76, '2019-08-02 09:06:48'),
(308, '10/10/2018', '1', 142, 68, '2019-08-02 09:06:48'),
(309, '10/10/2018', '1', 149, 46, '2019-08-02 09:06:48'),
(310, '10/10/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(311, '11/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(312, '11/10/2018', '1', 142, 82, '2019-08-02 09:06:48'),
(313, '11/10/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(314, '11/10/2018', '1', 110, 47, '2019-08-02 09:06:48'),
(315, '12/10/2018', '1', 145, 38, '2019-08-02 09:06:48'),
(316, '12/10/2018', '1', 149, 46, '2019-08-02 09:06:48'),
(317, '12/10/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(318, '12/10/2018', '1', 142, 68, '2019-08-02 09:06:48'),
(319, '12/10/2018', '1', 110, 109, '2019-08-02 09:06:48'),
(324, '16/10/2018', '1', 80, 108, '2019-08-02 09:06:48'),
(320, '16/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(321, '16/10/2018', '1', 130, 37, '2019-08-02 09:06:48'),
(322, '16/10/2018', '1', 149, 68, '2019-08-02 09:06:48'),
(323, '16/10/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(326, '17/10/2018', '1', 130, 108, '2019-08-02 09:06:48'),
(325, '17/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(327, '17/10/2018', '1', 149, 68, '2019-08-02 09:06:48'),
(328, '18/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(329, '18/10/2018', '1', 130, 59, '2019-08-02 09:06:48'),
(330, '18/10/2018', '1', 146, 82, '2019-08-02 09:06:48'),
(331, '18/10/2018', '1', 149, 64, '2019-08-02 09:06:48'),
(333, '19/10/2018', '1', 130, 85, '2019-08-02 09:06:48'),
(334, '19/10/2018', '1', 130, 85, '2019-08-02 09:06:48'),
(332, '19/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(335, '19/10/2018', '1', 146, 82, '2019-08-02 09:06:48'),
(336, '19/10/2018', '1', 130, 59, '2019-08-02 09:06:48'),
(337, '19/10/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(338, '19/10/2018', '1', 147, 68, '2019-08-02 09:06:48'),
(340, '22/10/2018', '1', 146, 108, '2019-08-02 09:06:48'),
(339, '22/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(341, '22/10/2018', '1', 157, 85, '2019-08-02 09:06:48'),
(342, '22/10/2018', '1', 149, 81, '2019-08-02 09:06:48'),
(343, '22/10/2018', '1', 162, 107, '2019-08-02 09:06:48'),
(344, '22/10/2018', '1', 156, 91, '2019-08-02 09:06:48'),
(345, '22/10/2018', '1', 142, 89, '2019-08-02 09:06:48'),
(346, '22/10/2018', '1', 146, 59, '2019-08-02 09:06:48'),
(350, '23/10/2018', '1', 149, 81, '2019-08-02 09:06:48'),
(347, '23/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(348, '23/10/2018', '1', 142, 98, '2019-08-02 09:06:48'),
(349, '23/10/2018', '1', 157, 85, '2019-08-02 09:06:48'),
(351, '23/10/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(352, '23/10/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(5, '24/10/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(3, '24/10/2018', '1', 157, 85, '2019-08-02 09:06:48'),
(12, '25/10/2018', '1', 157, 91, '2019-08-02 09:06:48'),
(6, '24/10/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(14, '25/10/2018', '1', 149, 35, '2019-08-02 09:06:48'),
(1, '24/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(9, '25/10/2018', '1', 145, 81, '2019-08-02 09:06:48'),
(7, '24/10/2018', '1', 156, 49, '2019-08-02 09:06:48'),
(17, '25/10/2018', '1', 156, 35, '2019-08-02 09:06:48'),
(2, '24/10/2018', '1', 110, 107, '2019-08-02 09:06:48'),
(19, '25/10/2018', '1', 110, 35, '2019-08-02 09:06:48'),
(22, '25/10/2018', '1', 154, 107, '2019-08-02 09:06:48'),
(21, '25/10/2018', '1', 110, 47, '2019-08-02 09:06:48'),
(4, '24/10/2018', '1', 142, 98, '2019-08-02 09:06:48'),
(11, '25/10/2018', '1', 142, 46, '2019-08-02 09:06:48'),
(20, '25/10/2018', '1', 145, 86, '2019-08-02 09:06:48'),
(8, '24/10/2018', '1', 146, 67, '2019-08-02 09:06:48'),
(10, '25/10/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(15, '25/10/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(18, '25/10/2018', '1', 156, 81, '2019-08-02 09:06:48'),
(13, '25/10/2018', '1', 157, 85, '2019-08-02 09:06:48'),
(16, '25/10/2018', '1', 162, 91, '2019-08-02 09:06:48'),
(24, '26/10/2018', '1', 146, 35, '2019-08-02 09:06:48'),
(23, '26/10/2018', '1', 145, 107, '2019-08-02 09:06:48'),
(25, '26/10/2018', '1', 156, 91, '2019-08-02 09:06:48'),
(26, '26/10/2018', '1', 110, 85, '2019-08-02 09:06:48'),
(27, '26/10/2018', '1', 146, 46, '2019-08-02 09:06:48'),
(28, '26/10/2018', '1', 144, 103, '2019-08-02 09:06:48'),
(29, '26/10/2018', '1', 162, 98, '2019-08-02 09:06:48'),
(30, '26/10/2018', '1', 149, 81, '2019-08-02 09:06:48'),
(31, '26/10/2018', '1', 142, 35, '2019-08-02 09:06:48'),
(35, '29/10/2018', '1', 130, 76, '2019-08-02 09:06:48'),
(32, '29/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(33, '29/10/2018', '1', 147, 103, '2019-08-02 09:06:48'),
(34, '29/10/2018', '1', 154, 98, '2019-08-02 09:06:48'),
(36, '29/10/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(37, '29/10/2018', '1', 162, 77, '2019-08-02 09:06:48'),
(38, '29/10/2018', '1', 144, 91, '2019-08-02 09:06:48'),
(45, '30/10/2018', '1', 129, 74, '2019-08-02 09:06:48'),
(47, '30/10/2018', '1', 160, 51, '2019-08-02 09:06:48'),
(39, '30/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(40, '30/10/2018', '1', 156, 91, '2019-08-02 09:06:48'),
(41, '30/10/2018', '1', 130, 103, '2019-08-02 09:06:48'),
(42, '30/10/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(43, '30/10/2018', '1', 162, 98, '2019-08-02 09:06:48'),
(44, '30/10/2018', '1', 147, 35, '2019-08-02 09:06:48'),
(46, '30/10/2018', '1', 109, 74, '2019-08-02 09:06:48'),
(48, '30/10/2018', '1', 160, 59, '2019-08-02 09:06:48'),
(54, '31/10/2018', '1', 147, 91, '2019-08-02 09:06:48'),
(51, '31/10/2018', '1', 130, 35, '2019-08-02 09:06:48'),
(49, '31/10/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(50, '31/10/2018', '1', 156, 85, '2019-08-02 09:06:48'),
(52, '31/10/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(53, '31/10/2018', '1', 160, 98, '2019-08-02 09:06:48'),
(55, '31/10/2018', '1', 130, 36, '2019-08-02 09:06:48'),
(56, '01/11/2018', '1', 145, 59, '2019-08-02 09:06:48'),
(57, '01/11/2018', '1', 145, 59, '2019-08-02 09:06:48'),
(58, '01/11/2018', '1', 130, 106, '2019-08-02 09:06:48'),
(59, '01/11/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(60, '01/11/2018', '1', 73, 98, '2019-08-02 09:06:48'),
(62, '02/11/2018', '1', 130, 109, '2019-08-02 09:06:48'),
(61, '02/11/2018', '1', 149, 103, '2019-08-02 09:06:48'),
(63, '02/11/2018', '1', 145, 85, '2019-08-02 09:06:48'),
(64, '02/11/2018', '1', 147, 95, '2019-08-02 09:06:48'),
(65, '02/11/2018', '1', 109, 74, '2019-08-02 09:06:48'),
(66, '06/11/2018', '1', 145, 93, '2019-08-02 09:06:48'),
(67, '06/11/2018', '1', 156, 91, '2019-08-02 09:06:48'),
(68, '06/11/2018', '1', 149, 83, '2019-08-02 09:06:48'),
(69, '06/11/2018', '1', 147, 73, '2019-08-02 09:06:48'),
(70, '07/11/2018', '1', 145, 73, '2019-08-02 09:06:48'),
(75, '07/11/2018', '1', 147, 109, '2019-08-02 09:06:48'),
(71, '07/11/2018', '1', 145, 93, '2019-08-02 09:06:48'),
(72, '07/11/2018', '1', 146, 73, '2019-08-02 09:06:48'),
(73, '07/11/2018', '1', 142, 83, '2019-08-02 09:06:48'),
(74, '07/11/2018', '1', 156, 91, '2019-08-02 09:06:48'),
(76, '07/11/2018', '1', 149, 77, '2019-08-02 09:06:48'),
(77, '07/11/2018', '1', 160, 109, '2019-08-02 09:06:48'),
(84, '08/11/2018', '1', 163, 74, '2019-08-02 09:06:48'),
(78, '08/11/2018', '1', 145, 109, '2019-08-02 09:06:48'),
(79, '08/11/2018', '1', 156, 91, '2019-08-02 09:06:48'),
(80, '08/11/2018', '1', 142, 93, '2019-08-02 09:06:48'),
(81, '08/11/2018', '1', 162, 73, '2019-08-02 09:06:48'),
(82, '08/11/2018', '1', 149, 83, '2019-08-02 09:06:48'),
(83, '08/11/2018', '1', 144, 56, '2019-08-02 09:06:48'),
(85, '08/11/2018', '1', 163, 74, '2019-08-02 09:06:48'),
(88, '09/11/2018', '1', 156, 91, '2019-08-02 09:06:48'),
(86, '09/11/2018', '1', 145, 93, '2019-08-02 09:06:48'),
(87, '09/11/2018', '1', 146, 73, '2019-08-02 09:06:48'),
(89, '09/11/2018', '1', 142, 83, '2019-08-02 09:06:48'),
(90, '09/11/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(91, '09/11/2018', '1', 162, 77, '2019-08-02 09:06:48'),
(92, '13/11/2018', '1', 146, 91, '2019-08-02 09:06:48'),
(93, '13/11/2018', '1', 130, 93, '2019-08-02 09:06:48'),
(94, '13/11/2018', '1', 156, 77, '2019-08-02 09:06:48'),
(95, '13/11/2018', '1', 157, 89, '2019-08-02 09:06:48'),
(96, '13/11/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(97, '14/11/2018', '1', 145, 93, '2019-08-02 09:06:48'),
(98, '14/11/2018', '1', 146, 91, '2019-08-02 09:06:48'),
(99, '14/11/2018', '1', 130, 106, '2019-08-02 09:06:48'),
(100, '14/11/2018', '1', 149, 89, '2019-08-02 09:06:48'),
(101, '14/11/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(102, '14/11/2018', '1', 162, 55, '2019-08-02 09:06:48'),
(104, '15/11/2018', '1', 156, 56, '2019-08-02 09:06:48'),
(107, '15/11/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(103, '15/11/2018', '1', 145, 93, '2019-08-02 09:06:48'),
(105, '15/11/2018', '1', 130, 91, '2019-08-02 09:06:48'),
(106, '15/11/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(108, '15/11/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(109, '16/11/2018', '1', 145, 93, '2019-08-02 09:06:48'),
(110, '16/11/2018', '1', 146, 91, '2019-08-02 09:06:48'),
(111, '16/11/2018', '1', 130, 56, '2019-08-02 09:06:48'),
(112, '16/11/2018', '1', 160, 109, '2019-08-02 09:06:48'),
(113, '16/11/2018', '1', 144, 74, '2019-08-02 09:06:48'),
(114, '16/11/2018', '1', 149, 89, '2019-08-02 09:06:48'),
(118, '19/11/2018', '1', 110, 91, '2019-08-02 09:06:48'),
(121, '19/11/2018', '1', 160, 77, '2019-08-02 09:06:48'),
(115, '19/11/2018', '1', 145, 93, '2019-08-02 09:06:48'),
(116, '19/11/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(117, '19/11/2018', '1', 142, 68, '2019-08-02 09:06:48'),
(119, '19/11/2018', '1', 162, 91, '2019-08-02 09:06:48'),
(120, '19/11/2018', '1', 144, 56, '2019-08-02 09:06:48'),
(122, '19/11/2018', '1', 160, 77, '2019-08-02 09:06:48'),
(123, '19/11/2018', '1', 156, 55, '2019-08-02 09:06:48'),
(124, '20/11/2018', '1', 145, 93, '2019-08-02 09:06:48'),
(125, '20/11/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(126, '20/11/2018', '1', 156, 91, '2019-08-02 09:06:48'),
(127, '20/11/2018', '1', 142, 68, '2019-08-02 09:06:48'),
(128, '20/11/2018', '1', 149, 76, '2019-08-02 09:06:48'),
(129, '20/11/2018', '1', 147, 85, '2019-08-02 09:06:48'),
(135, '21/11/2018', '1', 147, 35, '2019-08-02 09:06:48'),
(130, '21/11/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(131, '21/11/2018', '1', 110, 93, '2019-08-02 09:06:48'),
(132, '21/11/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(133, '21/11/2018', '1', 144, 68, '2019-08-02 09:06:48'),
(134, '21/11/2018', '1', 142, 91, '2019-08-02 09:06:48'),
(141, '22/11/2018', '1', 147, 74, '2019-08-02 09:06:48'),
(136, '22/11/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(137, '22/11/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(138, '22/11/2018', '1', 142, 93, '2019-08-02 09:06:48'),
(139, '22/11/2018', '1', 156, 91, '2019-08-02 09:06:48'),
(140, '22/11/2018', '1', 144, 68, '2019-08-02 09:06:48'),
(147, '23/11/2018', '1', 144, 35, '2019-08-02 09:06:48'),
(146, '23/11/2018', '1', 110, 91, '2019-08-02 09:06:48'),
(149, '23/11/2018', '1', 162, 35, '2019-08-02 09:06:48'),
(151, '23/11/2018', '1', 162, 91, '2019-08-02 09:06:48'),
(142, '23/11/2018', '1', 145, 93, '2019-08-02 09:06:48'),
(143, '23/11/2018', '1', 146, 89, '2019-08-02 09:06:48'),
(144, '23/11/2018', '1', 142, 68, '2019-08-02 09:06:48'),
(145, '23/11/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(148, '23/11/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(150, '23/11/2018', '1', 110, 74, '2019-08-02 09:06:48'),
(152, '23/11/2018', '1', 162, 91, '2019-08-02 09:06:48'),
(154, '26/11/2018', '1', 160, 35, '2019-08-02 09:06:48'),
(157, '26/11/2018', '1', 129, 109, '2019-08-02 09:06:48'),
(158, '26/11/2018', '1', 130, 91, '2019-08-02 09:06:48'),
(153, '26/11/2018', '1', 145, 108, '2019-08-02 09:06:48'),
(160, '26/11/2018', '1', 160, 76, '2019-08-02 09:06:48'),
(155, '26/11/2018', '1', 149, 93, '2019-08-02 09:06:48'),
(156, '26/11/2018', '1', 144, 89, '2019-08-02 09:06:48'),
(159, '26/11/2018', '1', 162, 98, '2019-08-02 09:06:48'),
(161, '26/11/2018', '1', 160, 109, '2019-08-02 09:06:48'),
(162, '26/11/2018', '1', 145, 86, '2019-08-02 09:06:48'),
(163, '26/11/2018', '1', 80, 76, '2019-08-02 09:06:48'),
(168, '27/11/2018', '1', 144, 108, '2019-08-02 09:06:48'),
(171, '27/11/2018', '1', 80, 35, '2019-08-02 09:06:48'),
(164, '27/11/2018', '1', 145, 93, '2019-08-02 09:06:48'),
(165, '27/11/2018', '1', 130, 109, '2019-08-02 09:06:48'),
(166, '27/11/2018', '1', 160, 85, '2019-08-02 09:06:48'),
(167, '27/11/2018', '1', 149, 98, '2019-08-02 09:06:48'),
(169, '27/11/2018', '1', 144, 91, '2019-08-02 09:06:48'),
(170, '27/11/2018', '1', 162, 108, '2019-08-02 09:06:48'),
(172, '27/11/2018', '1', 80, 35, '2019-08-02 09:06:48'),
(173, '28/11/2018', '1', 130, 109, '2019-08-02 09:06:48'),
(174, '28/11/2018', '1', 149, 93, '2019-08-02 09:06:48'),
(175, '28/11/2018', '1', 144, 108, '2019-08-02 09:06:48'),
(176, '28/11/2018', '1', 162, 91, '2019-08-02 09:06:48'),
(177, '28/11/2018', '1', 160, 35, '2019-08-02 09:06:48'),
(179, '29/11/2018', '1', 130, 109, '2019-08-02 09:06:48'),
(178, '29/11/2018', '1', 145, 93, '2019-08-02 09:06:48'),
(180, '29/11/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(181, '29/11/2018', '1', 162, 108, '2019-08-02 09:06:48'),
(182, '29/11/2018', '1', 144, 91, '2019-08-02 09:06:48'),
(183, '29/11/2018', '1', 160, 59, '2019-08-02 09:06:48'),
(188, '30/11/2018', '1', 144, 108, '2019-08-02 09:06:48'),
(184, '30/11/2018', '1', 145, 93, '2019-08-02 09:06:48'),
(185, '30/11/2018', '1', 160, 59, '2019-08-02 09:06:48'),
(186, '30/11/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(187, '30/11/2018', '1', 130, 56, '2019-08-02 09:06:48'),
(189, '30/11/2018', '1', 162, 109, '2019-08-02 09:06:48'),
(190, '30/11/2018', '1', 144, 91, '2019-08-02 09:06:48'),
(194, '03/12/2018', '1', 162, 55, '2019-08-02 09:06:48'),
(191, '03/12/2018', '1', 145, 91, '2019-08-02 09:06:48'),
(192, '03/12/2018', '1', 142, 56, '2019-08-02 09:06:48'),
(193, '03/12/2018', '1', 160, 85, '2019-08-02 09:06:48'),
(195, '03/12/2018', '1', 110, 55, '2019-08-02 09:06:48'),
(196, '04/12/2018', '1', 145, 55, '2019-08-02 09:06:48'),
(202, '04/12/2018', '1', 145, 55, '2019-08-02 09:06:48'),
(204, '04/12/2018', '1', 162, 92, '2019-08-02 09:06:48'),
(197, '04/12/2018', '1', 160, 85, '2019-08-02 09:06:48'),
(198, '04/12/2018', '1', 142, 56, '2019-08-02 09:06:48'),
(199, '04/12/2018', '1', 149, 91, '2019-08-02 09:06:48'),
(200, '04/12/2018', '1', 109, 79, '2019-08-02 09:06:48'),
(201, '04/12/2018', '1', 144, 74, '2019-08-02 09:06:48'),
(203, '04/12/2018', '1', 147, 55, '2019-08-02 09:06:48'),
(205, '04/12/2018', '1', 162, 47, '2019-08-02 09:06:48'),
(206, '05/12/2018', '1', 145, 85, '2019-08-02 09:06:48'),
(207, '05/12/2018', '1', 146, 55, '2019-08-02 09:06:48'),
(208, '05/12/2018', '1', 142, 56, '2019-08-02 09:06:48'),
(209, '05/12/2018', '1', 149, 91, '2019-08-02 09:06:48'),
(210, '05/12/2018', '1', 110, 70, '2019-08-02 09:06:48'),
(211, '06/12/2018', '1', 145, 85, '2019-08-02 09:06:48'),
(212, '06/12/2018', '1', 142, 55, '2019-08-02 09:06:48'),
(213, '06/12/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(214, '06/12/2018', '1', 110, 91, '2019-08-02 09:06:48'),
(215, '07/12/2018', '1', 145, 85, '2019-08-02 09:06:48'),
(216, '07/12/2018', '1', 142, 55, '2019-08-02 09:06:48'),
(217, '07/12/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(218, '07/12/2018', '1', 110, 91, '2019-08-02 09:06:48'),
(219, '07/12/2018', '1', 160, 98, '2019-08-02 09:06:48'),
(220, '07/12/2018', '1', 156, 81, '2019-08-02 09:06:48'),
(221, '10/12/2018', '1', 145, 91, '2019-08-02 09:06:48'),
(222, '10/12/2018', '1', 146, 91, '2019-08-02 09:06:48'),
(223, '10/12/2018', '1', 149, 55, '2019-08-02 09:06:48'),
(224, '11/12/2018', '1', 145, 55, '2019-08-02 09:06:48'),
(228, '11/12/2018', '1', 109, 79, '2019-08-02 09:06:48'),
(226, '11/12/2018', '1', 144, 109, '2019-08-02 09:06:48'),
(229, '12/12/2018', '1', 145, 55, '2019-08-02 09:06:48'),
(233, '13/12/2018', '1', 145, 36, '2019-08-02 09:06:48'),
(225, '11/12/2018', '1', 146, 91, '2019-08-02 09:06:48'),
(230, '12/12/2018', '1', 146, 79, '2019-08-02 09:06:48'),
(227, '11/12/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(231, '12/12/2018', '1', 149, 46, '2019-08-02 09:06:48'),
(232, '13/12/2018', '1', 149, 56, '2019-08-02 09:06:48'),
(234, '14/12/2018', '1', 149, 106, '2019-08-02 09:06:48'),
(239, '17/12/2018', '1', 147, 108, '2019-08-02 09:06:48'),
(236, '17/12/2018', '1', 146, 91, '2019-08-02 09:06:48'),
(238, '17/12/2018', '1', 149, 84, '2019-08-02 09:06:48'),
(240, '18/12/2018', '1', 149, 108, '2019-08-02 09:06:48'),
(237, '17/12/2018', '1', 142, 56, '2019-08-02 09:06:48'),
(235, '17/12/2018', '1', 144, 85, '2019-08-02 09:06:48'),
(243, '18/12/2018', '1', 144, 91, '2019-08-02 09:06:48'),
(242, '18/12/2018', '1', 147, 108, '2019-08-02 09:06:48'),
(241, '18/12/2018', '1', 149, 55, '2019-08-02 09:06:48'),
(245, '19/12/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(247, '19/12/2018', '1', 144, 85, '2019-08-02 09:06:48'),
(246, '19/12/2018', '1', 147, 108, '2019-08-02 09:06:48'),
(252, '20/12/2018', '1', 147, 91, '2019-08-02 09:06:48'),
(244, '19/12/2018', '1', 142, 37, '2019-08-02 09:06:48'),
(248, '19/12/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(249, '19/12/2018', '1', 149, 85, '2019-08-02 09:06:48'),
(253, '20/12/2018', '1', 147, 108, '2019-08-02 09:06:48'),
(250, '20/12/2018', '1', 142, 70, '2019-08-02 09:06:48'),
(251, '20/12/2018', '1', 149, 79, '2019-08-02 09:06:48'),
(254, '20/12/2018', '1', 110, 107, '2019-08-02 09:06:48'),
(259, '21/12/2018', '1', 160, 37, '2019-08-02 09:06:48'),
(257, '21/12/2018', '1', 144, 55, '2019-08-02 09:06:48'),
(255, '21/12/2018', '1', 142, 70, '2019-08-02 09:06:48'),
(256, '21/12/2018', '1', 147, 108, '2019-08-02 09:06:48'),
(258, '21/12/2018', '1', 162, 91, '2019-08-02 09:06:48'),
(260, '21/12/2018', '1', 160, 37, '2019-08-02 09:06:48'),
(261, '21/12/2018', '1', 144, 79, '2019-08-02 09:06:48'),
(262, '26/12/2018', '1', 144, 91, '2019-08-02 09:06:48'),
(263, '26/12/2018', '1', 162, 37, '2019-08-02 09:06:48'),
(264, '26/12/2018', '1', 147, 107, '2019-08-02 09:06:48'),
(269, '27/12/2018', '1', 164, 77, '2019-08-02 09:06:48'),
(267, '27/12/2018', '1', 147, 106, '2019-08-02 09:06:48'),
(265, '27/12/2018', '1', 160, 47, '2019-08-02 09:06:48'),
(266, '27/12/2018', '1', 144, 107, '2019-08-02 09:06:48'),
(268, '27/12/2018', '1', 162, 46, '2019-08-02 09:06:48'),
(270, '28/12/2018', '1', 147, 70, '2019-08-02 09:06:48'),
(271, '28/12/2018', '1', 162, 77, '2019-08-02 09:06:48'),
(272, '28/12/2018', '1', 144, 46, '2019-08-02 09:06:48'),
(273, '28/12/2018', '1', 149, 37, '2019-08-02 09:06:48'),
(274, '02/01/2019', '1', 144, 46, '2019-08-02 09:06:48'),
(275, '02/01/2019', '1', 162, 109, '2019-08-02 09:06:48'),
(276, '02/01/2019', '1', 160, 77, '2019-08-02 09:06:48'),
(277, '03/01/2019', '1', 160, 109, '2019-08-02 09:06:48'),
(278, '03/01/2019', '1', 156, 106, '2019-08-02 09:06:48'),
(279, '03/01/2019', '1', 149, 77, '2019-08-02 09:06:48'),
(280, '03/01/2019', '1', 162, 60, '2019-08-02 09:06:48'),
(281, '03/01/2019', '1', 144, 46, '2019-08-02 09:06:48'),
(282, '04/01/2019', '1', 156, 56, '2019-08-02 09:06:48'),
(283, '04/01/2019', '1', 144, 109, '2019-08-02 09:06:48'),
(284, '04/01/2019', '1', 149, 60, '2019-08-02 09:06:48'),
(285, '08/01/2019', '1', 160, 109, '2019-08-02 09:06:48'),
(286, '08/01/2019', '1', 156, 56, '2019-08-02 09:06:48'),
(287, '08/01/2019', '1', 157, 77, '2019-08-02 09:06:48'),
(288, '08/01/2019', '1', 144, 65, '2019-08-02 09:06:48'),
(289, '08/01/2019', '1', 147, 106, '2019-08-02 09:06:48'),
(290, '08/01/2019', '1', 145, 86, '2019-08-02 09:06:48'),
(291, '09/01/2019', '1', 145, 106, '2019-08-02 09:06:48'),
(292, '09/01/2019', '1', 160, 109, '2019-08-02 09:06:48'),
(293, '09/01/2019', '1', 142, 65, '2019-08-02 09:06:48'),
(294, '09/01/2019', '1', 144, 77, '2019-08-02 09:06:48'),
(295, '09/01/2019', '1', 162, 47, '2019-08-02 09:06:48'),
(296, '09/01/2019', '1', 145, 86, '2019-08-02 09:06:48'),
(301, '10/01/2019', '1', 147, 106, '2019-08-02 09:06:48'),
(297, '10/01/2019', '1', 157, 47, '2019-08-02 09:06:48'),
(298, '10/01/2019', '1', 156, 56, '2019-08-02 09:06:48'),
(299, '10/01/2019', '1', 142, 65, '2019-08-02 09:06:48'),
(300, '10/01/2019', '1', 144, 77, '2019-08-02 09:06:48'),
(302, '10/01/2019', '1', 160, 109, '2019-08-02 09:06:48'),
(303, '10/01/2019', '1', 145, 86, '2019-08-02 09:06:48'),
(306, '11/01/2019', '1', 110, 109, '2019-08-02 09:06:48'),
(304, '11/01/2019', '1', 142, 65, '2019-08-02 09:06:48'),
(305, '11/01/2019', '1', 156, 47, '2019-08-02 09:06:48'),
(307, '11/01/2019', '1', 147, 70, '2019-08-02 09:06:48'),
(308, '11/01/2019', '1', 110, 106, '2019-08-02 09:06:48'),
(309, '11/01/2019', '1', 144, 77, '2019-08-02 09:06:48'),
(311, '14/01/2019', '1', 147, 77, '2019-08-02 09:06:48'),
(310, '14/01/2019', '1', 130, 65, '2019-08-02 09:06:48'),
(312, '14/01/2019', '1', 129, 109, '2019-08-02 09:06:48'),
(313, '15/01/2019', '1', 146, 109, '2019-08-02 09:06:48'),
(314, '15/01/2019', '1', 130, 65, '2019-08-02 09:06:48'),
(315, '15/01/2019', '1', 144, 77, '2019-08-02 09:06:48'),
(318, '16/01/2019', '1', 145, 45, '2019-08-02 09:06:48'),
(316, '16/01/2019', '1', 146, 109, '2019-08-02 09:06:48'),
(317, '16/01/2019', '1', 147, 77, '2019-08-02 09:06:48'),
(319, '16/01/2019', '1', 162, 45, '2019-08-02 09:06:48'),
(321, '17/01/2019', '1', 146, 77, '2019-08-02 09:06:48'),
(323, '17/01/2019', '1', 146, 35, '2019-08-02 09:06:48'),
(325, '17/01/2019', '1', 158, 35, '2019-08-02 09:06:48'),
(320, '17/01/2019', '1', 156, 109, '2019-08-02 09:06:48'),
(322, '17/01/2019', '1', 160, 45, '2019-08-02 09:06:48'),
(324, '17/01/2019', '1', 130, 56, '2019-08-02 09:06:48'),
(326, '17/01/2019', '1', 145, 35, '2019-08-02 09:06:48'),
(327, '18/01/2019', '1', 145, 35, '2019-08-02 09:06:48'),
(328, '21/01/2019', '1', 146, 35, '2019-08-02 09:06:48'),
(332, '21/01/2019', '1', 158, 45, '2019-08-02 09:06:48'),
(331, '21/01/2019', '1', 149, 98, '2019-08-02 09:06:48'),
(333, '21/01/2019', '1', 110, 70, '2019-08-02 09:06:48'),
(329, '21/01/2019', '1', 142, 91, '2019-08-02 09:06:48'),
(330, '21/01/2019', '1', 146, 35, '2019-08-02 09:06:48'),
(334, '21/01/2019', '1', 144, 45, '2019-08-02 09:06:48'),
(335, '21/01/2019', '1', 158, 109, '2019-08-02 09:06:48'),
(336, '21/01/2019', '1', 149, 98, '2019-08-02 09:06:48'),
(343, '22/01/2019', '1', 147, 45, '2019-08-02 09:06:48'),
(344, '22/01/2019', '1', 147, 45, '2019-08-02 09:06:48'),
(345, '22/01/2019', '1', 147, 45, '2019-08-02 09:06:48'),
(339, '22/01/2019', '1', 149, 35, '2019-08-02 09:06:48'),
(347, '22/01/2019', '1', 164, 45, '2019-08-02 09:06:48'),
(346, '22/01/2019', '1', 149, 35, '2019-08-02 09:06:48'),
(337, '22/01/2019', '1', 146, 109, '2019-08-02 09:06:48'),
(338, '22/01/2019', '1', 142, 91, '2019-08-02 09:06:48'),
(340, '22/01/2019', '1', 138, 56, '2019-08-02 09:06:48'),
(341, '22/01/2019', '1', 136, 77, '2019-08-02 09:06:48'),
(342, '22/01/2019', '1', 144, 68, '2019-08-02 09:06:48'),
(348, '22/01/2019', '1', 149, 81, '2019-08-02 09:06:48'),
(5, '17/03/2019', '1', 107, 70, '2019-08-02 09:06:48'),
(1, '17/03/2019', '1', 132, 91, '2019-08-02 09:06:48'),
(2, '17/03/2019', '1', 79, 45, '2019-08-02 09:06:48'),
(3, '17/03/2019', '1', 93, 109, '2019-08-02 09:06:48'),
(4, '17/03/2019', '1', 101, 35, '2019-08-02 09:06:48'),
(6, '17/03/2019', '1', 75, 98, '2019-08-02 09:06:48'),
(7, '17/03/2019', '1', 144, 70, '2019-08-02 09:06:48'),
(8, '17/03/2019', '1', 144, 70, '2019-08-02 09:06:48'),
(9, '17/03/2019', '1', 144, 81, '2019-08-02 09:06:48'),
(10, '17/03/2019', '1', 144, 81, '2019-08-02 09:06:48'),
(11, '17/03/2019', '1', 144, 81, '2019-08-02 09:06:48'),
(12, '17/03/2019', '1', 144, 81, '2019-08-02 09:06:48'),
(13, '17/03/2019', '1', 144, 81, '2019-08-02 09:06:48'),
(14, '17/03/2019', '1', 163, 81, '2019-08-02 09:06:48'),
(15, '19/03/2019', '1', 144, 60, '2019-08-02 09:06:48'),
(16, '19/03/2019', '1', 144, 60, '2019-08-02 09:06:48'),
(17, '19/03/2019', '1', 163, 81, '2019-08-02 09:06:48'),
(18, '19/03/2019', '1', 164, 81, '2019-08-02 09:06:48'),
(19, '19/03/2019', '1', 144, 64, '2019-08-02 09:06:48'),
(20, '19/03/2019', '1', 163, 60, '2019-08-02 09:06:48'),
(21, '19/03/2019', '1', 164, 81, '2019-08-02 09:06:48'),
(22, '19/03/2019', '1', 164, 61, '2019-08-02 09:06:48'),
(23, '25/03/2019', '1', 144, 35, '2019-08-02 09:06:48'),
(24, '25/03/2019', '1', 148, 81, '2019-08-02 09:06:48'),
(25, '25/03/2019', '1', 144, 35, '2019-08-02 09:06:48'),
(26, '25/03/2019', '1', 148, 81, '2019-08-02 09:06:48'),
(27, '25/03/2019', '1', 144, 35, '2019-08-02 09:06:48'),
(28, '26/03/2019', '1', 142, 108, '2019-08-02 09:06:48'),
(29, '26/03/2019', '1', 158, 108, '2019-08-02 09:06:48'),
(30, '26/03/2019', '1', 156, 108, '2019-08-02 09:06:48'),
(31, '26/03/2019', '1', 142, 108, '2019-08-02 09:06:48'),
(32, '26/03/2019', '1', 158, 60, '2019-08-02 09:06:48'),
(33, '26/03/2019', '1', 156, 108, '2019-08-02 09:06:48'),
(34, '07/04/2019', '1', 144, 108, '2019-08-02 09:06:48'),
(35, '07/04/2019', '1', 145, 64, '2019-08-02 09:06:48'),
(36, '07/04/2019', '1', 144, 108, '2019-08-02 09:06:48'),
(37, '07/04/2019', '1', 145, 64, '2019-08-02 09:06:48'),
(38, '07/04/2019', '1', 144, 108, '2019-08-02 09:06:48'),
(39, '07/04/2019', '1', 145, 64, '2019-08-02 09:06:48'),
(40, '07/04/2019', '1', 144, 108, '2019-08-02 09:06:48'),
(41, '07/04/2019', '1', 145, 64, '2019-08-02 09:06:48'),
(42, '07/04/2019', '1', 146, 35, '2019-08-02 09:06:48'),
(43, '07/04/2019', '1', 144, 108, '2019-08-02 09:06:48'),
(44, '07/04/2019', '1', 145, 64, '2019-08-02 09:06:48'),
(45, '07/04/2019', '1', 146, 35, '2019-08-02 09:06:48'),
(46, '07/04/2019', '1', 144, 64, '2019-08-02 09:06:48'),
(47, '07/04/2019', '1', 145, 108, '2019-08-02 09:06:48'),
(48, '07/04/2019', '1', 146, 64, '2019-08-02 09:06:48'),
(49, '07/04/2019', '1', 144, 64, '2019-08-02 09:06:48'),
(50, '07/04/2019', '1', 145, 108, '2019-08-02 09:06:48'),
(51, '07/04/2019', '1', 146, 64, '2019-08-02 09:06:48'),
(52, '07/04/2019', '1', 145, 35, '2019-08-02 09:06:48'),
(53, '07/04/2019', '1', 144, 108, '2019-08-02 09:06:48'),
(1, '18/04/2019', '1', 144, 81, '2019-08-02 09:06:48'),
(2, '18/04/2019', '1', 142, 81, '2019-08-02 09:06:48'),
(3, '18/04/2019', '1', 144, 81, '2019-08-02 09:06:48'),
(4, '18/04/2019', '1', 142, 81, '2019-08-02 09:06:48'),
(1, '18/06/2019', '1', 145, 81, '2019-08-02 09:06:48'),
(2, '18/06/2019', '1', 145, 81, '2019-08-02 09:06:48'),
(4, '19/06/2019', '1', 146, 81, '2019-08-02 09:06:48'),
(3, '18/06/2019', '1', 145, 81, '2019-08-02 09:06:48'),
(7, '19/06/2019', '1', 143, 108, '2019-08-02 09:06:48'),
(5, '19/06/2019', '1', 146, 81, '2019-08-02 09:06:48'),
(6, '19/06/2019', '1', 142, 81, '2019-08-02 09:06:48'),
(7, '21/06/2019', '1', 142, 81, '2019-08-02 09:06:48'),
(8, '21/06/2019', '1', 143, 81, '2019-08-02 09:06:48'),
(9, '21/06/2019', '1', 142, 81, '2019-08-02 09:06:48'),
(10, '21/06/2019', '1', 142, 81, '2019-08-02 09:06:48'),
(11, '24/06/2019', '1', 145, 81, '2019-08-02 09:06:48'),
(12, '24/06/2019', '1', 145, 35, '2019-08-02 09:06:48'),
(13, '24/06/2019', '1', 145, 35, '2019-08-02 09:06:48'),
(14, '24/06/2019', '1', 145, 81, '2019-08-02 09:06:48'),
(16, '24/06/2019', '1', 145, 81, '2019-08-02 09:06:48'),
(15, '24/06/2019', '1', 145, 35, '2019-08-02 09:06:48'),
(1, '02/07/2019', '1', 148, 81, '2019-08-02 09:06:48'),
(2, '11/07/2019', '1', 145, 81, '2019-08-02 09:06:47'),
(3, '11/07/2019', '1', 142, 81, '2019-08-02 09:06:47'),
(4, '02/08/2019', '1', 156, 81, '2019-08-02 09:20:28'),
(5, '02/08/2019', '1', 156, 81, '2019-08-02 09:26:25'),
(1, '04/08/2019', '1', 145, 81, '2019-08-04 17:13:07'),
(1, '10/10/2019', '1', 144, 81, '2019-10-10 21:15:25'),
(2, '10/10/2019', '1', 148, 81, '2019-10-10 21:35:14'),
(3, '10/10/2019', '1', 148, 81, '2019-10-10 21:45:09'),
(4, '10/10/2019', '1', 144, 74, '2019-10-10 21:45:09'),
(5, '12/10/2019', '1', 174, 81, '2019-10-12 17:54:50'),
(6, '14/10/2019', '1', 143, 81, '2019-10-14 16:05:15'),
(7, '14/10/2019', '1', 175, 81, '2019-10-14 17:53:07'),
(8, '14/10/2019', '1', 175, 81, '2019-10-14 17:57:09'),
(9, '14/10/2019', '1', 174, 81, '2019-10-14 18:03:18'),
(10, '14/10/2019', '1', 175, 107, '2019-10-14 18:07:06'),
(11, '14/10/2019', '1', 175, 107, '2019-10-14 18:13:09'),
(12, '14/10/2019', '1', 176, 107, '2019-10-14 18:13:10'),
(13, '14/10/2019', '1', 174, 81, '2019-10-14 18:18:45'),
(14, '04/12/2019', '1', 74, 40, '2019-12-04 14:36:48'),
(16, '04/12/2019', '1', 95, 81, '2019-12-04 14:39:43'),
(18, '04/12/2019', '1', 95, 53, '2019-12-04 15:15:03'),
(19, '04/12/2019', '1', 95, 53, '2019-12-04 15:31:43'),
(20, '04/12/2019', '1', 95, 53, '2019-12-04 15:33:15'),
(15, '04/12/2019', '1', 67, 40, '2019-12-04 14:36:50'),
(17, '04/12/2019', '1', 74, 53, '2019-12-04 14:45:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_usuario`
--

CREATE TABLE `tb_usuario` (
  `id_usuario` int(11) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `clave` varchar(245) DEFAULT NULL,
  `img` varchar(245) DEFAULT NULL,
  `nombre` varchar(145) DEFAULT NULL,
  `apellido` varchar(145) DEFAULT NULL,
  `token` longtext,
  `rol` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_edificio` int(11) NOT NULL,
  `prioridad` int(11) DEFAULT '3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_usuario`
--

INSERT INTO `tb_usuario` (`id_usuario`, `email`, `clave`, `img`, `nombre`, `apellido`, `token`, `rol`, `estado`, `id_edificio`, `prioridad`) VALUES
(67, 'acano', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'ABELINO CANO ', 'RUIZ ANDRES', '', 3, 1, 1, 3),
(68, 'alguerrero', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'AIDA LUZ ', 'GUERRERO RADA ', '', 2, 1, 1, 3),
(69, 'aguerrero', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'ALCIDES', ' GUERRERO GAVIRIA ', NULL, 2, 1, 1, 3),
(70, 'avargas', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'ALFREDO ', 'ENRIQUE VARGAS RIOS ', NULL, 2, 1, 1, 3),
(71, 'aalvarez', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'ALICIA ', 'ALVAREZ BELTRAN', NULL, 2, 1, 1, 0),
(72, 'aospino', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'ALVARO DE JESUS ', 'OSPINO RAMOS ', NULL, 4, 1, 1, 3),
(73, 'aillera', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'ANDREA', 'ILLERA LARA', NULL, 4, 1, 1, 3),
(74, 'adelarosa', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'ARACELLYS LILIAN ', 'DE LA ROSA ENAMORADO', '', 3, 1, 1, 3),
(75, 'adelacruz', 'e3320d50ef8bb2a1631a1fc9346b8273', 'user.png', 'ARMANDO MARIO ', 'DE LA CRUZ CARMONA', NULL, 2, 1, 1, 3),
(76, 'bmaldonado', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'BEATRIZ ELENA ', 'MALDONADO VERA ', NULL, 2, 1, 1, 3),
(77, 'bzurbaran', 'd8a71a01a7dd1ebc847b8eb827278dd0', 'user.png', 'BEATRIZ ELVIRA ', 'ZURBARAN BARRIOS ', NULL, 2, 1, 1, 3),
(78, 'brodriguez', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'BRENDA ', 'RODRIGUEZ TOVAR ', NULL, 2, 1, 1, 3),
(79, 'clinero', 'c33367701511b4f6020ec61ded352059', 'user.png', 'CARLOS ALBERTO ', 'LINERO SERRANO ', NULL, 2, 1, 1, 3),
(80, 'cnino', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'CARLOS ANTONIO ', 'NInO MORALES ', NULL, 4, 1, 1, 3),
(81, 'ccuadrado', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'CHEMMY ANTONIO ', 'CUADRADO ACOSTA', NULL, 2, 1, 1, 3),
(82, 'cmillan', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'CLAUDIA LILIANA  ', 'MILLAN DURAN', NULL, 2, 1, 1, 3),
(83, 'cmoros', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'CLAUDIA MARGARITA ', 'MOROS REYES ', NULL, 2, 1, 1, 3),
(84, 'cpalma', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'CLAUDIA PATRICIA ', 'PALMA OROZCO ', NULL, 2, 1, 1, 3),
(85, 'crgomez', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'CRISTINA PAOLA ', 'GOMEZ VILLARREAL', NULL, 4, 1, 1, 3),
(86, 'ddelvalle', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'DAMARIS DEL ', 'VALLE SOTO', '', 2, 1, 1, 3),
(87, 'dosorio', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'DOMINGO RAFAEL ', 'OSORIO TORRES ', NULL, 2, 1, 1, 3),
(88, 'evilla', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'EDDIE DANILO ', 'VILLA GUTIERREZ ', NULL, 2, 1, 1, 3),
(89, 'etorres', '7b55f59d034002b5fdb7eee735c8846f', 'user.png', 'ERICK IVAN ', 'TORRES CALLE ', NULL, 4, 1, 1, 3),
(90, 'esaavedra', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'ESTELA DEL ROSARIO  ', 'SAAVEDRA GUZMAN', NULL, 2, 1, 1, 3),
(91, 'fperez', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'FABIAN GUSTAVO ', 'PEREZ RADA ', NULL, 2, 1, 1, 3),
(92, 'frodas', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'FANNY LEONOR ', 'RODAS DIAZ GRANADOS ', NULL, 2, 1, 1, 3),
(93, 'fmontoya', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'FERNAN ', 'MONTOYA ZULUAGA ', NULL, 2, 1, 1, 3),
(94, 'faarroyo', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'FRANKLIN ALBERTO ', 'ARROYO ANDRADE', NULL, 4, 1, 1, 3),
(95, 'gsanchez', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'GLADYS ESTHER ', 'SANCHEZ PERALES ', '', 3, 1, 1, 3),
(96, 'gcastro', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'GLADYS MARIA ', 'CASTRO BAYO', NULL, 2, 1, 1, 3),
(97, 'gnule', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'GUIDO ALBERTO ', 'NULE AMIN ', NULL, 2, 1, 1, 3),
(98, 'hsantodomingo', 'c33367701511b4f6020ec61ded352059', 'user.png', 'HECTOR EMILIO ', 'SANTODOMINGO OCHOA ', NULL, 2, 1, 1, 3),
(99, 'hagualimpia', 'f67be88e479f0e9991e0b652966af27b', 'user.png', 'HELMER ANTONIO ', 'AGUALIMPIA DUALIBY', NULL, 2, 1, 1, 3),
(100, 'hrojas', 'bb48679790431c22eda53bf67bf32704', 'user.png', 'HUGO ', 'ROJAS MEJIA ', NULL, 2, 1, 1, 3),
(101, 'Iturno', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'INGENIERO ', 'DE TURNO', NULL, 2, 1, 1, 3),
(102, 'Ialvarez', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'INGRID LILIANA ', 'ALVAREZ PRADA', NULL, 2, 1, 1, 3),
(103, 'Igarcia', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'ISABEL CRISTINA ', 'GARCIA OCAMPO', NULL, 2, 1, 1, 3),
(104, 'Isilva', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'ISMAEL ENRIQUE ', 'SILVA GOMEZ ', NULL, 2, 1, 1, 3),
(105, 'jsuarez', 'cae9fb77357a98291573cc71fb2f660a', 'user.png', 'JACOBO EDUARDO ', 'SUAREZ TAVERA', NULL, 2, 1, 1, 3),
(106, 'jfernandez', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'JAIRO ENRIQUE ', 'FERNANDEZ FANDINO', '', 2, 1, 1, 3),
(107, 'jsalazar', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'JAIRO ', 'SALAZAR PEREZ', '', 2, 1, 1, 3),
(108, 'jromero', 'c33367701511b4f6020ec61ded352059', 'user.png', 'JAIRO SIGIFREDO ', 'ROMERO MORA ', NULL, 2, 1, 1, 3),
(109, 'jcoronado', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'JEFERSON ISAAC ', 'CORONADO CASTANO', NULL, 4, 1, 1, 3),
(110, 'jmeek', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'JOHANA ', 'MEEK BEJARANO ', NULL, 4, 1, 1, 3),
(111, 'jrico', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'JOSE  RAFAEL ', 'RICO SALCEDO ', NULL, 4, 1, 1, 3),
(112, 'jpalma', '06f34114e73791be999e3d13029d9901', 'user.png', 'JOSE DAVID', 'PALMA VANEGAS ', NULL, 2, 1, 1, 3),
(113, 'jdelahoz', '01cfcd4f6b8770febfb40cb906715822', 'user.png', 'JUAN DE DIOS ', 'DE LA HOZ CANO', NULL, 2, 1, 1, 3),
(114, 'jonate', '48eaf86cabe56564dd3b8f051cdf53fc', 'user.png', 'JUAN MANUEL ', 'OnATE MORA ', NULL, 2, 1, 1, 3),
(115, 'jpombo', 'bd3342d1a024b28e5e1f9c9b812b14d2', 'user.png', 'JULIO CESAR ', 'POMBO ACEVEDO ', NULL, 2, 1, 1, 3),
(116, 'kalvarez', '25d55ad283aa400af464c76d713c07ad', 'user.png', 'KETTY ALVAREZ ', 'HERNANDEZ', NULL, 2, 1, 1, 3),
(117, 'lramirez', 'af3587b377e4bd80cd73b59ff534cef8', 'user.png', 'LUIS CARLOS ', 'RAMIREZ PERNETT ', NULL, 2, 1, 1, 3),
(118, 'lposada', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'LUIS ROBERTO ', 'POSADA SANCHEZ ', NULL, 2, 1, 1, 3),
(119, 'lbetancourt', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'LUZ ELENA ', 'BETANCOURT HENAO', NULL, 2, 1, 1, 3),
(120, 'mbarona', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'MARGARITA ROSA ', 'BARONA TABOADA', NULL, 2, 1, 1, 3),
(121, 'mpalacio', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'MARIA REGINA ', 'PALACIO SILVA ', NULL, 2, 1, 1, 3),
(122, 'mljimenez', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'MARTHA LUZ ', 'JIMENEZ GOMEZ ', NULL, 2, 1, 1, 3),
(123, 'mcarrizosa', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'MIGUEL ANGEL ', 'CARRIZOSA SANTOS', NULL, 2, 1, 1, 3),
(124, 'mcastro', '228a2a2fb81e5797c575fb02883dedeb', 'user.png', 'MISAEL EDUARDO ', 'CASTRO SIMANCA', NULL, 2, 1, 1, 3),
(125, 'mparra', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'MONICA MILENA ', 'PARRA RIOBO ', NULL, 2, 1, 1, 3),
(126, 'nvecchio', 'cee8d6b7ce52554fd70354e37bbf44a2', 'user.png', 'NATIVIDAD DE JESUS ', 'VECCHIO GUZMAN ', NULL, 2, 1, 1, 3),
(127, 'ooyola', 'd8ae5776067290c4712fa454006c8ec6', 'user.png', 'OLGA GUILLERMINA ', 'OYOLA ZARANTE ', NULL, 2, 1, 1, 3),
(128, 'odiaz', 'fd2a3077d841e6750545ba3fce5752f8', 'user.png', 'OMAR JOSE ', 'DIAZ APARICIO', NULL, 2, 1, 1, 3),
(129, 'oblanco', 'befe9f8a14346e3e52c762f333395796', 'user.png', 'ORLANDO ANDRES ', 'BLANCO BOHORQUEZ', NULL, 4, 1, 1, 3),
(130, 'omeza', '7f2e8e1e8c2d00de2438e1a3a5febc55', 'user.png', 'OSCAR DAVID ', 'MEZA NOVOA ', NULL, 4, 1, 1, 3),
(131, 'ojimenez', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'OSCAR JOSE ', 'JIMENEZ ANGULO ', NULL, 2, 1, 1, 3),
(132, 'pcordero', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'PEDRO ANTONIO ', 'CORDERO OSORIO ', NULL, 2, 1, 1, 3),
(133, 'pllanos', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'PEDRO REMBERTO ', 'LLANOS HERRERA', NULL, 2, 1, 1, 3),
(134, 'rgarcia', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'ROBERTO ANTONIO ', 'GARCIA RIASCOS', '', 2, 1, 1, 3),
(135, 'rsmit', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'RODOLFO BERNARDO ', 'SMIT KINDERMANN ', NULL, 2, 1, 1, 3),
(136, 'rfreja', '85c11f7658074cd78599292c056131e5', 'user.png', 'RODOLFO MIGUEL ', 'FREJA DE LA HOZ', NULL, 4, 1, 1, 3),
(137, 'rcastillo', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'ROGERS RAFAEL ', 'CASTILLO TORRES', NULL, 4, 1, 1, 3),
(138, 'rroa', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'RONALD JOAQUIN ', 'ROA JACOBS ', NULL, 4, 1, 1, 3),
(139, 'rinsignares', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'RUBEN DARIO ', 'INSIGNARES RESTREPO', NULL, 2, 1, 1, 3),
(140, 'tbarraza', 'd8578edf8458ce06fbc5bb76a58c5ca4', 'user.png', 'TELMA LETICIA ', 'BARRAZA OLAYA', '', 2, 1, 1, 3),
(141, 'xpuche', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'XIOMARA PATRICIA ', 'PUCHE LACHARME ', 'fb175834-d0c9-4d86-a697-67eb887ffe7b', 2, 1, 1, 3),
(142, 'manaya', 'e10adc3949ba59abbe56e057f20f883e', 'user.pnG', 'Maria Carolina', 'Anaya Saade', 'fb175834-d0c9-4d86-a697-67eb887ffe7b', 3, 1, 1, 3),
(143, 'jcantillo', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'Juan Daniel', 'Cantillo Acosta', '', 3, 1, 1, 3),
(144, 'cortega', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'Camilo Andres', 'Ortega Lopez', '', 3, 1, 1, 3),
(145, 'mvergara', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'Maria Beatriz', 'Vergara Ochoa', 'fb175834-d0c9-4d86-a697-67eb887ffe7b', 2, 1, 1, 3),
(146, 'rpabon', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'Ricardo Andres', 'Pabon Donado', '', 3, 1, 1, 3),
(147, 'cjulio', '01d8bae291b1e4724443375634ccfa0e', 'user.png', 'Carlos Eduardo', 'Julio Arteaga', NULL, 3, 1, 1, 3),
(148, 'fortiz', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'Farid', 'Ortiz Perea', '', 3, 1, 1, 3),
(149, 'est-sg', '21f0a76170dc8236be6c6c26b0ba812e', 'user.png', 'Jaime Orlando', 'Pedraza Cortes', NULL, 3, 1, 1, 3),
(151, 'admin', 'c1e6519b1db414000c5a95b519d573f3', 'user.png', 'Administrador', 'admin', NULL, 1, 1, 1, 3),
(152, 'est-abaste', 'd6cb8cd3865efb88b00869221bc4d5cf', 'user.png', 'Alejandro Mario', 'LLinas Simanca', NULL, 3, 1, 1, 3),
(153, 'allinas', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', ' ALEJANDRO MARIO', ' LLINÃS SIMANCA', NULL, 3, 1, 1, 3),
(154, 'est-comercial', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'Andrea Carolina', 'Silva Sandoval', NULL, 3, 1, 1, 3),
(155, 'vdelacruz', 'c4ca4238a0b923820dcc509a6f75849b', 'user.png', 'Victor', 'De la Cruz', NULL, 2, 1, 1, 3),
(156, 'lescano', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'Luis Carlos', 'Escano Rodriguez', '', 3, 1, 1, 3),
(157, 'jbarreto', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'Jose David', 'Barreto', NULL, 3, 1, 1, 3),
(158, 'ssierra', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'Saul Esteban', 'Sierra Asis', NULL, 3, 1, 1, 3),
(159, 'aquiroz', 'c33367701511b4f6020ec61ded352059', 'user.png', 'Alfredo Smith', 'Quiroz Madrigal', NULL, 3, 1, 1, 3),
(160, 'ntapia', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'NESTOR IVAN', 'TAPIA MEDINA ', NULL, 3, 1, 1, 3),
(161, 'lolaya', 'd8578edf8458ce06fbc5bb76a58c5ca4', 'user.png', 'Telma Leticia', 'Barraza Olaya', NULL, 3, 1, 1, 3),
(162, 'efherrera', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'EFRAIN JOSE', 'HERRERA RICAURTE', NULL, 3, 1, 1, 3),
(163, 'lmiranda', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'Leonel', 'Miranda', NULL, 3, 1, 1, 3),
(164, 'fpion', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'FUAD', 'PION PACHECO', NULL, 3, 1, 1, 3),
(165, 'jariza28', '38e55e849bd84feb15d9255aa6575fba', 'user.png', 'jeff', 'ariza', NULL, 3, 1, 1, 3),
(166, 'jariza296', '38e55e849bd84feb15d9255aa6575fba', 'user.png', 'jeff2', 'ariza', '', 3, 1, 1, 3),
(167, 'jariza28', '38e55e849bd84feb15d9255aa6575fba', 'user.png', 'jeff', 'ariza', NULL, 3, 1, 1, 3),
(168, 'jariza28', '38e55e849bd84feb15d9255aa6575fba', 'user.png', 'jeff', 'ariza', NULL, 3, 1, 1, 3),
(169, 'jariza28', '38e55e849bd84feb15d9255aa6575fba', 'user.png', 'jeff', 'ariza', NULL, 3, 1, 1, 3),
(170, 'jariza28', '38e55e849bd84feb15d9255aa6575fba', 'user.png', 'jeff', 'ariza', NULL, 3, 1, 1, 3),
(171, 'jariza28', '38e55e849bd84feb15d9255aa6575fba', 'user.png', 'jeff', 'ariza', NULL, 3, 1, 1, 3),
(172, 'jariza28', '38e55e849bd84feb15d9255aa6575fba', 'user.png', 'jeff', 'ariza', NULL, 3, 1, 1, 3),
(173, 'jeff', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'Jose', 'jariza28@outlook.com', NULL, 3, 1, 1, 0),
(174, 'Prueba', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'Jexc', 'Quiz', '', 3, 1, 1, 3),
(175, 'demo1', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'pedro', 'perez', '', 3, 1, 1, 0),
(176, 'demo2', 'e10adc3949ba59abbe56e057f20f883e', 'user.png', 'alan', 'jj', '', 4, 1, 1, 3);

-- --------------------------------------------------------

--
-- Estructura para la vista `calendariotodate`
--
DROP TABLE IF EXISTS `calendariotodate`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `calendariotodate`  AS  select `tb_calendario`.`id_calendario` AS `id_calendario`,str_to_date(concat(`tb_calendario`.`dia`,'/',`tb_calendario`.`mes`,'/',`tb_calendario`.`anio`),'%d/%m/%Y') AS `fecha`,`tb_calendario`.`horario` AS `horario`,`tb_calendario`.`id_espacio` AS `id_espacio`,`tb_espacio`.`numero` AS `espacio`,concat(`tb_usuario`.`nombre`,' ',`tb_usuario`.`apellido`) AS `nombre` from ((`tb_calendario` join `tb_espacio` on((`tb_calendario`.`id_espacio` = `tb_espacio`.`id_espacio`))) join `tb_usuario` on((`tb_espacio`.`id_usuario` = `tb_usuario`.`id_usuario`))) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `spacelibres`
--
DROP TABLE IF EXISTS `spacelibres`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `spacelibres`  AS  select `tb_espacio`.`id_espacio` AS `espacioid`,`tb_espacio`.`numero` AS `nombre`,`tb_espacio`.`id_piso` AS `idpiso`,`tb_bloque`.`id_bloque` AS `idbloque`,`tb_piso`.`numero` AS `nombrepiso`,`tb_calendario`.`dia` AS `dia`,`tb_calendario`.`mes` AS `mes`,`tb_calendario`.`anio` AS `anio`,`tb_calendario`.`horario` AS `hora`,`tb_edificio`.`id_edificio` AS `idedificio` from ((((`tb_calendario` join `tb_espacio` on((`tb_calendario`.`id_espacio` = `tb_espacio`.`id_espacio`))) join `tb_piso` on((`tb_piso`.`id_piso` = `tb_espacio`.`id_piso`))) join `tb_bloque` on((`tb_bloque`.`id_bloque` = `tb_piso`.`id_bloque`))) join `tb_edificio` on((`tb_edificio`.`id_edificio` = `tb_bloque`.`id_edificio`))) where ((not(`tb_espacio`.`id_espacio` in (select `tb_temp_usuario`.`id_espacio` from `tb_temp_usuario`))) and (`tb_espacio`.`estado` = 1)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tb_asignacion_reserva_temp`
--
ALTER TABLE `tb_asignacion_reserva_temp`
  ADD PRIMARY KEY (`id_asignacion_temp`);

--
-- Indices de la tabla `tb_bloque`
--
ALTER TABLE `tb_bloque`
  ADD PRIMARY KEY (`id_bloque`),
  ADD KEY `fk_tb_bloque_tb_edificio1_idx` (`id_edificio`);

--
-- Indices de la tabla `tb_calendario`
--
ALTER TABLE `tb_calendario`
  ADD PRIMARY KEY (`id_calendario`),
  ADD KEY `fk_tb_calendario_tb_espacio1_idx` (`id_espacio`);

--
-- Indices de la tabla `tb_edificio`
--
ALTER TABLE `tb_edificio`
  ADD PRIMARY KEY (`id_edificio`);

--
-- Indices de la tabla `tb_espacio`
--
ALTER TABLE `tb_espacio`
  ADD PRIMARY KEY (`id_espacio`),
  ADD KEY `fk_tb_espacio_tb_piso1_idx` (`id_piso`),
  ADD KEY `fk_tb_espacio_tb_usuario1_idx` (`id_usuario`);

--
-- Indices de la tabla `tb_millas`
--
ALTER TABLE `tb_millas`
  ADD PRIMARY KEY (`id_millas`),
  ADD KEY `fk_tb_millas_tb_usuario1_idx` (`tb_usuario_id_usuario`);

--
-- Indices de la tabla `tb_millas_redimidas`
--
ALTER TABLE `tb_millas_redimidas`
  ADD PRIMARY KEY (`id_redimidas`),
  ADD KEY `fk_tb_millas_redimidas_tb_usuario1_idx` (`id_usuario`),
  ADD KEY `fk_tb_millas_redimidas_tb_productos_millas1_idx` (`id_productos_millas`);

--
-- Indices de la tabla `tb_novedades`
--
ALTER TABLE `tb_novedades`
  ADD PRIMARY KEY (`id_novedad`);

--
-- Indices de la tabla `tb_parametros`
--
ALTER TABLE `tb_parametros`
  ADD PRIMARY KEY (`id_parametros`);

--
-- Indices de la tabla `tb_piso`
--
ALTER TABLE `tb_piso`
  ADD PRIMARY KEY (`id_piso`),
  ADD KEY `fk_tb_piso_tb_bloque1_idx` (`id_bloque`);

--
-- Indices de la tabla `tb_productos_millas`
--
ALTER TABLE `tb_productos_millas`
  ADD PRIMARY KEY (`id_productos_millas`);

--
-- Indices de la tabla `tb_reservas`
--
ALTER TABLE `tb_reservas`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `fk_tb_reservas_tb_usuario1_idx` (`tb_usuario_id_usuario`);

--
-- Indices de la tabla `tb_respuestas`
--
ALTER TABLE `tb_respuestas`
  ADD PRIMARY KEY (`id_respuesta`),
  ADD KEY `fk_tb_respuestas_tb_novedades1_idx` (`id_novedad`);

--
-- Indices de la tabla `tb_temp_usuario`
--
ALTER TABLE `tb_temp_usuario`
  ADD PRIMARY KEY (`id_temp`),
  ADD KEY `fk_tb_temp_usuario_tb_espacio1_idx` (`id_espacio`),
  ADD KEY `fk_tb_temp_usuario_tb_usuario1_idx` (`id_usuario`);

--
-- Indices de la tabla `tb_usuario`
--
ALTER TABLE `tb_usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `fk_tb_usuario_tb_edificio1_idx` (`id_edificio`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tb_asignacion_reserva_temp`
--
ALTER TABLE `tb_asignacion_reserva_temp`
  MODIFY `id_asignacion_temp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=312;

--
-- AUTO_INCREMENT de la tabla `tb_bloque`
--
ALTER TABLE `tb_bloque`
  MODIFY `id_bloque` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tb_calendario`
--
ALTER TABLE `tb_calendario`
  MODIFY `id_calendario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3732;

--
-- AUTO_INCREMENT de la tabla `tb_edificio`
--
ALTER TABLE `tb_edificio`
  MODIFY `id_edificio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_espacio`
--
ALTER TABLE `tb_espacio`
  MODIFY `id_espacio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT de la tabla `tb_millas`
--
ALTER TABLE `tb_millas`
  MODIFY `id_millas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT de la tabla `tb_millas_redimidas`
--
ALTER TABLE `tb_millas_redimidas`
  MODIFY `id_redimidas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `tb_novedades`
--
ALTER TABLE `tb_novedades`
  MODIFY `id_novedad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `tb_parametros`
--
ALTER TABLE `tb_parametros`
  MODIFY `id_parametros` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_piso`
--
ALTER TABLE `tb_piso`
  MODIFY `id_piso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tb_productos_millas`
--
ALTER TABLE `tb_productos_millas`
  MODIFY `id_productos_millas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_reservas`
--
ALTER TABLE `tb_reservas`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `tb_respuestas`
--
ALTER TABLE `tb_respuestas`
  MODIFY `id_respuesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_temp_usuario`
--
ALTER TABLE `tb_temp_usuario`
  MODIFY `id_temp` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_usuario`
--
ALTER TABLE `tb_usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=177;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tb_bloque`
--
ALTER TABLE `tb_bloque`
  ADD CONSTRAINT `fk_tb_bloque_tb_edificio1` FOREIGN KEY (`id_edificio`) REFERENCES `tb_edificio` (`id_edificio`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_calendario`
--
ALTER TABLE `tb_calendario`
  ADD CONSTRAINT `fk_tb_calendario_tb_espacio1` FOREIGN KEY (`id_espacio`) REFERENCES `tb_espacio` (`id_espacio`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_espacio`
--
ALTER TABLE `tb_espacio`
  ADD CONSTRAINT `fk_tb_espacio_tb_piso1` FOREIGN KEY (`id_piso`) REFERENCES `tb_piso` (`id_piso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_espacio_tb_usuario1` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_millas`
--
ALTER TABLE `tb_millas`
  ADD CONSTRAINT `fk_tb_millas_tb_usuario1` FOREIGN KEY (`tb_usuario_id_usuario`) REFERENCES `tb_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_millas_redimidas`
--
ALTER TABLE `tb_millas_redimidas`
  ADD CONSTRAINT `fk_tb_millas_redimidas_tb_productos_millas1` FOREIGN KEY (`id_productos_millas`) REFERENCES `tb_productos_millas` (`id_productos_millas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_millas_redimidas_tb_usuario1` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_piso`
--
ALTER TABLE `tb_piso`
  ADD CONSTRAINT `fk_tb_piso_tb_bloque1` FOREIGN KEY (`id_bloque`) REFERENCES `tb_bloque` (`id_bloque`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_reservas`
--
ALTER TABLE `tb_reservas`
  ADD CONSTRAINT `fk_tb_reservas_tb_usuario1` FOREIGN KEY (`tb_usuario_id_usuario`) REFERENCES `tb_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_respuestas`
--
ALTER TABLE `tb_respuestas`
  ADD CONSTRAINT `fk_tb_respuestas_tb_novedades1` FOREIGN KEY (`id_novedad`) REFERENCES `tb_novedades` (`id_novedad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_temp_usuario`
--
ALTER TABLE `tb_temp_usuario`
  ADD CONSTRAINT `fk_tb_temp_usuario_tb_espacio1` FOREIGN KEY (`id_espacio`) REFERENCES `tb_espacio` (`id_espacio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_temp_usuario_tb_usuario1` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_usuario`
--
ALTER TABLE `tb_usuario`
  ADD CONSTRAINT `fk_tb_usuario_tb_edificio1` FOREIGN KEY (`id_edificio`) REFERENCES `tb_edificio` (`id_edificio`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Base de datos: `douglas_bd`
--
CREATE DATABASE IF NOT EXISTS `douglas_bd` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `douglas_bd`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_bebidas`
--

CREATE TABLE `tb_bebidas` (
  `id_bebidas` int(11) NOT NULL,
  `nombre` varchar(145) NOT NULL,
  `descripcion` varchar(245) DEFAULT NULL,
  `valor` varchar(45) NOT NULL,
  `conenido` varchar(45) DEFAULT NULL,
  `eliminado` enum('SI','NO') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_bebidas`
--

INSERT INTO `tb_bebidas` (`id_bebidas`, `nombre`, `descripcion`, `valor`, `conenido`, `eliminado`) VALUES
(1, 'BEBIDA1', 'PRUEBA', '100', '300ML', 'NO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_cierre`
--

CREATE TABLE `tb_cierre` (
  `id_cierre` int(11) NOT NULL,
  `fecha_cierre` datetime DEFAULT NULL,
  `valor_tarjetas` varchar(45) DEFAULT NULL,
  `valor_efectivo` varchar(45) DEFAULT NULL,
  `notas` varchar(145) DEFAULT NULL,
  `cantidad_inicial` varchar(45) DEFAULT NULL,
  `total` varchar(45) DEFAULT NULL,
  `id_fac_imicial` varchar(45) DEFAULT NULL,
  `id_fac_final` varchar(45) DEFAULT NULL,
  `tb_user_id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_cierre`
--

INSERT INTO `tb_cierre` (`id_cierre`, `fecha_cierre`, `valor_tarjetas`, `valor_efectivo`, `notas`, `cantidad_inicial`, `total`, `id_fac_imicial`, `id_fac_final`, `tb_user_id_user`) VALUES
(1, '2013-12-11 16:12:42', '0', '0', 'prueba', '0', '0', '00000', '00001', 16),
(2, '2018-12-20 11:12:35', '600', '800', '', '0', '1400', '00002', '00010', 16),
(3, '2019-01-10 16:01:40', '900', '100', '', '0', '1000', '00011', '00014', 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_cliente`
--

CREATE TABLE `tb_cliente` (
  `id_cliente` int(11) NOT NULL,
  `cedula` varchar(45) NOT NULL,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_cliente`
--

INSERT INTO `tb_cliente` (`id_cliente`, `cedula`, `nombres`, `apellidos`, `telefono`) VALUES
(1, 'NINGUNO', 'NINGUNO', 'NINGUNO', 'NINGUNO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_detalle_factura`
--

CREATE TABLE `tb_detalle_factura` (
  `canidad` int(11) NOT NULL,
  `valor unitario` varchar(45) DEFAULT NULL,
  `total` varchar(45) DEFAULT NULL,
  `tb_factura_id_factura` int(11) NOT NULL,
  `tb_platos_id_platos` int(11) DEFAULT NULL,
  `tb_bebidas_id_bebidas` int(11) DEFAULT NULL,
  `tb_menu_id_menu` int(11) DEFAULT NULL,
  `tipo_tabla` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_detalle_factura`
--

INSERT INTO `tb_detalle_factura` (`canidad`, `valor unitario`, `total`, `tb_factura_id_factura`, `tb_platos_id_platos`, `tb_bebidas_id_bebidas`, `tb_menu_id_menu`, `tipo_tabla`) VALUES
(1, '100', '100', 3, NULL, 1, NULL, 'tb_bebidas'),
(1, '200', '200', 4, NULL, NULL, 1, 'tb_menu'),
(1, '100', '100', 4, NULL, 1, NULL, 'tb_bebidas'),
(1, '100', '100', 5, NULL, 1, NULL, 'tb_bebidas'),
(1, '100', '100', 6, NULL, 1, NULL, 'tb_bebidas'),
(1, '200', '200', 7, NULL, NULL, 1, 'tb_menu'),
(1, '200', '200', 7, NULL, NULL, 1, 'tb_menu'),
(1, '100', '100', 8, NULL, 1, NULL, 'tb_bebidas'),
(1, '100', '100', 8, NULL, 1, NULL, 'tb_bebidas'),
(1, '100', '100', 10, NULL, 1, NULL, 'tb_bebidas'),
(1, '100', '100', 9, NULL, 1, NULL, 'tb_bebidas'),
(1, '100', '100', 11, NULL, 1, NULL, 'tb_bebidas'),
(1, '100', '100', 12, NULL, 1, NULL, 'tb_bebidas'),
(1, '100', '100', 12, NULL, 1, NULL, 'tb_bebidas'),
(1, '200', '200', 13, NULL, NULL, 1, 'tb_menu'),
(1, '200', '200', 13, NULL, NULL, 1, 'tb_menu'),
(1, '100', '100', 14, NULL, 1, NULL, 'tb_bebidas'),
(1, '100', '100', 14, NULL, 1, NULL, 'tb_bebidas'),
(1, '100', '100', 14, NULL, 1, NULL, 'tb_bebidas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_empleados`
--

CREATE TABLE `tb_empleados` (
  `id_empleado` int(11) NOT NULL,
  `cedula` varchar(45) DEFAULT NULL,
  `nombres` varchar(145) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `direccion` varchar(145) DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `nota` longtext,
  `eliminado` enum('SI','NO') DEFAULT NULL,
  `tb_user_id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_empleados`
--

INSERT INTO `tb_empleados` (`id_empleado`, `cedula`, `nombres`, `apellidos`, `telefono`, `direccion`, `correo`, `nota`, `eliminado`, `tb_user_id_user`) VALUES
(14, '111111', 'PRUEBA', 'PRUEBA', '5555555', '555', 'PRUEBA@', 'PRUEBA', 'NO', 15),
(15, 'CAJERO', 'CAJERO', 'CAJERO', '63663330', '', '', '', 'NO', 16),
(16, '11431353355', 'HECTOR', 'ADARRAGA', '31116678250', '', '', '', 'NO', 17);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_factura`
--

CREATE TABLE `tb_factura` (
  `id_factura` int(11) NOT NULL,
  `consecutivo` varchar(10) NOT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `total` varchar(45) DEFAULT NULL,
  `tb_empleados_id_empleado` int(11) NOT NULL,
  `tb_cliente_id_cliente` int(11) NOT NULL,
  `observaciones` varchar(245) DEFAULT NULL,
  `cambio` varchar(45) DEFAULT NULL,
  `efectivo` varchar(45) DEFAULT NULL,
  `forma_pago` enum('EFECTIVO','TARJETA') DEFAULT NULL,
  `estado` enum('NOFACTURADA','FACTURADA','CANCELADA','UNIDA') DEFAULT NULL,
  `mesa` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_factura`
--

INSERT INTO `tb_factura` (`id_factura`, `consecutivo`, `fecha_creacion`, `total`, `tb_empleados_id_empleado`, `tb_cliente_id_cliente`, `observaciones`, `cambio`, `efectivo`, `forma_pago`, `estado`, `mesa`) VALUES
(1, '00001', '2018-10-04 00:00:00', '0', 15, 1, 'obs', '0', '0', 'EFECTIVO', 'FACTURADA', '1'),
(2, '00002', '2018-10-04 13:10:56', '0', 15, 1, 'v', '0', '0', 'EFECTIVO', 'FACTURADA', '33 '),
(3, '00003', '2018-10-05 19:10:21', '100', 15, 1, '', '0', '100', 'EFECTIVO', 'FACTURADA', '1   '),
(4, '00004', '2018-12-15 18:12:53', '300', 15, 1, 'ninguna', '0', '300', 'TARJETA', 'FACTURADA', '2 '),
(5, '00005', '2018-12-15 19:12:20', '100', 15, 1, 'no', '0', '100', 'TARJETA', 'FACTURADA', '1 '),
(6, '00006', '2018-12-15 20:12:28', '100', 15, 1, 'sdsd', '0', '100', 'TARJETA', 'FACTURADA', '2 '),
(7, '00007', '2018-12-16 13:12:16', '400', 15, 1, 'nada', '600', '1000', 'EFECTIVO', 'FACTURADA', '10 '),
(8, '00008', '2018-12-18 15:12:56', '200', 15, 1, '', '22', '222', 'EFECTIVO', 'FACTURADA', '112 '),
(9, '00009', '2018-12-18 15:12:36', '100', 15, 1, 'as', '0', '100', 'TARJETA', 'FACTURADA', '1 '),
(10, '00010', '2018-12-20 08:12:00', '100', 15, 1, 'sadasd', '0', '100', 'EFECTIVO', 'FACTURADA', 'sdas '),
(11, '00011', '2018-12-20 11:12:00', '100', 15, 1, 'df', '100', '200', 'EFECTIVO', 'FACTURADA', '12 '),
(12, '00012', '2018-12-20 11:12:14', '200', 15, 1, 'sd', '0', '200', 'TARJETA', 'FACTURADA', '2 '),
(13, '00013', '2018-12-21 15:12:03', '400', 15, 1, 'asd', '0', '400', 'TARJETA', 'FACTURADA', 's '),
(14, '00014', '2019-01-10 15:01:20', '300', 15, 1, '', '0', '300', 'TARJETA', 'FACTURADA', '1 ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_informe_existencias`
--

CREATE TABLE `tb_informe_existencias` (
  `id` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `nombre` varchar(245) DEFAULT NULL,
  `cantidad_inicial` varchar(45) DEFAULT NULL,
  `entrada` varchar(45) DEFAULT NULL,
  `fecha_entrada` varchar(45) DEFAULT NULL,
  `salida` varchar(45) DEFAULT NULL,
  `final` varchar(45) DEFAULT NULL,
  `fecha` varchar(45) DEFAULT NULL,
  `id_cierre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_info_factura`
--

CREATE TABLE `tb_info_factura` (
  `id_fac` int(11) NOT NULL,
  `tipo_de_factura` varchar(45) NOT NULL,
  `titulo` varchar(45) NOT NULL,
  `nit` varchar(45) NOT NULL,
  `leyes` varchar(245) DEFAULT NULL,
  `adicional` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_info_factura`
--

INSERT INTO `tb_info_factura` (`id_fac`, `tipo_de_factura`, `titulo`, `nit`, `leyes`, `adicional`) VALUES
(1, 'FACTURA DE VENTA', 'Douglas Dining & Cook', '900681475-0', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_inventario`
--

CREATE TABLE `tb_inventario` (
  `id_inventario` int(11) NOT NULL,
  `cantidad` varchar(45) NOT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `tb_suministro_id_suministro` int(11) DEFAULT NULL,
  `tb_bebidas_id_bebidas` int(11) DEFAULT NULL,
  `eliminado` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_inventario`
--

INSERT INTO `tb_inventario` (`id_inventario`, `cantidad`, `categoria`, `tb_suministro_id_suministro`, `tb_bebidas_id_bebidas`, `eliminado`) VALUES
(1, '108', 'BEBIDA1', NULL, 1, 'NO'),
(2, '4', 'PRUEBA', 1, NULL, 'NO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_menu`
--

CREATE TABLE `tb_menu` (
  `id_menu` int(11) NOT NULL,
  `nombre` varchar(145) DEFAULT NULL,
  `descripcion` varchar(245) DEFAULT NULL,
  `valor` varchar(45) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `eliminado` enum('SI','NO') DEFAULT NULL,
  `tipo` enum('COMBO','ALMUERZO') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_menu`
--

INSERT INTO `tb_menu` (`id_menu`, `nombre`, `descripcion`, `valor`, `fecha`, `eliminado`, `tipo`) VALUES
(1, 'PAPA MENU', 'PAPA', '200', '2018-10-04', 'NO', 'ALMUERZO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_movimiento`
--

CREATE TABLE `tb_movimiento` (
  `id_movimiento` int(11) NOT NULL,
  `tipo_movimiento` text NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `cantidad` varchar(45) DEFAULT NULL,
  `tb_inventario_id_inventario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_movimiento`
--

INSERT INTO `tb_movimiento` (`id_movimiento`, `tipo_movimiento`, `fecha`, `hora`, `cantidad`, `tb_inventario_id_inventario`) VALUES
(1, 'Salida x venta N Fac 00002', '2014-02-25', '13:00:00', '1', 9),
(2, 'SE AGREGO BEBIDA BEBIDA1', '2018-10-04', '17:10:59', '100', NULL),
(3, 'ENTRADA CANTIDAD DE BEBIDAS P BEBIDA1 --COD-- 1', '2018-10-04', '17:10:28', '10', 1),
(4, 'SE AGREGO SUMINISTRO PAPA PRUEBA', '2018-10-04', '17:10:06', 'UNIDADES', NULL),
(5, 'ENTRADA SUMINISTRO PRPAPA PRUEBA', '2018-10-04', '17:10:21', '5', 2),
(6, 'SALIDA DE PRODUCTO PAPA PRUEBA PARA LA RECETA  PAPAFRITAS', '2018-10-04', '17:10:20', '1', 2),
(7, 'MODIFICACION DE LA CANTIDAD PARA ALMUERZOS DE LA RECETA PAPAFRITAS', '2018-10-04', '17:10:04', '10', NULL),
(8, 'SE AGREGO LA RECETA PAPAFRITAS PARA EL ALMUERZO PAPA MENU', '2018-10-04', '17:10:38', '1', NULL),
(9, 'Salida x venta N Fac 00003', '2014-02-25', '13:00:00', '1', 1),
(10, 'Salida x venta N Fac 00003', '2014-02-25', '13:00:00', '1', 1),
(11, 'Salida x venta N Fac 00003', '2014-02-25', '13:00:00', '1', 1),
(12, 'Salida x venta N Fac 00010', '2014-02-25', '13:00:00', '1', 1),
(13, 'Salida x venta N Fac 00009', '2014-02-25', '13:00:00', '1', 1),
(14, 'Salida x venta N Fac 00004', '2014-02-25', '13:00:00', '1', 1),
(15, 'Salida x venta N Fac 00005', '2014-02-25', '13:00:00', '1', 1),
(16, 'Salida x venta N Fac 00006', '2014-02-25', '13:00:00', '1', 1),
(17, 'Salida x venta N Fac 00008', '2014-02-25', '13:00:00', '1', 1),
(18, 'Salida x venta N Fac 00008', '2014-02-25', '13:00:00', '1', 1),
(19, 'Salida x venta N Fac 00011', '2014-02-25', '13:00:00', '1', 1),
(20, 'Salida x venta N Fac 00012', '2014-02-25', '13:00:00', '1', 1),
(21, 'Salida x venta N Fac 00012', '2014-02-25', '13:00:00', '1', 1),
(22, 'ENTRADA CANTIDAD BEBIDAS BB--BEBIDA1 --COD-- 1', '2019-01-10', '15:01:52', '111', 1),
(23, 'Salida x venta N Fac 00014', '2014-02-25', '13:00:00', '1', 1),
(24, 'Salida x venta N Fac 00014', '2014-02-25', '13:00:00', '1', 1),
(25, 'Salida x venta N Fac 00014', '2014-02-25', '13:00:00', '1', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_permiso_user`
--

CREATE TABLE `tb_permiso_user` (
  `tb_user_id_user` int(11) NOT NULL,
  `crear_suministro` enum('SI','NO') NOT NULL,
  `crear_receta` enum('SI','NO') NOT NULL,
  `crear_plato` enum('SI','NO') NOT NULL,
  `ingresar_pedido` enum('SI','NO') NOT NULL,
  `consultar_factura` enum('SI','NO') NOT NULL,
  `parametro_factura` enum('SI','NO') NOT NULL,
  `generar_factura` enum('SI','NO') NOT NULL,
  `cerrar_caja` enum('SI','NO') NOT NULL,
  `generar_pdf` enum('SI','NO') NOT NULL,
  `crear_emple` enum('SI','NO') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_permiso_user`
--

INSERT INTO `tb_permiso_user` (`tb_user_id_user`, `crear_suministro`, `crear_receta`, `crear_plato`, `ingresar_pedido`, `consultar_factura`, `parametro_factura`, `generar_factura`, `cerrar_caja`, `generar_pdf`, `crear_emple`) VALUES
(15, 'SI', 'SI', 'SI', 'SI', 'SI', 'SI', 'SI', 'SI', 'SI', 'SI'),
(16, 'SI', 'NO', 'NO', 'SI', 'SI', 'SI', 'SI', 'SI', 'NO', 'SI'),
(17, 'SI', 'SI', 'SI', 'SI', 'SI', 'SI', 'NO', 'NO', 'NO', 'NO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_platos`
--

CREATE TABLE `tb_platos` (
  `id_platos` int(11) NOT NULL,
  `nombre` varchar(145) DEFAULT NULL,
  `description` varchar(245) DEFAULT NULL,
  `valor_final` varchar(45) DEFAULT NULL,
  `costo_plato` varchar(45) DEFAULT NULL,
  `eliminado` enum('SI','NO') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_recetas`
--

CREATE TABLE `tb_recetas` (
  `id_receta` int(11) NOT NULL,
  `nombre` varchar(145) DEFAULT NULL,
  `descripcion` varchar(245) DEFAULT NULL,
  `valor_recta` varchar(45) DEFAULT NULL,
  `cantidad_platos` varchar(45) DEFAULT NULL,
  `cant_inicial` varchar(45) DEFAULT NULL,
  `activa` varchar(45) DEFAULT NULL,
  `fecha_receta` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_recetas`
--

INSERT INTO `tb_recetas` (`id_receta`, `nombre`, `descripcion`, `valor_recta`, `cantidad_platos`, `cant_inicial`, `activa`, `fecha_receta`) VALUES
(1, 'PAPAFRITAS', 'A', '150', '10', '0', 'NO', '2018-10-04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_recetas_has_tb_menu`
--

CREATE TABLE `tb_recetas_has_tb_menu` (
  `tb_recetas_id_receta` int(11) NOT NULL,
  `tb_menu_id_menu` int(11) NOT NULL,
  `cantidad` varchar(45) DEFAULT NULL,
  `valor_unit` varchar(45) DEFAULT NULL,
  `valor_total` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_recetas_has_tb_menu`
--

INSERT INTO `tb_recetas_has_tb_menu` (`tb_recetas_id_receta`, `tb_menu_id_menu`, `cantidad`, `valor_unit`, `valor_total`) VALUES
(1, 1, '1', '15', '15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_recetas_has_tb_platos`
--

CREATE TABLE `tb_recetas_has_tb_platos` (
  `tb_recetas_id_receta` int(11) NOT NULL,
  `tb_platos_id_platos` int(11) NOT NULL,
  `cantidad` varchar(45) DEFAULT NULL,
  `valor_unit` varchar(45) DEFAULT NULL,
  `valor_total` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_recetas_has_tb_suministro`
--

CREATE TABLE `tb_recetas_has_tb_suministro` (
  `tb_recetas_id_receta` int(11) NOT NULL,
  `tb_suministro_id_suministro` int(11) NOT NULL,
  `cantidad` varchar(45) NOT NULL,
  `medida` varchar(45) NOT NULL,
  `valor_uni` varchar(45) NOT NULL,
  `valor_total` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_recetas_has_tb_suministro`
--

INSERT INTO `tb_recetas_has_tb_suministro` (`tb_recetas_id_receta`, `tb_suministro_id_suministro`, `cantidad`, `medida`, `valor_uni`, `valor_total`) VALUES
(1, 1, '1', 'UNIDADES', '150', '150');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_suministro`
--

CREATE TABLE `tb_suministro` (
  `id_suministro` int(11) NOT NULL,
  `nombre` varchar(145) DEFAULT NULL,
  `descripcion` varchar(245) DEFAULT NULL,
  `cantidad` varchar(45) DEFAULT NULL,
  `peso` varchar(45) DEFAULT NULL,
  `valor` varchar(45) DEFAULT NULL,
  `tb_tipo_suminitro_id_categoria` int(11) NOT NULL,
  `eliminado` enum('SI','NO') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_suministro`
--

INSERT INTO `tb_suministro` (`id_suministro`, `nombre`, `descripcion`, `cantidad`, `peso`, `valor`, `tb_tipo_suminitro_id_categoria`, `eliminado`) VALUES
(1, 'PAPA PRUEBA', 'PORCIONDEPAPA', '150', 'UNIDADES', '150', 15, 'NO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_temporal_almuerzod`
--

CREATE TABLE `tb_temporal_almuerzod` (
  `id` int(11) NOT NULL,
  `id_almuierzo` varchar(45) DEFAULT NULL,
  `cantidad` varchar(45) DEFAULT NULL,
  `nombre` varchar(145) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_temporal_bebida`
--

CREATE TABLE `tb_temporal_bebida` (
  `id` int(11) NOT NULL,
  `id_bebida` varchar(45) DEFAULT NULL,
  `cantidad` varchar(45) DEFAULT NULL,
  `nombre` varchar(145) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_temporal_bebida`
--

INSERT INTO `tb_temporal_bebida` (`id`, `id_bebida`, `cantidad`, `nombre`) VALUES
(1, '1', '6', 'BEBIDA1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_temporal_conteo`
--

CREATE TABLE `tb_temporal_conteo` (
  `idtb_temporal_conteo` int(11) NOT NULL,
  `id_suministro` int(11) DEFAULT NULL,
  `cantidad` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_temporal_conteo_menus`
--

CREATE TABLE `tb_temporal_conteo_menus` (
  `id` int(11) NOT NULL,
  `receta_id` varchar(45) DEFAULT NULL,
  `cantidad_vendida` varchar(45) DEFAULT NULL,
  `id_menu` varchar(45) DEFAULT NULL,
  `nombre_receta` varchar(45) DEFAULT NULL,
  `fecha` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_temporal_conteo_menus`
--

INSERT INTO `tb_temporal_conteo_menus` (`id`, `receta_id`, `cantidad_vendida`, `id_menu`, `nombre_receta`, `fecha`) VALUES
(1, '1', '5', '1', 'receta', '2018-12-20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_temporal_platos_vendidos`
--

CREATE TABLE `tb_temporal_platos_vendidos` (
  `id` int(11) NOT NULL,
  `id_plato` varchar(45) DEFAULT NULL,
  `cantidad` varchar(45) DEFAULT NULL,
  `nombre` varchar(145) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tipo_suminitro`
--

CREATE TABLE `tb_tipo_suminitro` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(145) DEFAULT NULL,
  `description` varchar(245) DEFAULT NULL,
  `eliminar` enum('SI','NO') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_tipo_suminitro`
--

INSERT INTO `tb_tipo_suminitro` (`id_categoria`, `nombre`, `description`, `eliminar`) VALUES
(3, 'CARNES', 'TODO TIPO DE CARNES COMO DE RES, POLLO, CERDO  ETC', 'NO'),
(4, 'LECHES Y DERIVADOS', 'LACTEOS', 'NO'),
(5, 'FRUTAS Y VERDURAS ', 'FRUTAS ETC', 'NO'),
(6, 'CEREALES', 'ARROZ, PAN, PASTAS ETC', 'NO'),
(7, 'LEGUMBRES', 'LEGUMBRES', 'NO'),
(8, 'CONDIMENTOS', 'MAGGI, COLOR, PIMIENTA, ETC ', 'NO'),
(9, 'ALMACEN', 'INSUMOS', 'NO'),
(10, 'DESPENSA', 'INSUMOS', 'NO'),
(11, 'VINOS', 'DESCORCHES', 'NO'),
(12, 'LASAGNA EVENTOS X 25PRS.', '190000', 'NO'),
(13, 'LASAGANA', '0000', 'NO'),
(14, 'LACTEOS', 'SUERO', 'NO'),
(15, 'PRUEBA', 'PRUEBA', 'NO'),
(16, 'OTROS', 'GRUPO DE ALIMENTO DESCONOCIDOS', 'NO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_user`
--

CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL,
  `user` varchar(45) DEFAULT NULL,
  `clave` varchar(145) DEFAULT NULL,
  `eliminado` enum('SI','NO') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_user`
--

INSERT INTO `tb_user` (`id_user`, `user`, `clave`, `eliminado`) VALUES
(1, 'ADMIN', 'ADMIN123', 'NO'),
(15, 'PRUEBA', '123', 'NO'),
(16, 'CAJERO', '123456', 'NO'),
(17, 'HADARRAGA', '0792', 'NO');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tb_bebidas`
--
ALTER TABLE `tb_bebidas`
  ADD PRIMARY KEY (`id_bebidas`);

--
-- Indices de la tabla `tb_cierre`
--
ALTER TABLE `tb_cierre`
  ADD PRIMARY KEY (`id_cierre`),
  ADD KEY `fk_tb_cierre_tb_user1_idx` (`tb_user_id_user`);

--
-- Indices de la tabla `tb_cliente`
--
ALTER TABLE `tb_cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `tb_detalle_factura`
--
ALTER TABLE `tb_detalle_factura`
  ADD KEY `fk_tb_detalle_factura_tb_platos1_idx` (`tb_platos_id_platos`),
  ADD KEY `fk_tb_detalle_factura_tb_bebidas1_idx` (`tb_bebidas_id_bebidas`),
  ADD KEY `fk_tb_detalle_factura_tb_menu1_idx` (`tb_menu_id_menu`),
  ADD KEY `fk_tb_detalle_factura_tb_factura1_idx` (`tb_factura_id_factura`);

--
-- Indices de la tabla `tb_empleados`
--
ALTER TABLE `tb_empleados`
  ADD PRIMARY KEY (`id_empleado`),
  ADD KEY `fk_tb_empleados_tb_user1_idx` (`tb_user_id_user`);

--
-- Indices de la tabla `tb_factura`
--
ALTER TABLE `tb_factura`
  ADD PRIMARY KEY (`id_factura`),
  ADD KEY `fk_tb_factura_tb_empleados1_idx` (`tb_empleados_id_empleado`),
  ADD KEY `fk_tb_factura_tb_cliente1_idx` (`tb_cliente_id_cliente`);

--
-- Indices de la tabla `tb_informe_existencias`
--
ALTER TABLE `tb_informe_existencias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tb_info_factura`
--
ALTER TABLE `tb_info_factura`
  ADD PRIMARY KEY (`id_fac`);

--
-- Indices de la tabla `tb_inventario`
--
ALTER TABLE `tb_inventario`
  ADD PRIMARY KEY (`id_inventario`),
  ADD KEY `fk_tb_inventario_tb_suministro1_idx` (`tb_suministro_id_suministro`),
  ADD KEY `fk_tb_inventario_tb_bebidas1_idx` (`tb_bebidas_id_bebidas`);

--
-- Indices de la tabla `tb_menu`
--
ALTER TABLE `tb_menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Indices de la tabla `tb_movimiento`
--
ALTER TABLE `tb_movimiento`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `fk_tb_movimiento_tb_inventario1_idx` (`tb_inventario_id_inventario`);

--
-- Indices de la tabla `tb_permiso_user`
--
ALTER TABLE `tb_permiso_user`
  ADD PRIMARY KEY (`tb_user_id_user`);

--
-- Indices de la tabla `tb_platos`
--
ALTER TABLE `tb_platos`
  ADD PRIMARY KEY (`id_platos`);

--
-- Indices de la tabla `tb_recetas`
--
ALTER TABLE `tb_recetas`
  ADD PRIMARY KEY (`id_receta`);

--
-- Indices de la tabla `tb_recetas_has_tb_menu`
--
ALTER TABLE `tb_recetas_has_tb_menu`
  ADD PRIMARY KEY (`tb_recetas_id_receta`,`tb_menu_id_menu`),
  ADD KEY `fk_tb_recetas_has_tb_menu_tb_menu1_idx` (`tb_menu_id_menu`),
  ADD KEY `fk_tb_recetas_has_tb_menu_tb_recetas1_idx` (`tb_recetas_id_receta`);

--
-- Indices de la tabla `tb_recetas_has_tb_platos`
--
ALTER TABLE `tb_recetas_has_tb_platos`
  ADD PRIMARY KEY (`tb_recetas_id_receta`,`tb_platos_id_platos`),
  ADD KEY `fk_tb_recetas_has_tb_platos_tb_platos1_idx` (`tb_platos_id_platos`),
  ADD KEY `fk_tb_recetas_has_tb_platos_tb_recetas1_idx` (`tb_recetas_id_receta`);

--
-- Indices de la tabla `tb_recetas_has_tb_suministro`
--
ALTER TABLE `tb_recetas_has_tb_suministro`
  ADD PRIMARY KEY (`tb_recetas_id_receta`,`tb_suministro_id_suministro`),
  ADD KEY `fk_tb_recetas_has_tb_suministro_tb_suministro1_idx` (`tb_suministro_id_suministro`),
  ADD KEY `fk_tb_recetas_has_tb_suministro_tb_recetas1_idx` (`tb_recetas_id_receta`);

--
-- Indices de la tabla `tb_suministro`
--
ALTER TABLE `tb_suministro`
  ADD PRIMARY KEY (`id_suministro`),
  ADD KEY `fk_tb_suministro_tb_tipo_suminitro1_idx` (`tb_tipo_suminitro_id_categoria`);

--
-- Indices de la tabla `tb_temporal_almuerzod`
--
ALTER TABLE `tb_temporal_almuerzod`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tb_temporal_bebida`
--
ALTER TABLE `tb_temporal_bebida`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tb_temporal_conteo`
--
ALTER TABLE `tb_temporal_conteo`
  ADD PRIMARY KEY (`idtb_temporal_conteo`);

--
-- Indices de la tabla `tb_temporal_conteo_menus`
--
ALTER TABLE `tb_temporal_conteo_menus`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tb_temporal_platos_vendidos`
--
ALTER TABLE `tb_temporal_platos_vendidos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tb_tipo_suminitro`
--
ALTER TABLE `tb_tipo_suminitro`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tb_bebidas`
--
ALTER TABLE `tb_bebidas`
  MODIFY `id_bebidas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_cierre`
--
ALTER TABLE `tb_cierre`
  MODIFY `id_cierre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tb_cliente`
--
ALTER TABLE `tb_cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_empleados`
--
ALTER TABLE `tb_empleados`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `tb_factura`
--
ALTER TABLE `tb_factura`
  MODIFY `id_factura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `tb_informe_existencias`
--
ALTER TABLE `tb_informe_existencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_info_factura`
--
ALTER TABLE `tb_info_factura`
  MODIFY `id_fac` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_inventario`
--
ALTER TABLE `tb_inventario`
  MODIFY `id_inventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tb_menu`
--
ALTER TABLE `tb_menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_movimiento`
--
ALTER TABLE `tb_movimiento`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `tb_platos`
--
ALTER TABLE `tb_platos`
  MODIFY `id_platos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_recetas`
--
ALTER TABLE `tb_recetas`
  MODIFY `id_receta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_suministro`
--
ALTER TABLE `tb_suministro`
  MODIFY `id_suministro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_temporal_almuerzod`
--
ALTER TABLE `tb_temporal_almuerzod`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_temporal_bebida`
--
ALTER TABLE `tb_temporal_bebida`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_temporal_conteo`
--
ALTER TABLE `tb_temporal_conteo`
  MODIFY `idtb_temporal_conteo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_temporal_conteo_menus`
--
ALTER TABLE `tb_temporal_conteo_menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_temporal_platos_vendidos`
--
ALTER TABLE `tb_temporal_platos_vendidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_tipo_suminitro`
--
ALTER TABLE `tb_tipo_suminitro`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tb_cierre`
--
ALTER TABLE `tb_cierre`
  ADD CONSTRAINT `fk_tb_cierre_tb_user1` FOREIGN KEY (`tb_user_id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_detalle_factura`
--
ALTER TABLE `tb_detalle_factura`
  ADD CONSTRAINT `fk_tb_detalle_factura_tb_bebidas1` FOREIGN KEY (`tb_bebidas_id_bebidas`) REFERENCES `tb_bebidas` (`id_bebidas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_detalle_factura_tb_factura1` FOREIGN KEY (`tb_factura_id_factura`) REFERENCES `tb_factura` (`id_factura`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_detalle_factura_tb_menu1` FOREIGN KEY (`tb_menu_id_menu`) REFERENCES `tb_menu` (`id_menu`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_detalle_factura_tb_platos1` FOREIGN KEY (`tb_platos_id_platos`) REFERENCES `tb_platos` (`id_platos`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_empleados`
--
ALTER TABLE `tb_empleados`
  ADD CONSTRAINT `fk_tb_empleados_tb_user1` FOREIGN KEY (`tb_user_id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_factura`
--
ALTER TABLE `tb_factura`
  ADD CONSTRAINT `fk_tb_factura_tb_cliente1` FOREIGN KEY (`tb_cliente_id_cliente`) REFERENCES `tb_cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_factura_tb_empleados1` FOREIGN KEY (`tb_empleados_id_empleado`) REFERENCES `tb_empleados` (`id_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_inventario`
--
ALTER TABLE `tb_inventario`
  ADD CONSTRAINT `fk_tb_inventario_tb_bebidas1` FOREIGN KEY (`tb_bebidas_id_bebidas`) REFERENCES `tb_bebidas` (`id_bebidas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_inventario_tb_suministro1` FOREIGN KEY (`tb_suministro_id_suministro`) REFERENCES `tb_suministro` (`id_suministro`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_movimiento`
--
ALTER TABLE `tb_movimiento`
  ADD CONSTRAINT `fk_tb_movimiento_tb_inventario1` FOREIGN KEY (`tb_inventario_id_inventario`) REFERENCES `tb_inventario` (`id_inventario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_permiso_user`
--
ALTER TABLE `tb_permiso_user`
  ADD CONSTRAINT `fk_tb_permiso_user_tb_user1` FOREIGN KEY (`tb_user_id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_recetas_has_tb_menu`
--
ALTER TABLE `tb_recetas_has_tb_menu`
  ADD CONSTRAINT `fk_tb_recetas_has_tb_menu_tb_menu1` FOREIGN KEY (`tb_menu_id_menu`) REFERENCES `tb_menu` (`id_menu`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_recetas_has_tb_menu_tb_recetas1` FOREIGN KEY (`tb_recetas_id_receta`) REFERENCES `tb_recetas` (`id_receta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_recetas_has_tb_platos`
--
ALTER TABLE `tb_recetas_has_tb_platos`
  ADD CONSTRAINT `fk_tb_recetas_has_tb_platos_tb_platos1` FOREIGN KEY (`tb_platos_id_platos`) REFERENCES `tb_platos` (`id_platos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_recetas_has_tb_platos_tb_recetas1` FOREIGN KEY (`tb_recetas_id_receta`) REFERENCES `tb_recetas` (`id_receta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_recetas_has_tb_suministro`
--
ALTER TABLE `tb_recetas_has_tb_suministro`
  ADD CONSTRAINT `fk_tb_recetas_has_tb_suministro_tb_recetas1` FOREIGN KEY (`tb_recetas_id_receta`) REFERENCES `tb_recetas` (`id_receta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_recetas_has_tb_suministro_tb_suministro1` FOREIGN KEY (`tb_suministro_id_suministro`) REFERENCES `tb_suministro` (`id_suministro`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_suministro`
--
ALTER TABLE `tb_suministro`
  ADD CONSTRAINT `fk_tb_suministro_tb_tipo_suminitro1` FOREIGN KEY (`tb_tipo_suminitro_id_categoria`) REFERENCES `tb_tipo_suminitro` (`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Base de datos: `photos_db`
--
CREATE DATABASE IF NOT EXISTS `photos_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `photos_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_album`
--

CREATE TABLE `tb_album` (
  `id_album` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `delete_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_album`
--

INSERT INTO `tb_album` (`id_album`, `name`, `description`, `create_time`, `delete_time`, `update_time`) VALUES
(1, 'Albun 1', 'Mi viaje', '2020-02-14 05:00:00', NULL, '2020-02-14 05:00:00'),
(2, 'album 2', 'dea', '2020-02-15 05:58:20', NULL, '2020-02-15 05:58:20'),
(3, 'album 3', NULL, '2020-02-15 05:00:00', NULL, NULL),
(4, 'Albun 4', 'asdasd', '2020-02-15 05:00:00', NULL, NULL),
(5, 'ASDAS', 'ASDASD', '2020-02-15 05:00:00', NULL, NULL),
(6, 'ASDAS', 'ASDASD', '2020-02-15 05:00:00', NULL, NULL),
(7, 'ASDAS', 'ASDASD', '2020-02-15 05:00:00', NULL, NULL),
(8, 'vxcv', 'cvxcvxcv', '2020-02-16 05:00:00', NULL, NULL),
(9, 'vxcv', 'cvxcvxcv', '2020-02-16 18:03:54', NULL, NULL),
(10, 'vxcv asd', 'cvxcvxcv', '2020-02-16 18:04:39', NULL, NULL),
(11, 'vxcv asd', 'cvxcvxcv', '2020-02-16 18:06:51', NULL, NULL),
(12, 'vxcv asd', 'cvxcvxcv asd', '2020-02-16 18:07:45', NULL, NULL),
(13, 'albun demo', 'denio', '2020-02-16 18:16:19', NULL, NULL),
(14, 'asdasd', 'asdasd', '2020-02-16 18:16:50', NULL, NULL),
(15, 'demo 15', 'asdasd', '2020-02-16 19:15:48', NULL, NULL),
(16, 'demo 15d', 'asdasd', '2020-02-16 19:57:05', NULL, NULL),
(17, 'asas', 'asds', '2020-02-16 19:59:25', '2020-02-17 13:26:57', NULL),
(18, 'vxcv', 'xcvxc', '2020-02-16 20:01:35', NULL, NULL),
(19, 'asdas', 'asdasda', '2020-02-16 20:03:43', NULL, NULL),
(20, 'asdas', 'dasd', '2020-02-16 20:04:56', NULL, NULL),
(21, 'sdasd', 'asdasd', '2020-02-16 20:09:29', NULL, NULL),
(22, 'wertr', 'wefgsgf', '2020-02-16 20:10:58', NULL, NULL),
(23, 'asd', 'asdas', '2020-02-16 20:15:12', NULL, NULL),
(24, 'asd', 'asdas', '2020-02-16 20:15:55', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_image`
--

CREATE TABLE `tb_image` (
  `id_image` int(11) NOT NULL,
  `file` longtext,
  `date` varchar(45) DEFAULT NULL,
  `create_time` varchar(45) DEFAULT 'CURRENT_TIMESTAMP',
  `delete_time` varchar(45) DEFAULT NULL,
  `description` varchar(245) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_image`
--

INSERT INTO `tb_image` (`id_image`, `file`, `date`, `create_time`, `delete_time`, `description`) VALUES
(1, 'https://spacenews.com/wp-content/uploads/2018/10/crewdragon-docking-879x485.jpg', '2020-02-14 00:00:00', '2020-02-14 00:00:00', NULL, 'new image'),
(2, 'https://images.trustinnews.pt/uploads/sites/5/2020/01/telescopio.jpg', '2020-02-14 00:00:00', '2020-02-14 00:00:00', NULL, 'new image'),
(3, 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Jupiter.jpg/600px-Jupiter.jpg', '2020-02-14 00:00:00', '2020-02-14 00:00:00', '2020-02-15 00:00:00', 'jupiter'),
(4, NULL, NULL, NULL, '2020-02-14 20:53:08', NULL),
(5, 'https://spacenews.com/wp-content/uploads/2018/10/crewdragon-docking-879x485.jpg', '2020-02-15 10:01:51', '2020-02-15 10:01:51', NULL, 'image'),
(6, 'https://spacenews.com/wp-content/uploads/2018/10/crewdragon-docking-879x485.jpg', '2020-02-15 10:01:54', '2020-02-15 10:01:54', '2020-02-15 10:22:35', 'image'),
(7, NULL, NULL, 'CURRENT_TIMESTAMP', '2020-02-16 16:55:15', NULL),
(8, NULL, NULL, 'CURRENT_TIMESTAMP', '2020-02-16 22:53:44', NULL),
(9, NULL, NULL, 'CURRENT_TIMESTAMP', '2020-02-16 22:53:45', 'null'),
(10, 'asdasdas', NULL, 'CURRENT_TIMESTAMP', '2020-02-16 22:53:46', 'des'),
(11, 'https://res.cloudinary.com/jariza28/image/upload/v1581890927/angular_sample/kcx5tjzsz3ue0pvhfepg.png', NULL, 'CURRENT_TIMESTAMP', NULL, NULL),
(12, 'https://res.cloudinary.com/jariza28/image/upload/v1581891573/angular_sample/u8ehchpyd6ucg5v7namn.png', NULL, 'CURRENT_TIMESTAMP', NULL, NULL),
(13, 'https://res.cloudinary.com/jariza28/image/upload/v1581911643/angular_sample/qjijd0f7b3gjn4dgkibu.png', NULL, 'CURRENT_TIMESTAMP', NULL, NULL),
(14, 'https://res.cloudinary.com/jariza28/image/upload/v1581912197/angular_sample/xslbxoawhm147jl74cin.png', NULL, 'CURRENT_TIMESTAMP', NULL, NULL),
(15, 'https://res.cloudinary.com/jariza28/image/upload/v1581947310/angular_sample/k4ps053vlnut2l7uznb6.png', NULL, 'CURRENT_TIMESTAMP', NULL, NULL),
(16, 'https://res.cloudinary.com/jariza28/image/upload/v1581947320/angular_sample/nbrnmlvgt7tzhniehipa.png', NULL, 'CURRENT_TIMESTAMP', NULL, NULL),
(17, 'https://res.cloudinary.com/jariza28/image/upload/v1581947349/angular_sample/vzkbxewiyp03yzdccdnf.jpg', NULL, 'CURRENT_TIMESTAMP', NULL, NULL),
(18, 'https://res.cloudinary.com/jariza28/image/upload/v1581947357/angular_sample/fz0jght7r6djvkvrdyqu.png', NULL, 'CURRENT_TIMESTAMP', '2020-02-17 08:49:47', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_image_has_tb_album`
--

CREATE TABLE `tb_image_has_tb_album` (
  `tb_image_id_image` int(11) NOT NULL,
  `tb_album_id_album` int(11) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tb_image_has_tb_album`
--

INSERT INTO `tb_image_has_tb_album` (`tb_image_id_image`, `tb_album_id_album`, `create_time`) VALUES
(1, 14, NULL),
(1, 23, NULL),
(2, 24, NULL),
(5, 24, NULL),
(1, 24, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tb_album`
--
ALTER TABLE `tb_album`
  ADD PRIMARY KEY (`id_album`);

--
-- Indices de la tabla `tb_image`
--
ALTER TABLE `tb_image`
  ADD PRIMARY KEY (`id_image`);

--
-- Indices de la tabla `tb_image_has_tb_album`
--
ALTER TABLE `tb_image_has_tb_album`
  ADD KEY `fk_tb_image_has_tb_album_tb_album1_idx` (`tb_album_id_album`),
  ADD KEY `fk_tb_image_has_tb_album_tb_image_idx` (`tb_image_id_image`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tb_album`
--
ALTER TABLE `tb_album`
  MODIFY `id_album` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `tb_image`
--
ALTER TABLE `tb_image`
  MODIFY `id_image` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tb_image_has_tb_album`
--
ALTER TABLE `tb_image_has_tb_album`
  ADD CONSTRAINT `fk_tb_image_has_tb_album_tb_album1` FOREIGN KEY (`tb_album_id_album`) REFERENCES `tb_album` (`id_album`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tb_image_has_tb_album_tb_image` FOREIGN KEY (`tb_image_id_image`) REFERENCES `tb_image` (`id_image`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(11) NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_length` text COLLATE utf8_bin,
  `col_collation` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8_bin DEFAULT '',
  `col_default` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `settings_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Volcado de datos para la tabla `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{\"angular_direct\":\"direct\",\"snap_to_grid\":\"off\",\"relation_lines\":\"true\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `template_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT '0',
  `x` float UNSIGNED NOT NULL DEFAULT '0',
  `y` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Volcado de datos para la tabla `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'bd_park', 'spacelibres', '{\"sorted_col\":\"`hora` ASC\"}', '2019-03-25 16:16:35'),
('root', 'bd_park', 'tb_asignacion_reserva_temp', '{\"CREATE_TIME\":\"2019-02-06 20:25:00\",\"col_order\":[0,1,2,3,4,5,6,7,8,9],\"col_visib\":[1,1,1,1,1,1,1,1,1,1]}', '2019-03-18 02:51:57'),
('root', 'bd_park', 'tb_espacio', '{\"sorted_col\":\"`id_usuario` ASC\"}', '2019-08-03 15:59:15'),
('root', 'bd_park', 'tb_millas', '{\"sorted_col\":\"`fecha` DESC\"}', '2019-06-18 23:58:33'),
('root', 'bd_park', 'tb_reservas', '{\"sorted_col\":\"`prioridad`  DESC\"}', '2019-12-04 19:25:37'),
('root', 'douglas_bd', 'tb_factura', '{\"sorted_col\":\"`tb_factura`.`forma_pago` ASC\"}', '2018-12-20 15:27:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin,
  `data_sql` longtext COLLATE utf8_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('', '2019-03-07 01:55:44', '{\"lang\":\"es\"}'),
('root', '2020-02-17 15:33:48', '{\"lang\":\"es\",\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Base de datos: `word`
--
CREATE DATABASE IF NOT EXISTS `word` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `word`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_commentmeta`
--

CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `comment_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_comments`
--

CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) UNSIGNED NOT NULL,
  `comment_post_ID` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_comments`
--

INSERT INTO `wp_comments` (`comment_ID`, `comment_post_ID`, `comment_author`, `comment_author_email`, `comment_author_url`, `comment_author_IP`, `comment_date`, `comment_date_gmt`, `comment_content`, `comment_karma`, `comment_approved`, `comment_agent`, `comment_type`, `comment_parent`, `user_id`) VALUES
(1, 1, 'Un comentarista de WordPress', 'wapuu@wordpress.example', 'https://wordpress.org/', '', '2018-09-25 17:38:02', '2018-09-25 17:38:02', 'Hola, esto es un comentario.\nPara empezar a moderar, editar y borrar comentarios, por favor, visita la pantalla de comentarios en el escritorio.\nLos avatares de los comentaristas provienen de <a href=\"https://gravatar.com\">Gravatar</a>.', 0, '1', '', '', 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_links`
--

CREATE TABLE `wp_links` (
  `link_id` bigint(20) UNSIGNED NOT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_options`
--

CREATE TABLE `wp_options` (
  `option_id` bigint(20) UNSIGNED NOT NULL,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_options`
--

INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(1, 'siteurl', 'http://127.0.0.1/wordpress/wordpress', 'yes'),
(2, 'home', 'http://127.0.0.1/wordpress/wordpress', 'yes'),
(3, 'blogname', 'Tienda', 'yes'),
(4, 'blogdescription', 'Otro sitio realizado con WordPress', 'yes'),
(5, 'users_can_register', '0', 'yes'),
(6, 'admin_email', 'jefferariza@outlook.com', 'yes'),
(7, 'start_of_week', '1', 'yes'),
(8, 'use_balanceTags', '0', 'yes'),
(9, 'use_smilies', '1', 'yes'),
(10, 'require_name_email', '1', 'yes'),
(11, 'comments_notify', '1', 'yes'),
(12, 'posts_per_rss', '10', 'yes'),
(13, 'rss_use_excerpt', '0', 'yes'),
(14, 'mailserver_url', 'mail.example.com', 'yes'),
(15, 'mailserver_login', 'login@example.com', 'yes'),
(16, 'mailserver_pass', 'password', 'yes'),
(17, 'mailserver_port', '110', 'yes'),
(18, 'default_category', '1', 'yes'),
(19, 'default_comment_status', 'open', 'yes'),
(20, 'default_ping_status', 'open', 'yes'),
(21, 'default_pingback_flag', '1', 'yes'),
(22, 'posts_per_page', '10', 'yes'),
(23, 'date_format', 'j F, Y', 'yes'),
(24, 'time_format', 'g:i a', 'yes'),
(25, 'links_updated_date_format', 'j F, Y g:i a', 'yes'),
(26, 'comment_moderation', '0', 'yes'),
(27, 'moderation_notify', '1', 'yes'),
(28, 'permalink_structure', '/%year%/%monthnum%/%day%/%postname%/', 'yes'),
(29, 'rewrite_rules', 'a:90:{s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:21:\"^index.php/wp-json/?$\";s:22:\"index.php?rest_route=/\";s:24:\"^index.php/wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:47:\"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:42:\"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:23:\"category/(.+?)/embed/?$\";s:46:\"index.php?category_name=$matches[1]&embed=true\";s:35:\"category/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?category_name=$matches[1]&paged=$matches[2]\";s:17:\"category/(.+?)/?$\";s:35:\"index.php?category_name=$matches[1]\";s:44:\"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:39:\"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:20:\"tag/([^/]+)/embed/?$\";s:36:\"index.php?tag=$matches[1]&embed=true\";s:32:\"tag/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?tag=$matches[1]&paged=$matches[2]\";s:14:\"tag/([^/]+)/?$\";s:25:\"index.php?tag=$matches[1]\";s:45:\"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:40:\"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:21:\"type/([^/]+)/embed/?$\";s:44:\"index.php?post_format=$matches[1]&embed=true\";s:33:\"type/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?post_format=$matches[1]&paged=$matches[2]\";s:15:\"type/([^/]+)/?$\";s:33:\"index.php?post_format=$matches[1]\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:32:\"feed/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:27:\"(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:8:\"embed/?$\";s:21:\"index.php?&embed=true\";s:20:\"page/?([0-9]{1,})/?$\";s:28:\"index.php?&paged=$matches[1]\";s:27:\"comment-page-([0-9]{1,})/?$\";s:39:\"index.php?&page_id=20&cpage=$matches[1]\";s:41:\"comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:36:\"comments/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:17:\"comments/embed/?$\";s:21:\"index.php?&embed=true\";s:44:\"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:39:\"search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:20:\"search/(.+)/embed/?$\";s:34:\"index.php?s=$matches[1]&embed=true\";s:32:\"search/(.+)/page/?([0-9]{1,})/?$\";s:41:\"index.php?s=$matches[1]&paged=$matches[2]\";s:14:\"search/(.+)/?$\";s:23:\"index.php?s=$matches[1]\";s:47:\"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:42:\"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:23:\"author/([^/]+)/embed/?$\";s:44:\"index.php?author_name=$matches[1]&embed=true\";s:35:\"author/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?author_name=$matches[1]&paged=$matches[2]\";s:17:\"author/([^/]+)/?$\";s:33:\"index.php?author_name=$matches[1]\";s:69:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:45:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:74:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:39:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:56:\"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:51:\"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:32:\"([0-9]{4})/([0-9]{1,2})/embed/?$\";s:58:\"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true\";s:44:\"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:26:\"([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:43:\"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:38:\"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:19:\"([0-9]{4})/embed/?$\";s:37:\"index.php?year=$matches[1]&embed=true\";s:31:\"([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:13:\"([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:58:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:68:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:88:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:83:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:83:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:64:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:53:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/embed/?$\";s:91:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/trackback/?$\";s:85:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&tb=1\";s:77:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]\";s:72:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]\";s:65:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/page/?([0-9]{1,})/?$\";s:98:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&paged=$matches[5]\";s:72:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/comment-page-([0-9]{1,})/?$\";s:98:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&cpage=$matches[5]\";s:61:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)(?:/([0-9]+))?/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&page=$matches[5]\";s:47:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:57:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:77:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:72:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:72:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:53:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&cpage=$matches[4]\";s:51:\"([0-9]{4})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&cpage=$matches[3]\";s:38:\"([0-9]{4})/comment-page-([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&cpage=$matches[2]\";s:27:\".?.+?/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\".?.+?/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\".?.+?/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"(.?.+?)/embed/?$\";s:41:\"index.php?pagename=$matches[1]&embed=true\";s:20:\"(.?.+?)/trackback/?$\";s:35:\"index.php?pagename=$matches[1]&tb=1\";s:40:\"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:35:\"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:28:\"(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:35:\"(.?.+?)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&cpage=$matches[2]\";s:24:\"(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";}', 'yes'),
(30, 'hack_file', '0', 'yes'),
(31, 'blog_charset', 'UTF-8', 'yes'),
(32, 'moderation_keys', '', 'no'),
(33, 'active_plugins', 'a:2:{i:0;s:36:\"contact-form-7/wp-contact-form-7.php\";i:1;s:35:\"illdy-companion/illdy-companion.php\";}', 'yes'),
(34, 'category_base', '', 'yes'),
(35, 'ping_sites', 'http://rpc.pingomatic.com/', 'yes'),
(36, 'comment_max_links', '2', 'yes'),
(37, 'gmt_offset', '0', 'yes'),
(38, 'default_email_category', '1', 'yes'),
(39, 'recently_edited', '', 'no'),
(40, 'template', 'illdy', 'yes'),
(41, 'stylesheet', 'illdy', 'yes'),
(42, 'comment_whitelist', '1', 'yes'),
(43, 'blacklist_keys', '', 'no'),
(44, 'comment_registration', '0', 'yes'),
(45, 'html_type', 'text/html', 'yes'),
(46, 'use_trackback', '0', 'yes'),
(47, 'default_role', 'subscriber', 'yes'),
(48, 'db_version', '38590', 'yes'),
(49, 'uploads_use_yearmonth_folders', '1', 'yes'),
(50, 'upload_path', '', 'yes'),
(51, 'blog_public', '1', 'yes'),
(52, 'default_link_category', '2', 'yes'),
(53, 'show_on_front', 'page', 'yes'),
(54, 'tag_base', '', 'yes'),
(55, 'show_avatars', '1', 'yes'),
(56, 'avatar_rating', 'G', 'yes'),
(57, 'upload_url_path', '', 'yes'),
(58, 'thumbnail_size_w', '150', 'yes'),
(59, 'thumbnail_size_h', '150', 'yes'),
(60, 'thumbnail_crop', '1', 'yes'),
(61, 'medium_size_w', '300', 'yes'),
(62, 'medium_size_h', '300', 'yes'),
(63, 'avatar_default', 'mystery', 'yes'),
(64, 'large_size_w', '1024', 'yes'),
(65, 'large_size_h', '1024', 'yes'),
(66, 'image_default_link_type', 'none', 'yes'),
(67, 'image_default_size', '', 'yes'),
(68, 'image_default_align', '', 'yes'),
(69, 'close_comments_for_old_posts', '0', 'yes'),
(70, 'close_comments_days_old', '14', 'yes'),
(71, 'thread_comments', '1', 'yes'),
(72, 'thread_comments_depth', '5', 'yes'),
(73, 'page_comments', '0', 'yes'),
(74, 'comments_per_page', '50', 'yes'),
(75, 'default_comments_page', 'newest', 'yes'),
(76, 'comment_order', 'asc', 'yes'),
(77, 'sticky_posts', 'a:0:{}', 'yes'),
(78, 'widget_categories', 'a:2:{i:2;a:4:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:12:\"hierarchical\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}', 'yes'),
(79, 'widget_text', 'a:5:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;i:5;a:3:{s:5:\"title\";s:8:\"PRODUCTS\";s:4:\"text\";s:201:\"<ul><li><a href=\"#\" title=\"Our work\">Our work</a></li><li><a href=\"#\" title=\"Club\">Club</a></li><li><a href=\"#\" title=\"News\">News</a></li><li><a href=\"#\" title=\"Announcement\">Announcement</a></li></ul>\";s:6:\"filter\";b:0;}i:6;a:3:{s:5:\"title\";s:11:\"INFORMATION\";s:4:\"text\";s:197:\"<ul><li><a href=\"#\" title=\"Pricing\">Pricing</a></li><li><a href=\"#\" title=\"Terms\">Terms</a></li><li><a href=\"#\" title=\"Affiliates\">Affiliates</a></li><li><a href=\"#\" title=\"Blog\">Blog</a></li></ul>\";s:6:\"filter\";b:0;}i:7;a:3:{s:5:\"title\";s:7:\"SUPPORT\";s:4:\"text\";s:205:\"<ul><li><a href=\"#\" title=\"Documentation\">Documentation</a></li><li><a href=\"#\" title=\"FAQs\">FAQs</a></li><li><a href=\"#\" title=\"Forums\">Forums</a></li><li><a href=\"#\" title=\"Contact\">Contact</a></li></ul>\";s:6:\"filter\";b:0;}}', 'yes'),
(80, 'widget_rss', 'a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}', 'yes'),
(81, 'uninstall_plugins', 'a:0:{}', 'no'),
(82, 'timezone_string', '', 'yes'),
(83, 'page_for_posts', '21', 'yes'),
(84, 'page_on_front', '20', 'yes'),
(85, 'default_post_format', '0', 'yes'),
(86, 'link_manager_enabled', '0', 'yes'),
(87, 'finished_splitting_shared_terms', '1', 'yes'),
(88, 'site_icon', '0', 'yes'),
(89, 'medium_large_size_w', '768', 'yes'),
(90, 'medium_large_size_h', '0', 'yes'),
(91, 'initial_db_version', '38590', 'yes'),
(92, 'wp_user_roles', 'a:5:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:61:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:34:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}}', 'yes'),
(93, 'fresh_site', '0', 'yes'),
(94, 'WPLANG', 'es_CO', 'yes'),
(95, 'widget_search', 'a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}', 'yes'),
(96, 'widget_recent-posts', 'a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}', 'yes'),
(97, 'widget_recent-comments', 'a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}', 'yes'),
(98, 'widget_archives', 'a:2:{i:2;a:3:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}', 'yes'),
(99, 'widget_meta', 'a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}', 'yes'),
(100, 'sidebars_widgets', 'a:15:{s:19:\"wp_inactive_widgets\";a:0:{}s:12:\"blog-sidebar\";a:6:{i:0;s:8:\"search-2\";i:1;s:14:\"recent-posts-2\";i:2;s:17:\"recent-comments-2\";i:3;s:10:\"archives-2\";i:4;s:12:\"categories-2\";i:5;s:6:\"meta-2\";}s:12:\"page-sidebar\";a:0:{}s:16:\"footer-sidebar-1\";a:1:{i:0;s:6:\"text-5\";}s:16:\"footer-sidebar-2\";a:1:{i:0;s:6:\"text-6\";}s:16:\"footer-sidebar-3\";a:1:{i:0;s:6:\"text-7\";}s:16:\"footer-sidebar-4\";a:0:{}s:24:\"front-page-about-sidebar\";a:3:{i:0;s:13:\"illdy_skill-2\";i:1;s:13:\"illdy_skill-3\";i:2;s:13:\"illdy_skill-4\";}s:27:\"front-page-projects-sidebar\";a:4:{i:0;s:15:\"illdy_project-3\";i:1;s:15:\"illdy_project-4\";i:2;s:15:\"illdy_project-5\";i:3;s:15:\"illdy_project-6\";}s:27:\"front-page-services-sidebar\";a:3:{i:0;s:15:\"illdy_service-2\";i:1;s:15:\"illdy_service-3\";i:2;s:15:\"illdy_service-4\";}s:26:\"front-page-counter-sidebar\";a:3:{i:0;s:15:\"illdy_counter-4\";i:1;s:15:\"illdy_counter-3\";i:2;s:15:\"illdy_counter-2\";}s:23:\"front-page-team-sidebar\";a:3:{i:0;s:14:\"illdy_person-5\";i:1;s:14:\"illdy_person-4\";i:2;s:14:\"illdy_person-2\";}s:29:\"front-page-full-width-sidebar\";a:1:{i:0;s:13:\"custom_html-3\";}s:31:\"front-page-testimonials-sidebar\";a:2:{i:0;s:19:\"illdy_testimonial-1\";i:1;s:19:\"illdy_testimonial-2\";}s:13:\"array_version\";i:3;}', 'yes'),
(101, 'widget_pages', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(102, 'widget_calendar', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(103, 'widget_media_audio', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(104, 'widget_media_image', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(105, 'widget_media_gallery', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(106, 'widget_media_video', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(107, 'widget_tag_cloud', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(108, 'widget_nav_menu', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(109, 'widget_custom_html', 'a:2:{s:12:\"_multiwidget\";i:1;i:3;a:2:{s:5:\"title\";s:0:\"\";s:7:\"content\";s:273:\"<iframe src=\"https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d5701.557247325895!2d-74.80578400685714!3d10.975619207683588!3m2!1i1024!2i768!4f13.1!5e0!3m2!1ses-419!2sco!4v1537899507346\" width=\"100%\" height=\"400\" frameborder=\"0\" style=\"border:0\" allowfullscreen></iframe>\";}}', 'yes'),
(110, 'cron', 'a:6:{i:1537900715;a:1:{s:34:\"wp_privacy_delete_old_export_files\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1537904485;a:1:{s:26:\"upgrader_scheduled_cleanup\";a:1:{s:32:\"adcb9b75260590ff6058773ddcb9ddd6\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:1:{i:0;i:4;}}}}i:1537940283;a:3:{s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1537983494;a:2:{s:19:\"wp_scheduled_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:25:\"delete_expired_transients\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1537983869;a:1:{s:30:\"wp_scheduled_auto_draft_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}s:7:\"version\";i:2;}', 'yes'),
(111, 'theme_mods_twentyseventeen', 'a:2:{s:18:\"custom_css_post_id\";i:-1;s:16:\"sidebars_widgets\";a:2:{s:4:\"time\";i:1537897296;s:4:\"data\";a:4:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:6:{i:0;s:8:\"search-2\";i:1;s:14:\"recent-posts-2\";i:2;s:17:\"recent-comments-2\";i:3;s:10:\"archives-2\";i:4;s:12:\"categories-2\";i:5;s:6:\"meta-2\";}s:9:\"sidebar-2\";a:0:{}s:9:\"sidebar-3\";a:0:{}}}}', 'yes'),
(124, '_site_transient_timeout_browser_8651940b33fd1e958c905441aa40a03d', '1538501896', 'no'),
(125, '_site_transient_browser_8651940b33fd1e958c905441aa40a03d', 'a:10:{s:4:\"name\";s:6:\"Chrome\";s:7:\"version\";s:13:\"69.0.3497.100\";s:8:\"platform\";s:7:\"Windows\";s:10:\"update_url\";s:29:\"https://www.google.com/chrome\";s:7:\"img_src\";s:43:\"http://s.w.org/images/browsers/chrome.png?1\";s:11:\"img_src_ssl\";s:44:\"https://s.w.org/images/browsers/chrome.png?1\";s:15:\"current_version\";s:2:\"18\";s:7:\"upgrade\";b:0;s:8:\"insecure\";b:0;s:6:\"mobile\";b:0;}', 'no'),
(126, '_site_transient_timeout_community-events-1aecf33ab8525ff212ebdffbb438372e', '1537940298', 'no'),
(127, 'can_compress_scripts', '1', 'no'),
(128, '_site_transient_community-events-1aecf33ab8525ff212ebdffbb438372e', 'a:2:{s:8:\"location\";a:1:{s:2:\"ip\";s:9:\"127.0.0.0\";}s:6:\"events\";a:2:{i:0;a:7:{s:4:\"type\";s:6:\"meetup\";s:5:\"title\";s:37:\"Segunda reunión Voluntarios WordCamp\";s:3:\"url\";s:64:\"https://www.meetup.com/Bogota-WordPress-Meetup/events/254855144/\";s:6:\"meetup\";s:24:\"Bogotá WordPress Meetup\";s:10:\"meetup_url\";s:47:\"https://www.meetup.com/Bogota-WordPress-Meetup/\";s:4:\"date\";s:19:\"2018-09-25 18:00:00\";s:8:\"location\";a:4:{s:8:\"location\";s:17:\"Bogotá, Colombia\";s:7:\"country\";s:2:\"co\";s:8:\"latitude\";d:4.6677999999999997;s:9:\"longitude\";d:-74.053659999999994;}}i:1;a:7:{s:4:\"type\";s:8:\"wordcamp\";s:5:\"title\";s:16:\"WordCamp Bogotá\";s:3:\"url\";s:32:\"https://2018.bogota.wordcamp.org\";s:6:\"meetup\";N;s:10:\"meetup_url\";N;s:4:\"date\";s:19:\"2018-11-09 00:00:00\";s:8:\"location\";a:4:{s:8:\"location\";s:31:\"Bogotá, Cundinamarca, Colombia\";s:7:\"country\";s:2:\"CO\";s:8:\"latitude\";d:4.5900812999999996;s:9:\"longitude\";d:-74.072955399999998;}}}}', 'no'),
(129, '_transient_timeout_feed_ef605fdbfbba53a6c98437c00d402dfe', '1537940301', 'no');
INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(130, '_transient_feed_ef605fdbfbba53a6c98437c00d402dfe', 'a:4:{s:5:\"child\";a:1:{s:0:\"\";a:1:{s:3:\"rss\";a:1:{i:0;a:6:{s:4:\"data\";s:3:\"\n\n\n\";s:7:\"attribs\";a:1:{s:0:\"\";a:1:{s:7:\"version\";s:3:\"2.0\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:1:{s:0:\"\";a:1:{s:7:\"channel\";a:1:{i:0;a:6:{s:4:\"data\";s:49:\"\n	\n	\n	\n	\n	\n	\n	\n	\n	\n	\n		\n		\n		\n		\n		\n		\n		\n		\n		\n	\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:3:{s:0:\"\";a:7:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:8:\"Español\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:24:\"https://es.wordpress.org\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:8:\"Español\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:13:\"lastBuildDate\";a:1:{i:0;a:5:{s:4:\"data\";s:34:\"\n	Thu, 13 Sep 2018 16:21:55 +0000	\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"language\";a:1:{i:0;a:5:{s:4:\"data\";s:5:\"es-ES\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:9:\"generator\";a:1:{i:0;a:5:{s:4:\"data\";s:40:\"https://wordpress.org/?v=5.0-alpha-43653\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"item\";a:10:{i:0;a:6:{s:4:\"data\";s:73:\"\n		\n		\n				\n				\n		\n				\n		\n		\n		\n		\n\n		\n				\n								\n							\n		\n							\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:5:{s:0:\"\";a:7:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:45:\"WordPress 4.9.8 – Versión de mantenimiento\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:77:\"https://es.wordpress.org/2018/08/03/wordpress-4-9-8-version-de-mantenimiento/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:86:\"https://es.wordpress.org/2018/08/03/wordpress-4-9-8-version-de-mantenimiento/#comments\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Fri, 03 Aug 2018 00:15:47 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"category\";a:5:{i:0;a:5:{s:4:\"data\";s:15:\"Actualizaciones\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:1;a:5:{s:4:\"data\";s:13:\"Mantenimiento\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:2;a:5:{s:4:\"data\";s:3:\"4.9\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:3;a:5:{s:4:\"data\";s:5:\"4.9.8\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:4;a:5:{s:4:\"data\";s:9:\"Gutenberg\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:32:\"https://es.wordpress.org/?p=2489\";s:7:\"attribs\";a:1:{s:0:\"\";a:1:{s:11:\"isPermaLink\";s:5:\"false\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:393:\"Estamos encantados de anunciar la disponibilidad inmediata de WordPress 4.9.8. Esta versión de mantenimiento soluciona 46 fallos, mejoras y benditas tareas, incluida la actualización del tema Twenty Seventeen incluido. A continuación tienes lo más destacado de las novedades. Mensaje “Prueba Gutenberg” A la mayoría de los usuarios se les mostrará un aviso en su escritorio [&#8230;]\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:16:\"Fernando Tellado\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:40:\"http://purl.org/rss/1.0/modules/content/\";a:1:{s:7:\"encoded\";a:1:{i:0;a:5:{s:4:\"data\";s:10195:\"<p>Estamos encantados de anunciar la disponibilidad inmediata de WordPress 4.9.8. Esta versión de mantenimiento soluciona 46 fallos, mejoras y benditas tareas, incluida la actualización del tema Twenty Seventeen incluido.</p>\n<p>A continuación tienes lo más destacado de las novedades.</p>\n<h2>Mensaje “Prueba Gutenberg”</h2>\n<p>A la mayoría de los usuarios se les mostrará un aviso en su escritorio de WordPress. Este “Prueba Gutenberg” es una oportunidad para los usuarios de usar el editor de bloques Gutenberg antes de su lanzamiento en WordPress 5.0.</p>\n<p><img class=\"alignnone wp-image-2490 size-large\" src=\"https://es.wordpress.org/files/2018/08/llamada-a-probar-gutenberg-wordpress-4.9.8-1024x587.png\" alt=\"\" width=\"612\" height=\"351\" srcset=\"https://es.wordpress.org/files/2018/08/llamada-a-probar-gutenberg-wordpress-4.9.8-1024x587.png 1024w, https://es.wordpress.org/files/2018/08/llamada-a-probar-gutenberg-wordpress-4.9.8-300x172.png 300w, https://es.wordpress.org/files/2018/08/llamada-a-probar-gutenberg-wordpress-4.9.8-768x441.png 768w\" sizes=\"(max-width: 612px) 100vw, 612px\" /></p>\n<p>En WordPress 4.9.8, el mensaje se mostrará a los siguientes usuarios:</p>\n<ul>\n<li>Si Gutenberg <em>no está</em> instalado o activo el mensaje se mostrará a los usuarios administradores en los sitios simples, y al super administrador en multisitios.</li>\n<li>Si Gutenberg <em>está</em> instalado y activo el mensaje se mostrará a usuarios colaboradores y superiores.</li>\n<li>Si está instalado y activo el plugin Classic Editor el mensaje se ocultará a todos los usuarios.</li>\n</ul>\n<p class=\"entry-title\">Puedes aprender más leyendo  <a href=\"https://make.wordpress.org/core/2018/08/02/try-gutenberg-callout-in-wordpress-4-9-8/\">“Try Gutenberg” Callout in WordPress 4.9.8 (en inglés)</a>.</p>\n<h2>Arreglos/mejoras de privacidad</h2>\n<p>Esta versión incluye 18 arreglos de privacidad centrados en asegurar la consistencia y flexibilidad en las nuevas herramientas de datos personales que se añadieron en la versión 4.9.6, incluyendo:</p>\n<ul>\n<li>El tipo de solicitud a confirmar ahora se incluye en la línea del asunto en todos los correos de confirmación de privacidad.</li>\n<li>Mejoras de consistencia con el nombre del sitio utilizado en los correos de privacidad en multisitio.</li>\n<li>Ahora se puede ajustar la paginación en las pantallas de administración de solicitudes de privacidad.</li>\n<li>Se ha incrementado la cobertura de pruebas para varias funciones de privacidad incluidas.</li>\n</ul>\n<p><a href=\"https://make.wordpress.org/core/2018/08/02/wordpress-4-9-8/\">Esta entrada tiene más información (en inglés) sobre todos los problemas solucionados en la versión 4.9.8 si quieres aprender más</a>.</p>\n<p><a href=\"https://es.wordpress.org/download/\">Descarga WordPress 4.9.8</a> o pásate por tu Escritorio → Actualizaciones y haz clic en &#8220;Actualizar ahora&#8221;. Los sitios compatibles con las actualizaciones automáticas en segundo plano ya están empezando a actualizarse automáticamente.</p>\n<p>Gracias a todos los que han contribuido a WordPress 4.9.8:</p>\n<p><a href=\"https://profiles.wordpress.org/1naveengiri/\">1naveengiri</a>, <a href=\"https://profiles.wordpress.org/aaroncampbell/\">Aaron D. Campbell</a>, <a href=\"https://profiles.wordpress.org/jorbin/\">Aaron Jorbin</a>, <a href=\"https://profiles.wordpress.org/abdullahramzan/\">Abdullah Ramzan</a>, <a href=\"https://profiles.wordpress.org/alejandroxlopez/\">alejandroxlopez</a>, <a href=\"https://profiles.wordpress.org/allendav/\">Allen Snook</a>, <a href=\"https://profiles.wordpress.org/afercia/\">Andrea Fercia</a>, <a href=\"https://profiles.wordpress.org/azaozz/\">Andrew Ozz</a>, <a href=\"https://profiles.wordpress.org/andrewtaylor-1/\">Andrew Taylor</a>, <a href=\"https://profiles.wordpress.org/aryamaaru/\">Arun</a>, <a href=\"https://profiles.wordpress.org/ayeshrajans/\">Ayesh Karunaratne</a>, <a href=\"https://profiles.wordpress.org/birgire/\">Birgir Erlendsson (birgire)</a>, <a href=\"https://profiles.wordpress.org/bph/\">Birgit Pauli-Haack</a>, <a href=\"https://profiles.wordpress.org/bjornw/\">BjornW</a>, <a href=\"https://profiles.wordpress.org/boonebgorges/\">Boone Gorges</a>, <a href=\"https://profiles.wordpress.org/kraftbj/\">Brandon Kraft</a>, <a href=\"https://profiles.wordpress.org/burhandodhy/\">Burhan Nasir</a>, <a href=\"https://profiles.wordpress.org/chetan200891/\">Chetan Prajapati</a>, <a href=\"https://profiles.wordpress.org/chrislema/\">Chris Lema</a>, <a href=\"https://profiles.wordpress.org/coreymckrill/\">Corey McKrill</a>, <a href=\"https://profiles.wordpress.org/danielbachhuber/\">Daniel Bachhuber</a>, <a href=\"https://profiles.wordpress.org/danieltj/\">Daniel James</a>, <a href=\"https://profiles.wordpress.org/dlh/\">David Herrera</a>, <a href=\"https://profiles.wordpress.org/dd32/\">Dion Hulse</a>, <a href=\"https://profiles.wordpress.org/ocean90/\">Dominik Schilling (ocean90)</a>, <a href=\"https://profiles.wordpress.org/dontstealmyfish/\">dontstealmyfish</a>, <a href=\"https://profiles.wordpress.org/dyrer/\">dyrer</a>, <a href=\"https://profiles.wordpress.org/felipeelia/\">Felipe Elia</a>, <a href=\"https://profiles.wordpress.org/flixos90/\">Felix Arntz</a>, <a href=\"https://profiles.wordpress.org/fclaussen/\">Fernando Claussen</a>, <a href=\"https://profiles.wordpress.org/garetharnold/\">Gareth</a>, <a href=\"https://profiles.wordpress.org/garrett-eclipse/\">Garrett Hyder</a>, <a href=\"https://profiles.wordpress.org/pento/\">Gary Pendergast</a>, <a href=\"https://profiles.wordpress.org/soulseekah/\">Gennady Kovshenin</a>, <a href=\"https://profiles.wordpress.org/gm_alex/\">GM_Alex</a>, <a href=\"https://profiles.wordpress.org/idea15/\">Heather Burns</a>, <a href=\"https://profiles.wordpress.org/iandunn/\">Ian Dunn</a>, <a href=\"https://profiles.wordpress.org/ianbelanger/\">ibelanger</a>, <a href=\"https://profiles.wordpress.org/imath/\">imath</a>, <a href=\"https://profiles.wordpress.org/audrasjb/\">Jb Audras</a>, <a href=\"https://profiles.wordpress.org/jpry/\">Jeremy Pry</a>, <a href=\"https://profiles.wordpress.org/johnjamesjacoby/\">JJJ</a>, <a href=\"https://profiles.wordpress.org/joemcgill/\">Joe McGill</a>, <a href=\"https://profiles.wordpress.org/joen/\">Joen Asmussen</a>, <a href=\"https://profiles.wordpress.org/johnbillion/\">John Blackbourn</a>, <a href=\"https://profiles.wordpress.org/desrosj/\">Jonathan Desrosiers</a>, <a href=\"https://profiles.wordpress.org/spacedmonkey/\">Jonny Harris</a>, <a href=\"https://profiles.wordpress.org/chanthaboune/\">Josepha</a>, <a href=\"https://profiles.wordpress.org/joshuawold/\">JoshuaWold</a>, <a href=\"https://profiles.wordpress.org/joyously/\">Joy</a>, <a href=\"https://profiles.wordpress.org/jrf/\">jrf</a>, <a href=\"https://profiles.wordpress.org/kadamwhite/\">K. Adam White</a>, <a href=\"https://profiles.wordpress.org/khaihong/\">khaihong</a>, <a href=\"https://profiles.wordpress.org/kjellr/\">kjellr</a>, <a href=\"https://profiles.wordpress.org/xkon/\">Konstantinos Xenos</a>, <a href=\"https://profiles.wordpress.org/laurelfulford/\">laurelfulford</a>, <a href=\"https://profiles.wordpress.org/lbenicio/\">lbenicio</a>, <a href=\"https://profiles.wordpress.org/leanderiversen/\">Leander Iversen</a>, <a href=\"https://profiles.wordpress.org/leemon/\">leemon</a>, <a href=\"https://profiles.wordpress.org/macbookandrew/\">macbookandrew</a>, <a href=\"https://profiles.wordpress.org/clorith/\">Marius L. J.</a>, <a href=\"https://profiles.wordpress.org/matveb/\">Matias Ventura</a>, <a href=\"https://profiles.wordpress.org/melchoyce/\">Mel Choyce</a>, <a href=\"https://profiles.wordpress.org/mensmaximus/\">mensmaximus</a>, <a href=\"https://profiles.wordpress.org/mermel/\">mermel</a>, <a href=\"https://profiles.wordpress.org/metalandcoffee/\">metalandcoffee</a>, <a href=\"https://profiles.wordpress.org/michelleweber/\">michelleweber</a>, <a href=\"https://profiles.wordpress.org/dimadin/\">Milan Dinić</a>, <a href=\"https://profiles.wordpress.org/xpertone/\">Muhammad Kashif</a>, <a href=\"https://profiles.wordpress.org/nao/\">Naoko Takano</a>, <a href=\"https://profiles.wordpress.org/nathanatmoz/\">Nathan Johnson</a>, <a href=\"https://profiles.wordpress.org/ov3rfly/\">Ov3rfly</a>, <a href=\"https://profiles.wordpress.org/palmiak/\">palmiak</a>, <a href=\"https://profiles.wordpress.org/pbiron/\">Paul Biron</a>, <a href=\"https://profiles.wordpress.org/pmbaldha/\">Prashant Baldha</a>, <a href=\"https://profiles.wordpress.org/presstigers/\">PressTigers</a>, <a href=\"https://profiles.wordpress.org/programmin/\">programmin</a>, <a href=\"https://profiles.wordpress.org/rafsuntaskin/\">Rafsun Chowdhury</a>, <a href=\"https://profiles.wordpress.org/redcastor/\">redcastor</a>, <a href=\"https://profiles.wordpress.org/littlerchicken/\">Robin Cornett</a>, <a href=\"https://profiles.wordpress.org/sergeybiryukov/\">Sergey Biryukov</a>, <a href=\"https://profiles.wordpress.org/pross/\">Simon Prosser</a>, <a href=\"https://profiles.wordpress.org/skoldin/\">skoldin</a>, <a href=\"https://profiles.wordpress.org/spyderbytes/\">spyderbytes</a>, <a href=\"https://profiles.wordpress.org/subrataemfluence/\">Subrata Sarkar</a>, <a href=\"https://profiles.wordpress.org/sebastienserre/\">Sébastien SERRE</a>, <a href=\"https://profiles.wordpress.org/karmatosed/\">Tammie Lister</a>, <a href=\"https://profiles.wordpress.org/tharsheblows/\">tharsheblows</a>, <a href=\"https://profiles.wordpress.org/thomasplevy/\">Thomas Patrick Levy</a>, <a href=\"https://profiles.wordpress.org/timbowesohft/\">timbowesohft</a>, <a href=\"https://profiles.wordpress.org/timothyblynjacobs/\">Timothy Jacobs</a>, <a href=\"https://profiles.wordpress.org/tz-media/\">Tobias Zimpel</a>, <a href=\"https://profiles.wordpress.org/tobifjellner/\">Tor-Bjorn Fjellner</a>, <a href=\"https://profiles.wordpress.org/itowhid06/\">Towhidul Islam</a>, <a href=\"https://profiles.wordpress.org/usmankhalid/\">Usman Khalid</a>, <a href=\"https://profiles.wordpress.org/warmlaundry/\">warmlaundry</a>, <a href=\"https://profiles.wordpress.org/earnjam/\">William Earnhardt</a>, <a href=\"https://profiles.wordpress.org/fierevere/\">Yui</a> y <a href=\"https://profiles.wordpress.org/yuriv/\">YuriV</a>.</p>\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:36:\"http://wellformedweb.org/CommentAPI/\";a:1:{s:10:\"commentRss\";a:1:{i:0;a:5:{s:4:\"data\";s:82:\"https://es.wordpress.org/2018/08/03/wordpress-4-9-8-version-de-mantenimiento/feed/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:38:\"http://purl.org/rss/1.0/modules/slash/\";a:1:{s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:1:\"3\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:1;a:6:{s:4:\"data\";s:67:\"\n		\n		\n				\n				\n		\n				\n		\n		\n\n		\n				\n								\n							\n		\n							\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:5:{s:0:\"\";a:7:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:60:\"WordPress 4.9.7, actualización de seguridad y mantenimiento\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:95:\"https://es.wordpress.org/2018/07/05/wordpress-4-9-7-actualizacion-de-seguridad-y-mantenimiento/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:104:\"https://es.wordpress.org/2018/07/05/wordpress-4-9-7-actualizacion-de-seguridad-y-mantenimiento/#comments\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Thu, 05 Jul 2018 18:57:15 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"category\";a:3:{i:0;a:5:{s:4:\"data\";s:13:\"Mantenimiento\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:1;a:5:{s:4:\"data\";s:9:\"Seguridad\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:2;a:5:{s:4:\"data\";s:5:\"4.9.7\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:32:\"https://es.wordpress.org/?p=2347\";s:7:\"attribs\";a:1:{s:0:\"\";a:1:{s:11:\"isPermaLink\";s:5:\"false\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:402:\"Ya está disponible WordPress 4.9.7. Es una actualización de seguridad y mantenimiento para todas las versiones desde WordPress 3.7. Te animamos a que actualices tus sitios inmediatamente. Las versiones de WordPress 4.9.6 y anteriores están afectadas por un problema con los medios que podría, potencialmente, permitir a un usuario con ciertas capacidades tratar de borrar archivos fuera [&#8230;]\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:16:\"Fernando Tellado\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:40:\"http://purl.org/rss/1.0/modules/content/\";a:1:{s:7:\"encoded\";a:1:{i:0;a:5:{s:4:\"data\";s:4293:\"<p>Ya está disponible WordPress 4.9.7. Es una <strong>actualización de seguridad y mantenimiento</strong> para todas las versiones desde WordPress 3.7. Te animamos a que actualices tus sitios inmediatamente.</p>\n<p>Las versiones de WordPress 4.9.6 y anteriores están afectadas por un problema con los medios que podría, potencialmente, permitir a un usuario con ciertas capacidades tratar de borrar archivos fuera del directorio de subidas.</p>\n<p>Gracias a <a href=\"https://hackerone.com/slavco\">Slavco</a> por informar del problema original y a <a href=\"https://www.wordfence.com/\">Matt Barry</a> por informar de problemas relacionados.</p>\n<p>Se han solucionado otros diecisiete fallos en WordPress 4.9.7. Anotamos aquí estos en particular:</p>\n<ul>\n<li>Taxonomía: Mejora de la gestión de caché en las peticiones de términos.</li>\n<li>Entradas, tipos de contenido: Limpieza de la cookie de contraseña perdida al salir de la sesión.</li>\n<li>Widgets: Se permiten etiquetas HTML básicas en las descripciones de la barra lateral en la pantalla de administración de widgets.</li>\n<li>Escritorio de eventos de la comunidad: Siempre se muestra la WordCamp cercana siguiente, aunque haya varias meetups antes.</li>\n<li>Privacidad: Nos aseguramos de que el contenido por defecto de la política de privacidad no provoque un error fatal al modificar las reglas de rewrite fuera del contexto de la administración.</li>\n</ul>\n<p><a href=\"https://es.wordpress.org/txt-download/\">Descarga WordPress 4.9.7</a> o pásate por Escritorio → Actualizaciones y haz clic en “Actualizar ahora.” Los sitios compatibles con actualizaciones automáticas de fondo ya se están empezando a actualizar automáticamente.</p>\n<p>La anteriormente programada como 4.9.7 ahora será la 4.9.8, y seguirá <a href=\"https://make.wordpress.org/core/2018/07/04/dev-chat-summary-july-4th-4-9-7-week-7/\">la programación de lanzamiento publicada ayer</a>.</p>\n<p>Gracias a todos los que han contribuido a WordPress 4.9.7:</p>\n<p><a href=\"https://profiles.wordpress.org/1naveengiri/\">1naveengiri</a>, <a href=\"https://profiles.wordpress.org/jorbin/\">Aaron Jorbin</a>, <a href=\"https://profiles.wordpress.org/abdullahramzan/\">abdullahramzan</a>, <a href=\"https://profiles.wordpress.org/alejandroxlopez/\">alejandroxlopez</a>, <a href=\"https://profiles.wordpress.org/azaozz/\">Andrew Ozz</a>, <a href=\"https://profiles.wordpress.org/aryamaaru/\">Arun</a>, <a href=\"https://profiles.wordpress.org/birgire/\">Birgir Erlendsson (birgire)</a>, <a href=\"https://profiles.wordpress.org/bjornw/\">BjornW</a>, <a href=\"https://profiles.wordpress.org/boonebgorges/\">Boone Gorges</a>, <a href=\"https://profiles.wordpress.org/kraftbj/\">Brandon Kraft</a>, <a href=\"https://profiles.wordpress.org/chetan200891/\">Chetan Prajapati</a>, <a href=\"https://profiles.wordpress.org/dlh/\">David Herrera</a>, <a href=\"https://profiles.wordpress.org/flixos90/\">Felix Arntz</a>, <a href=\"https://profiles.wordpress.org/garetharnold/\">Gareth</a>, <a href=\"https://profiles.wordpress.org/iandunn/\">Ian Dunn</a>, <a href=\"https://profiles.wordpress.org/ianbelanger/\">ibelanger</a>, <a href=\"https://profiles.wordpress.org/johnbillion/\">John Blackbourn</a>, <a href=\"https://profiles.wordpress.org/desrosj/\">Jonathan Desrosiers</a>, <a href=\"https://profiles.wordpress.org/joyously/\">Joy</a>, <a href=\"https://profiles.wordpress.org/khaihong/\">khaihong</a>, <a href=\"https://profiles.wordpress.org/lbenicio/\">lbenicio</a>, <a href=\"https://profiles.wordpress.org/leanderiversen/\">Leander Iversen</a>, <a href=\"https://profiles.wordpress.org/mermel/\">mermel</a>, <a href=\"https://profiles.wordpress.org/metalandcoffee/\">metalandcoffee</a>, <a href=\"https://profiles.wordpress.org/jbpaul17/\">Migrated to @jeffpaul</a>, <a href=\"https://profiles.wordpress.org/palmiak/\">palmiak</a>, <a href=\"https://profiles.wordpress.org/sergeybiryukov/\">Sergey Biryukov</a>, <a href=\"https://profiles.wordpress.org/skoldin/\">skoldin</a>, <a href=\"https://profiles.wordpress.org/subrataemfluence/\">Subrata Sarkar</a>, <a href=\"https://profiles.wordpress.org/itowhid06/\">Towhidul Islam</a>, <a href=\"https://profiles.wordpress.org/warmlaundry/\">warmlaundry</a>, y <a href=\"https://profiles.wordpress.org/yuriv/\">YuriV</a>.</p>\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:36:\"http://wellformedweb.org/CommentAPI/\";a:1:{s:10:\"commentRss\";a:1:{i:0;a:5:{s:4:\"data\";s:100:\"https://es.wordpress.org/2018/07/05/wordpress-4-9-7-actualizacion-de-seguridad-y-mantenimiento/feed/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:38:\"http://purl.org/rss/1.0/modules/slash/\";a:1:{s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:1:\"2\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:2;a:6:{s:4:\"data\";s:61:\"\n		\n		\n				\n				\n		\n				\n\n		\n				\n								\n							\n		\n							\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:5:{s:0:\"\";a:7:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:91:\"La Comunidad WordPress España mejor comunidad tecnológica en los premios Open Awards 2018\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:52:\"https://es.wordpress.org/2018/06/25/openawards-2018/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:60:\"https://es.wordpress.org/2018/06/25/openawards-2018/#respond\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Mon, 25 Jun 2018 08:00:13 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"category\";a:1:{i:0;a:5:{s:4:\"data\";s:7:\"General\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:32:\"https://es.wordpress.org/?p=2300\";s:7:\"attribs\";a:1:{s:0:\"\";a:1:{s:11:\"isPermaLink\";s:5:\"false\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:360:\"Durante el desarrollo del evento OpenExpo Europe 2018, como cada año, se entregaron los premios Open Awards a empresas y comunidades destacadas en el uso, difusión y promoción de aplicaciones Open Source. Este año, por primera vez, se presentó la Comunidad WordPress España, resultando como ganadora de la sección en la que se presentó: Mejor [&#8230;]\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:16:\"Fernando Tellado\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:40:\"http://purl.org/rss/1.0/modules/content/\";a:1:{s:7:\"encoded\";a:1:{i:0;a:5:{s:4:\"data\";s:2364:\"<p>Durante el desarrollo del evento <strong>OpenExpo Europe 2018</strong>, como cada año, se entregaron los premios <a href=\"https://openexpoeurope.com/es/oe2018/open-awards/\" target=\"_blank\" rel=\"noopener noreferrer\">Open Awards</a> a empresas y comunidades destacadas en el uso, <strong>difusión y promoción de aplicaciones Open Source</strong>.</p>\n<p>Este año, por primera vez, se presentó la <strong>Comunidad WordPress España</strong>, <strong>resultando como ganadora de la sección en la que se presentó: Mejor Comunidad Tecnológica</strong>.</p>\n<p><img class=\"size-large wp-image-2301 aligncenter\" src=\"https://es.wordpress.org/files/2018/06/sellos-ganadores-comunidad-1024x967.png\" alt=\"\" width=\"612\" height=\"578\" srcset=\"https://es.wordpress.org/files/2018/06/sellos-ganadores-comunidad-1024x967.png 1024w, https://es.wordpress.org/files/2018/06/sellos-ganadores-comunidad-300x283.png 300w, https://es.wordpress.org/files/2018/06/sellos-ganadores-comunidad-768x725.png 768w\" sizes=\"(max-width: 612px) 100vw, 612px\" /></p>\n<p>A la entrega del galardón acudieron varios miembros de la comunidad, agradeciendo <strong>el reconocimiento que supone para WordPress y su comunidad de usuarios, el verdadero motor, este galardón</strong>.</p>\n<p><img class=\"size-large wp-image-2302 aligncenter\" src=\"https://es.wordpress.org/files/2018/06/ganadores-open-awards-2018-1024x754.jpg\" alt=\"\" width=\"612\" height=\"451\" srcset=\"https://es.wordpress.org/files/2018/06/ganadores-open-awards-2018-1024x754.jpg 1024w, https://es.wordpress.org/files/2018/06/ganadores-open-awards-2018-300x221.jpg 300w, https://es.wordpress.org/files/2018/06/ganadores-open-awards-2018-768x565.jpg 768w, https://es.wordpress.org/files/2018/06/ganadores-open-awards-2018.jpg 1600w\" sizes=\"(max-width: 612px) 100vw, 612px\" /></p>\n<p>En el siguiente vídeo puedes revivir el momento de recogida del galardón, así como las palabras de Alejandro Gil, organizador de WordCamp Zaragoza, promotor de la idea de presentar este año a la comunidad a estos prestigiosos premios.</p>\n<p><iframe class=\'youtube-player\' type=\'text/html\' width=\'612\' height=\'375\' src=\'https://www.youtube.com/embed/SSnLU9-fZ8c?version=3&#038;rel=1&#038;fs=1&#038;autohide=2&#038;showsearch=0&#038;showinfo=1&#038;iv_load_policy=1&#038;wmode=transparent\' allowfullscreen=\'true\' style=\'border:0;\'></iframe></p>\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:36:\"http://wellformedweb.org/CommentAPI/\";a:1:{s:10:\"commentRss\";a:1:{i:0;a:5:{s:4:\"data\";s:57:\"https://es.wordpress.org/2018/06/25/openawards-2018/feed/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:38:\"http://purl.org/rss/1.0/modules/slash/\";a:1:{s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:1:\"0\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:3;a:6:{s:4:\"data\";s:64:\"\n		\n		\n				\n				\n		\n				\n		\n\n		\n				\n								\n							\n		\n							\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:5:{s:0:\"\";a:7:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:46:\"Actualización de las políticas de privacidad\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:81:\"https://es.wordpress.org/2018/05/29/actualizacion-de-las-politicas-de-privacidad/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:89:\"https://es.wordpress.org/2018/05/29/actualizacion-de-las-politicas-de-privacidad/#respond\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 29 May 2018 11:26:21 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"category\";a:2:{i:0;a:5:{s:4:\"data\";s:7:\"General\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:1;a:5:{s:4:\"data\";s:4:\"RGPD\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:32:\"https://es.wordpress.org/?p=2224\";s:7:\"attribs\";a:1:{s:0:\"\";a:1:{s:11:\"isPermaLink\";s:5:\"false\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:369:\"Las políticas de privacidad de WordPress.org se han actualizado para garantizar el cumplimiento del Reglamento General de Protección de Datos (RGPD) de la Unión Europea. En la nueva redacción de las políticas de privacidad &#8211; totalmente en español &#8211; se ha cuidado de dar toda la información, del modo más sencillo y comprensible, sobre qué [&#8230;]\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:16:\"Fernando Tellado\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:40:\"http://purl.org/rss/1.0/modules/content/\";a:1:{s:7:\"encoded\";a:1:{i:0;a:5:{s:4:\"data\";s:1162:\"<p>Las <a href=\"https://es.wordpress.org/about/privacy/\">políticas de privacidad de WordPress.org</a> se han actualizado para garantizar el cumplimiento del Reglamento General de Protección de Datos (RGPD) de la Unión Europea.</p>\n<p>En la nueva redacción de las políticas de privacidad &#8211; totalmente en español &#8211; se ha cuidado de dar toda la información, del modo más sencillo y comprensible, sobre qué datos se recogen en WordPress.org (y sitios asociados), cómo se tratan y de los derechos que tienes sobre tus datos personales.</p>\n<p>Creemos que incluso son entretenidas de leer, y ¡te animamos a hacerlo! <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f609.png\" alt=\"😉\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n<p>Nada más de momento, si quieres saber…</p>\n<ul>\n<li>Qué datos recopilamos y cómo lo hacemos</li>\n<li>Cuánto tiempo los conservamos y los motivos</li>\n<li>Cómo puedes ejercer tus derechos de revisión, cancelación, privacidad, acceso y olvido</li>\n</ul>\n<p>Aquí tienes <a href=\"https://es.wordpress.org/about/privacy/\">las nuevas políticas de privacidad de WordPress.org</a></p>\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:36:\"http://wellformedweb.org/CommentAPI/\";a:1:{s:10:\"commentRss\";a:1:{i:0;a:5:{s:4:\"data\";s:86:\"https://es.wordpress.org/2018/05/29/actualizacion-de-las-politicas-de-privacidad/feed/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:38:\"http://purl.org/rss/1.0/modules/slash/\";a:1:{s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:1:\"0\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:4;a:6:{s:4:\"data\";s:67:\"\n		\n		\n				\n				\n		\n				\n		\n		\n\n		\n				\n								\n							\n		\n							\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:5:{s:0:\"\";a:7:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:61:\"WordPress 4.9.6, actualización de privacidad y mantenimiento\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:96:\"https://es.wordpress.org/2018/05/17/wordpress-4-9-6-actualizacion-de-privacidad-y-mantenimiento/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:105:\"https://es.wordpress.org/2018/05/17/wordpress-4-9-6-actualizacion-de-privacidad-y-mantenimiento/#comments\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Thu, 17 May 2018 20:34:43 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"category\";a:3:{i:0;a:5:{s:4:\"data\";s:15:\"Actualizaciones\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:1;a:5:{s:4:\"data\";s:3:\"4.9\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:2;a:5:{s:4:\"data\";s:5:\"4.9.6\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:32:\"https://es.wordpress.org/?p=2192\";s:7:\"attribs\";a:1:{s:0:\"\";a:1:{s:11:\"isPermaLink\";s:5:\"false\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:351:\"Ya está disponible WordPress 4.9.6. Esta es una actualización de privacidad y mantenimiento. Te animamos a que actualices tus sitios y disfrutes de las nuevas funcionalidades de privacidad Privacidad El Reglamento General de Protección de Datos (RGPD) de la Unión Europea entra en vigor el 25 de mayo. El RGPD requiere que las empresas y [&#8230;]\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:16:\"Fernando Tellado\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:40:\"http://purl.org/rss/1.0/modules/content/\";a:1:{s:7:\"encoded\";a:1:{i:0;a:5:{s:4:\"data\";s:12482:\"<p>Ya está disponible WordPress 4.9.6. Esta es <strong>una actualización de privacidad y mantenimiento</strong>. Te animamos a que actualices tus sitios y disfrutes de las nuevas funcionalidades de privacidad</p>\n<p><img class=\"alignnone size-full wp-image-2193\" src=\"https://es.wordpress.org/files/2018/05/GDPR-Banner.png\" alt=\"\" width=\"1264\" height=\"632\" srcset=\"https://es.wordpress.org/files/2018/05/GDPR-Banner.png 1264w, https://es.wordpress.org/files/2018/05/GDPR-Banner-300x150.png 300w, https://es.wordpress.org/files/2018/05/GDPR-Banner-768x384.png 768w, https://es.wordpress.org/files/2018/05/GDPR-Banner-1024x512.png 1024w\" sizes=\"(max-width: 1264px) 100vw, 1264px\" /></p>\n<h2>Privacidad</h2>\n<p>El Reglamento General de Protección de Datos (<strong>RGPD</strong>) de la Unión Europea entra en vigor el 25 de mayo. El RGPD requiere que las empresas y propietarios de sitios sean transparentes acerca de cómo recopilan, usan y comparten datos personales. También da a los individuos más acceso y capacidad de elección en lo que se refiere a cómo se recopilan, usan y comparten sus datos personales.</p>\n<p>Es importante comprender que aunque el RGPD es una regulación europea, sus requisitos se aplican a todos los sitios y negocios online que recopilen, almacenen y procesen datos personales de residentes en la UE, da igual dónde esté situado el negocio.</p>\n<p>Puedes aprender más sobre el RGPD en <a href=\"http://ec.europa.eu/justice/smedataprotect/index_es.htm\" target=\"_blank\" rel=\"noopener noreferrer\">la página de protección de datos</a> de la Comisión Europea.</p>\n<p>Estamos comprometidos en ayudar a los propietarios de sitios de todo el mundo a su tarea de cumplir con esta importante ley. Como parte de este esfuerzo hemos añadido en esta actualización nuevas funcionalidades de privacidad.</p>\n<h2>Comentarios</h2>\n<p><img class=\"alignnone size-full wp-image-2194\" src=\"https://es.wordpress.org/files/2018/05/comments-border.png\" alt=\"\" width=\"1264\" height=\"1224\" srcset=\"https://es.wordpress.org/files/2018/05/comments-border.png 1264w, https://es.wordpress.org/files/2018/05/comments-border-300x291.png 300w, https://es.wordpress.org/files/2018/05/comments-border-768x744.png 768w, https://es.wordpress.org/files/2018/05/comments-border-1024x992.png 1024w\" sizes=\"(max-width: 1264px) 100vw, 1264px\" /></p>\n<p>Los comentaristas no conectados tendrán la opción de elegir si quieren que su nombre, dirección de correo electrónico y web se guarden en una cookie de su navegador.</p>\n<h2>Página de políticas de privacidad</h2>\n<p><img class=\"alignnone size-full wp-image-2195\" src=\"https://es.wordpress.org/files/2018/05/privacy-policy-collapsed.png\" alt=\"\" width=\"1264\" height=\"745\" srcset=\"https://es.wordpress.org/files/2018/05/privacy-policy-collapsed.png 1264w, https://es.wordpress.org/files/2018/05/privacy-policy-collapsed-300x177.png 300w, https://es.wordpress.org/files/2018/05/privacy-policy-collapsed-768x453.png 768w, https://es.wordpress.org/files/2018/05/privacy-policy-collapsed-1024x604.png 1024w\" sizes=\"(max-width: 1264px) 100vw, 1264px\" /></p>\n<p>Los propietarios de sitios pueden ahora designar una página de políticas de privacidad. Esta pagina se mostrará en tus páginas de acceso y registro. Deberías añadir manualmente un enlace a tus políticas en todas las páginas de tu web. Si tienes un menú en el pie de página ese es un fantástico lugar para incluir tus políticas de privacidad.</p>\n<p>Además, hemos creado una guía que incluye ideas de WordPress y plugins adaptados sobre cómo gestionan los datos personales. Estas ideas puedes copiarlas y pegarlas en la política de privacidad de tu sitio para ayudarte a empezar.</p>\n<p>Si mantienes un plugin que recopila datos te recomendamos que incluyas esa información en la guía de políticas de privacidad de WordPress. <a href=\"https://developer.wordpress.org/plugins/privacy/\">Aprende más en nuestra sección de privacidad del manual de plugins</a>.</p>\n<h2>Gestión de los datos</h2>\n<p><img class=\"alignnone size-full wp-image-2196\" src=\"https://es.wordpress.org/files/2018/05/export-data.png\" alt=\"\" width=\"1264\" height=\"929\" srcset=\"https://es.wordpress.org/files/2018/05/export-data.png 1264w, https://es.wordpress.org/files/2018/05/export-data-300x220.png 300w, https://es.wordpress.org/files/2018/05/export-data-768x564.png 768w, https://es.wordpress.org/files/2018/05/export-data-1024x753.png 1024w\" sizes=\"(max-width: 1264px) 100vw, 1264px\" /></p>\n<h3 class=\"layout-column-1\">Exportación de datos</h3>\n<p>Los propietarios de sitios pueden exportar un archivo ZIP que contiene los datos personales del usuario, usando datos obtenidos de WordPress y plugins adaptados.</p>\n<h3 class=\"layout-column-2\">Borrado de datos</h3>\n<p class=\"layout-column-2\">Los propietarios de sitios pueden borrar datos personales de los usuarios, incluidos datos recopilados de plugins adaptados.</p>\n<blockquote><p>Hola,</p>\n<p>Se ha realizado una solicitud de realizar la siguiente acción en tu cuenta:</p>\n<p><strong>Exportar datos personales</strong></p>\n<p>Para confirmar esto, por favor, haz clic en el siguiente enlace:<br />\n<a href=\"https://wordpress.org/news/2018/05/wordpress-4-9-6-privacy-and-maintenance-release/#\">http://.wordpress.org/wp-login.php?action=confirmaction…</a></p>\n<p>Puedes ignorar con seguridad este correo si no quieres llevar a cabo esta acción.</p>\n<p>Este correo se han enviado a <a href=\"https://wordpress.org/news/2018/05/wordpress-4-9-6-privacy-and-maintenance-release/#\">you@example.com</a>.</p>\n<p>Saludos,<br />\n<em>Tus amigos de WordPress</em><br />\n<a href=\"https://wordpress.org/\"><em>http://wordpress.org</em></a></p></blockquote>\n<p>Los propietarios de sitios tienen un método basado en correos electrónicos que pueden usar para confirmar las solicitudes de datos. Esta herramienta de confirmación de solicitudes funciona tanto para solicitudes de exportación como de borrado, y para usuarios registrados y comentaristas.</p>\n<hr />\n<h2>Mantenimiento</h2>\n<p>Se han realizado 95 actualizaciones en WordPress 4.9.6. Además de lo anterior, queremos destacar particularmente:</p>\n<ul>\n<li>“Mío” se ha añadido como filtro en la biblioteca de medios.</li>\n<li>Al ver un plugin en la administración, ahora te dice la versión mínima requerida de PHP.</li>\n<li>Hemos añadido nuevos polyfills de PHP para compatibilidad futura y una mejor validación de variables.</li>\n<li>TinyMCE se ha actualizado a la última versión (4.7.11).</li>\n</ul>\n<p><a href=\"https://make.wordpress.org/core/2018/05/17/4-9-6-update-guide/\">Esta entrada tiene más información sobre todos los fallos solucionados en la versión 4.9.6, si quieres aprender más</a>.</p>\n<p><a href=\"https://es.wordpress.org/txt-download/\">Descarga WordPress 4.9.6</a> o pásate por Escritorio → Actualizaciones y haz clic en “Actualizar ahora.” Los sitios compatibles con actualizaciones automáticas de fondo ya se están empezando a actualizar automáticamente</p>\n<p class=\"has-background has-very-light-gray-background-color\">Por favor, ten en cuenta que si estás actualmente en WordPress 4.9.3 deberías actualizar manualmente tu sitio de inmediato.</p>\n<hr class=\"wp-block-separator\" />\n<p>Gracias a todos los que han contribuido a WordPress 4.9.6:<br />\n<a href=\"https://profiles.wordpress.org/aaroncampbell/\">Aaron D. Campbell</a>, <a href=\"https://profiles.wordpress.org/jorbin/\">Aaron Jorbin</a>, <a href=\"https://profiles.wordpress.org/abdullahramzan/\">abdullahramzan</a>, <a href=\"https://profiles.wordpress.org/adamsilverstein/\">Adam Silverstein</a>, <a href=\"https://profiles.wordpress.org/schlessera/\">Alain Schlesser</a>, <a href=\"https://profiles.wordpress.org/allendav/\">allendav</a>, <a href=\"https://profiles.wordpress.org/afercia/\">Andrea Fercia</a>, <a href=\"https://profiles.wordpress.org/andreamiddleton/\">Andrea Middleton</a>, <a href=\"https://profiles.wordpress.org/azaozz/\">Andrew Ozz</a>, <a href=\"https://profiles.wordpress.org/ayeshrajans/\">Ayesh Karunaratne</a>, <a href=\"https://profiles.wordpress.org/birgire/\">Birgir Erlendsson (birgire)</a>, <a href=\"https://profiles.wordpress.org/bridgetwillard/\">bridgetwillard</a>, <a href=\"https://profiles.wordpress.org/burlingtonbytes/\">Burlington Bytes</a>, <a href=\"https://profiles.wordpress.org/chetan200891/\">Chetan Prajapati</a>, <a href=\"https://profiles.wordpress.org/claudiu/\">claudiu</a>, <a href=\"https://profiles.wordpress.org/coreymckrill/\">Corey McKrill</a>, <a href=\"https://profiles.wordpress.org/danielbachhuber/\">Daniel Bachhuber</a>, <a href=\"https://profiles.wordpress.org/dlh/\">David Herrera</a>, <a href=\"https://profiles.wordpress.org/ocean90/\">Dominik Schilling (ocean90)</a>, <a href=\"https://profiles.wordpress.org/iseulde/\">Ella Van Dorpe</a>, <a href=\"https://profiles.wordpress.org/ericdaams/\">Eric Daams</a>, <a href=\"https://profiles.wordpress.org/fclaussen/\">Fernando Claussen</a>, <a href=\"https://profiles.wordpress.org/garrett-eclipse/\">Garrett Hyder</a>, <a href=\"https://profiles.wordpress.org/pento/\">Gary Pendergast</a>, <a href=\"https://profiles.wordpress.org/idea15/\">Heather Burns</a>, <a href=\"https://profiles.wordpress.org/helen/\">Helen Hou-Sandi</a>, <a href=\"https://profiles.wordpress.org/herregroen/\">herregroen</a>, <a href=\"https://profiles.wordpress.org/iandunn/\">Ian Dunn</a>, <a href=\"https://profiles.wordpress.org/ianbelanger/\">ibelanger</a>, <a href=\"https://profiles.wordpress.org/imath/\">imath</a>, <a href=\"https://profiles.wordpress.org/audrasjb/\">Jb Audras</a>, <a href=\"https://profiles.wordpress.org/jeffpaul/\">Jeffrey Paul</a>, <a href=\"https://profiles.wordpress.org/jeremyfelt/\">Jeremy Felt</a>, <a href=\"https://profiles.wordpress.org/jesperher/\">Jesper V Nielsen</a>, <a href=\"https://profiles.wordpress.org/johnjamesjacoby/\">JJJ</a>, <a href=\"https://profiles.wordpress.org/joemcgill/\">Joe McGill</a>, <a href=\"https://profiles.wordpress.org/johnbillion/\">John Blackbourn</a>, <a href=\"https://profiles.wordpress.org/desrosj/\">Jonathan Desrosiers</a>, <a href=\"https://profiles.wordpress.org/chanthaboune/\">Josepha</a>, <a href=\"https://profiles.wordpress.org/jrf/\">jrf</a>, <a href=\"https://profiles.wordpress.org/dejliglama/\">Kåre Mulvad Steffensen</a>, <a href=\"https://profiles.wordpress.org/lakenh/\">Laken Hafner</a>, <a href=\"https://profiles.wordpress.org/laurelfulford/\">laurelfulford</a>, <a href=\"https://profiles.wordpress.org/lbenicio/\">lbenicio</a>, <a href=\"https://profiles.wordpress.org/macbookandrew/\">macbookandrew</a>, <a href=\"https://profiles.wordpress.org/clorith/\">Marius L. J.</a>, <a href=\"https://profiles.wordpress.org/melchoyce/\">Mel Choyce</a>, <a href=\"https://profiles.wordpress.org/mnelson4/\">Michael Nelson</a>, <a href=\"https://profiles.wordpress.org/mikejolley/\">Mike Jolley</a>, <a href=\"https://profiles.wordpress.org/casiepa/\">Pascal Casier</a>, <a href=\"https://profiles.wordpress.org/pbarthmaier/\">pbrocks</a>, <a href=\"https://profiles.wordpress.org/postphotos/\">postphotos</a>, <a href=\"https://profiles.wordpress.org/pmbaldha/\">Prashant Baldha</a>, <a href=\"https://profiles.wordpress.org/presstigers/\">PressTigers</a>, <a href=\"https://profiles.wordpress.org/programmin/\">programmin</a>, <a href=\"https://profiles.wordpress.org/littlerchicken/\">Robin Cornett</a>, <a href=\"https://profiles.wordpress.org/sergeybiryukov/\">Sergey Biryukov</a>, <a href=\"https://profiles.wordpress.org/satollo/\">Stefano Lissa</a>, <a href=\"https://profiles.wordpress.org/stephdau/\">Stephane Daury (stephdau)</a>, <a href=\"https://profiles.wordpress.org/subrataemfluence/\">Subrata Sarkar</a>, <a href=\"https://profiles.wordpress.org/karmatosed/\">Tammie Lister</a>, <a href=\"https://profiles.wordpress.org/teddytime/\">teddytime</a>, <a href=\"https://profiles.wordpress.org/thomasplevy/\">thomasplevy</a>, <a href=\"https://profiles.wordpress.org/timothyblynjacobs/\">Timothy Jacobs</a>, <a href=\"https://profiles.wordpress.org/tz-media/\">Tobias Zimpel</a>, <a href=\"https://profiles.wordpress.org/tjnowell/\">Tom J Nowell</a>, <a href=\"https://profiles.wordpress.org/tobifjellner/\">Tor-Bjorn Fjellner</a>, <a href=\"https://profiles.wordpress.org/itowhid06/\">Towhidul Islam</a>, <a href=\"https://profiles.wordpress.org/voneff/\">voneff</a>, <a href=\"https://profiles.wordpress.org/earnjam/\">William Earnhardt</a>, y <a href=\"https://profiles.wordpress.org/xkon/\">Xenos (xkon) Konstantinos</a>.</p>\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:36:\"http://wellformedweb.org/CommentAPI/\";a:1:{s:10:\"commentRss\";a:1:{i:0;a:5:{s:4:\"data\";s:101:\"https://es.wordpress.org/2018/05/17/wordpress-4-9-6-actualizacion-de-privacidad-y-mantenimiento/feed/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:38:\"http://purl.org/rss/1.0/modules/slash/\";a:1:{s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:1:\"4\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:5;a:6:{s:4:\"data\";s:61:\"\n		\n		\n				\n				\n		\n				\n\n		\n				\n								\n							\n		\n							\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:5:{s:0:\"\";a:7:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Noticias y eventos de la semana\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:86:\"https://es.wordpress.org/2018/04/16/noticias-y-eventos-wordpress-para-la-semana-16-18/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:94:\"https://es.wordpress.org/2018/04/16/noticias-y-eventos-wordpress-para-la-semana-16-18/#respond\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Mon, 16 Apr 2018 07:02:12 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"category\";a:1:{i:0;a:5:{s:4:\"data\";s:7:\"General\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:32:\"https://es.wordpress.org/?p=2176\";s:7:\"attribs\";a:1:{s:0:\"\";a:1:{s:11:\"isPermaLink\";s:5:\"false\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:355:\"¡Hola a todos! Os dejamos como todas las semanas el listado con los próximos Meetups de WordPress alrededor de España y el avance de las distintas WordCamps. Meetups de esta semana 16/04 &#8211; Aljarafe &#8211; ¿Qué es la Comunidad de WordPress? 16/04 &#8211; Las Palmas de Gran Canaria &#8211; Custom Post Types, más allá de los posts [&#8230;]\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:15:\"Mauricio Gelves\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:40:\"http://purl.org/rss/1.0/modules/content/\";a:1:{s:7:\"encoded\";a:1:{i:0;a:5:{s:4:\"data\";s:6778:\"<p><img class=\"aligncenter size-full wp-image-1150\" src=\"https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png\" alt=\"Eventos WordPress para esta semana en españa\" width=\"1280\" height=\"476\" srcset=\"https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png 1280w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-300x112.png 300w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-768x286.png 768w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-1024x381.png 1024w\" sizes=\"(max-width: 1280px) 100vw, 1280px\" /></p>\n<p><strong>¡Hola a todos! </strong>Os dejamos como todas las semanas el listado con los próximos Meetups de <strong>WordPress</strong> alrededor de España y el avance de las distintas WordCamps.</p>\n<h2>Meetups de esta semana</h2>\n<ul>\n<li>16/04 &#8211; <b>Aljarafe</b> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Aljarafe-Meetup/events/249354153/\">¿Qué es la Comunidad de WordPress?</a></li>\n<li>16/04 &#8211; <strong>Las Palmas de Gran Canaria</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Las-Palmas-de-Gran-Canaria-WordPress-Meetup/events/249453046/\">Custom Post Types, más allá de los posts</a></li>\n<li>17/04 &#8211; <strong>Alcalá de Henares</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Alcala-de-Henares-WordPress-Meetup/events/248737011/\">Primeros pasos con Gutenberg</a></li>\n<li>18/04 &#8211; <strong>Cádiz</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Cadiz-WordPress-Meetup/events/249490722/\">Google Search Console y otros tips de SEO</a></li>\n<li>18/04 &#8211; <strong>Granada</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Granada-WordPress-Meetup/events/248339276/\">Exprimir el flujo de compra en WooCommerce: Vender más con menos esfuerzo</a></li>\n<li>18/04 &#8211; <strong>Zaragoza</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Zaragoza/events/249090276/\">Taller de Gutenberg</a></li>\n<li>21/04 &#8211; <strong>Molins de Rei</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Molins-de-Rei/events/249454091/\">Descobreix Gutenberg, el nou editor de WordPress</a></li>\n</ul>\n<h2>Próximas WordCamps</h2>\n<p>Sigue de cerca la organización de los próximos WordCamps que se celebrarán en España durante el 2018.</p>\n<p>&#8212;&#8212;&#8212;</p>\n<p><img class=\"size-full wp-image-1983 alignnone\" src=\"https://es.wordpress.org/files/2018/01/wordcamp-madrid-2018.jpg\" alt=\"wordcamp madrid 2018\" width=\"434\" height=\"190\" srcset=\"https://es.wordpress.org/files/2018/01/wordcamp-madrid-2018.jpg 434w, https://es.wordpress.org/files/2018/01/wordcamp-madrid-2018-300x131.jpg 300w\" sizes=\"(max-width: 434px) 100vw, 434px\" /></p>\n<h3>WordCamp Madrid | 21-22 de Abril 2018</h3>\n<p><a href=\"https://2018.madrid.wordcamp.org/\" target=\"_blank\" rel=\"noopener noreferrer\">Web</a> | <a href=\"https://2018.madrid.wordcamp.org/anuncios/llamada-a-ponentes/\">Ponentes</a> | <a href=\"https://2018.laspalmas.wordcamp.org/llamada-a-voluntarios/\">Voluntarios</a> | <a href=\"https://2018.madrid.wordcamp.org/anuncios/llamada-a-patrocinadores/\">Patrocinadores</a> | <a href=\"https://2018.madrid.wordcamp.org/programa/\">Programa</a> | <a href=\"https://2018.madrid.wordcamp.org/entradas/\">Tickets</a> <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n<hr />\n<h3><img class=\"size-full wp-image-2179 alignnone\" src=\"https://es.wordpress.org/files/2018/04/wordcamp-bilbao-2018-logo.png\" alt=\"WordCamp Bilbao 2018 Logo\" width=\"434\" height=\"190\" srcset=\"https://es.wordpress.org/files/2018/04/wordcamp-bilbao-2018-logo.png 434w, https://es.wordpress.org/files/2018/04/wordcamp-bilbao-2018-logo-300x131.png 300w\" sizes=\"(max-width: 434px) 100vw, 434px\" /></h3>\n<h3></h3>\n<h3>WordCamp Bilbao | 19-20 de Mayo 2018</h3>\n<p><a href=\"https://2018.bilbao.wordcamp.org/\">Web</a> | <a href=\"https://2018.bilbao.wordcamp.org/llamada-ponentes/\">Ponentes</a> | <a href=\"https://2018.bilbao.wordcamp.org/llamada-voluntarios/\">Voluntarios</a> | <a href=\"https://2018.bilbao.wordcamp.org/patrocinadores/patrocina/\">Patrocinadores</a> | Programa | Tickets <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n<hr />\n<h3><img class=\"size-full wp-image-2178 alignnone\" src=\"https://es.wordpress.org/files/2018/04/wordcamp-irun-logo.png\" alt=\"\" width=\"434\" height=\"190\" srcset=\"https://es.wordpress.org/files/2018/04/wordcamp-irun-logo.png 434w, https://es.wordpress.org/files/2018/04/wordcamp-irun-logo-300x131.png 300w\" sizes=\"(max-width: 434px) 100vw, 434px\" /></h3>\n<h3>WordCamp Irún | 02-03 de Junio 2018</h3>\n<p><a href=\"https://2018.irun.wordcamp.org/\" target=\"_blank\" rel=\"noopener noreferrer\">Web</a> | <a href=\"https://2018.irun.wordcamp.org/llamada-a-ponentes/\">Ponentes</a> | <a href=\"https://2018.irun.wordcamp.org/llamada-a-voluntarios/\">Voluntarios</a> | <a href=\"https://2018.irun.wordcamp.org/llamada-a-podcasters/\">Podcasters</a> | <a href=\"https://2018.irun.wordcamp.org/llamada-a-patrocinadores/\">Patrocinadores</a> | <a href=\"https://2018.irun.wordcamp.org/programa/\">Programa</a> | <a href=\"https://2018.irun.wordcamp.org/entradas/\">Tickets</a> <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n<hr />\n<h3><img class=\"size-full wp-image-2027 alignnone\" src=\"https://es.wordpress.org/files/2018/01/wordcamp-barcelona-2018.jpg\" alt=\"WordCamp Barcelona 2018\" width=\"434\" height=\"190\" srcset=\"https://es.wordpress.org/files/2018/01/wordcamp-barcelona-2018.jpg 434w, https://es.wordpress.org/files/2018/01/wordcamp-barcelona-2018-300x131.jpg 300w\" sizes=\"(max-width: 434px) 100vw, 434px\" /></h3>\n<h3>WordCamp Barcelona | 05-06 de Octubre 2018</h3>\n<p><a href=\"https://2018.barcelona.wordcamp.org/\" target=\"_blank\" rel=\"noopener noreferrer\">Web</a> | <a href=\"https://2018.barcelona.wordcamp.org/2018/03/05/llamada-a-ponentes/\">Ponentes</a> | <a href=\"https://2018.barcelona.wordcamp.org/2018/01/29/llamada-a-voluntarios/\">Voluntarios</a> | <a href=\"https://2018.barcelona.wordcamp.org/2018/02/12/llamada-a-patrocinadores/\">Patrocinadores</a> | Programa | Tickets <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n<hr />\n<h3>WordCamp Granada | 17-18 de Noviembre 2018</h3>\n<p><a href=\"https://2018.granada.wordcamp.org/\">Web</a> | Ponentes | Voluntarios | Patrocinadores | Programa | Tickets <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:36:\"http://wellformedweb.org/CommentAPI/\";a:1:{s:10:\"commentRss\";a:1:{i:0;a:5:{s:4:\"data\";s:91:\"https://es.wordpress.org/2018/04/16/noticias-y-eventos-wordpress-para-la-semana-16-18/feed/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:38:\"http://purl.org/rss/1.0/modules/slash/\";a:1:{s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:1:\"0\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:6;a:6:{s:4:\"data\";s:73:\"\n		\n		\n				\n				\n		\n				\n		\n		\n		\n		\n\n		\n				\n								\n							\n		\n							\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:5:{s:0:\"\";a:7:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:60:\"WordPress 4.9.5, actualización de seguridad y mantenimiento\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:95:\"https://es.wordpress.org/2018/04/04/wordpress-4-9-5-actualizacion-de-seguridad-y-mantenimiento/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:104:\"https://es.wordpress.org/2018/04/04/wordpress-4-9-5-actualizacion-de-seguridad-y-mantenimiento/#comments\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Wed, 04 Apr 2018 07:30:55 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"category\";a:5:{i:0;a:5:{s:4:\"data\";s:15:\"Actualizaciones\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:1;a:5:{s:4:\"data\";s:13:\"Mantenimiento\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:2;a:5:{s:4:\"data\";s:9:\"Seguridad\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:3;a:5:{s:4:\"data\";s:3:\"4.9\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}i:4;a:5:{s:4:\"data\";s:5:\"4.9.5\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:32:\"https://es.wordpress.org/?p=2170\";s:7:\"attribs\";a:1:{s:0:\"\";a:1:{s:11:\"isPermaLink\";s:5:\"false\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:387:\"Ya está disponible WordPress 4.9.5. Esta es una actualización de seguridad y mantenimiento para todas las versiones desde WordPress 3.7. Te animamos encarecidamente a que actualices tus sitios de inmediato. Las versiones de WordPress 4.9.4 y anteriores están afectadas por tres problemas de seguridad. Como parte del compromiso del equipo del núcleo con el refuerzo de la [&#8230;]\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:16:\"Fernando Tellado\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:40:\"http://purl.org/rss/1.0/modules/content/\";a:1:{s:7:\"encoded\";a:1:{i:0;a:5:{s:4:\"data\";s:6680:\"<p>Ya está disponible WordPress 4.9.5. Esta es una <strong>actualización de seguridad y mantenimiento</strong> para todas las versiones desde WordPress 3.7. Te animamos encarecidamente a que actualices tus sitios de inmediato.</p>\n<p>Las versiones de WordPress 4.9.4 y anteriores están afectadas por tres problemas de seguridad. Como parte del compromiso del equipo del núcleo con el refuerzo de la seguridad se han implementado los siguientes arreglos en la versión 4.9.5:</p>\n<ol>\n<li>No tratar <code>localhost</code> como el mismo host por defecto.</li>\n<li>Uso de redirecciones seguras al redirigir la página de acceso si se ha forzado el SSL.</li>\n<li>Asegurar que la cadena de la versión se escapa correctamente para usarla en las etiquetas generator.</li>\n</ol>\n<p>Gracias a los que han informado de estos problemas por practicar <a href=\"https://make.wordpress.org/core/handbook/testing/reporting-security-vulnerabilities/\">la divulgación coordinada de seguridad</a>: <a href=\"https://profiles.wordpress.org/xknown\">xknown</a>, <a href=\"https://hackerone.com/nitstorm\">Nitin Venkatesh (nitstorm)</a> y <a href=\"https://twitter.com/voldemortensen\">Garth Mortensen</a> del equipo de seguridad de WordPress.</p>\n<p>Se han solucionado otros veinticinco fallos en la versión de WordPress 4.9.5. Queremos destacar algunos:</p>\n<ul>\n<li>Se han restaurado los anteriores estilos en los shortcodes de leyenda.</li>\n<li>Ahora se puede recortar en dispositivos de pantalla táctil.</li>\n<li>Se  ha actualizado diversas cadenas como por ejemplo mensajes de error para que sean más claras.</li>\n<li>Se ha solucionado la posición del marcador de posición del adjunto durante la carga de archivos.</li>\n<li>La funcionalidad de nonces personalizados en el cliente JavaScript de la REST API se ha hecho que sea consistent en todo el código base.</li>\n<li>Compatibilidad mejorada con PHP 7.2.</li>\n</ul>\n<p><a href=\"https://make.wordpress.org/core/2018/04/03/wordpress-4-9-5/\">Esta entrada tiene más información (en inglés) sobre todos los problemas solucionados en la versión 4.9.5, por si quieres aprender más</a>.</p>\n<p><a href=\"https://es.wordpress.org/txt-download/\">Descarga WordPress 4.9.5</a> o pásate por tu Escritorio → Actualizaciones y haz clic en &#8220;Actualizar ahora.&#8221; Los sitios compatibles con las actualizaciones automáticas en segundo plano ya están empezando a actualizarse automáticamente.</p>\n<p>Gracias a todos los que han contribuido a WordPress 4.9.5:</p>\n<p><a href=\"https://profiles.wordpress.org/1265578519-1/\">1265578519</a>, <a href=\"https://profiles.wordpress.org/jorbin/\">Aaron Jorbin</a>, <a href=\"https://profiles.wordpress.org/adamsilverstein/\">Adam Silverstein</a>, <a href=\"https://profiles.wordpress.org/schlessera/\">Alain Schlesser</a>, <a href=\"https://profiles.wordpress.org/alexgso/\">alexgso</a>, <a href=\"https://profiles.wordpress.org/afercia/\">Andrea Fercia</a>, <a href=\"https://profiles.wordpress.org/andrei0x309/\">andrei0x309</a>, <a href=\"https://profiles.wordpress.org/antipole/\">antipole</a>, <a href=\"https://profiles.wordpress.org/aranwer104/\">Anwer AR</a>, <a href=\"https://profiles.wordpress.org/birgire/\">Birgir Erlendsson (birgire)</a>, <a href=\"https://profiles.wordpress.org/blair-jersyer/\">Blair jersyer</a>, <a href=\"https://profiles.wordpress.org/bandonrandon/\">Brooke.</a>, <a href=\"https://profiles.wordpress.org/chetan200891/\">Chetan Prajapati</a>, <a href=\"https://profiles.wordpress.org/codegrau/\">codegrau</a>, <a href=\"https://profiles.wordpress.org/conner_bw/\">conner_bw</a>, <a href=\"https://profiles.wordpress.org/davidakennedy/\">David A. Kennedy</a>, <a href=\"https://profiles.wordpress.org/designsimply/\">designsimply</a>, <a href=\"https://profiles.wordpress.org/dd32/\">Dion Hulse</a>, <a href=\"https://profiles.wordpress.org/ocean90/\">Dominik Schilling (ocean90)</a>, <a href=\"https://profiles.wordpress.org/electricfeet/\">ElectricFeet</a>, <a href=\"https://profiles.wordpress.org/ericmeyer/\">ericmeyer</a>, <a href=\"https://profiles.wordpress.org/fpcsjames/\">FPCSJames</a>, <a href=\"https://profiles.wordpress.org/garrett-eclipse/\">Garrett Hyder</a>, <a href=\"https://profiles.wordpress.org/pento/\">Gary Pendergast</a>, <a href=\"https://profiles.wordpress.org/soulseekah/\">Gennady Kovshenin</a>, <a href=\"https://profiles.wordpress.org/henrywright/\">Henry Wright</a>, <a href=\"https://profiles.wordpress.org/audrasjb/\">Jb Audras</a>, <a href=\"https://profiles.wordpress.org/jbpaul17/\">Jeffrey Paul</a>, <a href=\"https://profiles.wordpress.org/jipmoors/\">Jip Moors</a>, <a href=\"https://profiles.wordpress.org/joemcgill/\">Joe McGill</a>, <a href=\"https://profiles.wordpress.org/joen/\">Joen Asmussen</a>, <a href=\"https://profiles.wordpress.org/johnbillion/\">John Blackbourn</a>, <a href=\"https://profiles.wordpress.org/johnpgreen/\">johnpgreen</a>, <a href=\"https://profiles.wordpress.org/junaidkbr/\">Junaid Ahmed</a>, <a href=\"https://profiles.wordpress.org/kristastevens/\">kristastevens</a>, <a href=\"https://profiles.wordpress.org/obenland/\">Konstantin Obenland</a>, <a href=\"https://profiles.wordpress.org/lakenh/\">Laken Hafner</a>, <a href=\"https://profiles.wordpress.org/lancewillett/\">Lance Willett</a>, <a href=\"https://profiles.wordpress.org/leemon/\">leemon</a>, <a href=\"https://profiles.wordpress.org/melchoyce/\">Mel Choyce</a>, <a href=\"https://profiles.wordpress.org/mikeschroder/\">Mike Schroder</a>, <a href=\"https://profiles.wordpress.org/mrmadhat/\">mrmadhat</a>, <a href=\"https://profiles.wordpress.org/nandorsky/\">nandorsky</a>, <a href=\"https://profiles.wordpress.org/jainnidhi/\">Nidhi Jain</a>, <a href=\"https://profiles.wordpress.org/swissspidy/\">Pascal Birchler</a>, <a href=\"https://profiles.wordpress.org/qcmiao/\">qcmiao</a>, <a href=\"https://profiles.wordpress.org/rachelbaker/\">Rachel Baker</a>, <a href=\"https://profiles.wordpress.org/larrach/\">Rachel Peter</a>, <a href=\"https://profiles.wordpress.org/ravanh/\">RavanH</a>, <a href=\"https://profiles.wordpress.org/otto42/\">Samuel Wood (Otto)</a>, <a href=\"https://profiles.wordpress.org/sebastienthivinfocom/\">Sebastien SERRE</a>, <a href=\"https://profiles.wordpress.org/sergeybiryukov/\">Sergey Biryukov</a>, <a href=\"https://profiles.wordpress.org/shital-patel/\">Shital Marakana</a>, <a href=\"https://profiles.wordpress.org/netweb/\">Stephen Edgar</a>, <a href=\"https://profiles.wordpress.org/karmatosed/\">Tammie Lister</a>, <a href=\"https://profiles.wordpress.org/thomas-vitale/\">Thomas Vitale</a>, <a href=\"https://profiles.wordpress.org/kwonye/\">Will Kwon</a>, y <a href=\"https://profiles.wordpress.org/yahil/\">Yahil Madakiya</a>.</p>\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:36:\"http://wellformedweb.org/CommentAPI/\";a:1:{s:10:\"commentRss\";a:1:{i:0;a:5:{s:4:\"data\";s:100:\"https://es.wordpress.org/2018/04/04/wordpress-4-9-5-actualizacion-de-seguridad-y-mantenimiento/feed/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:38:\"http://purl.org/rss/1.0/modules/slash/\";a:1:{s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:1:\"1\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:7;a:6:{s:4:\"data\";s:61:\"\n		\n		\n				\n				\n		\n				\n\n		\n				\n								\n							\n		\n							\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:5:{s:0:\"\";a:7:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Noticias y eventos de la semana\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:86:\"https://es.wordpress.org/2018/03/19/noticias-y-eventos-wordpress-para-la-semana-12-18/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:94:\"https://es.wordpress.org/2018/03/19/noticias-y-eventos-wordpress-para-la-semana-12-18/#respond\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Mon, 19 Mar 2018 08:18:12 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"category\";a:1:{i:0;a:5:{s:4:\"data\";s:7:\"General\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:32:\"https://es.wordpress.org/?p=2091\";s:7:\"attribs\";a:1:{s:0:\"\";a:1:{s:11:\"isPermaLink\";s:5:\"false\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:375:\"¡Hola a todos! Os dejamos como todas las semanas el listado con los próximos Meetups de WordPress alrededor de España y el avance de las distintas WordCamps. Meetups de esta semana 19/03 &#8211; Las Palmas de Gran Canaria &#8211; Diseño Web en WordPress. Personaliza y triunfa 21/03 &#8211; Valencia &#8211; [Charla] Anatomía de un Plugin de WordPress 21/03 [&#8230;]\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:15:\"Mauricio Gelves\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:40:\"http://purl.org/rss/1.0/modules/content/\";a:1:{s:7:\"encoded\";a:1:{i:0;a:5:{s:4:\"data\";s:6726:\"<p><img class=\"aligncenter size-full wp-image-1150\" src=\"https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png\" alt=\"Eventos WordPress para esta semana en españa\" width=\"1280\" height=\"476\" srcset=\"https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png 1280w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-300x112.png 300w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-768x286.png 768w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-1024x381.png 1024w\" sizes=\"(max-width: 1280px) 100vw, 1280px\" /></p>\n<p><strong>¡Hola a todos! </strong>Os dejamos como todas las semanas el listado con los próximos Meetups de <strong>WordPress</strong> alrededor de España y el avance de las distintas WordCamps.</p>\n<h2>Meetups de esta semana</h2>\n<ul>\n<li>19/03 &#8211; <b>Las Palmas de Gran Canaria</b> &#8211; <a href=\"https://www.meetup.com/es-ES/Las-Palmas-de-Gran-Canaria-WordPress-Meetup/events/246272076/\">Diseño Web en WordPress. Personaliza y triunfa</a></li>\n<li>21/03 &#8211; <strong>Valencia</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/wordpress-valencia-meetup/events/248838322/\">[Charla] Anatomía de un Plugin de WordPress</a></li>\n<li>21/03 &#8211; <strong>Cádiz</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Cadiz-WordPress-Meetup/events/248735874/\">Pasión por WordPress &#8211; Preguntas y respuestas</a></li>\n<li>21/03 &#8211; <strong>Zaragoza</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Zaragoza/events/248857636/\">Coloquio abierto</a></li>\n<li>22/03 &#8211; <strong>Cartagena</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Cartagena/events/248798941/\">WordPress Multisite: Pros y contras</a></li>\n<li>22/03 &#8211; <strong>Collado Villalba</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Collado-Villalba-Meetup/events/246675246/\">Crea tu marca personal con la Comunidad de WordPress</a></li>\n<li>22/03 &#8211; <strong>Pamplona</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Pamplona/events/248643470/\">Seguridad en WordPress</a></li>\n<li>22/03 &#8211; <strong>Sevilla</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Sevilla/events/248221645/\">Automatiza tu tienda WooCommerce y échate a dormir</a></li>\n<li>22/03 &#8211; <strong>Valladolid</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Valladolid-WordPress-Meetup/events/248304871/\">¡Tú también puedes tener un podcast!</a></li>\n<li>22/03 &#8211; <strong>Oviedo</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Oviedo-WordPress-Meetup/events/248104740/\">Estructura de archivos WordPress A Fondo</a></li>\n<li>23/03 &#8211; <strong>Amurrio</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Amurrio-WordPress-Meetup/events/246843726/\">Taller: Cómo crear una tienda online con WordPress y WooCommerce</a></li>\n<li>23/03 &#8211; <strong>Lleida</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Lleida/events/248690616/\">Posicionament a Google: SEO amb WordPress</a></li>\n<li>23/03 &#8211; <strong>Pontevedra</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Pontevedra-WordPress-Meetup/events/248693040/\">&#8220;Encabezados de seguridade en WP&#8221; + &#8220;WP-CLI&#8221; + Pregunta tus dudas de WordPress</a></li>\n<li>23/03 &#8211; <strong>Lugo</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPressLugo/events/248662869/\">6ª MeetUp de WordPress Lugo</a></li>\n<li>24/03 &#8211; <strong>Cádiz</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Cadiz-WordPress-Meetup/events/248734269/\">Pasión por WordPress</a></li>\n<li>24/03 &#8211; <strong>Chiclana</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Meetup-Chiclana/events/248734969/\">Pasión por WordPress</a></li>\n</ul>\n<h2>Próximas WordCamps</h2>\n<p>Sigue de cerca la organización de los próximos WordCamps que se celebrarán en España durante el 2018.</p>\n<p>&#8212;&#8212;&#8212;</p>\n<p><img class=\"size-full wp-image-1983 alignnone\" src=\"https://es.wordpress.org/files/2018/01/wordcamp-madrid-2018.jpg\" alt=\"wordcamp madrid 2018\" width=\"434\" height=\"190\" srcset=\"https://es.wordpress.org/files/2018/01/wordcamp-madrid-2018.jpg 434w, https://es.wordpress.org/files/2018/01/wordcamp-madrid-2018-300x131.jpg 300w\" sizes=\"(max-width: 434px) 100vw, 434px\" /></p>\n<h3>WordCamp Madrid | 21-22 de Abril 2018</h3>\n<p><a href=\"https://2018.madrid.wordcamp.org/\" target=\"_blank\" rel=\"noopener noreferrer\">Web</a> | <a href=\"https://2018.madrid.wordcamp.org/anuncios/llamada-a-ponentes/\">Ponentes</a> | <a href=\"https://2018.laspalmas.wordcamp.org/llamada-a-voluntarios/\">Voluntarios</a> | <a href=\"https://2018.madrid.wordcamp.org/anuncios/llamada-a-patrocinadores/\">Patrocinadores</a> | <a href=\"https://2018.madrid.wordcamp.org/programa/\">Programa</a> | <a href=\"https://2018.madrid.wordcamp.org/entradas/\">Tickets</a> <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n<hr />\n<h3>WordCamp Irún | 02-03 de Junio 2018</h3>\n<p><a href=\"https://2018.irun.wordcamp.org/\" target=\"_blank\" rel=\"noopener noreferrer\">Web</a> | <a href=\"https://2018.irun.wordcamp.org/llamada-a-ponentes/\">Ponentes</a> | <a href=\"https://2018.irun.wordcamp.org/llamada-a-voluntarios/\">Voluntarios</a> | <a href=\"https://2018.irun.wordcamp.org/llamada-a-podcasters/\">Podcasters</a> | <a href=\"https://2018.irun.wordcamp.org/llamada-a-patrocinadores/\">Patrocinadores</a> | Programa | Tickets <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n<hr />\n<h3><img class=\"size-full wp-image-2027 alignnone\" src=\"https://es.wordpress.org/files/2018/01/wordcamp-barcelona-2018.jpg\" alt=\"WordCamp Barcelona 2018\" width=\"434\" height=\"190\" srcset=\"https://es.wordpress.org/files/2018/01/wordcamp-barcelona-2018.jpg 434w, https://es.wordpress.org/files/2018/01/wordcamp-barcelona-2018-300x131.jpg 300w\" sizes=\"(max-width: 434px) 100vw, 434px\" /></h3>\n<h3>WordCamp Barcelona | 05-06 de Octubre 2018</h3>\n<p><a href=\"https://2018.barcelona.wordcamp.org/\" target=\"_blank\" rel=\"noopener noreferrer\">Web</a> | <a href=\"https://2018.barcelona.wordcamp.org/2018/03/05/llamada-a-ponentes/\">Ponentes</a> | <a href=\"https://2018.barcelona.wordcamp.org/2018/01/29/llamada-a-voluntarios/\">Voluntarios</a> | <a href=\"https://2018.barcelona.wordcamp.org/2018/02/12/llamada-a-patrocinadores/\">Patrocinadores</a> | Programa | Tickets <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:36:\"http://wellformedweb.org/CommentAPI/\";a:1:{s:10:\"commentRss\";a:1:{i:0;a:5:{s:4:\"data\";s:91:\"https://es.wordpress.org/2018/03/19/noticias-y-eventos-wordpress-para-la-semana-12-18/feed/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:38:\"http://purl.org/rss/1.0/modules/slash/\";a:1:{s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:1:\"0\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:8;a:6:{s:4:\"data\";s:61:\"\n		\n		\n				\n				\n		\n				\n\n		\n				\n								\n							\n		\n							\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:5:{s:0:\"\";a:7:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Noticias y eventos de la semana\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:86:\"https://es.wordpress.org/2018/03/12/noticias-y-eventos-wordpress-para-la-semana-11-18/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:95:\"https://es.wordpress.org/2018/03/12/noticias-y-eventos-wordpress-para-la-semana-11-18/#comments\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Mon, 12 Mar 2018 07:29:58 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"category\";a:1:{i:0;a:5:{s:4:\"data\";s:7:\"General\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:32:\"https://es.wordpress.org/?p=2085\";s:7:\"attribs\";a:1:{s:0:\"\";a:1:{s:11:\"isPermaLink\";s:5:\"false\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:404:\"¡Hola a todos! Os dejamos como todas las semanas el listado con los próximos Meetups de WordPress alrededor de España y el avance de las distintas WordCamps. Meetups de esta semana 12/03 &#8211; Sevilla &#8211; Nueva cocina rústica #francachelawpsevilla 12/03 &#8211; Alicante &#8211; Aprende a hacer tu web: Gestión de usuarios en WordPress 13/03 &#8211; Granollers &#8211; 💡Aprende [&#8230;]\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:15:\"Mauricio Gelves\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:40:\"http://purl.org/rss/1.0/modules/content/\";a:1:{s:7:\"encoded\";a:1:{i:0;a:5:{s:4:\"data\";s:4931:\"<p><img class=\"aligncenter size-full wp-image-1150\" src=\"https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png\" alt=\"Eventos WordPress para esta semana en españa\" width=\"1280\" height=\"476\" srcset=\"https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png 1280w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-300x112.png 300w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-768x286.png 768w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-1024x381.png 1024w\" sizes=\"(max-width: 1280px) 100vw, 1280px\" /></p>\n<p><strong>¡Hola a todos! </strong>Os dejamos como todas las semanas el listado con los próximos Meetups de <strong>WordPress</strong> alrededor de España y el avance de las distintas WordCamps.</p>\n<h2>Meetups de esta semana</h2>\n<ul>\n<li style=\"list-style-type: none\">\n<ul>\n<li>12/03 &#8211; <b>Sevilla</b> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Sevilla/events/247953135/\">Nueva cocina rústica #francachelawpsevilla</a></li>\n<li>12/03 &#8211; <strong>Alicante</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Alicante/events/248431176/\">Aprende a hacer tu web: Gestión de usuarios en WordPress</a></li>\n<li>13/03 &#8211; <strong>Granollers</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPressGranollers/events/247800489/\"><img src=\"https://s.w.org/images/core/emoji/11/72x72/1f4a1.png\" alt=\"💡\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" />Aprende a Crear Tu WordPress Multiidioma<img src=\"https://s.w.org/images/core/emoji/11/72x72/1f4a1.png\" alt=\"💡\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></a></li>\n<li>13/03 &#8211; <strong>Alcalá de Henares</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Alcala-de-Henares-WordPress-Meetup/events/248302503/\">Posicionamiento y Visibilidad de Tu Proyecto Digital (y II)</a></li>\n<li>15/03 &#8211; <strong>Tarragona</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/wordpresstarragona/events/248567343/\">WordPress&amp;Beers – Marzo 2018</a></li>\n</ul>\n</li>\n</ul>\n<h2>Próximas WordCamps</h2>\n<p>Sigue de cerca la organización de los próximos WordCamps que se celebrarán en España durante el 2018.</p>\n<p>&#8212;&#8212;&#8212;</p>\n<p><img class=\"size-full wp-image-1983 alignnone\" src=\"https://es.wordpress.org/files/2018/01/wordcamp-madrid-2018.jpg\" alt=\"wordcamp madrid 2018\" width=\"434\" height=\"190\" srcset=\"https://es.wordpress.org/files/2018/01/wordcamp-madrid-2018.jpg 434w, https://es.wordpress.org/files/2018/01/wordcamp-madrid-2018-300x131.jpg 300w\" sizes=\"(max-width: 434px) 100vw, 434px\" /></p>\n<h3>WordCamp Madrid | 21-22 de Abril 2018</h3>\n<p><a href=\"https://2018.madrid.wordcamp.org/\" target=\"_blank\" rel=\"noopener noreferrer\">Web</a> | <a href=\"https://2018.madrid.wordcamp.org/anuncios/llamada-a-ponentes/\">Ponentes</a> | <a href=\"https://2018.laspalmas.wordcamp.org/llamada-a-voluntarios/\">Voluntarios</a> | <a href=\"https://2018.madrid.wordcamp.org/anuncios/llamada-a-patrocinadores/\">Patrocinadores</a> | <a href=\"https://2018.madrid.wordcamp.org/programa/\">Programa</a> | <a href=\"https://2018.madrid.wordcamp.org/entradas/\">Tickets</a> <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n<hr />\n<h3>WordCamp Irún | 02-03 de Junio 2018</h3>\n<p><a href=\"https://2018.irun.wordcamp.org/\" target=\"_blank\" rel=\"noopener noreferrer\">Web</a> | <a href=\"https://2018.irun.wordcamp.org/llamada-a-ponentes/\">Ponentes</a> | Voluntarios | <a href=\"https://2018.irun.wordcamp.org/llamada-a-podcasters/\">Podcasters</a> | <a href=\"https://2018.irun.wordcamp.org/llamada-a-patrocinadores/\">Patrocinadores</a> | Programa | Tickets <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n<hr />\n<h3><img class=\"size-full wp-image-2027 alignnone\" src=\"https://es.wordpress.org/files/2018/01/wordcamp-barcelona-2018.jpg\" alt=\"WordCamp Barcelona 2018\" width=\"434\" height=\"190\" srcset=\"https://es.wordpress.org/files/2018/01/wordcamp-barcelona-2018.jpg 434w, https://es.wordpress.org/files/2018/01/wordcamp-barcelona-2018-300x131.jpg 300w\" sizes=\"(max-width: 434px) 100vw, 434px\" /></h3>\n<h3>WordCamp Barcelona | 05-06 de Octubre 2018</h3>\n<p><a href=\"https://2018.barcelona.wordcamp.org/\" target=\"_blank\" rel=\"noopener noreferrer\">Web</a> | <a href=\"https://2018.barcelona.wordcamp.org/2018/03/05/llamada-a-ponentes/\">Ponentes</a> | <a href=\"https://2018.barcelona.wordcamp.org/2018/01/29/llamada-a-voluntarios/\">Voluntarios</a> | <a href=\"https://2018.barcelona.wordcamp.org/2018/02/12/llamada-a-patrocinadores/\">Patrocinadores</a> | Programa | Tickets <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:36:\"http://wellformedweb.org/CommentAPI/\";a:1:{s:10:\"commentRss\";a:1:{i:0;a:5:{s:4:\"data\";s:91:\"https://es.wordpress.org/2018/03/12/noticias-y-eventos-wordpress-para-la-semana-11-18/feed/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:38:\"http://purl.org/rss/1.0/modules/slash/\";a:1:{s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:1:\"2\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:9;a:6:{s:4:\"data\";s:61:\"\n		\n		\n				\n				\n		\n				\n\n		\n				\n								\n							\n		\n							\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:5:{s:0:\"\";a:7:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Noticias y eventos de la semana\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:86:\"https://es.wordpress.org/2018/03/05/noticias-y-eventos-wordpress-para-la-semana-10-18/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:94:\"https://es.wordpress.org/2018/03/05/noticias-y-eventos-wordpress-para-la-semana-10-18/#respond\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Mon, 05 Mar 2018 08:40:05 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"category\";a:1:{i:0;a:5:{s:4:\"data\";s:7:\"General\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:32:\"https://es.wordpress.org/?p=2081\";s:7:\"attribs\";a:1:{s:0:\"\";a:1:{s:11:\"isPermaLink\";s:5:\"false\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:362:\"¡Hola a todos! Os dejamos como todas las semanas el listado con los próximos Meetups de WordPress alrededor de España y el avance de las distintas WordCamps. Meetups de esta semana 06/03 &#8211; Granada &#8211; Taller de Gutenberg: Ven a conocer el nuevo editor de WordPress 06/03 &#8211; Chiclana &#8211; Adapta tu web al nuevo Reglamento General [&#8230;]\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:15:\"Mauricio Gelves\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:40:\"http://purl.org/rss/1.0/modules/content/\";a:1:{s:7:\"encoded\";a:1:{i:0;a:5:{s:4:\"data\";s:5442:\"<p><img class=\"aligncenter size-full wp-image-1150\" src=\"https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png\" alt=\"Eventos WordPress para esta semana en españa\" width=\"1280\" height=\"476\" srcset=\"https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana.png 1280w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-300x112.png 300w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-768x286.png 768w, https://es.wordpress.org/files/2017/02/eventos-wordpress-semana-espana-1024x381.png 1024w\" sizes=\"(max-width: 1280px) 100vw, 1280px\" /></p>\n<p><strong>¡Hola a todos! </strong>Os dejamos como todas las semanas el listado con los próximos Meetups de <strong>WordPress</strong> alrededor de España y el avance de las distintas WordCamps.</p>\n<h2>Meetups de esta semana</h2>\n<ul>\n<li style=\"list-style-type: none\">\n<ul>\n<li>06/03 &#8211; <b>Granada</b> &#8211; <a href=\"https://www.meetup.com/es-ES/Granada-WordPress-Meetup/events/248338410/\">Taller de Gutenberg: Ven a conocer el nuevo editor de WordPress</a></li>\n<li>06/03 &#8211; <strong>Chiclana</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Meetup-Chiclana/events/248186913/\">Adapta tu web al nuevo Reglamento General de Protección de Datos (RGPD)</a></li>\n<li>08/03 &#8211; <strong>Valencia</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/wordpress-valencia-meetup/events/247620440/\">WordPress &amp; Beers!</a></li>\n<li>08/03 &#8211; <strong>Oviedo</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Oviedo-WordPress-Meetup/events/248104597/\">Seguridad en WordPress</a></li>\n<li>08/03 &#8211; <strong>Almería</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WPAlmeria/events/248191764/\">Conquista el SEO Local desde Almería </a></li>\n<li>09/03 &#8211; <strong>Móstoles</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Mostoles-WordPress-Meetup/events/247435719/\">Cómo crear tu Membership en WordPress</a></li>\n<li>09/03 &#8211; <strong>Girona</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/Girona-WordPress-Meetup/events/247800262/\"><img src=\"https://s.w.org/images/core/emoji/11/72x72/1f64c.png\" alt=\"🙌\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /> WordPress és segur <img src=\"https://s.w.org/images/core/emoji/11/72x72/2714.png\" alt=\"✔\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /> però l&#8217;ésser humà no ✘</a></li>\n<li>09/03 &#8211; <strong>Marbella</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WordPress-Meetup-Marbella/events/248398195/\">Compositores Visuales en WordPress: Gutenberg está llegando!</a></li>\n<li>10/03 &#8211; <strong>Valencia</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/wordpress-valencia-meetup/events/248025984/\">[Hackathon] Renovar la web de WP Valencia</a></li>\n<li>10/03 &#8211; <strong>Cantabria</strong> &#8211; <a href=\"https://www.meetup.com/es-ES/WP-Cantabria/events/247081706/\">Instalación y primeros pasos con WooCommerce</a></li>\n</ul>\n</li>\n</ul>\n<h2>Próximas WordCamps</h2>\n<p>Sigue de cerca la organización de los próximos WordCamps que se celebrarán en España durante el 2018.</p>\n<p>&#8212;&#8212;&#8212;</p>\n<p><img class=\"size-full wp-image-1983 alignnone\" src=\"https://es.wordpress.org/files/2018/01/wordcamp-madrid-2018.jpg\" alt=\"wordcamp madrid 2018\" width=\"434\" height=\"190\" srcset=\"https://es.wordpress.org/files/2018/01/wordcamp-madrid-2018.jpg 434w, https://es.wordpress.org/files/2018/01/wordcamp-madrid-2018-300x131.jpg 300w\" sizes=\"(max-width: 434px) 100vw, 434px\" /></p>\n<h3>WordCamp Madrid | 21-22 de Abril 2018</h3>\n<p><a href=\"https://2018.madrid.wordcamp.org/\" target=\"_blank\" rel=\"noopener noreferrer\">Web</a> | <a href=\"https://2018.madrid.wordcamp.org/anuncios/llamada-a-ponentes/\">Ponentes</a> | <a href=\"https://2018.laspalmas.wordcamp.org/llamada-a-voluntarios/\">Voluntarios</a> | <a href=\"https://2018.madrid.wordcamp.org/anuncios/llamada-a-patrocinadores/\">Patrocinadores</a> | Programa | Tickets <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n<hr />\n<h3>WordCamp Irún | 02-03 de Junio 2018</h3>\n<p><a href=\"https://2018.irun.wordcamp.org/\" target=\"_blank\" rel=\"noopener noreferrer\">Web</a> | Ponentes | Voluntarios | Patrocinadores | Programa | Tickets <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n<hr />\n<h3><img class=\"size-full wp-image-2027 alignnone\" src=\"https://es.wordpress.org/files/2018/01/wordcamp-barcelona-2018.jpg\" alt=\"WordCamp Barcelona 2018\" width=\"434\" height=\"190\" srcset=\"https://es.wordpress.org/files/2018/01/wordcamp-barcelona-2018.jpg 434w, https://es.wordpress.org/files/2018/01/wordcamp-barcelona-2018-300x131.jpg 300w\" sizes=\"(max-width: 434px) 100vw, 434px\" /></h3>\n<h3>WordCamp Barcelona | 05-06 de Octubre 2018</h3>\n<p><a href=\"https://2018.barcelona.wordcamp.org/\" target=\"_blank\" rel=\"noopener noreferrer\">Web</a> | Ponentes | <a href=\"https://2018.barcelona.wordcamp.org/2018/01/29/llamada-a-voluntarios/\">Voluntarios</a> | <a href=\"https://2018.barcelona.wordcamp.org/2018/02/12/llamada-a-patrocinadores/\">Patrocinadores</a> | Programa | Tickets <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f39f.png\" alt=\"🎟\" class=\"wp-smiley\" style=\"height: 1em; max-height: 1em;\" /></p>\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:36:\"http://wellformedweb.org/CommentAPI/\";a:1:{s:10:\"commentRss\";a:1:{i:0;a:5:{s:4:\"data\";s:91:\"https://es.wordpress.org/2018/03/05/noticias-y-eventos-wordpress-para-la-semana-10-18/feed/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:38:\"http://purl.org/rss/1.0/modules/slash/\";a:1:{s:8:\"comments\";a:1:{i:0;a:5:{s:4:\"data\";s:1:\"0\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}}}s:27:\"http://www.w3.org/2005/Atom\";a:1:{s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:0:\"\";s:7:\"attribs\";a:1:{s:0:\"\";a:3:{s:4:\"href\";s:30:\"https://es.wordpress.org/feed/\";s:3:\"rel\";s:4:\"self\";s:4:\"type\";s:19:\"application/rss+xml\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:44:\"http://purl.org/rss/1.0/modules/syndication/\";a:2:{s:12:\"updatePeriod\";a:1:{i:0;a:5:{s:4:\"data\";s:9:\"\n	hourly	\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:15:\"updateFrequency\";a:1:{i:0;a:5:{s:4:\"data\";s:4:\"\n	1	\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}}}}}}}}s:4:\"type\";i:128;s:7:\"headers\";O:42:\"Requests_Utility_CaseInsensitiveDictionary\":1:{s:7:\"\0*\0data\";a:8:{s:6:\"server\";s:5:\"nginx\";s:4:\"date\";s:29:\"Tue, 25 Sep 2018 17:38:17 GMT\";s:12:\"content-type\";s:34:\"application/rss+xml; charset=UTF-8\";s:6:\"x-olaf\";s:3:\"⛄\";s:13:\"last-modified\";s:29:\"Thu, 13 Sep 2018 16:21:55 GMT\";s:4:\"link\";s:61:\"<https://es.wordpress.org/wp-json/>; rel=\"https://api.w.org/\"\";s:15:\"x-frame-options\";s:10:\"SAMEORIGIN\";s:4:\"x-nc\";s:9:\"HIT ord 1\";}}s:5:\"build\";s:14:\"20180925173700\";}', 'no');
INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(131, '_transient_timeout_feed_mod_ef605fdbfbba53a6c98437c00d402dfe', '1537940301', 'no'),
(132, '_transient_feed_mod_ef605fdbfbba53a6c98437c00d402dfe', '1537897101', 'no'),
(133, '_transient_timeout_feed_d117b5738fbd35bd8c0391cda1f2b5d9', '1537940304', 'no');
INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(134, '_transient_feed_d117b5738fbd35bd8c0391cda1f2b5d9', 'a:4:{s:5:\"child\";a:1:{s:0:\"\";a:1:{s:3:\"rss\";a:1:{i:0;a:6:{s:4:\"data\";s:3:\"\n\n\n\";s:7:\"attribs\";a:1:{s:0:\"\";a:1:{s:7:\"version\";s:3:\"2.0\";}}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:1:{s:0:\"\";a:1:{s:7:\"channel\";a:1:{i:0;a:6:{s:4:\"data\";s:61:\"\n	\n	\n	\n	\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:1:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:16:\"WordPress Planet\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:28:\"http://planet.wordpress.org/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:8:\"language\";a:1:{i:0;a:5:{s:4:\"data\";s:2:\"en\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:47:\"WordPress Planet - http://planet.wordpress.org/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"item\";a:50:{i:0;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:85:\"WPTavern: Gutenberg 3.9 Introduces Reusable, Exportable Templates for Multiple Blocks\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=84179\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:95:\"https://wptavern.com/gutenberg-3-9-introduces-reusable-exportable-templates-for-multiple-blocks\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:3107:\"<p><a href=\"https://make.wordpress.org/core/2018/09/21/whats-new-in-gutenberg/\" rel=\"noopener noreferrer\" target=\"_blank\">Gutenberg 3.9</a> was released last week with a new feature that allows users to group multiple blocks into reusable templates. The templates can also be exported and imported as a JSON file.</p>\n<p>The idea of reusable templates is an expansion of the concept of <a href=\"https://github.com/WordPress/gutenberg/issues/1516\" rel=\"noopener noreferrer\" target=\"_blank\">dynamic reusable blocks</a> that Gutenberg technical lead Matias Ventura proposed in June 2017. Reusability is even more powerful when applied to multiple blocks. The import/export capabilities make it possible for templates to be easily shared across WordPress sites.</p>\n<p><a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/09/Screen-Shot-2018-09-24-at-1.04.36-PM.png?ssl=1\"><img /></a></p>\n<p>If you want to test it, you can select multiple blocks by selecting the content inside a block and dragging outside the boundaries of the block to extend the selection to multiple blocks. The <a href=\"https://github.com/WordPress/gutenberg/issues/62\" rel=\"noopener noreferrer\" target=\"_blank\">multi-select feature</a> was originally added for the purpose of deleting or moving multiple blocks but it has now become indispensable for creating reusable templates.</p>\n<p>This feature lays the ground work for a full-fledged layout builder in the next phase of Gutenberg development. Reusable templates should make it a breeze to build WordPress sites with pre-defined layouts that users and developers can share. They are much more intuitive to implement than page templates.</p>\n<p>&#8220;Holy wow, imagine this: wp-blueprints.com, where people can group blocks together and share their JSON strings with nice little copy buttons,&#8221; Gutenberg designer Joen Asmussen commented on the PR. &#8220;Categories for top rated, most downloaded, search, etc? This is going to happen because of this magic.&#8221;</p>\n<p>Matias Ventura&#8217;s demo video shows the reusable templates in action. It also highlights a new tool for <a href=\"https://github.com/WordPress/gutenberg/pull/7995\" rel=\"noopener noreferrer\" target=\"_blank\">visually comparing possible ways to convert an invalid block</a>. The editor now includes a diff UI for blocks, which Ventura said could possibly scale in the future to provide an improved UX for revisions as a whole.</p>\n<p></p>\n<p>A few other notable additions in the 3.9 release include improvements to the drag and drop handle, collapsible groups for the block toolbar, and the ability to convert a cover image block to an image and back. <a href=\"https://github.com/WordPress/gutenberg/pull/9683\" rel=\"noopener noreferrer\" target=\"_blank\">Dark editor style support</a> is now available for theme developers, making Gutenberg more friendly for use with dark WordPress themes. Check out the <a href=\"https://make.wordpress.org/core/2018/09/21/whats-new-in-gutenberg/\" rel=\"noopener noreferrer\" target=\"_blank\">3.9 changelog</a> to see a full list of enhancements and bug fixes.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Mon, 24 Sep 2018 23:32:53 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:1;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:82:\"WPTavern: New commonWP Plugin Enables WordPress Sites to Use the Free jsDelivr CDN\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=84046\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:93:\"https://wptavern.com/new-commonwp-plugin-enables-wordpress-sites-to-use-the-free-jsdelivr-cdn\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:5414:\"<p>Milan Dinić, a WordPress developer based in Serbia, has released his <a href=\"https://wordpress.org/plugins/commonwp/\" rel=\"noopener noreferrer\" target=\"_blank\">commonWP</a> plugin that enables WordPress sites to use the free, public <a href=\"https://www.jsdelivr.com/\" rel=\"noopener noreferrer\" target=\"_blank\">jsDelivr</a> CDN. Last year <a href=\"https://www.jsdelivr.com/blog/jsdelivr-reloaded-2017/\" rel=\"noopener noreferrer\" target=\"_blank\">jsDelivr was revamped</a> to allow any file from GitHub and npm to be served by the CDN. WordPress&#8217; mirror on GitHub made it possible for Dinić to create a plugin that works with the CDN.</p>\n<p>commonWP aims to speed up performance by offloading JavaScript and CSS files to jsDelivr, including the following:</p>\n<ul>\n<li>All files from WordPress core (unless development version of WordPress is in use)</li>\n<li>All files from plugins hosted by WordPress.org Plugins Repository (unless author of specific plugin doesn’t use SVN tags for releasing)</li>\n<li>All files from themes hosted by WordPress.org Themes Repository</li>\n<li>All files from plugins and themes hosted on GitHub that support GitHub Updater</li>\n<li>All files marked as available on npm in any type of theme, plugin, or MU plugin</li>\n</ul>\n<p>Dinić said he designed commonWP with a emphasis on keeping it lightweight, easy-to-use, and secure. He claims the approach he used in the plugin is safer than any other plugin that employs a CDN for WordPress files:</p>\n<blockquote><p>First, commonWP will only rewrite file to point to one on jsDelivr if that remote file is identical to local one. Second, during comparison, it generates <a href=\"https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity\" rel=\"noopener noreferrer\" target=\"_blank\">subresource identity hash</a> of remote jsDelivr file and includes that hash in page’s source code so browser won’t load remote file if it doesn’t have exactly the same hash.</p></blockquote>\n<p>Dinić recommends the plugin for users who are not already using a CDN, have limited budgets, or live in less developed countries.</p>\n<p>&#8220;Using a CDN is generally recommended, and with this one they might get even more speed because some files might be already cached by their visitors,&#8221; he said. &#8220;Imagine if jquery.js, jquery-migrate.min.js (most common files) are always served from one place. You wouldn&#8217;t need to get them from each WordPress site you visit. You would get them once and they would be in your browser&#8217;s cache, and initial page load would be faster.&#8221;</p>\n<p>Dinić referenced a Trac <a href=\"https://core.trac.wordpress.org/ticket/44229\" rel=\"noopener noreferrer\" target=\"_blank\">ticket</a> where using a CDN is proposed for serving assets like jQuery, but no action has been taken on the proposal yet. One benefit he cites for WordPress&#8217; global user base is that a CDN like jsDelivr allows visitors to get files from their own content, country, or even the same city. jsDelivr has a large multi-CDN network with infrastructure built on top of other networks, including StackPath, Cloudflare, Fastly, and Quantil. It also has custom servers in locations like China where other public CDNs have little or no presence.</p>\n<p><a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/09/Screen-Shot-2018-09-21-at-2.39.40-PM.png?ssl=1\"><img /></a></p>\n<p>commonWP doesn&#8217;t have any settings for users to configure. The plugin fills up its cache in the background after it is activated. Developers can fine tune it for their needs and Dinić has published some <a href=\"https://github.com/dimadin/commonWP#marking-files-that-exist-in-npm\" rel=\"noopener noreferrer\" target=\"_blank\">code examples</a> to GitHub.</p>\n<p>In his release <a href=\"https://milandinic.com/2018/09/18/introducing-commonwp/\" rel=\"noopener noreferrer\" target=\"_blank\">post</a>, Dinić referenced a Serbian site getting a 1-second loading improvement and has done other tests but said he&#8217;s still looking for a good way to present the data. The plugin&#8217;s FAQ outlines which factors influence whether or not commonWP can bring performance improvements:</p>\n<ul>\n<li>How many of your files are available on jsDelivr and can be rewritten &#8211; the more files on jsDelivr, the more speed; the more files used by the page are rewritten to jsDelivr, the more speed.</li>\n<li>The further your site&#8217;s visitors are from the server your site is hosted on, the more speed you can get.</li>\n<li>The slower your server is, the more speed it can get.</li>\n<li>If your visitors already visited WordPress site(s) with commonWP activated, there is more chance that some of the files you use on your site are already cached by them so they can get more speed.</li>\n</ul>\n<p>Not every site will see drastic improvements for site owners testing performance, but visitors from other parts of the world may be able to load certain files faster. Dinić recommends users test their sites using webpagetest.org and select a higher number of tests to get an average. He also recommends testing with different locations and different connection speeds. Test with the plugin activated and deactivated and when the site has a full cache. In general, the further the location is from the server and the larger number of files sent to jsDelivr, the bigger the performance improvement will be.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Fri, 21 Sep 2018 20:19:34 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:2;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:71:\"WPTavern: Gutenstats Blog Is Live, Tracking Gutenberg Beta Testing Data\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=84153\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:81:\"https://wptavern.com/gutenstats-blog-is-live-tracking-gutenberg-beta-testing-data\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:1455:\"<p>Matt Mullenweg <a href=\"https://twitter.com/photomatt/status/1042901193679241216\" rel=\"noopener noreferrer\" target=\"_blank\">tweeted</a> out a link to <a href=\"https://gutenstats.blog/\" rel=\"noopener noreferrer\" target=\"_blank\">Gutenstats.blog</a> this evening, a new site dedicated to tracking Gutenberg beta testing data. The site shows there are currently more than 420,000 active installations of Gutenberg, a slightly more precise number than reported on the WordPress.org plugin page (400K+).</p>\n<p>Gutenstats also tracked 213,000 posts written with the new editor and 8,142 posts written yesterday. These numbers were collected from posts made on WordPress.com and Jetpack sites since late August 2018 and a note on the site says the actual number is higher.</p>\n<p>In June, Mullenweg unveiled a <a href=\"https://wptavern.com/matt-mullenweg-unveils-gutenberg-roadmap-at-wceu-wordpress-agencies-and-product-developers-sprint-to-prepare\" rel=\"noopener noreferrer\" target=\"_blank\">roadmap for Gutenberg to land in WordPress 5.0</a>. At that time the plugin was active on just 14,000 sites. He proposed 100K+ sites having made 250K+ posts using Gutenberg as a threshold for adequate pre-5.0 testing.</p>\n<p>Gutenstats tracking shows testing has far exceeded the original goal for active installations and should reach the posts written goal in just a few days. Mullenweg said they plan to add some block stats to the tracking page in the future.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Fri, 21 Sep 2018 04:21:59 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:3;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:70:\"WPTavern: ACF 5.0 Released with Updated UI and Gutenberg Compatibility\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=84105\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:81:\"https://wptavern.com/acf-5-0-released-with-updated-ui-and-gutenberg-compatibility\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:2771:\"<p><a href=\"https://www.advancedcustomfields.com/blog/acf-5-0-release/\" rel=\"noopener noreferrer\" target=\"_blank\">ACF version 5.0</a> landed on WordPress.org this week with Gutenberg compatibility now available for more than one million sites where the plugin is active. The release is a welcome update for developers who were concerned about what would happen in real world usage of Gutenberg on sites with ACF-powered customizations. ACF&#8217;s Gutenberg compatibility is arriving well ahead of WordPress 5.0&#8217;s TBD schedule for merging the new editor, giving developers time to get their clients&#8217; sites ready.</p>\n<p>&#8220;You can expect to see lots of Gutenberg related items in our changelogs over the coming months as we edge nearer to WordPress version 5.0,&#8221; the ACF announcement stated. &#8220;You’ll also want to take note that ACF 5 is the only version that will provide Gutenberg support. Previous versions will not be compatible.&#8221;</p>\n<p>The version numbers across ACF Pro and the free version on WordPress.org are somewhat confusing. This particular release is significant in that it brings several years of development from the Pro version into the plugin hosted on WordPress.org. Now both products are technically on v5.7.6.</p>\n<blockquote class=\"twitter-tweet\">\n<p lang=\"en\" dir=\"ltr\">Hi guys. This version 5 release is for our “free plugin” on <a href=\"https://t.co/V7oUQSI5Ei\">https://t.co/V7oUQSI5Ei</a> and does not affect ACF PRO. Now both ACF and ACF PRO are v5.7.6!</p>\n<p>&mdash; Advanced Custom Fields (@wp_acf) <a href=\"https://twitter.com/wp_acf/status/1041590825505849344?ref_src=twsrc%5Etfw\">September 17, 2018</a></p></blockquote>\n<p></p>\n<p>ACF 5.0 introduces a redesigned UI, performance improvements, and the plugin&#8217;s new <a href=\"https://www.advancedcustomfields.com/resources/local-json/\" rel=\"noopener noreferrer\" target=\"_blank\">Local JSON</a> feature, which saves field group and field settings as .json files within the user&#8217;s theme. This reduces database calls and allows for version control of field settings.</p>\n<a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/09/acf-5-0-fresh-ui.jpg?ssl=1\"><img /></a>image credit: <a href=\"https://www.advancedcustomfields.com/blog/acf-5-0-release/\">ACF</a>\n<p>Version 5.0 adds six new fields, including a link, group, accordion, oEmbed, date time picker, and clone fields (an ACF pro feature). It also introduce a new Tools page where users can export and import field groups as JSON.</p>\n<p>For more information on items related to upgrading ACF and add-on compatibility, check out the official <a href=\"https://www.advancedcustomfields.com/blog/acf-5-0-release/\" rel=\"noopener noreferrer\" target=\"_blank\">5.0 release post</a>.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Thu, 20 Sep 2018 17:54:02 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:4;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:61:\"WPTavern: WPForms Acquires Pirate Forms, Plugin to be Retired\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=84108\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:71:\"https://wptavern.com/wpforms-acquires-pirate-forms-plugin-to-be-retired\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:3737:\"<a href=\"https://i1.wp.com/wptavern.com/wp-content/uploads/2018/09/pirates.jpg?ssl=1\"><img /></a>photo credit: Reiterlied <a href=\"http://www.flickr.com/photos/126661502@N05/37773453702\">Plundering San Francisco Bay</a> &#8211; <a href=\"https://creativecommons.org/licenses/by-nc-sa/2.0/\">(license)</a>\n<p><a href=\"https://wpforms.com/wpforms-has-acquired-pirate-forms/\" rel=\"noopener noreferrer\" target=\"_blank\">WPForms has acquired Pirate Forms</a>, a popular WordPress contact form and SMTP plugin originally created by ThemeIsle in 2015. The announcement coincides with International Talk Like a Pirate Day but the pirate branding of the plugin is set to be retired and its users will be given the option to migrate to WPForms.</p>\n<p><a href=\"https://wordpress.org/plugins/pirate-forms/\" rel=\"noopener noreferrer\" target=\"_blank\">Pirate Forms</a> was purchased in what WPForms co-founder and CEO Syed Balkhi describes as &#8220;an all-cash deal.&#8221; Although the plugin currently has more than 300,000 users on WordPress.org, its features and capabilities are inferior to the more modern WPForms and its creators lacked the resources to bring it up to speed.</p>\n<p>Pirate Forms had gained popularity in its earlier days by providing a simple forms plugin (without all the builder functions) for sites that required just one contact form.</p>\n<p>&#8220;Where most of the other plugins aim at &#8216;mega functionality&#8217; with tons of customizations, add-ons and whatnots, Pirate Forms has made a bet on simplicity,&#8221; ThemeIsle representative Karol K said in the plugin&#8217;s <a href=\"https://themeisle.com/blog/pirate-forms-is-now-wpforms/\" rel=\"noopener noreferrer\" target=\"_blank\">farewell post</a>.</p>\n<p>&#8220;In other words, it just works(ed) right after the installation, with no particular setup required (other than adding your form to a contact page). This was a nice refreshment compared to the usual &#8216;get through tons of onboarding wizard screens before you can use the plugin&#8217; -approach.&#8221;</p>\n<p>Pirate Forms could no longer deliver what users expect from a forms plugin in 2018 and ThemeIsle opted to find a buyer in order to free up resources to focus on releasing the <a href=\"https://themeisle.com/blog/hestia-2-0/\" rel=\"noopener noreferrer\" target=\"_blank\">Hestia 2.0</a> theme.</p>\n<p>&#8220;This acquisition further strengthens WPForms&#8217; position in the WordPress ecosystem,&#8221; Balkhi said. The expectation is that a large number of users will migrate their forms to WPForms as the result of Pirate Forms discontinuing active development.</p>\n<p><a href=\"https://wpforms.com/docs/how-to-move-from-pirate-forms-to-wpforms/\" rel=\"noopener noreferrer\" target=\"_blank\">A migration path to WPForms</a> is built into the latest version of Pirate Forms and Balkhi describes the process as a seamless transition. Users are also free to select another forms plugin but they will not have the benefit of the migration tool, which also imports the notification email and confirmation settings from users&#8217; existing forms. Those who have purchased Pirate Forms Pro will receive a free one-year license to WPForms Pro.</p>\n<p><a href=\"https://wordpress.org/plugins/wpforms-lite/\" rel=\"noopener noreferrer\" target=\"_blank\">WPForms</a> has more than 1 million active installs and currently maintains a 4.9 out of 5 star average rating on WordPress.org. The drag-and-drop WordPress form builder is much more advanced than Pirate Forms and the free version allows users to create contact forms, subscription forms, payment forms, offline forms, multi-page forms, and many other types of customized feedback mechanisms. It is also compatible with all of ThemeIsle&#8217;s themes.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Thu, 20 Sep 2018 02:50:38 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:5;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:90:\"WPTavern: Big Bite Creative to Launch New Amnesty International Website based on Gutenberg\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=84074\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:100:\"https://wptavern.com/big-bite-creative-launches-new-amnesty-international-website-based-on-gutenberg\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:4776:\"<p><a href=\"https://i1.wp.com/wptavern.com/wp-content/uploads/2018/09/Screen-Shot-2018-09-19-at-10.39.11-AM.png?ssl=1\"><img /></a></p>\n<p>The team at <a href=\"http://bigbitecreative.com\" rel=\"noopener noreferrer\" target=\"_blank\">Big Bite Creative</a> has developed a new website for Amnesty International using Gutenberg, soon to be launched at <a href=\"http://amnesty.eu\" rel=\"noopener noreferrer\" target=\"_blank\">amnesty.eu</a>. The agency worked in partnership with <a href=\"https://vip.wordpress.com\" rel=\"noopener noreferrer\" target=\"_blank\">WordPress.com VIP</a> to provide the London-based human rights organization with the tools to create multiple sites that could be uniquely customized for their editorial needs.</p>\n<p>After successfully using Gutenberg to launch a site for an international bank, Big Bite CTO Jason Agnew said his team gained confidence to use the new editor for the Amnesty site. The client approached Bite Bite around the time of WordCamp Europe when Matt Mullenweg unveiled a roadmap for getting a stable Gutenberg release before the end of the year.</p>\n<p>&#8220;On top of this the Amnesty project suited Gutenberg,&#8221; Agnew said. &#8220;Their brief mentioned 14 components which could be used to build out multiple sites. I honestly think it would have been difficult to build something that required this level of flexibility with a field manager like Fieldmanager, CMB2 or ACF. Perhaps it would have been possible with page builders like Visual Composer, but these platforms are still figuring out how they will work with the WordPress 5.0.&#8221;</p>\n<p>Through the use of a combination of prompts, custom blocks, nested blocks, and predefined styles, Big Bite made it possible for even non-technical editorial staff to create and arrange content to build out websites for various outreach locations.</p>\n<p>&#8220;It&#8217;s been fascinating to give the client full control over the site structure compared to the more traditional development of templates,&#8221; Agnew said. &#8220;We are still in the early stages of launching sites with the new platform, but the client has built up the EU site on their own without much support, which should be going live early October. Now they are in the process building out websites for Mali and Iran, with the goal to launch around 20 sites initially. We&#8217;ve had the editorial team describe the experience as fun &#8211; that&#8217;s from a team who have used WordPress with ACF in the past, which does offer an intuitive UI but still requires a level of training of what fields relate to what pieces of content on the front-end.&#8221;</p>\n<p>As many others have reported, one of the most challenging things Big Bite encountered in extending Gutenberg was the project&#8217;s incomplete documentation.</p>\n<p>&#8220;We&#8217;ve had our challenges, and particularly the Gutenberg documentation is not up to standard, which leads to a lot of time being wasted,&#8221; Agnew said. &#8220;But I have to say once our team get over the first block or two it wasn&#8217;t an issue. It&#8217;s important to say that the Gutenberg team Slack have been a great help when we did run into problems. We did discover IE11 support is still a work in progress, for example, copy &amp; paste didn&#8217;t work, meta boxes wouldn&#8217;t render causing saving issues with posts.&#8221;</p>\n<p>Agnew said for most issues there isn&#8217;t a lot one can do to resolve them apart from waiting for each update as the plugin improves, but it&#8217;s something agencies need to account for when working with clients. The Big Bite team also found that Gutenberg compatibility is still an issue for many of the plugins that they looked at using for the project.</p>\n<p>&#8220;Apart from using Yoast we&#8217;ve mainly custom built the theme due to many plugins still requiring UI changes to work well with Gutenberg,&#8221; Agnew said. &#8220;Probably the most significant feature we wrote was language syndication system.&#8221;</p>\n<p>Big Bite plans to open source Amnesty International&#8217;s full theme, which includes all of the custom blocks. Prior to that they are going to remove all the branding to avoid lots of new sites popping looking like the Amnesty brand. The agency is aiming for publishing the code the same day as WordPress 5.0 is released or earlier if the release is delayed beyond January.</p>\n<p>For a closer look at the Amnesty International project, check out Big Bite&#8217;s announcement <a href=\"https://bigbitecreative.com/investing-gutenberg-amnesty-international/\" rel=\"noopener noreferrer\" target=\"_blank\">post</a>. The video below was created in partnership with WordPress.com VIP and offers a tour of some of the custom Gutenberg blocks they created for Amnesty.</p>\n<p></p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Wed, 19 Sep 2018 19:12:43 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:6;a:6:{s:4:\"data\";s:11:\"\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:1:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:46:\"HeroPress: The “India is cheap” Stereotype\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://heropress.com/?p=2627\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:125:\"https://heropress.com/the-india-is-cheap-stereotype/#utm_source=rss&utm_medium=rss&utm_campaign=the-india-is-cheap-stereotype\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:3284:\"<img width=\"960\" height=\"480\" src=\"https://s20094.pcdn.co/wp-content/uploads/2015/10/MeasureSuccess-HeroPress-2-1024x512.jpg\" class=\"attachment-large size-large wp-post-image\" alt=\"Pull quote: Measure success in terms of the impact your work is making.\" /><p>In the early days of HeroPress there were quite a few Indian contributors, for a variety of reasons. India has long been a technology powerhouse, but the WordPress community was just beginning to get traction. I got to meet many Indians and even traveled there for <a href=\"https://heropress.com/going-to-wordcamp-pune/\">WordCamp Pune</a>. The stereotype that &#8220;India is cheap&#8221; is a difficult one for Indians to deal with. What does it mean? How should it be responded to?</p>\n<p>In October of 2015 Rahul Bansal, the owner of a world class WordPress agency named rtCamp, did a HeroPress essay where he talks about what it means to run an agency in India, charge properly, and turn our work that rivals any from anywhere else in the world.  Check out Rahul&#8217;s thoughts:</p>\n<blockquote class=\"wp-embedded-content\"><p><a href=\"https://heropress.com/essays/wordpress-continues-inspire/\">WordPress Continues to Inspire</a></p></blockquote>\n<p></p>\n<div class=\"rtsocial-container rtsocial-container-align-right rtsocial-horizontal\"><div class=\"rtsocial-twitter-horizontal\"><div class=\"rtsocial-twitter-horizontal-button\"><a title=\"Tweet: The “India is cheap” Stereotype\" class=\"rtsocial-twitter-button\" href=\"https://twitter.com/share?text=The%20%E2%80%9CIndia%20is%20cheap%E2%80%9D%20Stereotype&via=heropress&url=https%3A%2F%2Fheropress.com%2Fthe-india-is-cheap-stereotype%2F\" rel=\"nofollow\" target=\"_blank\"></a></div></div><div class=\"rtsocial-fb-horizontal fb-light\"><div class=\"rtsocial-fb-horizontal-button\"><a title=\"Like: The “India is cheap” Stereotype\" class=\"rtsocial-fb-button rtsocial-fb-like-light\" href=\"https://www.facebook.com/sharer.php?u=https%3A%2F%2Fheropress.com%2Fthe-india-is-cheap-stereotype%2F\" rel=\"nofollow\" target=\"_blank\"></a></div></div><div class=\"rtsocial-linkedin-horizontal\"><div class=\"rtsocial-linkedin-horizontal-button\"><a class=\"rtsocial-linkedin-button\" href=\"https://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fheropress.com%2Fthe-india-is-cheap-stereotype%2F&title=The+%E2%80%9CIndia+is+cheap%E2%80%9D+Stereotype\" rel=\"nofollow\" target=\"_blank\" title=\"Share: The “India is cheap” Stereotype\"></a></div></div><div class=\"rtsocial-pinterest-horizontal\"><div class=\"rtsocial-pinterest-horizontal-button\"><a class=\"rtsocial-pinterest-button\" href=\"https://pinterest.com/pin/create/button/?url=https://heropress.com/the-india-is-cheap-stereotype/&media=https://heropress.com/wp-content/uploads/2015/10/MeasureSuccess-HeroPress-2-150x150.jpg&description=The “India is cheap” Stereotype\" rel=\"nofollow\" target=\"_blank\" title=\"Pin: The “India is cheap” Stereotype\"></a></div></div><a rel=\"nofollow\" class=\"perma-link\" href=\"https://heropress.com/the-india-is-cheap-stereotype/\" title=\"The “India is cheap” Stereotype\"></a></div><p>The post <a rel=\"nofollow\" href=\"https://heropress.com/the-india-is-cheap-stereotype/\">The “India is cheap” Stereotype</a> appeared first on <a rel=\"nofollow\" href=\"https://heropress.com\">HeroPress</a>.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Wed, 19 Sep 2018 14:59:29 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:7;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:89:\"WPTavern: Gutenberg Cloud: A Cross-Platform Community Library for Custom Gutenberg Blocks\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=84045\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:99:\"https://wptavern.com/gutenberg-cloud-a-cross-platform-community-library-for-custom-gutenberg-blocks\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:8949:\"<p>During their <a href=\"https://wptavern.com/drupal-gutenberg-project-receives-enthusiastic-reception-at-drupal-europe\" rel=\"noopener noreferrer\" target=\"_blank\">presentation at Drupal Europe</a>, the <a href=\"https://www.frontkom.no/\" rel=\"noopener noreferrer\" target=\"_blank\">Frontkom</a> team behind the Drupal Gutenberg project announced that they are working on a block management system called <a href=\"https://gutenbergcloud.org/\" rel=\"noopener noreferrer\" target=\"_blank\">Gutenberg Cloud</a>, a collective library of blocks online.</p>\n<p>The library will offer a content repository for custom Gutenberg blocks, such as forms, a call-to-action section, product grid, or even a web component. Since the blocks are JavaScript-only, they would work across both Drupal and WordPress alike, so developers can build for both platforms simultaneously. The Gutenberg Cloud creators are aiming to facilitate a new level of cross-platform sharing that few envisioned when the Gutenberg project began.</p>\n<p>&#8220;Gutenberg to us is much more than just another module,&#8221; Frontkom CIO Per André Rønsen said during their presentation at Drupal Europe. &#8220;We think of it as a platform for brand new features. We are very excited about the sharing/community aspect and the possibilities here. We want to make it easy to share and reuse custom blocks across pages, across projects, across companies, and even across publishing platforms. Drupal has always been great at sharing backend style of code. Now let&#8217;s make it great at sharing frontend code as well. This is why we&#8217;re working on a block managing system.&#8221;</p>\n<p><a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/09/gutenberg-cloud.png?ssl=1\"><img /></a></p>\n<p>Gutenberg Cloud would provide a plugin for WordPress and a module for Drupal (and eventually other applications) that would enable users to browse, filter, and discover blocks within the admin and download the ones they select. Early mockups I previewed show an interface similar to the theme and plugin browsers inside the WordPress admin.</p>\n<p>A cloud-based block service solves a few problems that Gutenberg early adopters are already experiencing when hunting for blocks. WordPress theme and plugin shops have have been releasing their own block collections bundled into a plugin, but it&#8217;s not easy to discover or browse the individual blocks. Having blocks available on Gutenberg Cloud would prevent developers from having to create a new module or plugin for each individual block. It also prevents users from having to download an entire collection of blocks in a plugin when they really only need one or two of them.</p>\n<h3>Gutenberg Cloud Will Launch as a Community Project, Developers Contribute by Publishing Packages to NPM</h3>\n<p>Rønsen said they plan to launch Gutenberg Cloud as a community project. Any developer can contribute blocks by creating an NPM package and tagging it with &#8220;gutenberg-cloud.&#8221; The description on the cloud service outlines their intentions: &#8220;Code once, use everywhere: As Gutenberg blocks are CMS-agnostic, we want to provide an ecosystem all systems can connect to.&#8221;</p>\n<a href=\"https://i0.wp.com/wptavern.com/wp-content/uploads/2018/09/Screen-Shot-2018-09-18-at-3.39.54-PM.png?ssl=1\"><img /></a>An example Hero section block published to NPM\n<p>&#8220;We imagine everything from freelancers to big agencies and even community minded non-profits to contribute,&#8221; Rønsen said. &#8220;When people benefit from a better user experience, they tend to want to pay it forward. We have already talked to people in both communities wanting to contribute with code, so that is a great start for the platform.&#8221;</p>\n<p>I asked if his team envisions block creators being able to sell access to their blocks in the future. He said his team is open to finding a payment solution for commercial blocks but only if the community demands it.</p>\n<p>&#8220;Personally, I would be skeptical about committing to a community project that had a very commercial edge,&#8221; Rønsen said. &#8220;I think it&#8217;s important that the project stays focused on open source contributions, with a sharing-is-caring attitude. It&#8217;s the only language we know in Drupal. However, there is nothing wrong in providing high quality content and getting paid to do it. That&#8217;s why it&#8217;s on our roadmap to facilitate a payment solution for premium blocks – if the community wants it. It&#8217;s not central to the success of the platform, but I imagine it could be a great way to make some money for a skilled designer.&#8221;</p>\n<p>Rønsen said his team plans to launch Gutenberg Cloud sometime later this year after completing internal testing and an invitation-only closed beta with a different companies. One of the most challenging aspect of the project is creating a system that can handle updates.</p>\n<p>&#8220;By default users will get the latest stable release for the block from the author,&#8221; Rønsen said. &#8220;There will be a way to lock into a specific version and to version control that in Git, however. The plugin update system is a good analogy, but the infrastructure is completely outside of WordPress core. There are also some issues we haven’t solved yet regarding updates; it’s hard to make a system that doesn’t require a high maintenance effort for block developers.&#8221;</p>\n<p>The Gutenberg Cloud project is contingent upon Gutenberg development continuing on a path towards being a library that is decoupled from WordPress. Last week Rønsen <a href=\"https://wptavern.com/drupal-gutenberg-project-receives-enthusiastic-reception-at-drupal-europe\" rel=\"noopener noreferrer\" target=\"_blank\">told</a> the Tavern that his team hopes &#8220;that Gutenberg core devs will catch onto the vision of Gutenberg as the ‘editor for the open web’ — not just for WordPress.&#8221;</p>\n<p>Gutenberg team member Gary Pendergast indirectly acknowledged this in a recent blog <a href=\"https://pento.net/2018/09/16/the-mission-democratise-publishing/\" rel=\"noopener noreferrer\" target=\"_blank\">post</a> that affirmed the Drupal Gutenberg project and reiterated WordPress&#8217; mission to democratize publishing.</p>\n<p>&#8220;One of the primary philosophies of Gutenberg’s technical architecture is platform agnosticism, and we can see the practical effects of this practice coming to fruition across a variety of projects,&#8221; Pendergast said.</p>\n<p>&#8220;From early experiments in running the block editor as a standalone application, to being able to compile it into a native mobile component, and now seeing it running on Drupal, Gutenberg’s technical goals have always included a radical level of platform agnosticism.&#8221;</p>\n<p>If the Drupal community ends up adopting Gutenberg for its core editor, the shared library presents an unprecedented opportunity for deeper collaboration across the two publishing platforms. As an agency that has done client work for publishers on both CMSs, Frontkom saw the potential before many others and took it upon themselves to fork Gutenberg for Drupal. This is the beauty of open source software in action.</p>\n<p>&#8220;WordPress has many advantages that make it so popular, but hoarding those to ourselves doesn’t help the open web, it just creates more silos,&#8221; Pendergast said. &#8220;The open web is the only platform on which publishing can be democratized, so it makes sense for Gutenberg to work anywhere on the open web, not just inside WordPress. Drupal isn’t a competitor here, we’re all working towards the same goal, the different paths we’ve taken have made the open web stronger as a whole.&#8221;</p>\n<p>Rønsen said he could see other applications and e-commerce platforms like Magento benefitting from better page-building tools. His company has a special interest in publishers and plans to release a set of open source tools for building news front pages later in 2018. Rønsen said he is hopeful the Drupal Gutenberg project can evolve alongside WordPress as it enters into the site building and customization phase of the project.</p>\n<p>&#8220;I&#8217;m hopeful that the Gutenberg project will stay decoupled from WP one way or another,&#8221; Rønsen said. &#8220;This will leave room for Drupal to innovate on top of it. It could even be the case that the page building tools and customizer integration in WP will play nicely into the current architecture. In any case, I believe the basics of the editor and block concept will continue to be a good fit for Drupal. There is already some consensus out there on how to use Gutenberg for page building. A great example, is <a href=\"https://www.youtube.com/watch?v=OgF5ImDlCTw\" rel=\"noopener noreferrer\" target=\"_blank\">Big Bite&#8217;s work with Amnesty</a>. If the continued experience is anything like that, I think we have a perfect match.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 18 Sep 2018 22:38:31 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:8;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"Matt: CEOs and the Real World\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:22:\"https://ma.tt/?p=48345\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:46:\"https://ma.tt/2018/09/ceos-and-the-real-world/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:4867:\"<blockquote class=\"wp-block-quote\"><p>The downside of Zuckerberg’s exalted status within his company is that it is difficult for him to get genuine, unexpurgated feedback. He has tried, at times, to puncture his own bubble. In 2013, as a New Year’s resolution, he pledged to meet someone new, outside Facebook, every day. In 2017, he travelled to more than thirty states on a “listening tour” that he hoped would better acquaint him with the outside world. David Plouffe, President Obama’s former campaign manager, who is now the head of policy and advocacy at the Chan Zuckerberg Initiative, the family’s philanthropic investment company, attended some events on the tour. He told me, “When a politician goes to one of those, it’s an hour, and they’re talking for fifty of those minutes. He would talk for, like, five, and just ask questions.”</p><p>But the exercise came off as stilted and tone-deaf. Zuckerberg travelled with a professional photographer, who documented him feeding a calf in Wisconsin, ordering barbecue, and working on an assembly line at a Ford plant in Michigan. Online, people joked that the photos made him look like an extraterrestrial exploring the human race for the first time. A former Facebook executive who was involved in the tour told a friend, “No one wanted to tell Mark, and no one did tell Mark, that this really looks just dumb.”</p></blockquote>\n\n<p>There seem to be three communication gaps outlined here in Evan Osnos&#8217;s <a href=\"https://www.newyorker.com/magazine/2018/09/17/can-mark-zuckerberg-fix-facebook-before-it-breaks-democracy\">revealing profile of Mark Zuckerberg</a>: one is getting unvarnished feedback from your employees. Speaking as a fellow CEO and founder, it&#8217;s certainly hard to pop that bubble &#8212; see <a href=\"https://www.youtube.com/watch?v=uAxAVusStCg\">&#8220;the bear is sticky with honey.&#8221;</a> There are a few techniques like skip-level 1:1 meetings, anonymous feedback forms, interviewing new hires, and 360 reviews you can do to try to counter this, but there&#8217;s no panacea and this one requires constant work as you scale.</p>\n\n<p>The second gap is getting the unvarnished truth from your users &#8212; much easier, as they&#8217;re quite happy to tell you what&#8217;s what. I&#8217;ve recently started cold-calling (yes, on the phone!) some of our Jetpack customers just to understand what they love and don&#8217;t love about the experience and about how we can help them solve their business challenges. There&#8217;s a casual intimacy to phone conversations that just can&#8217;t be replicated in other user feedback forums. Pair this with good instrumentation throughout your product so you see what people do and not just what they say and you&#8217;re golden.</p>\n\n<p>The third and last communication gap is the connection to the world as most people experience it. If your status, wealth, or celebrity reach a point that they are shutting you out from &#8220;real&#8221; experiences, take some risks and get outside of your comfort zone. As it turns out, <a href=\"https://www.gq.com/story/the-untold-stories-of-paul-mccartney\">this new GQ profile of Paul McCartney offered a tip on that: </a></p>\n\n<blockquote class=\"wp-block-quote\"><p>McCartney tells me a further such story of a time he took the Hampton Jitney, the slightly upmarket bus service that runs from the Hamptons into Manhattan, because he was deep into Charles Dickens&#8217;s Nicholas Nickleby and he wanted to finish it, and how he then took a local bus uptown, and when a woman blurted from across the bus, &#8220;Hey! Are you Paul McCartney?&#8221; he invited her to sit next to him and chatted all the way uptown. &#8220;It&#8217;s a way of not worrying about your fame,&#8221; he says. &#8220;It&#8217;s a way of not turning into the reclusive rock star. I often say to Nancy: I get in their faces before they get a chance to get in mine.&#8221;</p></blockquote>\n\n<p>Makes me wonder if <a href=\"https://techcrunch.com/2012/09/12/jack-dorsey-bus-bubble/\">Jack Dorsey still rides the bus to work every day</a>. I think this is what Zuckerberg was attempting with his 30-state tour, and hopefully it was helpful even if the optics didn&#8217;t appeal to everyone — the daily habit of his 2013 resolution to meet someone new every day feels more powerful than the touristic 30-state one. But for an entity as large as Facebook maybe it&#8217;s moot, as Casey Newton pointed out <a href=\"https://www.getrevue.co/profile/caseynewton/issues/the-trouble-with-mark-zuckerberg-profiles-133299\">in his newsletter last week</a> it can be quite hard to pin the answers to Facebook&#8217;s real problems, and our democracy&#8217;s real challenges <a href=\"https://ma.tt/2018/09/responsibility-of-technology/\">in the face of targeted online propaganda</a>, to just one person.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 18 Sep 2018 21:35:20 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:4:\"Matt\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:9;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:95:\"WPTavern: Hybrid Core 5.0 Offers a More Modern, Modular Approach to WordPress Theme Development\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83987\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:99:\"https://wptavern.com/hybrid-core-5-0-offers-a-more-modern-modular-approach-to-wordpress-development\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:3877:\"<a href=\"https://i1.wp.com/wptavern.com/wp-content/uploads/2018/09/coffee-computer.jpg?ssl=1\"><img /></a>image credit: <a href=\"https://stocksnap.io/photo/JFPYO9HEZR\">Shopify</a>\n<p><a href=\"https://themehybrid.com/weblog/hybrid-core-version-5-0\" rel=\"noopener noreferrer\" target=\"_blank\">Version 5.0</a> of Hybrid Core, one of the longest-running WordPress theme frameworks, is now available. Justin Tadlock celebrated 10 years with his Theme Hybrid community last month and <a href=\"https://wptavern.com/mythic-a-wordpress-starter-theme-by-justin-tadlock-now-in-open-beta\" rel=\"noopener noreferrer\" target=\"_blank\">released his new Mythic starter theme into beta</a>. Mythic was built on top of Hybrid Core and developed in tandem with version 5.0.</p>\n<p>The framework has been rewritten almost entirely from scratch to be a leaner, more modern starting place for theme development. Tadlock describes it as &#8220;a fundamentally different framework, rewritten from the ground up, that supports more modern PHP practices.&#8221;</p>\n<p>&#8220;I started 5.0 with a goal of bringing the framework up to date with more modern PHP practices and code,&#8221; he said. &#8220;The first iteration of the framework was built in 2008, so it was time to get us ready for the next era of theme building.&#8221;</p>\n<p>In nearly a decade of supporting the framework, Tadlock found that users didn&#8217;t always know how to get started building something from scratch. Many copied one of his existing themes and would add and remove things from it based on their own needs.</p>\n<p>Version 5.0 doesn&#8217;t necessarily make it easier to build on top of Hybrid Core with its new, more complicated method of bootstrapping, new <a href=\"https://themehybrid.com/weblog/working-with-the-view-class\" rel=\"noopener noreferrer\" target=\"_blank\">view system for templating</a>, and requirement for using <a href=\"https://getcomposer.org/\" rel=\"noopener noreferrer\" target=\"_blank\">Composer</a>. This is why Tadlock is officially recommending <a href=\"https://themehybrid.com/themes/mythic\" rel=\"noopener noreferrer\" target=\"_blank\">Mythic</a> as the path for building a theme with Hybrid Core in the future. Most of the documentation and tutorials he plans to create in the future will be centered around the Mythic starter theme, which is nearing a 1.0 release.</p>\n<blockquote class=\"twitter-tweet\">\n<p lang=\"en\" dir=\"ltr\">We just closed all tickets on the 1.0.0 milestone for the Mythic starter theme! It feels pretty good.</p>\n<p>Barring any OMGBBQ issues between now and tomorrow, you should see an announcement post from me.<a href=\"https://t.co/J4CGLKa1y5\">https://t.co/J4CGLKa1y5</a></p>\n<p>&mdash; Justin Tadlock (@justintadlock) <a href=\"https://twitter.com/justintadlock/status/1041808697813598208?ref_src=twsrc%5Etfw\">September 17, 2018</a></p></blockquote>\n<p></p>\n<p>For many theme developers, Mythic&#8217;s use of the BEM (Block-Element-Modifier) CSS class-naming system is their first introduction to a system of non-hierarchal, component-based CSS. Because BEM doesn&#8217;t rely on nested selectors, it&#8217;s easier for users to overwrite CSS that they want to change. Tadlock explains the benefit for child themes in a recent post about <a href=\"https://themehybrid.com/weblog/why-mythic-uses-bem\" rel=\"noopener noreferrer\" target=\"_blank\">why Mythic uses BEM</a>.</p>\n<p>A handful of the Hybrid add-ons are now available as Composer packages, including one for breadcrumbs, customizer controls and settings, Google fonts, and a featured image script. Tadlock plans to split more parts of the framework off into packages in the future for an increasingly modular core.</p>\n<p>Hybrid Core 5.0 requires PHP 5.6+ (with 7.0+ recommended) and WordPress 4.9.6+. Tadlock will support Hybrid Core&#8217;s 4.x series for at least another year to give theme authors time to adapt.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 18 Sep 2018 04:07:44 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:10;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:81:\"WPTavern: Yoast SEO 8.2 Adds How-To and FAQ Gutenberg Blocks with Structured Data\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83822\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:92:\"https://wptavern.com/yoast-seo-8-2-adds-how-to-and-faq-gutenberg-blocks-with-structured-data\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:2422:\"<p><a href=\"https://yoast.com/yoast-seo-8-2/\" rel=\"noopener noreferrer\" target=\"_blank\">Yoast SEO 8.2</a> was released last week with the plugin&#8217;s first tools designed specifically for Gutenberg. It includes two new How-To and FAQ structured data content blocks for early adopters of the new editor.</p>\n<p>Structured data is content that can be marked up with a shared vocabulary, such as the one provided by <a href=\"http://Schema.org\" rel=\"noopener noreferrer\" target=\"_blank\">Schema.org</a>. Content like products, books, reviews, podcasts, events, and recipes lend themselves well to this specific type of organization. Structured data helps search engines index the site more effectively and communicate results in more compelling ways, such as rich snippets, rich cards, or voice search.</p>\n<p>Structured data is not easy for most WordPress users to implement without the help of a plugin. Now that more content is being created in Gutenberg, users who want their content to display as enhanced search results will need to seek out plugins that make that an automatic part of the content creation process.</p>\n<p>The plugin outlines all the necessary data the users needs to add in order for the How-To and FAQ content blocks to appear as valid pieces of structured data.</p>\n<p><a href=\"https://i0.wp.com/wptavern.com/wp-content/uploads/2018/09/faq-structured-data-yoast-seo.png?ssl=1\"><img /></a></p>\n<p>Alongside this release, Yoast&#8217;s <a href=\"https://yoast.com/wordpress/plugins/local-seo/\" rel=\"noopener noreferrer\" target=\"_blank\">Local SEO</a> and the <a href=\"https://yoast.com/wordpress/plugins/local-seo-for-woocommerce/\" rel=\"noopener noreferrer\" target=\"_blank\">WooCommerce SEO</a> plugins have also added two new structured data Gutenberg blocks: an address block and a Google Maps block.</p>\n<a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/09/local_seo_content_blocks.jpg?ssl=1\"><img /></a>image credit: <a href=\"https://yoast.com/yoast-seo-8-2/\">Yoast.com</a>\n<p>In the future the Yoast team plans to create many more structured data blocks.</p>\n<p>&#8220;We’ll work first on blocks which we can dogfood on Yoast.com, like Job posting and Event,&#8221; Yoast CTO Omar Reiss <a href=\"https://yoast.com/content-blocks-future-benefit-seo/\" rel=\"noopener noreferrer\" target=\"_blank\">said</a>. &#8220;After that, we’ll just go for the popular ones, like Recipe.&#8221;</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Mon, 17 Sep 2018 17:43:29 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:11;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:41:\"Gary: The Mission: Democratise Publishing\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:25:\"https://pento.net/?p=1909\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:64:\"https://pento.net/2018/09/16/the-mission-democratise-publishing/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:5406:\"<p>It&#8217;s exciting to see the <a href=\"https://drupalgutenberg.org/\">Drupal Gutenberg</a> project getting under way, it makes me proud of the work we&#8217;ve done ensuring the flexibility of the underlying Gutenberg architecture. One of the primary philosophies of Gutenberg&#8217;s technical architecture is platform agnosticism, and we can see the practical effects of this practice coming to fruition across a variety of projects.</p>\n\n<p>Yoast are <a href=\"https://yoast.com/yoast-seo-8-2/\">creating new features for the block editor</a>, as well as <a href=\"https://yoast.com/yoast-seo-8-0-introducing-the-yoast-seo-gutenberg-sidebar-a-revamped-meta-box/\">porting existing features</a>, which they&#8217;re able to <a href=\"https://twitter.com/aaronjorbin/status/1040988210682318848\">reuse in the classic editor</a>.</p>\n\n<p>Outside of WordPress Core, the Automattic teams who work on <a href=\"https://github.com/Automattic/wp-calypso\">Calypso</a> have been <a href=\"https://github.com/Automattic/wp-calypso/search?q=gutenberg\">busy</a> adding Gutenberg support, in order to make the block editor interface available on WordPress.com. Gutenberg and Calypso are large JavaScript applications, built with strong opinions on design direction and technical architecture, and having <a href=\"https://github.com/Automattic/wp-calypso/issues/27034\">significant component overlap</a>. That these two projects can function together at all is something of an obscure engineering feat that&#8217;s both difficult and overwhelming to appreciate.</p>\n\n<p>If we reached the limit of Gutenberg&#8217;s platform agnosticism here, it would still be a successful project.</p>\n\n<p>But that&#8217;s not where the ultimate goals of the Gutenberg project stand. From <a href=\"https://github.com/youknowriad/standalone-gutenberg\">early experiments</a> in running the block editor as a <a href=\"https://gutenberg-standalone.surge.sh/\">standalone application</a>, to being able to compile it into a <a href=\"https://github.com/wordpress-mobile/gutenberg-mobile\">native mobile component</a>, and now seeing it <a href=\"https://www.drupal.org/project/gutenberg\">running on Drupal</a>, Gutenberg&#8217;s technical goals have always included a radical level of platform agnosticism.</p>\n\n<h2>Better Together</h2>\n\n<p>Inside the WordPress world, significant effort and focus has been on ensuring backwards compatibility with existing WordPress sites, plugins, and practices. Given that WordPress is such a hugely popular platform, it&#8217;s exceedingly important to ensure this is done right. With Gutenberg expanding outside of the WordPress world, however, we&#8217;re seeing different focuses and priorities arise.</p>\n\n<p>The <a href=\"https://gutenbergcloud.org/\">Gutenberg Cloud</a> service is a fascinating extension being built as part of the Drupal Gutenberg project, for example. It provides a method for new blocks to be shared and discovered, the <a href=\"https://www.npmjs.com/package/@frontkom/g-hero-section\">sample hero block</a> sets a clear tone of providing practical components that can be rapidly put together into a full site. While we&#8217;ve certainly seen similar services appear for the various site builder plugins, this is the first one (that I&#8217;m aware of, at least) build specifically for Gutenberg.</p>\n\n<p>By making the Gutenberg experience available for everyone, regardless of their technical proficiency, experience, or even <em>preferred platform</em>, we pave the way for a better future for all.</p>\n\n<h2>Democratising Publishing</h2>\n\n<p>You might be able to guess where this is going. <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f609.png\" alt=\"😉\" class=\"wp-smiley\" /></p>\n\n<p>WordPress&#8217; mission is to &#8220;democratise publishing&#8221;. It isn&#8217;t to &#8220;be the most popular CMS&#8221;, or to &#8220;run on old versions of PHP&#8221;, though it&#8217;s easy to think that might be the case on the surface. That these statements are true is simply a side effect of the broader principle: All people, regardless of who they are or where they come from, should be able to publish their content as part of a free and open web.</p>\n\n<p>The WordPress mission is not to &#8220;democratise publishing with WordPress&#8221;.</p>\n\n<p>WordPress has many advantages that make it so popular, but hoarding those to ourselves doesn&#8217;t help the open web, it just creates more silos. The open web is the only platform on which publishing can be democratised, so it makes sense for Gutenberg to work anywhere on the open web, not just inside WordPress. Drupal isn&#8217;t a competitor here, we&#8217;re all working towards the same goal, the different paths we&#8217;ve taken have made the open web stronger as a whole.</p>\n\n<p>Much as the block editor has been the first practical implementation of the Gutenberg architecture, WordPress is simply the first practical integration of the block editor into a CMS. The Gutenberg project will expand into site customisation and theming next, and while there&#8217;s no requirement that Drupal make use of these, I&#8217;d be very interested to see what they came up with if they did. Bringing together our many years of experience in tackling these complex problems can only make the end result better.</p>\n\n<p>I know I&#8217;m looking forward to all of us working together for the betterment of the open web.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Sun, 16 Sep 2018 04:48:44 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:4:\"Gary\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:12;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:55:\"WPTavern: Gutenberg 3.8 Released, Adds Full Screen Mode\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83861\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:65:\"https://wptavern.com/gutenberg-3-8-released-adds-full-screen-mode\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:2254:\"<p>Gutenberg 3.8 is <a href=\"https://wordpress.org/plugins/gutenberg/\">available for download</a>. This release features a full screen mode that hides both the admin bar and the menu. Unlike previous versions of Distraction-Free-Writing mode where things would fade in and out of view, these two items stay hidden until full-screen mode is disabled.</p>\n\n<p>User Interface elements have been added to manage reusable blocks in bulk. Theme authors are now able to <a href=\"https://github.com/WordPress/gutenberg/pull/9008\">register editor styles</a> for blocks by targeting the blocks themselves. This avoids combating CSS specificity and doesn&#8217;t require knowledge of the internal DOM structure for the editor. </p>\n\n<p>The block settings icon has been moved from the right side of blocks to the toolbar. This change sets the foundation for refactoring the toolbar and it reduces clutter by keeping the icons together.<br /></p>\n\n<img />Block Settings Moved to The Right Side of The Toolbar\n\n<p>Gutenberg 3.8 also contains a significant increase in performance thanks to a new <a href=\"https://github.com/WordPress/gutenberg/pull/8083\">hand-coded default</a> block parser. </p>\n\n<blockquote class=\"wp-block-quote\"><p>Having a formal specification of the Gutenberg block grammar has allowed us both to maintain a stable core during the almost 40 releases of the plugin and lately to allow competing parser implementation to evolve and be compared in terms of performance and correctness. </p><p>In concrete terms, we are shipping <a href=\"https://github.com/WordPress/gutenberg/pull/8083\">a new default implementation</a> that is hundreds of times faster than the spec and has been stress tested with really long posts (including Moby Dick). These tests are also available for anyone to run against. Memory consumption has also gone down dramatically for server side operations. I’d like to specially thank Dennis Snell and Ivan Enderlin for their great work improving this area.</p><cite>Matias Ventura </cite></blockquote>\n\n<p>To see a complete list of changes along with links to their corresponding pull requests, check out <a href=\"https://make.wordpress.org/core/2018/09/12/whats-new-in-gutenberg-12th-september/\">the release post.</a> </p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Sat, 15 Sep 2018 00:08:32 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Jeff Chandler\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:13;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:64:\"WPTavern: Gutenberg is Slowly Rolling Out to WordPress.com Users\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83331\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:75:\"https://wptavern.com/gutenberg-is-slowly-rolling-out-to-wordpress-com-users\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:1483:\"<p>As part of <a href=\"https://wptavern.com/matt-mullenweg-unveils-gutenberg-roadmap-at-wceu-wordpress-agencies-and-product-developers-sprint-to-prepare\">the roadmap</a> unveiled at WordCamp EU earlier this year, WordPress.com has started rolling out Gutenberg to a subset of users. </p>\n\n<div class=\"wp-block-image\"><img />Try Gutenberg Call-out on WordPress.com</div>\n\n<p>According to a <a href=\"https://en.forums.wordpress.com/topic/information-on-gutenberg-implementation/#post-3173840\">WordPress.com Happiness Engineer</a>, the team is testing the implementation to determine the best way and time to enable it. Users will not be able to use Gutenberg unless their theme is updated to support blocks and the various alignment options. </p>\n\n<p>Theme Wranglers are already in the process of adding support to WordPress.com&#8217;s nearly 100 free themes.</p>\n\n<p>A <a href=\"https://en.forums.wordpress.com/search/gutenberg/\">quick search</a> of the WordPress.com support forums for Gutenberg provides some insight into what users think about the new editor. For example, <a href=\"https://en.forums.wordpress.com/topic/new-gutenberg-editing/\">this user provided feedback</a> on the use of so many icons without displaying their textual equivalent. </p>\n\n<p>For now, Gutenberg is opt-in but eventually will be opt-out. Once Gutenberg is made available to a wider audience, support documents and official blog posts will be published to inform users about the new editor. <br /></p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Fri, 14 Sep 2018 23:24:52 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Jeff Chandler\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:14;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:83:\"WPTavern: Drupal Gutenberg Project Receives Enthusiastic Reception at Drupal Europe\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83854\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:94:\"https://wptavern.com/drupal-gutenberg-project-receives-enthusiastic-reception-at-drupal-europe\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:6188:\"<p><a href=\"https://i0.wp.com/wptavern.com/wp-content/uploads/2018/09/Screen-Shot-2018-09-14-at-2.59.59-PM.png?ssl=1\"><img /></a></p>\n<p>The <a href=\"https://wptavern.com/first-look-at-live-demo-of-the-gutenberg-content-editor-for-drupal-8\" rel=\"noopener noreferrer\" target=\"_blank\">Drupal Gutenberg</a> project is gaining momentum after Per André Rønsen and Marco Fernandes gave a presentation at Drupal Europe this week titled &#8220;Introducing the Gutenberg content editor for Drupal 8.&#8221; Rønsen and Fernandes are representatives of Frontkom, a digital services agency based in Norway that has ported WordPress&#8217; Gutenberg editor over to Drupal for use with client projects. They also created the <a href=\"https://drupalgutenberg.org/\" rel=\"noopener noreferrer\" target=\"_blank\">Drupal Gutenberg</a> project, which aims to bring this new publishing experience to Drupal core.</p>\n<blockquote class=\"twitter-tweet\">\n<p lang=\"en\" dir=\"ltr\">Building landing pages in <a href=\"https://twitter.com/hashtag/Drupal?src=hash&ref_src=twsrc%5Etfw\">#Drupal</a> has never been easier. Coming soon to a Drupal site near you! <a href=\"https://twitter.com/hashtag/drupaleurope?src=hash&ref_src=twsrc%5Etfw\">#drupaleurope</a> <a href=\"https://t.co/LLpH91AY9n\">pic.twitter.com/LLpH91AY9n</a></p>\n<p>&mdash; drupalgutenberg (@drupalgutenberg) <a href=\"https://twitter.com/drupalgutenberg/status/1040203765452820480?ref_src=twsrc%5Etfw\">September 13, 2018</a></p></blockquote>\n<p></p>\n<p>The Frontkom team gave a live demo of the Gutenberg module added to the page content type and showed how a few of the core blocks work. They concluded the presentation by hailing Gutenberg as an exciting new tool that will bring companies new business, make happier clients, and inspire more code reuse and sharing among developers.</p>\n<p>&#8220;The reception has been amazing,&#8221; Rønsen said. &#8220;A lot of different speakers have referred to Gutenberg both before and after the session. Bigger organizations and companies have expressed interest in implementation and contributing. I was told the session was one of the most well visited (after the keynotes) in the whole conference.&#8221;</p>\n<blockquote class=\"twitter-tweet\">\n<p lang=\"en\" dir=\"ltr\">Gutenberg for Drupal looks good <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f4a5.png\" alt=\"💥\" class=\"wp-smiley\" /><img src=\"https://s.w.org/images/core/emoji/11/72x72/1f4a5.png\" alt=\"💥\" class=\"wp-smiley\" /> GoGo <a href=\"https://twitter.com/frontkom?ref_src=twsrc%5Etfw\">@frontkom</a> <a href=\"https://twitter.com/hashtag/DrupalEurope?src=hash&ref_src=twsrc%5Etfw\">#DrupalEurope</a> <a href=\"https://t.co/rV6dRT76Rk\">pic.twitter.com/rV6dRT76Rk</a></p>\n<p>&mdash; Daniel Andersson (@moppedanne) <a href=\"https://twitter.com/moppedanne/status/1039852251173543936?ref_src=twsrc%5Etfw\">September 12, 2018</a></p></blockquote>\n<p></p>\n<p>Overall, the Drupal community gave the Gutenberg editor a positive reception. However, Rønsen said he received feedback from some who are concerned about how it stores data. He said the general consensus was that &#8220;the UI is awesome,&#8221; but that the Drupal Gutenberg project would need to make sure data is stored in way that is as structured and portable as possible.</p>\n<p>&#8220;Some developers are skeptical about storing too much data unstructured like Gutenberg does,&#8221; Rønsen said. &#8220;This also means we might integrate Gutenberg closer to some key Drupal modules used for structured page building today. Gutenberg can serve as a UI for embedding existing structured content, and that is something we are looking into.&#8221;</p>\n<p>Rønsen said the next steps are centered around getting a stable release that will handle the core Gutenberg blocks and the core D8 blocks in a way that is future proof. In order to do this, they are waiting for the project to be merged into WordPress core.</p>\n<p>&#8220;We will delay a stable release until Gutenberg is in WP core,&#8221; Rønsen said. &#8220;Things are moving very fast still with Gutenberg – and that’s a good thing. As soon as we have a stable release, we will introduce tools we have built in top of Gutenberg for publishers. These will be available to WordPress, too.&#8221;</p>\n<h3>Gutenberg as the “editor for the open web” — not just for WordPress</h3>\n<p>One of the most exciting aspects of the Frontkom team&#8217;s presentation was the idea of sharing a project across publishing platforms.</p>\n<p>&#8220;It is key for us that Gutenberg stays decoupled from both CMSs as a library, and our hope is that Gutenberg core devs will catch onto the vision of Gutenberg as the &#8216;editor for the open web&#8217; — not just for WordPress,&#8221; Rønsen said.</p>\n<p>&#8220;Drupal core developers are however planning a React-based revamp of the Drupal admin UI, too. It will take at least two years to release it, and even then, I’m of the opinion that the content edit UI and page building features should be done last, and rather leave room for third party solutions like Gutenberg. This is an open question, but at least the key decisions makers for the new UI will consider how Gutenberg works and learn from it.&#8221;</p>\n<p>Drupal decision makers are also taking interest in Gutenberg and seem open to considering it as viable option for improving the CMS&#8217;s editing experience.</p>\n<p>&#8220;When the Drupal project owner was asked directly in a Q&amp;A what he thought about solutions like Gutenberg coming into Drupal, he said he liked it, and that it’s a good thing for Drupal,&#8221; Rønsen said. &#8220;Dries is very open minded and not afraid of the concept of &#8216;Proudly built elsewhere.\'&#8221;</p>\n<p>Rønsen and Fernandes have <a href=\"https://docs.google.com/presentation/d/1Rm1tiXR9sAVqasT8L8SZCg1LBVuTTuG3otNj_3Sj2r8/edit#slide=id.g321e3b1fbe_0_57\" rel=\"noopener noreferrer\" target=\"_blank\">published the slides</a> for those who want to view them, although most of the session was devoted to the live demo. The official recording has not yet been posted but should be available shortly.</p>\n<p>Update: The official recording has been published:</p>\n<p></p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Fri, 14 Sep 2018 22:31:50 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:15;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:48:\"BuddyPress: BuddyPress 3.2.0 Maintenance Release\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:32:\"https://buddypress.org/?p=276415\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:68:\"https://buddypress.org/2018/09/buddypress-3-2-0-maintenance-release/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:463:\"<p>BuddyPress 3.2.0 is now available. This is a maintenance release that fixes 25 bugs and is a recommended upgrade for all BuddyPress installations.</p>\n<p>Update to BuddyPress 3.2.0 today in your WordPress Dashboard, or by <a href=\"https://wordpress.org/plugins/buddypress/\">downloading from the wordpress.org plugin repository</a>. For details on the changes, read the <a href=\"https://codex.buddypress.org/releases/version-3-2-0/\">3.2.0 release notes</a>.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Fri, 14 Sep 2018 15:14:20 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:10:\"Paul Gibbs\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:16;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:66:\"WPTavern: WPWeekly Episode 330 – WPShout, Community, and Burnout\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:58:\"https://wptavern.com?p=83932&preview=true&preview_id=83932\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:71:\"https://wptavern.com/wpweekly-episode-330-wpshout-community-and-burnout\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:2001:\"<p>In this episode, <a href=\"http://jjj.me\">John James Jacoby</a> and I are joined by Fred Meyer, David Hayes, and Alex Denning of <a href=\"https://wpshout.com/\">WPShout</a> to learn about <a href=\"https://wpshout.com/announcing-pro-community/\">WPShout&#8217;s Pro Community</a>. This community aims to bring people together to learn from each other and provide one-to-one mentorship opportunities with David and Fred.</p>\n<p>Later in the show, John and I discuss why it&#8217;s a matter of when and not if, Dark Mode will be added to WordPress. We round out the show by discussing burnout and some other personal things.</p>\n<h2>Stories Discussed:</h2>\n<p><a href=\"https://wptavern.com/dark-mode-is-possibly-coming-to-a-wordpress-dashboard-near-you\">Dark Mode is Possibly Coming to a WordPress Dashboard Near You</a></p>\n<p><a href=\"https://wptavern.com/wordpress-coding-standards-1-1-0-released\">WordPress Coding Standards 1.1.0 Released</a></p>\n<p><a href=\"https://wptavern.com/meetup-group-organizers-can-now-earn-a-wordpress-org-user-profile-badge\">Meetup Group Organizers Can Now Earn A WordPress.org User Profile Badge</a></p>\n<p><a href=\"https://wptavern.com/marcel-bootsman-is-walking-700km-to-wordcamp-europe-to-raise-funds-for-donatewc\">Marcel Bootsman is Walking 700km to WordCamp Europe to Raise Funds for DonateWC</a></p>\n<h2>WPWeekly Meta:</h2>\n<p><strong>Next Episode:</strong> Wednesday, September 26th 3:00 P.M. Eastern</p>\n<p>Subscribe to <a href=\"https://itunes.apple.com/us/podcast/wordpress-weekly/id694849738\">WordPress Weekly via Itunes</a></p>\n<p>Subscribe to <a href=\"https://www.wptavern.com/feed/podcast\">WordPress Weekly via RSS</a></p>\n<p>Subscribe to <a href=\"http://www.stitcher.com/podcast/wordpress-weekly-podcast?refid=stpr\">WordPress Weekly via Stitcher Radio</a></p>\n<p>Subscribe to <a href=\"https://play.google.com/music/listen?u=0#/ps/Ir3keivkvwwh24xy7qiymurwpbe\">WordPress Weekly via Google Play</a></p>\n<p><strong>Listen To Episode #330:</strong><br />\n</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Thu, 13 Sep 2018 22:24:36 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Jeff Chandler\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:17;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:99:\"WPTavern: WordPress 4.9.9 Release Focus Items Include Site Health Project and Gutenberg Preparation\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83892\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:110:\"https://wptavern.com/wordpress-4-9-9-release-focus-items-include-site-health-project-and-gutenberg-preparation\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:2819:\"<p>The WordPress 4.9.9 release leads published a <a href=\"https://make.wordpress.org/core/2018/09/12/wordpress-4-9-9-minor-release-roadmap/\" rel=\"noopener noreferrer\" target=\"_blank\">roadmap for the release</a> this week. The minor release will be led by Anthony Burchell and Alain Schlesser. It is targeted for November 5 with the first beta arriving near the end of October.</p>\n<p>The leads identified four key focus areas for the upcoming release: accessibility, internationalization, the Site Health Project, and Gutenberg preparation. The internationalization focus is aimed at improving translations and RTL support, as well as ensuring that date/time values work. The roadmap doesn&#8217;t identify any specific accessibility items but Burchell said the leads see lots of ways they can &#8220;drastically improve the experience for a lot of people with minimal effort.&#8221;</p>\n<p>Contributors to the Site Health Project, previously known by the &#8220;Servehappy&#8221; code name, will be working on resolving issues that will allow users to stay on WordPress 4.9.9 while they prepare for 5.0 and still have access to the important information about how to update their PHP versions.</p>\n<p>&#8220;It will be crucial to get the Servehappy components included: WSOD protection, update dashboard notice, plugin version requirements,&#8221; Burchell said. &#8220;The reason for this focus is because, when 5.0 ships, users who decide not to upgrade will be on 4.9.9 for a potentially extended time period. If we don’t have these Servehappy components included in 4.9.9, getting rid of old PHP versions will only happen after 5.0.&#8221;</p>\n<p>Another major part of WordPress 4.9.9 will be landing items that lay the groundwork for anything necessary for Gutenberg&#8217;s merge into 5.0. Two items identified include <a href=\"https://core.trac.wordpress.org/ticket/44758\" rel=\"noopener noreferrer\" target=\"_blank\">user locale support in REST API endpoints</a> and <a href=\"https://core.trac.wordpress.org/ticket/44862\" rel=\"noopener noreferrer\" target=\"_blank\">endpoints to lock/unlock and release posts</a>.</p>\n<p>With an unusually quick turnaround, WordPress 5.0 could arrive before the end of 2018. Development will kick off in mid-November, one week ahead of the U.S. Thanksgiving holiday.</p>\n<p><strong>UPDATE 9/13/2018 &#8211; 8:13PM:</strong> The wording on the roadmap document has been updated to more accurately reflect the intentions of contributors regarding the work outlined for the Site Health Project. The roadmap now reads:</p>\n<p><em>&#8220;We will investigate the work remaining for the Servehappy project and determine how to get it in people’s hands as soon as possible. WSOD protection, update dashboard notice, plugin version requirements are the hot items pending.&#8221;</em></p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Thu, 13 Sep 2018 17:58:37 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:18;a:6:{s:4:\"data\";s:11:\"\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:1:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"HeroPress: Diversity of Thought\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://heropress.com/?p=2623\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:107:\"https://heropress.com/diversity-of-thought/#utm_source=rss&utm_medium=rss&utm_campaign=diversity-of-thought\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:3237:\"<img width=\"960\" height=\"480\" src=\"https://s20094.pcdn.co/wp-content/uploads/2018/09/092017-1024x512.jpg\" class=\"attachment-large size-large wp-post-image\" alt=\"Pull Quote: I became completely inspired by the mission of WordPress. I had become a part of something bigger than myself.\" /><p>About a year ago, Christie Chirinos wrote the essay &#8220;<a href=\"https://heropress.com/essays/what-i-do-does-not-define-who-i-am/\">What I Do Does Not Define Who I Am</a>&#8220;. It felt like a big deal at the time, and it was, but like most big deals, it slowly faded from memory. That&#8217;s one of the reasons I do these replays, for the benefit of my own memory as much as anything else.</p>\n<p>As I&#8217;ve mentioned, part of the goal of HeroPress is to speak to those with less privilege and show how WordPress can help overcome that. That message shouldn&#8217;t come from me, a white American male. I simply don&#8217;t have the experience. I can read about it, but I&#8217;ll never actually have the experiences.</p>\n<p>The story really needs to come from someone with experience. Christie has some of that experience, and she does a wonderful job talking about how WordPress helped a little bit. I hope her story helps.</p>\n<blockquote class=\"wp-embedded-content\"><p><a href=\"https://heropress.com/essays/what-i-do-does-not-define-who-i-am/\">What I Do Does Not Define Who I Am</a></p></blockquote>\n<p></p>\n<div class=\"rtsocial-container rtsocial-container-align-right rtsocial-horizontal\"><div class=\"rtsocial-twitter-horizontal\"><div class=\"rtsocial-twitter-horizontal-button\"><a title=\"Tweet: Diversity of Thought\" class=\"rtsocial-twitter-button\" href=\"https://twitter.com/share?text=Diversity%20of%20Thought&via=heropress&url=https%3A%2F%2Fheropress.com%2Fdiversity-of-thought%2F\" rel=\"nofollow\" target=\"_blank\"></a></div></div><div class=\"rtsocial-fb-horizontal fb-light\"><div class=\"rtsocial-fb-horizontal-button\"><a title=\"Like: Diversity of Thought\" class=\"rtsocial-fb-button rtsocial-fb-like-light\" href=\"https://www.facebook.com/sharer.php?u=https%3A%2F%2Fheropress.com%2Fdiversity-of-thought%2F\" rel=\"nofollow\" target=\"_blank\"></a></div></div><div class=\"rtsocial-linkedin-horizontal\"><div class=\"rtsocial-linkedin-horizontal-button\"><a class=\"rtsocial-linkedin-button\" href=\"https://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fheropress.com%2Fdiversity-of-thought%2F&title=Diversity+of+Thought\" rel=\"nofollow\" target=\"_blank\" title=\"Share: Diversity of Thought\"></a></div></div><div class=\"rtsocial-pinterest-horizontal\"><div class=\"rtsocial-pinterest-horizontal-button\"><a class=\"rtsocial-pinterest-button\" href=\"https://pinterest.com/pin/create/button/?url=https://heropress.com/diversity-of-thought/&media=https://heropress.com/wp-content/uploads/2018/09/092017-150x150.jpg&description=Diversity of Thought\" rel=\"nofollow\" target=\"_blank\" title=\"Pin: Diversity of Thought\"></a></div></div><a rel=\"nofollow\" class=\"perma-link\" href=\"https://heropress.com/diversity-of-thought/\" title=\"Diversity of Thought\"></a></div><p>The post <a rel=\"nofollow\" href=\"https://heropress.com/diversity-of-thought/\">Diversity of Thought</a> appeared first on <a rel=\"nofollow\" href=\"https://heropress.com\">HeroPress</a>.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Thu, 13 Sep 2018 16:21:38 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:19;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:54:\"WPTavern: Official WooCommerce Android App Now in Beta\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83859\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:65:\"https://wptavern.com/official-woocommerce-android-app-now-in-beta\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:3827:\"<p>The first official <a href=\"https://woocommerce.com/mobile/\" rel=\"noopener noreferrer\" target=\"_blank\">WooCommerce Android app</a> is now in open beta. The companion mobile app allows users to manage their WooCommerce stores on the go. Store owners who want to test the unreleased version of the mobile app can <a href=\"https://play.google.com/apps/testing/com.woocommerce.android\" rel=\"noopener noreferrer\" target=\"_blank\">sign up with the Google Play Store</a>. The WooCommerce app <a href=\"https://woocommercehalo.wordpress.com/faq/\" rel=\"noopener noreferrer\" target=\"_blank\">requires Jetpack</a> to connect stores to the app.</p>\n<p><a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/09/Manage-Orders@2x.jpg?ssl=1\"><img /></a></p>\n<p>The beta introduces a basic set of features for managing orders, viewing store stats, and receiving sales notifications, including the following:</p>\n<ul>\n<li>Check basic orders and revenue statistics with time period selection.</li>\n<li>View orders list in chronological order, with status and total value.</li>\n<li>Review individual orders with all the standard details, and contact customers.</li>\n<li>Perform basic order fulfillment.</li>\n<li>Get notifications about orders and reviews, and the ability to moderate them.</li>\n<li>View a list of the top-selling products on your store.</li>\n</ul>\n<p>The app&#8217;s real-time order alerts even include an optional &#8220;cha-ching&#8221; sounds for new orders.</p>\n<p><a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/09/Push-Notifications@2x.jpg?ssl=1\"><img /></a></p>\n<p>Over the past few years, the WooCommerce community has demonstrated a demand for mobile apps on both platforms. A <a href=\"http://ideas.woocommerce.com/forums/133476-woocommerce/suggestions/6172593-android-equivalent-of-woocommerce-ios-app\" rel=\"noopener noreferrer\" target=\"_blank\">suggestion for an Android app</a> received 533 upvotes on the WooCommerce ideas board. There is also a motley assortment of unofficial WooCommerce store management apps available on the Google Play Store. Some of the more popular ones include <a href=\"https://play.google.com/store/apps/details?id=com.woostore.wooforce\" rel=\"noopener noreferrer\" target=\"_blank\">StorePep WooCommerce App</a>, <a href=\"https://play.google.com/store/apps/details?id=com.pinta.woocommerce.woocommercemobileadmin\" rel=\"noopener noreferrer\" target=\"_blank\">WooCommerce Mobile Admin</a>, <a href=\"https://play.google.com/store/apps/details?id=com.mstoreapp.wooadmin03\" rel=\"noopener noreferrer\" target=\"_blank\">Admin app for WooCommerce</a>, and <a href=\"https://play.google.com/store/apps/details?id=com.lxrmarketplace.woocommerce\" rel=\"noopener noreferrer\" target=\"_blank\">Dashly &#8211; WooCommerce Dashboard</a>.</p>\n<p>None of the third-party mobile apps seem to be very highly rated, nor are they consistent with the WooCommerce branding. A cursory glance at the reviews for these apps shows that most of them are slow, buggy, and not very well supported. However, they have temporarily fulfilled a need in the absence of an official app from WooCommerce.</p>\n<p>Considering the options currently available, an official WooCommerce app will be a welcome addition to the tools available for store owners. An iOS app is also in the works. At the end of July, the WooCommerce development team put out a <a href=\"https://woocommercehalo.wordpress.com/2018/07/31/call-for-testing-first-ios-beta/\" rel=\"noopener noreferrer\" target=\"_blank\">call for testing the first iOS Beta</a>. Anyone interested to test the apps can check out the <a href=\"https://woocommercehalo.wordpress.com\" rel=\"noopener noreferrer\" target=\"_blank\">Woo Halo</a> site and <a href=\"http://eepurl.com/dv-oo1\" rel=\"noopener noreferrer\" target=\"_blank\">register</a> to be part of the testing group.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Thu, 13 Sep 2018 16:19:55 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:20;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:37:\"Post Status: WordPress and Blockchain\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"https://poststatus.com/?p=47409\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:48:\"https://poststatus.com/wordpress-and-blockchain/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:5235:\"<p>WordPress is one of the driving forces and great success stories of the open web to date. As an open source platform, it&#8217;s become a dominant CMS used by 30% of the web to publish content — on websites large and small.</p>\n<p>WordPress has grown up in an era of evolving challenges: ushering in web standards, adapting for publishing and viewing on all device sizes; building for accessibility by all; establishing its place in the era of expansive and centralized social media platforms; and more.</p>\n<p>Today, we’re faced with a new generation of technologies coming down the pipe, ready to disrupt the current ecosystem. These technologies include blockchain, artificial intelligence, augmented reality, the internet of things, and more I&#8217;m sure. It’s the first of these that is the focus of this post and the following conversation.</p>\n<p>I was approached by David Lockie of <a href=\"https://pragmatic.agency/\">Pragmatic</a> to discuss how WordPress and blockchain technology may fit together, and how they may not. David and I have both been interested in the cryptocurrency and blockchain space over the past couple of years, and have over time encountered a lot of projects that aim to disrupt or enhance various elements of the web: from DNS to CMS.</p>\n<p>David gathered a group of people for an initial online, open, honest conversation about how WordPress could be impacted, disrupted or take advantage of distributed ledger and blockchain technologies.</p>\n<p>Examples include:</p>\n<ul>\n<li>Blockchain platforms impacting people’s choice to use WordPress e.g. <a href=\"https://steemit.com/\">Steemit</a></li>\n<li>Blockchain projects impacting people already using WordPress e.g. <a href=\"https://www.basicattentiontoken.org/\">Basic Attention Token</a> or <a href=\"https://www.po.et/\">Po.et</a>, <a href=\"https://vip.wordpress.com/2018/07/11/client-spotlight-civil/\">Civil</a></li>\n<li>Cryptocurrencies’ impact on eCommerce and the wider ecosystem, e.g. the Coinbase Commerce merchant gateway</li>\n<li>What we can learn from blockchain projects’ governance systems and lessons learned</li>\n<li>Ideas for improving security, integrations, etc</li>\n<li>Various identity-based projects</li>\n<li>New environments which may be used to run WordPress, such as decentralized web technologies e.g. <a href=\"https://substratum.net/\">Substratum </a> or <a href=\"https://www.maidsafe.net/\">MaidSafe</a>.</li>\n<li>Impact on the talent pool for WordPress professionals</li>\n<li>General <a href=\"https://speakerdeck.com/dcent/wordpress-and-blockchain-threats-and-opportunities\">threats and opportunities</a></li>\n<li>Discussion of anything new, interesting and relevant in the blockchain/cryptocurrency space</li>\n<li>All of the above as it relates to open source and the web generally, outside of WordPress</li>\n</ul>\n<p>Our aim for the initial conversation, as well as future conversations, <strong>is not</strong> to advocate specifically for any existing project or to necessarily endorse blockchain as appropriate for WordPress to somehow integrate in any way. It&#8217;s to explore what&#8217;s out there now, how it could impact WordPress today and in the future, and down the road perhaps how WordPress may take advantage of potential opportunities. We are approaching this like a discovery phase — not to get overly excited, but to be informed. And we welcome participants in this conversation.</p>\n<p>This first conversation included the following participants:</p>\n<ul>\n<li>David Lockie, <a href=\"https://pragmatic.agency/\">Pragmatic</a></li>\n<li>Brian Krogsgard, Post Status</li>\n<li>Bradford Campeau-Laurion, <a href=\"https://alley.co/\">Alley Interactive</a></li>\n<li>Zac Gordon, <a href=\"https://zacgordon.com/\">Deeply</a></li>\n<li>Christie Chirinos, <a href=\"https://calderalabs.org/\">Caldera Labs</a></li>\n<li>Josh Pollock, <a href=\"https://calderalabs.org/\">Caldera Labs</a></li>\n<li>Brad Williams, <a href=\"https://webdevstudios.com/\">WebDevStudios</a></li>\n</ul>\n<p>I attempted to reiterate it in the call, but I believe it&#8217;s important to address this topic with a skeptic&#8217;s hat on. By no means do any of us think that it&#8217;s a great idea to just go head first in trying to integrate blockchain technology to WordPress. The jury is still very much out in terms of where, how, and even if blockchain brings significant advantages to web applications.</p>\n<p></p>\n<p>If you are interested in future discussions, we welcome you! There is currently a channel (#blockchain) in Post Status Slack where people can discuss, and we&#8217;ll also announce future video-conference discussions. We may make a more independent place to discuss, blog, etc, in the future depending on how these early conversations go.</p>\n<p>We don&#8217;t know exactly where this conversation will go. It may fizzle out, or it could evolve into a much broader community effort. The first thing to do, if you are interested to continue this conversation, is just follow along with future conversations, which will be posted here. If you would like to be on the next video call, please <a href=\"https://pragmatic.agency/contact/\">contact David</a> or <a href=\"https://poststatus.com/contact\">me</a>.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Wed, 12 Sep 2018 22:58:40 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:15:\"Brian Krogsgard\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:21;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:65:\"WPTavern: WordCamp Wilmington Cancelled Due to Hurricane Florence\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83851\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:76:\"https://wptavern.com/wordcamp-wilmington-cancelled-due-to-hurricane-florence\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:2572:\"<p>Hurricane Florence <a href=\"https://www.nhc.noaa.gov/graphics_at1.shtml?cone#contents\">is forecast</a> to make landfall as a major hurricane near Wilmington, North Carolina bringing potentially catastrophic flooding and strong winds to the region. </p>\n\n<img />Hurricane Florence Forecast Track From the National Hurricane Center\n\n<p>Because of the hurricane, <a href=\"https://2018.wilmington.wordcamp.org\">WordCamp Wilmington</a> which was scheduled to take place September 22nd and 23rd <a href=\"https://2018.wilmington.wordcamp.org/2018/09/11/canceled-2018-wordcamp-wilmington/\">has been cancelled</a>. </p>\n\n<p>&#8220;We wish all of our WordCamp Wilmington enthusiasts a minimum of impact from Hurricane Florence,&#8221; Helen Rittersporn, one of the event&#8217;s organizers said. <br /></p>\n\n<p>&#8220;On behalf of my fellow Organizers for 2018 WordCamp Wilmington, we are looking forward to seeing everyone in 2019!&#8221;</p>\n\n<h2>Safety of Attendees, Speakers, and Sponsors Takes Priority<br /></h2>\n\n<p>Peter La Fond, one of the event&#8217;s lead organizers, says the decision to cancel the event has been mentally taxing to him and the team.</p>\n\n<p>&#8220;From the beginning, the decision making was really hard,&#8221; he said. &#8220;How we made the decision about this was very fluid. The entire team has been texting back and forth every several hours on various decisions over many days.</p>\n\n<p>&#8220;We ended up having to set thresholds in advance for canceling.  Then on Monday morning, we started to get inquiries and cancellations of attendees, vendors and speakers so we had to make a call.&#8221; </p>\n\n<p>Although a lot hours were spent by volunteers to organize the event, speaker, attendee, and sponsor safety took priority. <br /></p>\n\n<p>&#8220;The organizing team is totally bummed about canceling the event considering the amount of effort we put into organizing it,&#8221; La Fond said. &#8220;However, we’re more concerned about the safety and security of our family and friends. Especially those who chose to stay.&#8221;</p>\n\n<p>Those who purchased tickets are eligible for a refund. But due to evacuations and the length of time the storm is expected wreak havoc in the area, organizers will not be able to fulfill refund requests until after the storm has passed. <br /></p>\n\n<p>This is the second time a tropical weather system has postponed or cancelled a WordCamp in the US. In 2016, <a href=\"https://wptavern.com/wordcamp-orlando-cancelled-due-to-hurricane\">WordCamp Orlando was postponed</a> due to Hurricane Matthew. </p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Wed, 12 Sep 2018 22:05:22 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Jeff Chandler\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:22;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:70:\"WPTavern: MetaSlider Plugin Adds Gutenberg Block for Inserting Sliders\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83865\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:81:\"https://wptavern.com/metaslider-plugin-adds-gutenberg-block-for-inserting-sliders\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:4203:\"<p>If you <a href=\"https://wordpress.org/plugins/search/slider/\" rel=\"noopener noreferrer\" target=\"_blank\">search for &#8220;slider&#8221;</a> in the WordPress plugins directory, <a href=\"https://wordpress.org/plugins/ml-slider/\" rel=\"noopener noreferrer\" target=\"_blank\">MetaSlider</a> is the first result that comes up. The plugin, created by the team at <a href=\"https://updraftplus.com\" rel=\"noopener noreferrer\" target=\"_blank\">UpdraftPlus</a>, is active on more than 900,000 sites, more than any other free slider plugin, and averages a 4.7-star review. It includes four different types of sliders: Flex 2, Nivo Slider, Responsive Slides, and Coin Slider.</p>\n<p>An update released today introduces Gutenberg support with a block for inserting sliders. Users can access their sliders via the block insertion tool.</p>\n<p><a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/09/metaslider-gutenberg-block.png?ssl=1\"><img /></a></p>\n<p>Clicking on the MetaSlider block allows users to select from among the sliders that they have already created in the admin.</p>\n<p><a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/09/Screen-Shot-2018-09-12-at-12.46.10-PM.png?ssl=1\"><img /></a></p>\n<p>After the user selects a slider, a preview will appear instantly in the Gutenberg editor.</p>\n<p><a href=\"https://i0.wp.com/wptavern.com/wp-content/uploads/2018/09/metaslider-in-gutenberg.jpg?ssl=1\"><img /></a></p>\n<p>Previously, the process of inserting a slider into content involved copying and pasting a shortcode. Joe Miles, director of Business Strategy at UpdraftPlus, said the team sees the Gutenberg editor as a major improvement especially for those who are new to WordPress.</p>\n<p>&#8220;I think Gutenberg makes it much easier for novices to web design to make changes and insert sliders,&#8221; Miles said. &#8220;I know people who&#8217;d be comfortable using a Gutenberg block but not comfortable using a shortcode as it looks scary.&#8221;</p>\n<p>Miles said the company is currently working on adding the ability for users to create and edit sliders within Gutenberg and hope to include it in the plugin before WordPress 5.0 lands. The UpdraftPlus team includes 13 developers who are devoted to the company&#8217;s WP-Optimize and MetaSlider products. Miles said adapting to Gutenberg was fairly simple relative to some of the other projects the team is working on.</p>\n<p>UpdraftPlus plans to continue to maintain and improve the shortcode-based slider insertion method, as demonstrated in the changelog. Users who opt to stick with the Classic Editor will still be able to keep their same workflow. Meanwhile, the product&#8217;s development team will be working on integrating all of the pro version&#8217;s front-end features with Gutenberg.</p>\n<p>In addition to Gutenberg support, the team is also going to be <a href=\"https://updraftplus.com/metasliders-bringing-out-new-slider-themes-and-theyre-completely-free/\" rel=\"noopener noreferrer\" target=\"_blank\">adding the concept of themes to sliders</a> so users can build a slider and change its theme in a couple of clicks. They plan to release free and commercial themes and all will be built to be compatible with Gutenberg.</p>\n<p><a href=\"https://wordpress.org/plugins/smart-slider-3/\" rel=\"noopener noreferrer\" target=\"_blank\">Smart Slider 3</a>, MetaSlider&#8217;s next closest competitor with 300,000 installs, is <a href=\"https://smartslider3.com/blog/gutenberg-and-smart-slider-3-how-to-add-sliders-to-wordpress/\" rel=\"noopener noreferrer\" target=\"_blank\">also compatible with Gutenberg</a> with a similar workflow for inserting sliders. Both slider plugins are not yet capable of providing the slider creation and editing process inside the Gutenberg interface but the capabilities should evolve as WordPress gets closer to the 5.0 release.</p>\n<p>&#8220;I personally love the idea of Gutenberg since Matt Mullenweg announced it at WordCamp EU 2017,&#8221; Miles said. &#8220;I understand why experienced developers don&#8217;t want the change, but too many people are going for inferior website solutions like WIX because they&#8217;re used to WYSIWYG. So adapting MetaSlider was a no-brainer.&#8221;</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Wed, 12 Sep 2018 20:59:26 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:23;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:89:\"WPTavern: Marcel Bootsman is Walking 700km to WordCamp Europe to Raise Funds for DonateWC\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83797\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:100:\"https://wptavern.com/marcel-bootsman-is-walking-700km-to-wordcamp-europe-to-raise-funds-for-donatewc\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:3272:\"<p><a href=\"https://i1.wp.com/wptavern.com/wp-content/uploads/2018/09/Screen-Shot-2018-09-11-at-3.37.12-PM.png?ssl=1\"><img /></a></p>\n<p>In May 2019, <a href=\"https://twitter.com/mbootsman\" rel=\"noopener noreferrer\" target=\"_blank\">Marcel Bootsman</a> will be lacing up a pair of hiking boots and walking 700km (435 miles) from his home in Rotterdam to WordCamp Europe in Berlin. Bootsman, a WordPress consultant and WordCamp organizer, is walking to raise funds and awareness for the <a href=\"https://donatewc.org/\" rel=\"noopener noreferrer\" target=\"_blank\">DonateWC</a> organization.</p>\n<p>The DonateWC initiative provides a global fund for helping people in need of financial assistance to attend a big WordCamp. Donations go towards individually-tailored sponsorships that help selected attendees purchase a WordCamp ticket, door-to-door transportation, food and drink, and internet access.</p>\n<p>&#8220;Imagine for a moment that you are not backed by a company that will pay for you to go to a community event,&#8221; DonateWC founder Ines van Essen said. &#8220;You work hard at being a valuable community member but are never able to actually meet the others in your team. This means you are less likely to get a job, less likely to get recognized as a worthwhile member, you’re unlikely to be at the front-end of changes that impact your work significantly.&#8221;</p>\n<p>DonateWC aims to keep the larger WordCamps from being unintentionally exclusive of those with lesser financial means. Bootsman said he believes in the organization because it is community-driven and enables the greater WordPress community to do something for their fellow community members.</p>\n<p>So far, Bootsman&#8217;s walking journey has raised €116.57. He set up a <a href=\"https://walktowc.eu\" rel=\"noopener noreferrer\" target=\"_blank\">walktowc.eu</a> website to track his progress and the <a href=\"https://walktowc.eu/donate/\" rel=\"noopener noreferrer\" target=\"_blank\">donation page</a> displays a live update of donated funds. Contributors have the option to designate their donations for DonateWC or for Bootsman&#8217;s personal needs on the trek. He plans to deliver all of the funds raised for the organization when he arrives in Berlin. In the coming weeks he will also open up sponsor packages to better motivate companies to donate.</p>\n<p>Bootsman does not plan to work during his trek. He will be on the road for approximately 30 days and plans to walk 30km per day. He is traveling light with just a backpack and is looking for places where he can sleep along the way. Bootsman will update the <a href=\"https://walktowc.eu/route/\" rel=\"noopener noreferrer\" target=\"_blank\">Route page</a> on his website with the places where people volunteer a bed for him to spend the night.</p>\n<p>If you want to keep track of his progress, follow the hashtag <a href=\"https://twitter.com/hashtag/walktowceu?src=hash\" rel=\"noopener noreferrer\" target=\"_blank\">#walktwceu</a> on Twitter. Bootsman has published his first vlog about his training sessions (see video below) where you can hear in his own words why his making the long journey on foot. When I asked him if he&#8217;ll be walking home after WordCamp Europe, he said, &#8220;You&#8217;re kidding, right?&#8221;</p>\n<p></p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 11 Sep 2018 22:25:00 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:24;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:26:\"Matt: WP Dev on Chromebook\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:22:\"https://ma.tt/?p=48342\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:43:\"https://ma.tt/2018/09/wp-dev-on-chromebook/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:256:\"<p>Dan Walmsley has an interesting <a href=\"https://developer.wordpress.com/2018/09/11/developing-wordpress-jetpack-and-calypso-on-chromeos/\">walkthrough on getting set up for WordPress and Calypso development on the new Linux mode on a Chromebook</a>.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 11 Sep 2018 18:29:48 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:4:\"Matt\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:25;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:48:\"WPTavern: Hemingway Theme Adds Gutenberg Support\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83790\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:59:\"https://wptavern.com/hemingway-theme-adds-gutenberg-support\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:4178:\"<p>Anders Norén has <a href=\"http://www.andersnoren.se/hemingway-meet-gutenberg/\" rel=\"noopener noreferrer\" target=\"_blank\">added Gutenberg support</a> to his popular <a href=\"https://wordpress.org/themes/hemingway/\" rel=\"noopener noreferrer\" target=\"_blank\">Hemingway</a> theme in the latest update, version 1.66. The theme has a simple, timeless design that appeals to both bloggers and business owners alike. It is active on more than 30,000 websites and some of those site administrators are using Gutenberg.</p>\n<p>What does Gutenberg support look like for Hemingway? Norén styled the editor to match the front-end design, with the same colors and fonts. He also added support for specific Gutenberg blocks, such as cover images, full-width elements, and pull quotes.</p>\n<a href=\"https://i0.wp.com/wptavern.com/wp-content/uploads/2018/09/hemingway-gutenberg-e1536683158337.jpg?ssl=1\"><img /></a>image credit: Anders Norén\n<p>Norén said he knew since Gutenberg was announced that he would need to add support to all 17 of his themes in a substantial update at some point but had put it off because developing for the new editor felt &#8220;like aiming for a moving target.&#8221;</p>\n<p>&#8220;I don’t think it was any single thing that made me realize that I needed to get going with Gutenberg, but rather that the Gutenberg volume knob in the community has been turned up at a steady pace,&#8221; Norén said. &#8220;After the &#8216;Try Gutenberg&#8217; prompt in 4.9.8, I also started to receive a lot more support requests regarding Gutenberg. When regular WordPress users – not developers – started to ask when they can expect Gutenberg support in my themes, I knew that I couldn’t push it ahead of me much further.&#8221;</p>\n<p>Hemingway is the first of his themes to support the new editor and Norén is aiming to have his entire collection Gutenberg-ready by the time WordPress 5.0 is released. (This does not include the <a href=\"https://wordpress.com/theme/hemingway-rewritten\" rel=\"noopener noreferrer\" target=\"_blank\">Hemingway Rewritten</a> version, which was created by Automattic and is available on WordPress.com.)</p>\n<p>Norén sees the new editor as a significant improvement over the current editor and said he thinks it is the right way forward for WordPress.</p>\n<p>&#8220;It’s always easy to speculate about the road not travelled, but the Visual Editor needs replacement, and Gutenberg will be a good replacement for it,&#8221; he said. &#8220;It’s better at everything the old editor can do (except editing raw HTML, perhaps), and it also brings with it new possibilities for WordPress developers and users. There are a lot of issues in Gutenberg still to be worked out, but when they are, I think Gutenberg will be a big step forward for the WordPress community.&#8221;</p>\n<p>Norén said his chief concern is not about the editor itself but about how WordPress will handle the transition period for users, especially for those who would benefit from continuing on with the Classic Editor.</p>\n<p>&#8220;I hope that the upgrade notice for 5.0 will be accompanied by clear messaging around the changes included in 5.0, along with the option to install the Classic Editor in Gutenberg&#8217;s stead,&#8221; Norén said. &#8220;Similar to the &#8216;Try Gutenberg&#8217; prompt, but presented more clearly as an either-or option before the user actually updates to 5.0. It was encouraging to see Matt Mullenweg say that the Classic Editor will be maintained for many years to come.&#8221;</p>\n<p>Norén&#8217;s 17 free WordPress.org-hosted themes have an estimated 100,000 active installs. Those using his products can be confident that the author behind the themes has Gutenberg-support among his immediate priorities for updates. Users who opt to move forward using the Classic Editor should not notice a difference in how the themes work.</p>\n<p>&#8220;I hope that Gutenberg is received with excitement and widespread support when 5.0 is finally released,&#8221; Noren said. &#8220;I also hope that the WordPress team does whatever it can to make sure that end-users don’t feel ambushed by the new editing experience.&#8221;</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 11 Sep 2018 18:04:17 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:26;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:81:\"WPTavern: Meetup Group Organizers Can Now Earn A WordPress.org User Profile Badge\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83806\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:92:\"https://wptavern.com/meetup-group-organizers-can-now-earn-a-wordpress-org-user-profile-badge\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:2241:\"<p>The WordPress Community team <a href=\"https://make.wordpress.org/community/2018/09/10/new-tool-for-community-deputies-meetup-tracker/\">has unveiled</a> a new tool called Meetup Tracker. This tool replaces the Meetup Status Document and will enable Global Community Team members to more easily track all Meetup.com groups.</p>\n\n<p>There&#8217;s also a <a href=\"https://central.wordcamp.org/meetup-organizer-application/\">new application form</a> available for organizers looking to join the <a href=\"https://make.wordpress.org/community/handbook/community-deputy/meetup-program-basics/\">WordPress Meetup Chapter Program</a>. Groups that are part of the program have their Meetup.com fees paid for by WordPress Community Support PBC.<br /></p>\n\n<p>Thanks to the new system that is hosted on the backend of <a href=\"https://central.wordcamp.org/\">WordCamp Central</a>, the community team is able to award badges to meetup organizers which will be displayed on their WordPress.org user profiles.</p>\n\n<div class=\"wp-block-image\"><img />Example of Contribution Badges Displayed on WordPress.org User Profiles</div>\n\n<p>In order to receive a badge and to fill the new system with updated information, organizers with meetups that are part of the chapter program are required to add the following information to this <a href=\"https://docs.google.com/spreadsheets/d/1LYnNDDpBQC7przZyufG4W5mdO67BcTTy_yz8eHY24lc/edit#gid=0\">Google Document</a>.</p>\n\n<ul><li> <strong>WordPress.org username for main contact</strong> <br /></li><li><strong>WordPress.org usernames of all organizers</strong> <br /></li><li><strong>Whether or not the contact’s WordPress.org email address is still valid</strong> <br /></li></ul>\n\n<p>Badges were added to WordPress.org <a href=\"https://wptavern.com/wordpress-org-profile-redesign-is-live\">user profiles as part of a redesign in 2014</a> and are a quick way to gauge a person&#8217;s activity and or interests across the WordPress project. </p>\n\n<p>The meetup organizer&#8217;s badge design has yet to be determined. For more information or if you have questions, please leave a comment on the <a href=\"https://make.wordpress.org/community/2018/09/10/calling-all-meetup-group-orgnisers/\">announcement post</a>. </p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 11 Sep 2018 02:52:41 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Jeff Chandler\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:27;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:51:\"WPTavern: WordPress Coding Standards 1.1.0 Released\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83804\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:62:\"https://wptavern.com/wordpress-coding-standards-1-1-0-released\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:688:\"<p>The WordPress Coding Standards version 1.1.0 has <a href=\"https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards/releases/tag/1.1.0\">been released</a> on GitHub. This release includes more stringent function call formatting checks which are <a href=\"https://make.wordpress.org/core/handbook/best-practices/coding-standards/php/#multiline-function-calls\">explained</a> in the handbook. There&#8217;s also stricter checks for overrides of WordPress global variables. </p>\n\n<p>To see a full list of what was changed, fixed, and added, check out the <a href=\"https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards/releases/tag/1.1.0\">changelog</a>. </p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 11 Sep 2018 01:16:34 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Jeff Chandler\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:28;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:36:\"Matt: Seth Godin on Customer Service\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:22:\"https://ma.tt/?p=48340\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:53:\"https://ma.tt/2018/09/seth-godin-on-customer-service/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:236:\"<p>This morning <a href=\"https://seths.blog/2015/03/what-is-customer-service-for/\">I&#8217;m enjoying Seth Godin&#8217;s classic on Customer Service</a>. <cite>Hat tip: <a href=\"https://andrewspittle.com/\">Andrew Spittle</a>.</cite></p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Mon, 10 Sep 2018 16:39:42 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:4:\"Matt\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:29;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:34:\"Matt: Responsibility of Technology\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:22:\"https://ma.tt/?p=48337\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:51:\"https://ma.tt/2018/09/responsibility-of-technology/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:834:\"<p>There&#8217;s <a href=\"https://www.buzzfeednews.com/article/daveyalba/facebook-philippines-dutertes-drug-war\">fascinating and terrifying feature article about Facebook, Duterte, and the drug war in the Philippines</a>, written <a href=\"https://twitter.com/daveyalba/status/1036917302061608960\">by Davey Alba</a>. My first trip there was actually to Davao, and having been to the country several times and met so many bloggers there it&#8217;s hard to imagine what&#8217;s described. There are definitely echoes of <a href=\"https://www.wired.com/story/how-facebooks-rise-fueled-chaos-and-confusion-in-myanmar/\">the Wired feature on Facebook and ethnic cleansing in Myanmar</a>. Both are good reminders that as technologists the tools we create can be used and leveraged in ways we wouldn&#8217;t imagine in our worst nightmares.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Sun, 09 Sep 2018 17:46:02 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:4:\"Matt\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:30;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:76:\"WPTavern: Biratnagar, Nepal to Host Its First WordCamp – December 22, 2018\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83719\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:81:\"https://wptavern.com/biratnagar-nepal-to-host-its-first-wordcamp-december-22-2018\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:2614:\"<p><a href=\"https://i0.wp.com/wptavern.com/wp-content/uploads/2018/09/wordcamp-biratnagar.png?ssl=1\"><img /></a></p>\n<p>Biratnagar, one of the oldest cities in Nepal, is gearing up to <a href=\"https://2018.biratnagar.wordcamp.org/\" rel=\"noopener noreferrer\" target=\"_blank\">host its first WordCamp</a> on December 22, 2018. The local community organized its first meetup in 2011 with 40 participants. Since that time the community has grown and recently hosted 250 members for <a href=\"http://wp.tecnepal.com/\" rel=\"noopener noreferrer\" target=\"_blank\">a two-day meetup</a> in January 2018.</p>\n<p>&#8220;WordPress Biratnagar has a remarkably large number of enthusiastic participants in local WordPress meetups, more than any other meetups in Nepal,&#8221; lead organizer Ganga Kafle said. Kafle is a developer and WordPress.org theme reviewer. He said his local community is full of energetic youth who are excited to make the WordCamp happen.</p>\n<p>&#8220;From an 8th grade student in a government school to a 56-year-old passionate retired army soldier, all are members of the WordPress Biratnagar community. This community is diverse, open, and has the ability to have fun together. They help each other out a lot, sharing tips and tricks, and solve problems together.&#8221;</p>\n<p>Kafle said the topics of most interest to the local community include WordPress SEO, blogging, and WordPress theme development, as the majority of community members are students, developers, freelancers, and designers. He expects the WordCamp will attract attendees from different cities inside Nepal and from nearby countries, including India, Bangladesh, Pakistan, and other South Asian countries. Sessions will be conducted in both English and Nepali.</p>\n<p>WordCamp Biratnagar will be the seventh WordCamp held in Nepal, following WordCamp Pokhara which is scheduled one month earlier on November 24. Pokhara is 11 hours away by car so the two WordPress communities are quite a distance away from each other. WordCamp Biratnagar is the last camp on the global WordCamp calendar for 2018.</p>\n<p>Kafle said he hopes the event will bring the Biratnagar WordPress community opportunities that will lead to more entrepreneurship and contribution to the greater tech community in the region. The event has <a href=\"https://2018.biratnagar.wordcamp.org/wordcamp-biratnagar-tickets/\" rel=\"noopener noreferrer\" target=\"_blank\">200 tickets available</a> and the capacity to expand if there is a greater demand. Early Bird Tickets are now on sale at Rs 1000. Once those are sold, Regular Tickets will be available for Rs 1500.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Sat, 08 Sep 2018 01:40:06 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:31;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:72:\"WPTavern: Dark Mode is Possibly Coming to a WordPress Dashboard Near You\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83660\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:83:\"https://wptavern.com/dark-mode-is-possibly-coming-to-a-wordpress-dashboard-near-you\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:4514:\"<p>For the past year, <a href=\"https://profiles.wordpress.org/danieltj\">Daniel James</a> has been developing the <a href=\"https://wordpress.org/plugins/dark-mode/\">Dark Mode</a> plugin for WordPress. The plugin is actively installed on more than 1K sites. Dark Mode replaces the white and grey colors in the backend with darker colors that are easier on the eyes.</p>\n\n<div class=\"wp-block-image\"><img />Dark Mode for WordPress</div>\n\n<p>James has published <a href=\"https://make.wordpress.org/core/2018/08/30/merge-proposal-dark-mode/\">a proposal</a> to merge the plugin into core. There are three things to know about Dark Mode up front. It does not have a high contrast mode to meet accessibility needs, is not a new admin color scheme for the backend, and is not a tool that helps people with vision issues. </p>\n\n<p>By default, WordPress ships with eight admin color schemes. However, color schemes are only applied to the WordPress sidebar and Admin toolbar. Dark Mode is applied to the main content area of the dashboard. This gives users the ability to use Dark Mode and an Admin Color Scheme in tandem. </p>\n\n<img />Admin Color Schemes\n\n<p>Dark Mode is not compatible with Gutenberg but is compatible with TinyMCE. Because of the speed at which Gutenberg is being developed as a plugin, James decided that a merge proposal without Gutenberg support is the best way forward. Compatibility with Gutenberg will likely arrive once it is merged into core.</p>\n\n<p>Because Dark Mode affects the content area of the WordPress Dashboard, if it&#8217;s merged into core, plugins will need to support two different color schemes. </p>\n\n<p>There is no easy way for Dark Mode to support every plugin, especially when many of them use custom user interface elements. <a href=\"https://github.com/danieltj27/Dark-Mode/wiki/Help:-Plugin-Compatibility-Guide\">This guide</a> on the <a href=\"https://github.com/danieltj27/Dark-Mode\">plugin&#8217;s GitHub page</a> explains how developers can add support for Dark Mode.</p>\n\n<h2>Proposal Hits a Snag</h2>\n\n<p>Within the comments on the proposal, members of the core and accessibility teams weighed in. Gary Pendergast, a WordPress core developer, <a href=\"https://make.wordpress.org/core/2018/08/30/merge-proposal-dark-mode/#comment-33913\">outlined</a> a list of requirements from the <a href=\"https://make.wordpress.org/core/handbook/about/release-cycle/features-as-plugins/#feature-plugin-merge-criteria\">Core Handbook</a> that the plugin has yet to achieve. </p>\n\n<p>James <a href=\"https://make.wordpress.org/core/2018/08/30/merge-proposal-dark-mode/#comment-33928\">responded</a> by explaining the process of merging a feature plugin into core as outlined in the Core Handbook does not lend itself to all projects. </p>\n\n<p>&#8220;For example, weekly meetings, or kick-off posts etc,&#8221; James said. &#8220;I understand that Gutenberg is probably a top priority right now but it’d be great if I could have some help on what to do to push this forward. I think an introduction of Gutenberg <strong>and</strong> Dark Mode would be a great addition to shout about in 5.0.&#8221;</p>\n\n<h2>Some of the Benefits of Dark Mode</h2>\n\n<p>One of the obvious benefits is that Dark Mode is aesthetically pleasing, especially after sunset. Depending on the <a href=\"https://www.quora.com/Does-a-white-background-use-more-energy-on-an-LCD-than-if-it-was-set-to-black\">screen technology</a>, darker colors are more energy efficient. It&#8217;s also a mode that&#8217;s gaining in popularity. For example, earlier this year, <a href=\"https://developer.apple.com/videos/play/wwdc2018/210/\">Apple announced</a> Dark Mode will be available in macOS Mojave.<br /></p>\n\n<p>I find myself using Dark Mode on Reddit, the Twitter app on my iPhone, and now WordPress. I like to browse the web on my phone while laying in bed and my partner enjoys not seeing a bright screen shining in her direction.<br /></p>\n\n<p>Based on <a href=\"https://make.wordpress.org/core/2018/08/30/merge-proposal-dark-mode/#comment-33929\">comments made</a> to the proposal and on <a href=\"https://twitter.com/mikelikethebike/status/1035513986836570112\">social media</a>, there is a definitive interest in having a Dark Mode option in WordPress. Is Dark Mode something you&#8217;d like to see be part of core? Also, I&#8217;m curious as to which Admin Color scheme you use. Please vote in the poll below. </p>\n\nNote: There is a poll embedded within this post, please visit the site to participate in this post\'s poll.\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Sat, 08 Sep 2018 00:14:05 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Jeff Chandler\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:32;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:57:\"WPTavern: The State of JavaScript 2018 Survey is Now Open\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83749\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:68:\"https://wptavern.com/the-state-of-javascript-2018-survey-is-now-open\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:3004:\"<p>The annual <a href=\"https://stateofjs.com/\" rel=\"noopener noreferrer\" target=\"_blank\">State of JavaScript 2018 Survey</a> is in its third year running and is now open for participants. <a href=\"http://sachagreif.com/\" rel=\"noopener noreferrer\" target=\"_blank\">Sacha Greif</a>, an Osaka-based web designer and developer, said he created the survey to get more data about recent trends after hearing all the online discussion about “JavaScript fatigue.”</p>\n<p>Last year&#8217;s survey had more than 20,000 participants, a 115% increase over the previous year&#8217;s 9,300 responses. In the popular front-end frameworks category, React won out again as the framework with the greatest number of respondents indicating that they had used it and would use it again.</p>\n<p><a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/09/Screen-Shot-2018-09-07-at-12.35.08-PM.png?ssl=1\"><img /></a></p>\n<p>The 2017 survey participants were asked to rate their happiness with the current state of front-end tools on a scale of 1-5. The results averaged a 3.8, so there is room in the front-end tools category for things to shift quite a bit over a year.</p>\n<p>The salary ranges data is particularly useful for job seekers or those new to JavaScript who are trying to decide what libraries to learn. Backbone and Ember commanded the highest salaries for participants, with Vue and Angular 2 coming in at the lower end.</p>\n<p><a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/09/Screen-Shot-2018-09-07-at-12.53.47-PM.png?ssl=1\"><img /></a></p>\n<p>Check out the full <a href=\"https://2017.stateofjs.com/2017/introduction/\" rel=\"noopener noreferrer\" target=\"_blank\">2017 results</a> for more data on participants&#8217; opinions on state management tools, back-end frameworks, build tools, and more.</p>\n<p>&#8220;The main change this year is that we added some extra logic to the survey: if you mention having used a given library, we’ll ask a follow-up question to find out what you like (or disliked) about it,&#8221; Greif said in announcing the 2018 survey. &#8220;We’re hoping that this helps us get more granular data about why some technologies are popular.&#8221;</p>\n<p>The 2018 survey has also dropped the CSS libraries category this year, in favor of keeping it from getting too long. Greif hinted that CSS may get its own survey one day, but that section will no longer by included in the JavaScript survey.</p>\n<p>Greif is aiming to publish the results by mid-November and will also give a preview at the <a href=\"https://www.dotjs.io/\" rel=\"noopener noreferrer\" target=\"_blank\">Dot JS</a> conference in Paris on November 9th. Your participation in the 2018 survey will help it to more accurately present the trends in the JavaScript ecosystem and help other developers see which tools have the highest satisfaction ratings and best salaries. Visit <a href=\"https://stateofjs.com/\" rel=\"noopener noreferrer\" target=\"_blank\">stateofjs.com</a> to take the survey now.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Fri, 07 Sep 2018 19:07:04 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:33;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:80:\"WPTavern: Pootlepress Previews Upcoming Storefront Blocks Plugin for WooCommerce\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83538\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:91:\"https://wptavern.com/pootlepress-previews-upcoming-storefront-blocks-plugin-for-woocommerce\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:6098:\"<p>At the end of 2017, WooCommerce <a href=\"https://wptavern.com/woocommerce-explores-the-possibilities-and-challenges-for-e-commerce-in-the-gutenberg-era\">published some of their &#8220;Wootenberg experiments&#8221;</a>, one of the first previews of what e-commerce might look like in the Gutenberg era. Gutenberg&#8217;s handling of meta boxes has greatly evolved since that time and the <a href=\"https://wordpress.org/plugins/woo-gutenberg-products-block/\" rel=\"noopener noreferrer\" target=\"_blank\">WooCommerce Gutenberg Products Block</a> feature plugin is now active on more than 20,000 sites. The plugin provides a basic custom products area for featuring products.</p>\n<p>Pootlepress has expanded on this idea of offering a configurable product display and is currently previewing its upcoming <a href=\"https://www.pootlepress.com/storefront-blocks/\" rel=\"noopener noreferrer\" target=\"_blank\">Storefront Blocks</a> plugin, created specifically for use with the WooCommerce <a href=\"https://wordpress.org/themes/storefront/\" rel=\"noopener noreferrer\" target=\"_blank\">Storefront theme</a>. The plugin allows users to easily customize more advanced layouts for various product displays that can be used anywhere in their content.</p>\n<div class=\"embed-vimeo\"></div>\n<p>Storefront Blocks includes the following custom blocks:</p>\n<ul>\n<li>Product Masonry Grid block</li>\n<li>Category Masonry block</li>\n<li>Square Product Grid block</li>\n<li>Slider block</li>\n<li>WooCommerce default product</li>\n<li>Carousel block</li>\n</ul>\n<p>Storefront Blocks lets store owners easily customize font, colors, label positioning and alignment, grid gap, product grid rows, and columns. The blocks can be expanded to be full-width. They can also be transformed and reused. One example shown in the video above demonstrates converting a product grid into a slider.</p>\n<p><a href=\"https://i0.wp.com/wptavern.com/wp-content/uploads/2018/08/Screen-Shot-2018-09-05-at-4.04.37-PM.png?ssl=1\"><img /></a></p>\n<p>Check out the live frontend demo at <a href=\"https://storefrontblocks.com/\" rel=\"noopener noreferrer\" target=\"_blank\">storefrontblocks.com</a>.</p>\n<p>The team at Pootlepress was aiming to release the plugin in first week of September but have pushed it back to the week of the September 17th, due to issues caused by Gutenberg 3.7.</p>\n<blockquote class=\"twitter-tweet\">\n<p lang=\"en\" dir=\"ltr\">Gutenberg 3.7 dropped today and broke some stuff. Trying to develop in prep for <a href=\"https://twitter.com/hashtag/gutenberg?src=hash&ref_src=twsrc%5Etfw\">#gutenberg</a> is like shooting at a fast moving target atm. Makes me agree  more and more with <a href=\"https://twitter.com/mor10?ref_src=twsrc%5Etfw\">@mor10</a> that we need a 6 month freeze once the code base is stable to prepare properly.</p>\n<p>&mdash; pootlepress (@pootlepress) <a href=\"https://twitter.com/pootlepress/status/1035574622840938496?ref_src=twsrc%5Etfw\">August 31, 2018</a></p></blockquote>\n<p></p>\n<p>Pootlepress founder Jamie Marsland said they plan to sell Storefront Blocks at several price points: $75 (single site license), $125 for 5 sites, $149 for 25 sites, and $199 for an unlimited license. The product is a natural extension of their current offerings, which include a page builder plugin used on more than 10,000 websites and a Storefront Pro plugin used on 5,000+ stores.</p>\n<p>Marsland said he was previously a skeptic about Gutenberg but is convinced that a unified interface is going to be the chief benefit of Gutenberg in the long term.</p>\n<p>&#8220;My skepticism was really based on how it was being rolled out to the WP community, rather than the technical approach of Gutenberg,&#8221; Marsland said. &#8220;I still feel that way actually. But from a end user point of view I’m convinced users are going to love it. 50% of our business is focused on running WordPress training courses for beginners, so we see first hand the issues that WordPress users have with the existing editor. The layout limitations of the current editor is the number complaint that users have with WordPress (from our experience of having trained thousands of end users over the past 7 years).&#8221;</p>\n<p>Marsland&#8217;s team at Pootlepress has gone all-in on developing for Gutenberg. So far their greatest challenge in extending the new editor has been keeping pace with its rapid development.</p>\n<p>&#8220;It feels a bit like developing for a moving target at times,&#8221; Marsland said. &#8220;The Gutenberg documentation is getting better but there are still gaps in it. The Slack channel has been really helpful though and the team have been great and responding to specific questions we have.&#8221;</p>\n<p>Marsland doesn&#8217;t see Gutenberg impacting Pootlepress&#8217; WooCommerce page builder product, at least not until Gutenberg evolves further on its journey into site customization capabilities.</p>\n<p>&#8220;At the moment Gutenberg is quite limited in what’s possible from a layout and design perspective,&#8221; Marsland said. &#8220;For example, our WooCommerce page builder plugin lets users change the design and layout of individual WooCommerce products. This isn’t possible with Gutenberg and may not be for quite some time. It feels like Gutenberg will stay more of a content editor than become a true page builder, especially given the current feedback from the community. That said, the ease of adding blocks within a unified interface like Gutenberg is perfect for a block approach like we are building for Storefront Blocks.&#8221;</p>\n<p>If you&#8217;ve been wondering what Gutenberg will look like in a WooCommerce context, Pootlepress&#8217; upcoming Storefront Blocks plugin gives you an idea of the customization possibilities the new editor will bring. The plugin makes it easy for non-technical store owners to showcase their products in a compelling way and enables them to create and customize product layouts. Storefront Blocks is an impressive example of how Gutenberg-powered products can replace clunky shortcodes with a more user-friendly interface for building store pages.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Wed, 05 Sep 2018 21:27:02 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:34;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:58:\"HeroPress: The Deaf World May Await, But It’s Not Silent\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:56:\"https://heropress.com/?post_type=heropress-essays&p=2616\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:160:\"https://heropress.com/essays/the-deaf-world-may-await-but-its-not-silent/#utm_source=rss&utm_medium=rss&utm_campaign=the-deaf-world-may-await-but-its-not-silent\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:15627:\"<img width=\"960\" height=\"480\" src=\"https://s20094.pcdn.co/wp-content/uploads/2019/09/090518-min-1024x512.jpg\" class=\"attachment-large size-large wp-post-image\" alt=\"Pull Quote: The handicap of deafness is no in the ear, it is in the mind. -- Marlee Matlin\" /><p>Have you ever wondered what it would be like if the world you lived in completely changed, turning your life upside down?</p>\n<p>And for those who have gone through an experience like this, can you remember how it felt to wake up in a world you were not used to?</p>\n<p>Even though life can throw many curve balls your way, the way you tackle them can redefine you as a person.</p>\n<h3>From One World to Another</h3>\n<p>I was just a toddler when I was diagnosed with a hearing impairment. My parents noticed my speaking skills lagged behind other toddlers of a similar age. I was diagnosed with a hearing loss at the age of 2 or 3.</p>\n<p>Even though it’s something I’ve lived with my entire life, it has been (and still is) a long and confusing journey for me as I try to figure out how best to live with it.</p>\n<p>You see, I’m not profoundly deaf. I can hear relatively well for now (I’ll get to that part in a minute), which means that I was brought up in a mainstream hearing environment.</p>\n<p>This didn’t come without its challenges though as I experience inaccessibility issues regularly. For example, noisy environments such as bars and restaurants, bad audio at conferences and mumbling voices when listening to podcasts.</p>\n<p>As a young child who didn’t know any better and acted naive about life, I just accepted it. But then as I got older and learned more about the world around me, well, that’s when things started to change.</p>\n<p>Because I am part of the hearing world but also have one “ear” in the non-hearing world, it has been a confusing position to be in. I already know what it’s “supposed to” be like if I had normal hearing. But that’s the thing, I don’t have normal hearing and I’m not profoundly deaf either.</p>\n<p>So where do I stand?</p>\n<p>Well there was always the possibility that my hearing would get worse, which was something my audiologist told me as a teenager. I figured maybe that will give me a better idea of where I stand.</p>\n<blockquote><p>But come on, as a teenager, I acted like a teenager – I was in denial about my situation and just wanted to fit in, like we all do as human beings.</p></blockquote>\n<p>Nothing was going to stop me from playing football, playing the guitar, socialising with friends, going to restaurants (plenty of head nodding happens there) and going to the cinema (even if I had to pretend to enjoy the latter and act as if I could hear everything, which was awkward when everyone talks about it afterwards).</p>\n<p>Over time, I learned to develop tricks to help me get by, living in both worlds. For example, when playing the guitar, I’m not able to fine-tune my music without the help of technology or someone else who can assist me. Or when I go to the cinema, I only focus on action movies so I don’t REALLY have to talk about the story line, so I talk about the graphics, car chases and explosions instead.</p>\n<p>On top of that I was learning English, which is my second language (but now my main language), and I was having speech therapy sessions and attended countless audiology appointments.</p>\n<p>But you keep going, right? You don’t let anything stop you. I made it through two universities, a number of jobs and navigated life in general throughout my twenties relatively unscathed.</p>\n<p>Then one day, a few years ago, I realised my hearing had declined even further. Unexpectedly, I found myself in a much quieter world than the one I was used to.</p>\n<p>Remember that warning from the audiologist? Well things got very real, very fast.</p>\n<p>I realised there was no turning back. And so began a whole new unfamiliar journey over what to do next.</p>\n<h3>Silent with a Loud Voice</h3>\n<p>It’s quite common to see online creators documenting their lives using whatever platform is available, such as social media and personal websites. The same applies for those who are going through certain struggles and share them with the world. And I used to find that strange. For something so personal, why would you share this with strangers?</p>\n<p>Many years ago, it’s not something that I would have thought of doing. And there was definitely no intention of writing about being partially deaf. Like I said, I was trying to fit in, so I told myself to keep going to the cinema and pretend that I enjoyed it.</p>\n<p>But there comes a time where you have to stop pretending and start being real, like I did by creating a video to publicly declare my intention to do so (and I’ll talk more about that later).</p>\n<p>I’m lucky to have a job that revolves around the internet. As someone who works in the digital marketing industry, it was natural for me to <a href=\"https://iamahmedkhalifa.com\" target=\"_blank\" rel=\"noopener\">have my own website</a>. I remember there were a lot of experimenting and trying to work out how to start one, as well as trying to figure out what it should be about.</p>\n<p>Having your own website sounds like a cool thing to have, but it wasn’t something I made a lot of use of in the early days. My priority was always on my clients’ or employers’ websites.</p>\n<p>But over the past few years, I’ve grown more and more involved with WordPress and have a deeper appreciation for those who use the platform to find their voice.</p>\n<p>And that made me curious.</p>\n<blockquote><p>It wasn’t until I started my own business in 2016 that I took WordPress more seriously, both for me personally and for my clients.</p></blockquote>\n<p>That is when I started to get more involved with the WordPress community. Because of my continued desire to contribute to the community and also how much I enjoyed helping others to make the most out of their WordPress sites. This inevitably led me to being one of the co-organisers of the WordPress meet-up group in Edinburgh as well as the current lead organiser for WordCamp Edinburgh.</p>\n<p>My main WordPress site is my business site. It’s where I predominantly focus on the subjects of SEO, Google Analytics, WordPress (of course), online business, etc. You know, anything to help others use their WordPress site to grow their online visibility, engagement and conversion.</p>\n<p>There is another side to being part of WordPress, and that is the community – it means you’re involved with a wide variety of people, mixing with different personalities and opening your mind to more experiences. It is where you can share valuable insights that can impact not just your life but the lives of those around you who are using WordPress in some shape or form.</p>\n<p>And that includes the subjects of inclusivity and accessibility, two areas which have a direct effect on me. But with regards to accessibility, I do depend on subtitles/closed captions in certain situations. I’m thankful that TV is getting better at it, but outside the house, it’s not that simple.</p>\n<blockquote><p>Having been to many meet-ups and WordCamps, the code of conduct is clear – it’s about making the environment welcoming and comfortable for everyone.</p></blockquote>\n<p>The subject of online accessibility is becoming more important. Even though we are still behind in terms of understanding accessibility and making it a standard approach on websites, I’m starting to see people taking it more seriously, and rightly so.</p>\n<p>So I should feel comfortable about the online world, right? Well, not exactly. Accessibility is still trying to catch up online and offline for everyone, not just for deaf people. For example, there are still campaigns going on to have subtitled screenings at cinemas as they tend to be limited and are often used during impossible hours like Monday mornings.</p>\n<p>Because apparently, deaf people don’t have day jobs.</p>\n<p>The combined effect of a lack of accessibility and various challenges means there is a nagging feeling that being deaf means my abilities are limited in an online world.</p>\n<p>It’s a stupid thing, right? But imposter syndrome is a powerful thing. If you don’t have a firm hold on it, it can be beat the hell out of you.</p>\n<p>Until one day&#8230;</p>\n<p>“Enough! I’ve had enough.”</p>\n<p>There came a point where I decided to let go of the very thing (my hearing impairment) that I felt was holding me back in life and to use that as the catalyst to move forward. I was reading a book called “Let Go” by Pat Flynn of Smart Passive Income. He is someone I’ve admired from afar and I have learnt a lot from him, even before reading that book.</p>\n<p>But that book was the first “soft” trigger for me in accepting the present and the future. Little did I realise how doing this would pave the way for a whole new world of possibilities and opportunities. And that’s when the second trigger happened. I had the opportunity of spending a day with Pat in San Diego – it was an experience I’ll never forget.</p>\n<p>But just as importantly and for the final trigger, it allowed me remove those chains that shackled me and gave me the freedom to move forward and to take advantage of whatever life had to offer me, even if it meant things were “limited” because of my gradual hearing loss.</p>\n<p>It’s amazing what can happen when you share your vulnerabilities and experiences with others. We can always learn from each other and sharing this experience has ended up helping many others. I have received private messages from strangers thanking me for creating videos that help spread awareness.</p>\n<p>And I’m not stopping there either.</p>\n<h3>The World Got Quieter</h3>\n<p>If I am going deeper into the deaf world, it doesn’t mean it’s going to be silent, at least not in an online sense. I have created a dedicated website called <a href=\"https://hearmeoutcc.com\" target=\"_blank\" rel=\"noopener\">Hear Me Out! [CC]</a> to document my hearing journey. It’s a place to share other people’s stories and to provide advice on managing in the deaf world – whether you are deaf or not.</p>\n<p>See, that’s the great thing about putting websites together. It’s about giving you the platform you never had before. It’s also the ethos of WordPress &#8220;to democratise publishing through Open Source, GPL Software”.</p>\n<p>It’s a funny thing when you start documenting and talking about your life online. Many people use social media as a platform to help with that and to create a voice, but I prefer to use my WordPress site for that voice. And then I use social media to help elevate it.</p>\n<h3>Your Voice Can Influence Others</h3>\n<p>Since I’ve been using WordPress and been involved in digital marketing for almost 10 years, it made sense to use that experience to my advantage. I’m lucky that my business allows me to use my expertise to help other people with their sites.</p>\n<p>But sometimes you have to be a little selfish and think about your own journey too, not just those of your clients or customers (as well as your friends and family).</p>\n<p>Not only are you allowed to do that, but you should do that. Because if you don’t help yourself first, you can’t help anyone else around you.</p>\n<p>Several years ago, I wouldn’t have thought of doing that. I mean, who the hell would want to listen to me? But I truly believe in the motto “your vibe attracts your tribe” – it doesn’t matter who you are, you’ve got something worth sharing online that your tribe, whoever they are, would love.</p>\n<p>And it’s never too late to start.</p>\n<hr />\n<p>There is a quote I really like by American actress, Marlee Matlin:</p>\n<blockquote><p>“The handicap of deafness is not in the ear; it is in the mind.”</p></blockquote>\n<p>That quote applies to me perfectly, but you can also apply it to your own circumstances if deafness doesn’t apply to you.</p>\n<p>It’s like that old saying we all heard as children: “You can do anything if you put your mind to it.”</p>\n<p>It is kind of true in a way, but it has taken me a long time to realise it. Even though I wish I had started earlier, it’s about starting today rather than thinking about yesterday.</p>\n<p>And I think that can apply to any situation.</p>\n<p>I’m not just talking about creating a website. It’s also about finding the right time for you to let go of whatever is holding you back, and for you to understand what your next steps are.</p>\n<p>That was my challenge. I had to redefine myself if I wanted to move forward. I see no reason why you can’t do that too.</p>\n<p>So here is my message to you: if you have something that is holding you back, I urge you to write down what you are going to do about it. You need to stick it somewhere where you can see it all the time.</p>\n<p>And if you are feeling REALLY brave, you can let me know in the comment section below what is holding you back in your life – and what you are doing to let it go.</p>\n<p>My way of doing that was to create another WordPress site to share my stories and document my journey.</p>\n<p>Because take it from me, once you do that, the world awaits you… online and offline.</p>\n<div class=\"rtsocial-container rtsocial-container-align-right rtsocial-horizontal\"><div class=\"rtsocial-twitter-horizontal\"><div class=\"rtsocial-twitter-horizontal-button\"><a title=\"Tweet: The Deaf World May Await, But It&#8217;s Not Silent\" class=\"rtsocial-twitter-button\" href=\"https://twitter.com/share?text=The%20Deaf%20World%20May%20Await%2C%20But%20It%27s%20Not%20Silent&via=heropress&url=https%3A%2F%2Fheropress.com%2Fessays%2Fthe-deaf-world-may-await-but-its-not-silent%2F\" rel=\"nofollow\" target=\"_blank\"></a></div></div><div class=\"rtsocial-fb-horizontal fb-light\"><div class=\"rtsocial-fb-horizontal-button\"><a title=\"Like: The Deaf World May Await, But It&#8217;s Not Silent\" class=\"rtsocial-fb-button rtsocial-fb-like-light\" href=\"https://www.facebook.com/sharer.php?u=https%3A%2F%2Fheropress.com%2Fessays%2Fthe-deaf-world-may-await-but-its-not-silent%2F\" rel=\"nofollow\" target=\"_blank\"></a></div></div><div class=\"rtsocial-linkedin-horizontal\"><div class=\"rtsocial-linkedin-horizontal-button\"><a class=\"rtsocial-linkedin-button\" href=\"https://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fheropress.com%2Fessays%2Fthe-deaf-world-may-await-but-its-not-silent%2F&title=The+Deaf+World+May+Await%2C+But+It%26%238217%3Bs+Not+Silent\" rel=\"nofollow\" target=\"_blank\" title=\"Share: The Deaf World May Await, But It&#8217;s Not Silent\"></a></div></div><div class=\"rtsocial-pinterest-horizontal\"><div class=\"rtsocial-pinterest-horizontal-button\"><a class=\"rtsocial-pinterest-button\" href=\"https://pinterest.com/pin/create/button/?url=https://heropress.com/essays/the-deaf-world-may-await-but-its-not-silent/&media=https://heropress.com/wp-content/uploads/2019/09/090518-min-150x150.jpg&description=The Deaf World May Await, But It\'s Not Silent\" rel=\"nofollow\" target=\"_blank\" title=\"Pin: The Deaf World May Await, But It&#8217;s Not Silent\"></a></div></div><a rel=\"nofollow\" class=\"perma-link\" href=\"https://heropress.com/essays/the-deaf-world-may-await-but-its-not-silent/\" title=\"The Deaf World May Await, But It&#8217;s Not Silent\"></a></div><p>The post <a rel=\"nofollow\" href=\"https://heropress.com/essays/the-deaf-world-may-await-but-its-not-silent/\">The Deaf World May Await, But It&#8217;s Not Silent</a> appeared first on <a rel=\"nofollow\" href=\"https://heropress.com\">HeroPress</a>.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Wed, 05 Sep 2018 08:00:31 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Ahmed Khalifa\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:35;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:108:\"WPTavern: AMP for WordPress Plugin to Introduce User-Friendly Theme Support Settings in Upcoming 1.0 Release\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83671\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:119:\"https://wptavern.com/amp-for-wordpress-plugin-to-introduce-user-friendly-theme-support-settings-in-upcoming-1-0-release\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:14488:\"<p>In October, Google&#8217;s open source <a href=\"https://www.ampproject.org/\" rel=\"noopener noreferrer\" target=\"_blank\">AMP project</a> (Accelerated Mobile Pages) will be heading into its third year. The initiative aims to improve performance on the mobile web and currently boasts usage on 25 million domains across publishing, advertising, e-commerce, and business websites.</p>\n<p>WordPress had a rocky beginning with its <a href=\"https://wordpress.org/plugins/amp/\" rel=\"noopener noreferrer\" target=\"_blank\">official AMP plugin</a>, which was originally developed by Automattic, one of the earliest publishing partners on the project. The first versions of the plugin were not easy to use, especially for heavily customized installations. It required site owners to invest considerable effort into optimizing AMP pages and fine tuning them for their needs. AMP for WordPress <a href=\"https://wptavern.com/amp-project-turns-2-automattic-partners-with-google-to-improve-wordpress-plugin\" rel=\"noopener noreferrer\" target=\"_blank\">went without updates for 10 months in 2017</a>, was fraught with errors, and incompatible with many other plugins.</p>\n<p>XWP began leading development of the plugin last year in partnership with Google, beginning with the 0.6 release. Weston Ruter is the tech lead with several XWP engineers contributing to development, design, and testing. Alberto Medina, Developer Advocate at Google, and his team have been leading the product management and outreach efforts.</p>\n<p>&#8220;Around May last year, my team at Google started a long-term effort with a bigger scope than just AMP, which included significantly investing engineering resources on the development of the plugin,&#8221; Medina said. &#8220;We started investing development resources, and then teamed up with XWP to expand the engineering scope. During this phase of the project Google and XWP have driven all the execution of the project and the development efforts.&#8221;</p>\n<p>Ruter said his team went through six months of the plugin&#8217;s support topics on WordPress.org and categorized them to figure out what issues users were struggling with most. They used that information to guide the focus for their first release and have been keeping a pulse on the support forum ever since.</p>\n<p>The plugin has incorporated many changes since XWP began spearheading its development, putting AMP&#8217;s newer features to use within the context of WordPress. Earlier versions of the plugin only allowed posts to be served as AMP but the 0.6 release added pages to its capabilities. Version 0.7 introduced the ability for all URLS on a site to served as AMP (“Native AMP”) but lacked the ability for users to customize which types of content should be excluded from this format. The upcoming 1.0 release will allow users to have a native AMP site that excludes certain templates, such as a shopping cart or a category archive, from being served as AMP.</p>\n<p>&#8220;AMP initially was limited in functionality,&#8221; Ruter said. &#8220;The AMP plugin was created when AMP was young. In the beginning it was focused on Accelerated <em>Mobile</em> Pages and it wasn&#8217;t able to recreate full responsive experiences that site owners expect. This has changed and AMP is able to do a lot. So that is what we have been focused on with the AMP plugin, is to bring it up to speed with the AMP project itself so that WordPress sites can take advantage of all the features and functionality that are now available.&#8221;</p>\n<p>The team at XWP is aiming to release version 1.0 of AMP for WordPress in mid-September. The <a href=\"https://make.xwp.co/2018/06/09/amp-plugin-release-v1-0-alpha1/\" rel=\"noopener noreferrer\" target=\"_blank\">1.0 alpha release</a> introduced extended AMP theme support with a more user-oriented approach to the settings. Previous versions of the plugin were more developer-centric, requiring edits to a theme or child theme to configure template support. Users can now enable Native AMP or Paired mode on the AMP settings screen and the <a href=\"https://make.xwp.co/2018/07/06/amp-plugin-release-v1-0-beta1/\" rel=\"noopener noreferrer\" target=\"_blank\">beta release</a> adds granular controls for selecting supported templates.</p>\n<a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/09/amp-1-0-beta.png?ssl=1\"><img /></a>image credit: <a href=\"https://make.xwp.co/2018/07/06/amp-plugin-release-v1-0-beta1/\">XWP</a>\n<p>Other notable updates in the alpha and beta releases include:</p>\n<ul>\n<li>Enhanced UI for handling AMP validation errors</li>\n<li>Expanded Gutenberg support to surface AMP validation errors at a block level</li>\n<li>Addition of AMP-specific functionality to core blocks</li>\n<li>Redirection to non-AMP URL when unaccepted validation errors present</li>\n<li>Beta brings back WP Admin Bar AMP menu with AMP error highlighting</li>\n</ul>\n<p>AMP for WordPress <a href=\"https://make.xwp.co/2018/08/06/amp-plugin-release-v1-0-beta2/\" rel=\"noopener noreferrer\" target=\"_blank\">v1.0-beta2</a> was released in August and is not yet ready for production use. The good news for those who want to use AMP is that the plugin is becoming more of a plug-and-play solution as development progresses.</p>\n<p>&#8220;There is only one setting that the user needs to change to take advantage of the new theme support: switching from legacy to paired or native,&#8221; Ruter said. &#8220;Everything else is optional and just customizes the behavior. There will be a new admin pointer in 1.0 that will call out this updated admin screen.&#8221;</p>\n<p>Ruter also said his team is considering implementing a wizard-type experience to minimize the number of tweaks users need to make. They are discussing automating the compatibility check of the various templates prior to enabling theme support so users can get a high level view of the areas of the site that would be best-suited for AMP.</p>\n<h3>AMP Remains a Controversial Solution to Web Page Performance</h3>\n<p>Many users encountered insurmountable difficulties in their first attempts at using the AMP plugin with highly customized sites, relegating AMP usage to sites with dedicated engineering teams. Early versions of the AMP project did not have the flexibility that many publishers required.</p>\n<p>Brian Boyer, VP of Product and People at Spirited Media, home of The Incline, Billy Penn, and Denverite publications, gave a presentation at WordCamp for Publishers titled &#8220;<a href=\"https://wordpress.tv/2018/08/22/brian-boyer-why-we-ditched-amp-and-other-ux-choices-we-made-for-launching-membership/\" rel=\"noopener noreferrer\" target=\"_blank\">Why we ditched AMP, and other UX choices we made for launching membership</a>.&#8221;</p>\n<p>&#8220;We need more control over our user experience than AMP allows &#8211; to build an unshitty, persuasive, native feeling, highly effective membership experience, I need a little more JavaScript,&#8221; Boyer said. &#8220;I need a little bit more control over the page and to be fair, we could probably make some of this stuff but we cannot afford to design, build, and most crucially, test multiple versions of our website.&#8221;</p>\n<p>Boyer cited the expense of of building and testing multiple codebases as one of the primary reasons his team ditched AMP. The complication of maintaining a second user experience was &#8220;far too much to ask&#8221; for his development team, who had already produced a fast, lightweight WordPress setup with proper caching.</p>\n<p>&#8220;An AMP page might load a little faster but our other needs far outweigh that minor performance improvement,&#8221; Boyer said. &#8220;We got over our FOMP (Fear of Missing Pageviews). If I can be better at making conversions, I&#8217;ll take the hit with pageviews.&#8221;</p>\n<p>Recent <a href=\"https://xwp.co/an-introduction-to-native-amp/\" rel=\"noopener noreferrer\" target=\"_blank\">Enhancements to the AMP project and the plugin</a>, including the addition of components allowing for the creation of rich interactive experiences, continue to narrow the gap between the custom JavaScript many websites require and AMP&#8217;s limitations. This may be encouraging for those who have chosen to embrace AMP, but ultimately will not make a difference for those who fundamentally oppose the initiative as an affront to the open web.</p>\n<p>Beyond the technical investment in fine-tuning an AMP setup to meet the needs of his publications, Boyer concluded the presentation by outlining his broader objections to the AMP project:</p>\n<blockquote><p>By policing slow websites, Google has turned the big publishers&#8217; problem into my problem, but that fix comes at a high cost to me, a small publisher,&#8221; Boyer said. &#8220;AMP is not the Open Web &#8211; it&#8217;s a short term fix for bad choices. If you build a slow and terrible website that supports a creepy business model, like tracking the shit out of your users, then yes, AMP is one path to a better user experience. It is an escape hatch from your legacy code and the bad choices of your predecessors. I understand why that would be tempting, but it is also a deal with the devil. AMP and its cousin Instant Articles put even more control in the hands of companies that already have too much control, and I for one cannot abide by that. I just ask you, do the work, fix your websites, make them fast, friendly, and respectful.</p></blockquote>\n<p>Other vocal critics are not comfortable with how Google is positioning AMP as a long-term solution, instead of addressing the root issues of web page performance. Jeremy Keith articulated this stance in his article titled &#8220;<a href=\"https://adactio.com/journal/13964\" rel=\"noopener noreferrer\" target=\"_blank\">AMPstinction</a>.&#8221;</p>\n<p>&#8220;If the AMP project existed in order to create a web where AMP was no longer needed, I think I could get behind it,&#8221; Keith said. &#8220;But the more it’s positioned as the only viable solution to solving performance, the more uncomfortable I am with it.</p>\n<p>&#8220;Which, by the way, brings me to one of the most pernicious ideas around Google AMP—positioning anyone opposed to it as not caring about web performance. Nothing could be further from the truth. It’s precisely because performance on the web is so important that it deserves a long-term solution, co-created by all of us: not some commandants delivered to us from on-high by one organization, enforced by preferential treatment by that organization’s monopoly in search.&#8221;</p>\n<p>However, decoupling AMP from Google&#8217;s influence would also mean separating the project from the leadership and resources that have so far driven its adoption across millions of websites. There may be other approaches to addressing performance but Alberto Medina and his team see AMP as serving a practical purpose for users and developers who wouldn&#8217;t otherwise be capable of optimizing their sites to the same degree. What he described is in a sense &#8220;democratizing performance.&#8221;</p>\n<p>&#8220;The root causes of web performance problems are well known and there are tools, techniques, and web APIs, that allow developers to achieve awesome UX close to what AMP provides,&#8221; Medina said. &#8220;However, the reality is that doing so is very hard for most developers. Usually achieving it requires having solid engineering teams and enough financial resources. That is not fair for most developers and organizations that do not have the resources.&#8221;</p>\n<p>Medina sees AMP as an answer to what he describes as the <a href=\"https://medinathoughts.com/2018/05/17/progressive-wordpress/\" rel=\"noopener noreferrer\" target=\"_blank\">Capability/Usage gap</a>: the difference between what can be achieved in the web and what is actually done in the web.</p>\n<p>&#8220;The problem is that as the power and complexity of the web increases, that gap has increased as well,&#8221; Medina said. &#8220;The problem is that as long as that gap exists, achieving the best UX is not possible. So, the goal is to close that gap. There are two options: developers do the right thing all the time, or we provide tooling/libraries that enable them to do the right thing in an easy and effective way. AMP served the latter purpose.&#8221;</p>\n<p>Medina also emphasized that AMP is fully built on open web technologies. &#8220;Basically, it provides what developers could do by themselves but it is hard to do,&#8221; he said.</p>\n<p>In a recent <a href=\"https://art19.com/shows/recode-decode/episodes/3d56208e-a4b9-4c74-861e-8fec105a4ee8\" rel=\"noopener noreferrer\" target=\"_blank\">Recode Decode podcast interview</a> with Kara Swisher, Matt Mullenweg also weighed in on the AMP project.</p>\n<p>&#8220;It gets a bad rap because Google kind of botched the rollout a little bit,&#8221; Mullenweg said. &#8220;The underlying tech is open source and it&#8217;s actually quite good. Because for you as an independent publisher to have a future, we need you to load just as fast as something that&#8217;s embedded in an app. Facebook has done the bait and switch so many times that we need an independent alternative and I think AMP can be that.&#8221;</p>\n<p>Google&#8217;s investment in the AMP plugin through its partnership with Automattic and XWP has made AMP more approachable for the average user, especially with the updates coming in version 1.0. Medina said Google chose to collaborate with WordPress because they share a similar goal of providing a better user experience for the platform.</p>\n<p>&#8220;AMP is not an end goal in itself; the real objective is enabling all WordPress developers and site owners to provide awesome user experiences powered by WordPress,&#8221; Medina said. &#8220;AMP is just a component in that overall story, together with PWA capabilities, coding and performance best practices, Tide, etc.&#8221; In architecting the latest version of the plugin, Medina said the team is aiming to &#8220;enable native AMP experiences in WordPress without compromising content fidelity or surrendering the flexibility of the WordPress platform.&#8221;</p>\n<p>Whatever your opinion of the AMP project, the user-friendly theme support options and better validation error handling are game changing improvements for the WordPress plugin. It is currently active on more than 300,000 sites. Updates coming in the 1.0 release will enable thousands of WordPress users to have a more successful experience with AMP.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 04 Sep 2018 21:28:48 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:36;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:45:\"Dev Blog: The Month in WordPress: August 2018\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:34:\"https://wordpress.org/news/?p=6191\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:70:\"https://wordpress.org/news/2018/09/the-month-in-wordpress-august-2018/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:5553:\"<p>Many of the WordPress contribution teams have been working hard on the new WordPress editor, and the tools, services, and documentation surrounding it. Read on to find out more about this ongoing project, as well as everything else that has been happening around the WordPress community in August.</p>\n\n<hr class=\"wp-block-separator\" />\n\n<h2>WordPress 4.9.8 is Released</h2>\n\n<p><a href=\"https://wordpress.org/news/2018/08/wordpress-4-9-8-maintenance-release/\">WordPress 4.9.8 was released</a> at the beginning of the month. While this was a maintenance release fixing 46 bugs, it was significant for Core development because it made a point of highlighting Gutenberg — the new WordPress editor that is currently in development (more on that below).<br /></p>\n\n<p>This release also included some important updates to the privacy tools that were added to Core earlier this year.<br /></p>\n\n<p>Want to get involved in building WordPress Core? Follow <a href=\"https://make.wordpress.org/core/\">the Core team blog</a> and join the #core channel in the <a href=\"https://make.wordpress.org/chat/\">Making WordPress Slack group</a>.</p>\n\n<h2>New WordPress Editor Development Continues</h2>\n\n<p>Active development continues on <a href=\"https://wordpress.org/gutenberg/\">Gutenberg</a>, the new editing experience for WordPress Core. <a href=\"https://make.wordpress.org/core/2018/08/31/whats-new-in-gutenberg-31st-august/\">The latest version</a> features a number of important user experience improvements, including a new unified toolbar and support for a more focussed writing mode.<br /></p>\n\n<p>Users can test Gutenberg right now by installing <a href=\"https://wordpress.org/plugins/gutenberg/\">the plugin</a>, which currently has nearly 300,000 active installs. Along with that, <a href=\"https://wordpress.org/gutenberg/handbook/reference/faq/\">the Gutenberg Handbook</a> has some very useful information about how to use and develop for the new editor.<br /></p>\n\n<p>Want to get involved in building Gutenberg? Follow <a href=\"https://make.wordpress.org/core/tag/gutenberg/\">the #gutenberg tag on the Core team blog</a> and join the #core-editor channel in the <a href=\"https://make.wordpress.org/chat/\">Making WordPress Slack group</a>.</p>\n\n<h2>Planning Begins for the Next Global WordPress Translation Day</h2>\n\n<p>The Global WordPress Translation Day is a 24-hour event held online and all across the world. It is designed to bring communities together to translate WordPress into their local languages, and to help them connect with other communities doing the same thing.<br /></p>\n\n<p>There have been three Translation Days since April 2016, and <a href=\"https://make.wordpress.org/polyglots/2018/08/29/global-wordpress-translation-day-4-preliminary-planning/\">the fourth edition is in the planning stages now</a>. The Polyglots team, who organizes these events, is currently looking for input on the date, format, and content for the event and would love some feedback from the community.<br /></p>\n\n<p>Want to get involved in translating WordPress into your own language? Follow <a href=\"https://make.wordpress.org/polyglots/\">the Polyglots team blog</a> and join the #polyglots channel in the <a href=\"https://make.wordpress.org/chat/\">Making WordPress Slack group</a>.<br /></p>\n\n<hr class=\"wp-block-separator\" />\n\n<h2>Further Reading:</h2>\n\n<ul><li><a href=\"https://wordpress.org/support/upgrade-php/\">The Update PHP page on WordPress.org</a> has been revised and improved to make the reasons for upgrading more clear.</li><li>The Mobile team is looking for people to help test the latest versions of the <a href=\"https://make.wordpress.org/mobile/2018/08/29/call-for-testing-wordpress-for-android-10-8/\">Android</a> and <a href=\"https://make.wordpress.org/mobile/2018/08/28/call-for-testing-wordpress-for-ios-10-8/\">iOS</a> apps for WordPress.</li><li><a href=\"https://wordbits.io/\">WordBits</a> is a innovative new platform for publishing WordPress-based code snippets with the ability to download each snippet as a working plugin.</li><li>The Community Team <a href=\"https://make.wordpress.org/community/2018/08/27/wordcamp-incubator-2018-update-thread-august-edition/\">has some updates</a> about how things are going with this year’s WordCamp Incubator program.</li><li>The WordPress Support Forums <a href=\"https://make.wordpress.org/support/2018/08/august-16th-support-team-meeting-summary/\">now include a feature</a> allowing forum volunteers to easily report a post to the moderators for a follow-up.</li><li>WordCamp Kochi, India <a href=\"https://2018.kochi.wordcamp.org/wordcamp-kochi-2018-is-postponed-to-november-3rd-2018-saturday/\">has unfortunately had to postpone their event</a> due to floods in the region.</li><li><a href=\"http://www.wpglossary.net/\">WP Glossary</a> is a new site that offers helpful definitions of words that you could encounter when using WordPress.</li><li>A few WordPress community members <a href=\"https://make.wordpress.org/community/2018/08/13/in-the-words-of-the/\">have started a working group</a> to tackle the idea of building diverse WordPress  communities all across the world.</li><li>A new <a href=\"https://editorblockswp.com/library/\">Gutenberg Block Library</a> is available, listing the details of the many blocks available for the new editor.</li></ul>\n\n<p><em>If you have a story we should consider including in the next “Month in WordPress” post, please </em><a href=\"https://make.wordpress.org/community/month-in-wordpress-submissions/\"><em>submit it here</em></a><em>.</em></p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Mon, 03 Sep 2018 11:00:43 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:15:\"Hugh Lashbrooke\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:37;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:59:\"WPTavern: Gutenberg 3.7 Released, Introduces Spotlight Mode\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83662\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:69:\"https://wptavern.com/gutenberg-3-7-released-introduces-spotlight-mode\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:1786:\"<p>Gutenberg 3.7 <a href=\"https://wordpress.org/plugins/gutenberg/\">is available</a> for download and contains a number of changes. The Fixed Toolbar has been renamed Unified Toolbar. This is an optional mode that fixes all of the toolbar icons to the top of the editor, similar to the Classic editor.</p>\n\n<p>The team discovered that experienced users who don&#8217;t mind the disconnect between blocks and the toolbar preferred this layout. <br /></p>\n\n<div class=\"wp-block-image\"><img />Unified Toolbar</div>\n\n<p>There&#8217;s now an animation and icon specifically tailored for the Block Converter action. Hovering the cursor over a block&#8217;s icon will display two arrows that represent the ability to change block types. <br /></p>\n\n<div class=\"wp-block-image\"><img />Change Bock Types Icon</div>\n\n<p>For those who want to focus on one block of content at a time, there&#8217;s a new mode called Spotlight. When enabled, the blocks that are not being edited partially fade away and the block outlines disappear. This is an experimental attempt at introducing a <a href=\"https://wptavern.com/gutenberg-contributors-considering-a-focus-mode-for-writing\">Distraction Free Writing mode</a>. </p>\n\n<p>The <a href=\"https://github.com/WordPress/gutenberg/pull/9152\">icons have been updated</a> for Paragraph, Heading, and Subheading blocks to add clarity. Previous to 3.7, the Paragraph block icon looked like an alignment option causing confusion. </p>\n\n<div class=\"wp-block-image\"><img />Updated Icons for Paragraph, Heading, and Subheading blocks</div>\n\n<p>You can find a complete list of changes and links to corresponding issues on GitHub by visiting the <a href=\"https://make.wordpress.org/core/2018/08/31/whats-new-in-gutenberg-31st-august/\">Gutenberg 3.7 release post</a>.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Fri, 31 Aug 2018 21:34:08 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Jeff Chandler\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:38;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:85:\"WPTavern: WPWeekly Episode 329 – Gutenberg, Forks, and WordPress Development Cycles\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:58:\"https://wptavern.com?p=83650&preview=true&preview_id=83650\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:90:\"https://wptavern.com/wpweekly-episode-329-gutenberg-forks-and-wordpress-development-cycles\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:3189:\"<p>In this episode, <a href=\"http://jjj.me\">John James Jacoby</a> and I discuss the news of the week. We have a candid conversation about what it would be like if Gutenberg were merged into WordPress trunk earlier versus developed as a plugin. We also talk about Classic Editor install numbers, praising forks of WordPress, and some new tools that are available to search Gutenberg blocks. This might be the first episode since Jacoby took over as co-host that we ended the show in under an hour.</p>\n<h2>Stories Discussed:</h2>\n<p><a href=\"https://wptavern.com/gutenberg-block-library-provides-a-searchable-index-of-individual-blocks\">Gutenberg Block Library Provides a Searchable Index of Individual Blocks</a></p>\n<p><a href=\"https://wptavern.com/gutenberg-and-classic-editor-plugins-pass-200000-active-installations-wordpress-4-9-9-planning-underway\">Gutenberg and Classic Editor Plugins Pass 200,000 Active Installations, WordPress 4.9.9 Planning Underway</a></p>\n<p><a href=\"https://wptavern.com/wordpress-to-support-classic-editor-for-many-years-to-come-plugin-and-theme-markets-expected-to-drive-gutenberg-adoption\">WordPress to Support Classic Editor for “Many Years to Come,” Plugin and Theme Markets Expected to Drive Gutenberg Adoption</a></p>\n<p><a href=\"https://wptavern.com/gary-pendergast-praises-classicpress-extends-invitation-for-collaboration\">Gary Pendergast Praises ClassicPress, Extends Invitation for Collaboration</a></p>\n<p><a href=\"https://wptavern.com/wordcamp-for-publishers-2018-videos-now-available-on-wordpress-tv\">WordCamp for Publishers 2018 Videos Now Available on WordPress.tv</a></p>\n<p><a href=\"https://wptavern.com/wpcampus-2018-videos-are-now-available-to-watch\">WPCampus 2018 Videos Are Now Available to Watch</a></p>\n<p><a href=\"https://wptavern.com/new-network-media-library-plugin-creates-a-shared-library-on-a-multisite-network\">New Network Media Library Plugin Creates a Shared Library on a Multisite Network</a></p>\n<p><a href=\"https://wptavern.com/new-wp-glossary-site-translates-wordpress-techspeak-into-plain-english\">New WP Glossary Site Translates WordPress Techspeak into Plain English</a></p>\n<h2>Picks of the Week:</h2>\n<p>Jeff &#8211; <a href=\"https://www.youtube.com/channel/UCuhqf3xFlQcopapi4xHiTfA\">WP Minute</a> by Malcom Peralty over at <a href=\"https://www.presstitan.com/\">PressTitan</a> &#8211; A new video series by a longtime friend and former co-host, David Peralty that provides quick updates on stories making the rounds in the WordPress ecosystem.</p>\n<h2>WPWeekly Meta:</h2>\n<p><strong>Next Episode:</strong> Wednesday,September 5th 3:00 P.M. Eastern</p>\n<p>Subscribe to <a href=\"https://itunes.apple.com/us/podcast/wordpress-weekly/id694849738\">WordPress Weekly via Itunes</a></p>\n<p>Subscribe to <a href=\"https://www.wptavern.com/feed/podcast\">WordPress Weekly via RSS</a></p>\n<p>Subscribe to <a href=\"http://www.stitcher.com/podcast/wordpress-weekly-podcast?refid=stpr\">WordPress Weekly via Stitcher Radio</a></p>\n<p>Subscribe to <a href=\"https://play.google.com/music/listen?u=0#/ps/Ir3keivkvwwh24xy7qiymurwpbe\">WordPress Weekly via Google Play</a></p>\n<p><strong>Listen To Episode #329:</strong><br />\n</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Thu, 30 Aug 2018 09:11:31 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Jeff Chandler\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:39;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:75:\"WPTavern: Distributor Plugin Now Publicly Available, Adds Gutenberg Support\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83634\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:85:\"https://wptavern.com/distributor-plugin-now-publicly-available-adds-gutenberg-support\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:2468:\"<p>10up&#8217;s Distributor plugin has exited beta and is <a href=\"https://10up.com/blog/2018/distributor-wordpress-syndication-reuse/\" rel=\"noopener noreferrer\" target=\"_blank\">now publicly available</a>. The free plugin syndicates content across WordPress multisite networks and the web. It <a href=\"https://wptavern.com/distributor-plugin-now-in-beta-a-new-wordpress-content-syndication-solution-from-10up\" rel=\"noopener noreferrer\" target=\"_blank\">went into beta</a> last year and 10up reports that more than 100 organizations and developers participated in the beta program.</p>\n<p>&#8220;We’ve already integrated many improvements contributed by beta testers, including 10up clients,&#8221;  10up President Jake Goldman said. &#8220;Distributor has been approved for use on WordPress.com VIP and is ready for enterprise implementations. We have a roadmap of planned enhancements, with ambitious plans including more advanced media distribution and sophisticated &#8216;take down&#8217; features for the forced removal of distributed content.&#8221;</p>\n<p>The public release of Distributor also introduces support for Gutenberg for the settings that are available in the edit screen. Users should be aware that this new feature is still in beta, as Gutenberg is still in active development and not has not yet been merged into WordPress core.</p>\n<a href=\"https://i1.wp.com/wptavern.com/wp-content/uploads/2018/08/distributor-gutenberg.png?ssl=1\"><img /></a>image credit: <a href=\"https://10up.com/blog/2018/distributor-wordpress-syndication-reuse/\">10up</a>\n<p>&#8220;We’ve even considered interoperability between the classic editor and Gutenberg, and instances where custom blocks are not registered on remote sites,&#8221; Goldman said. &#8220;All aspects of the user interface have been carried over to ensure a coherent and cohesive experience.&#8221;</p>\n<p>10up has also launched an Enterprise support package that offers faster response for issues, support for custom integrations, and white-labeling. Support packages fund ongoing development and customers have the opportunity to help shape the roadmap of the plugin.</p>\n<p>Distributor is available at <a href=\"http://distributorplugin.com\" rel=\"noopener noreferrer\" target=\"_blank\">distributorplugin.com</a> where users can register to get a free license key. The plugin is also <a href=\"https://github.com/10up/distributor\" rel=\"noopener noreferrer\" target=\"_blank\">available on GitHub</a>.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Wed, 29 Aug 2018 21:48:01 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:40;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:75:\"WPTavern: Gutenberg Contributors Considering a “Focus Mode” for Writing\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83525\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:80:\"https://wptavern.com/gutenberg-contributors-considering-a-focus-mode-for-writing\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:4462:\"<p>After overwhelming <a href=\"https://wordpress.org/support/plugin/gutenberg/reviews/\" rel=\"noopener noreferrer\" target=\"_blank\">feedback from testers</a> indicating that Gutenberg is not well suited for simply writing posts, the project&#8217;s contributors are considering a few options for improving the writing flow. These proposals are spread across several tickets on GitHub.</p>\n<p>Two weeks ago, Gutenberg technical lead Matias Ventura submitted a PR exploring the possibility of <a href=\"https://github.com/WordPress/gutenberg/pull/8920\" rel=\"noopener noreferrer\" target=\"_blank\">introducing a &#8220;Focus Mode&#8221; to the editor</a>. This mode would highlight the current selected block with all other blocks faded while the &#8220;fix toolbar to header&#8221; option is enabled. The video below shows an example of what that might look like:</p>\n<p></p>\n<p>&#8220;The aim is to provide a writing experience that can satisfy those that would prefer an environment with the least amount of distractions at the expense of tool clarity,&#8221; Ventura said. &#8220;I&#8217;ve been testing this and personally find it a very enjoyable mode to toggle when I just want to write for a bit. Paired with a robust set of keyboard shortcuts it could be quite nice to use. In this sense, it&#8217;d be important to provide an easy keyboard shortcut to toggle the mode on and off.&#8221;</p>\n<p>Automattic designer Kjell Reigstad opened another <a href=\"https://github.com/WordPress/gutenberg/issues/9334\" rel=\"noopener noreferrer\" target=\"_blank\">ticket</a> that proposes transforming the &#8220;Fix Toolbar to Top&#8221; setting into a &#8220;Focus Mode.&#8221;</p>\n<p>&#8220;A key feedback point we hear is that Gutenberg’s interface can be a little overwhelming,&#8221; Reigstad said. &#8220;This often comes from users who more commonly focus on &#8216;writing&#8217; versus &#8216;building&#8217; their posts. They find the contextual block controls and block hover states to be distracting: When they&#8217;re focused on writing, they don&#8217;t necessarily want to think about blocks — they just want to write.&#8221;</p>\n<p>Reigstad said this same subset of users also misses having the formatting toolbar at the top of the page, as it is in other applications like Google Docs, MS Word, and WordPress&#8217; classic editor. He proposed a solution that addresses these concerns by combining the &#8220;Fix Toolbar to Top&#8221; option with the following UI changes that would provide a more complete &#8220;Focus Mode:&#8221;</p>\n<ul>\n<li>The block toolbar would be pinned to the top of the screen.</li>\n<li>The editor would be full screen.</li>\n<li>Block outlines would be removed for both hover and selected states.</li>\n<li>The block label would appear on a delay, and be toned down visually.</li>\n<li>Block mover + block options would also appear on a delay.</li>\n</ul>\n<p>Reigstad also created a video demo of this concept:</p>\n<p></p>\n<p>This new &#8220;focus Mode&#8221; concept is also compatible with Ventura&#8217;s proposal for highlighting the current selected block and fading out the others. It could either be present in both modes or available as an add-on feature.</p>\n<p>A couple of well-written reviews on the Gutenberg plugin <a href=\"https://wordpress.org/support/topic/not-everyone-needs-everything-to-be-blocks-gutenberg-must-focus-on-writers/\" rel=\"noopener noreferrer\" target=\"_blank\">describe how the concept of blocks complicates the writing experience</a> and how Gutenberg&#8217;s current writing environment is <a href=\"https://wordpress.org/support/topic/gutenberg-gets-wordpress-wrong-and-is-a-terrible-writing-environment/\" rel=\"noopener noreferrer\" target=\"_blank\">visually distracting and disruptive</a>. This has been a major concern since the plugin was first released for testing, as there are many users who depend on WordPress for its writing features more than the page building aspects.</p>\n<p>The Gutenberg team&#8217;s new ideas go a long way towards decluttering the interface for writers. This is especially important for those who want to do their long-form writing inside WordPress, instead of beginning their work in an application that is dedicated to providing a distraction-free writing experience. Introducing a &#8220;focus mode&#8221; or &#8220;writing mode&#8221; will solve one of the most critical issues with the new editor and we&#8217;re looking forward to seeing how this develops.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Wed, 29 Aug 2018 18:32:08 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:41;a:6:{s:4:\"data\";s:11:\"\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:1:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"HeroPress: WordPress Is For You\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://heropress.com/?p=2610\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:107:\"https://heropress.com/wordpress-is-for-you/#utm_source=rss&utm_medium=rss&utm_campaign=wordpress-is-for-you\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:3215:\"<img width=\"960\" height=\"480\" src=\"https://s20094.pcdn.co/wp-content/uploads/2015/08/OpenUpDoors-1024x512.jpg\" class=\"attachment-large size-large wp-post-image\" alt=\"Pull Quote: This one simple attitude adjustment, changing “no” to “let me look into that”, opened up more doors and possibilities than I ever thought possible.\" /><p>When HeroPress started, a stated intention was to be a voice for people on the fringe of the Western WordPress culture. In my head I thought this geographical, and involved places like Africa and Asia. I quickly came to realize that everyone is on the fringe of something.</p>\n<p>This month&#8217;s HeroPress replay is titled &#8220;<a href=\"https://heropress.com/essays/doing-what-i-want/\">Doing What I Want</a>&#8221;  by Becky Davis. Becky&#8217;s an American, but she doesn&#8217;t fit the American IT worker mold of young white male. In fact, her gender and age were regular friction points in her attempts to get jobs. She&#8217;s not old by any means, but she&#8217;s not 19 either.</p>\n<p>WordPress became a place for her where things like age and gender don&#8217;t matter nearly as much as other jobs. Check out Becky&#8217;s essay and perhaps drop her a comment.</p>\n<p>&nbsp;</p>\n<blockquote class=\"wp-embedded-content\"><p><a href=\"https://heropress.com/essays/doing-what-i-want/\">Doing What I Want</a></p></blockquote>\n<p></p>\n<div class=\"rtsocial-container rtsocial-container-align-right rtsocial-horizontal\"><div class=\"rtsocial-twitter-horizontal\"><div class=\"rtsocial-twitter-horizontal-button\"><a title=\"Tweet: WordPress Is For You\" class=\"rtsocial-twitter-button\" href=\"https://twitter.com/share?text=WordPress%20Is%20For%20You&via=heropress&url=https%3A%2F%2Fheropress.com%2Fwordpress-is-for-you%2F\" rel=\"nofollow\" target=\"_blank\"></a></div></div><div class=\"rtsocial-fb-horizontal fb-light\"><div class=\"rtsocial-fb-horizontal-button\"><a title=\"Like: WordPress Is For You\" class=\"rtsocial-fb-button rtsocial-fb-like-light\" href=\"https://www.facebook.com/sharer.php?u=https%3A%2F%2Fheropress.com%2Fwordpress-is-for-you%2F\" rel=\"nofollow\" target=\"_blank\"></a></div></div><div class=\"rtsocial-linkedin-horizontal\"><div class=\"rtsocial-linkedin-horizontal-button\"><a class=\"rtsocial-linkedin-button\" href=\"https://www.linkedin.com/shareArticle?mini=true&url=https%3A%2F%2Fheropress.com%2Fwordpress-is-for-you%2F&title=WordPress+Is+For+You\" rel=\"nofollow\" target=\"_blank\" title=\"Share: WordPress Is For You\"></a></div></div><div class=\"rtsocial-pinterest-horizontal\"><div class=\"rtsocial-pinterest-horizontal-button\"><a class=\"rtsocial-pinterest-button\" href=\"https://pinterest.com/pin/create/button/?url=https://heropress.com/wordpress-is-for-you/&media=https://heropress.com/wp-content/uploads/2015/08/OpenUpDoors-150x150.jpg&description=WordPress Is For You\" rel=\"nofollow\" target=\"_blank\" title=\"Pin: WordPress Is For You\"></a></div></div><a rel=\"nofollow\" class=\"perma-link\" href=\"https://heropress.com/wordpress-is-for-you/\" title=\"WordPress Is For You\"></a></div><p>The post <a rel=\"nofollow\" href=\"https://heropress.com/wordpress-is-for-you/\">WordPress Is For You</a> appeared first on <a rel=\"nofollow\" href=\"https://heropress.com\">HeroPress</a>.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Wed, 29 Aug 2018 12:17:07 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:42;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:84:\"WPTavern: Gary Pendergast Praises ClassicPress, Extends Invitation for Collaboration\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83608\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:94:\"https://wptavern.com/gary-pendergast-praises-classicpress-extends-invitation-for-collaboration\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:2529:\"<p>Gutenberg and WordPress core contributor Gary Pendergast has <a href=\"https://pento.net/2018/08/26/forking-is-a-feature/\">weighed in</a> with this thoughts on <a href=\"https://wptavern.com/classicpress-gutenberg-not-included\">ClassicPress</a>, a fork of WordPress created by Scott Bowler. Pendergast praises the fork and extended an open invitation to Bowler to collaborate in the future. </p>\n\n<blockquote class=\"wp-block-quote\"><p>As a member of the WordPress core team, I certainly hold no ill-feelings towards them, and I hope they’ll be open to working with us in the future. I hope we’ll be able to learn from their work, to improve WordPress for everyone.</p><p>Ultimately, we all share the same goal: creating a free and open web, \nfor everyone to enjoy. While ClassicPress has styled itself as a protest\n against Gutenberg for now, I hope they’ll find their voice <em>for</em> something, instead of just <em>against</em> something.</p><cite>Gary Pendergast</cite></blockquote>\n\n<p>In the comments of the article, Pendergast <a href=\"https://pento.net/2018/08/26/forking-is-a-feature/#comment-37409\">received harsh criticism</a> for writing blog posts instead of working on Gutenberg&#8217;s 1K plus issues on GitHub. In an example of <a href=\"https://chrislema.com/grace/\">showing grace</a>, Pendergast <a href=\"https://pento.net/2018/08/26/forking-is-a-feature/#comment-37412\">responds</a> to the person&#8217;s question of whether or not Gutenberg&#8217;s development team is correctly prioritizing their time.</p>\n\n<p>&#8220;Personally, I believe we’re doing a reasonable job, though we could probably lean a little <em>more</em> towards blogging than we are now,&#8221; he said. &#8220;There’s been valid criticism that the Gutenberg team has been less communicative than it could be, which we’re working to address.&#8221;</p>\n\n<p>Additionally, Pendergast compared the number of open issues in other projects and dismissed it as a measurement of software quality or readiness. </p>\n\n<p>Personally, I miss reading blog posts about WordPress from core developers. Many of the people on the <a href=\"https://planet.wordpress.org/\">Planet WordPress feed</a> no longer work on the project or write about WordPress. </p>\n\n<p>I always enjoyed when they shared their deep knowledge of the software or explained why they decided to lead the project in a certain direction. Pendergast&#8217;s post is a breath of fresh air and something I&#8217;d like to see more often from other core contributors.<br /></p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Wed, 29 Aug 2018 04:58:49 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Jeff Chandler\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:43;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:80:\"WPTavern: New WP Glossary Site Translates WordPress Techspeak into Plain English\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83522\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:91:\"https://wptavern.com/new-wp-glossary-site-translates-wordpress-techspeak-into-plain-english\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:3701:\"<p><a href=\"http://www.andersnoren.se/\" rel=\"noopener noreferrer\" target=\"_blank\">Anders Norén</a> has launched a new website called <a href=\"https://www.wpglossary.net/\" rel=\"noopener noreferrer\" target=\"_blank\">WP Glossary</a> that contains definitions for terms that people encounter when using WordPress. The resource was born out of a need to provide documentation for client projects.</p>\n<p>&#8220;The last time I updated the glossary for a new client documentation, in the middle of May this year, it hit me that there must be a website for this,&#8221; Norén said. &#8220;A list of WordPress definitions written not for WordPress developers, but for those who manage WordPress websites either as part of their work or in their spare time.&#8221;</p>\n<p>Norén said he found resources written for developers but nothing satisfactory for regular WordPress users. Inspired to fill this gap, he bought a domain name and built the site over the next couple weeks. WP Glossary contains definitions for nearly a hundred WordPress-specific and industry-related terms, with more than 25,000 total words.</p>\n<a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/08/wp-glossary.jpg?ssl=1\"><img /></a>image credit: Anders Norén\n<p>Norén, who has recently jumped into client work with a new agency, is better known for his popular minimalist <a href=\"https://wordpress.org/themes/author/anlino/\" rel=\"noopener noreferrer\" target=\"_blank\">themes on WordPress.org</a>. His 17 themes have a cumulative rating of 4.97 out of 5 stars and <a href=\"http://wptally.com/?wpusername=anlino\" rel=\"noopener noreferrer\" target=\"_blank\">more than 2.1 million downloads</a>. He designed the WP Glossary site, wrote all the definitions, and credits <a href=\"https://twitter.com/tdh\" rel=\"noopener noreferrer\" target=\"_blank\">Thord Hedengren</a> for feedback on the design and editorial assistance.</p>\n<p>Each glossary term includes a plain English definition and common use cases with a bit of WordPress history sprinkled in. The terms also link to related documentation and some also have related WordPress.tv links. The <a href=\"https://www.wpglossary.net/word/default-themes/\" rel=\"noopener noreferrer\" target=\"_blank\">Default Themes</a> term is the longest article on the site with 1,744 words. Each term has a &#8220;Send Corrections&#8221; link that visitors can use if they see a term that could be improved.</p>\n<p>WP Glossary was enthusiastically received when Norén <a href=\"https://twitter.com/andersnoren/status/1033636227994533888/photo/1\" rel=\"noopener noreferrer\" target=\"_blank\">announced it on Twitter</a>. Many commented that the site will be useful for meetups with members who are new to WordPress and need a quick way to look up some of the jargon they encounter.</p>\n<p>Norén&#8217;s glossary project overlaps with a glossary the WordPress Marketing team <a href=\"https://make.wordpress.org/marketing/2018/02/28/wordpress-jargon-glossary/\" rel=\"noopener noreferrer\" target=\"_blank\">published</a> earlier this year. WP Glossary is more in-depth and contains less techspeak than the marketing team&#8217;s copy. It is also targeted at people who use WordPress as part of their job or as a hobby.</p>\n<p>The sheer volume of terms on this site reveals how much insider language one encounters while managing a WordPress site. If you&#8217;re working in the WordPress world every day, it&#8217;s easy to forget how unfamiliar these terms are to new users. WP Glossary is released under the Creative Commons Attribution 4.0 International license (CC BY 4.0) so freelancers and agencies that want to duplicate, modify, and share the material have permission to do so with attribution.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 28 Aug 2018 20:25:50 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:44;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:84:\"WPTavern: A Proposal for Improving the Change Block Type User Interface in Gutenberg\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83570\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:95:\"https://wptavern.com/a-proposal-for-improving-the-change-block-type-user-interface-in-gutenberg\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:3549:\"<p>In Gutenberg 3.6.2, the development team moved the Convert Block option to the left most icon in the toolbar. As long as the toolbar is visible, so is the option to change block types. However, there are a few user experience issues with this approach.<br /></p>\n\n<img />Convert Block Option\n\n<p>The first is obvious. The paragraph block icon looks like an alignment option. The second issue is that the icon represents the current block being edited, sort of like a block label. Unless a user hovers their cursor over the icon, it&#8217;s difficult to realize that it&#8217;s for changing block types. </p>\n\n<p><a href=\"https://twitter.com/kevinwhoffman\" rel=\"noreferrer noopener\" target=\"_blank\">Kevin Hoffman</a>, a WordPress developer and core contributor, <a href=\"https://github.com/WordPress/gutenberg/issues/9127#issuecomment-416058227\">has proposed</a> a new user interface suggestion that aims to solve the issues mentioned above. </p>\n\n<img />Suggested Changes by Kevin Hoffman\n\n<p>Hoffman suggests changing the icon to a drop-down menu, similar to the one in the Classic Editor. The menu would make the ability to change block types more discoverable. It removes confusion associated with icons and is a workflow that&#8217;s already established. </p>\n\n<p>Gutenberg developer Joen Asmussen <a href=\"https://github.com/WordPress/gutenberg/issues/9127#issuecomment-416166190\">thanked Hoffman</a> for the feedback and listed a number of things to consider with his approach. These include the editor&#8217;s <a href=\"https://github.com/WordPress/gutenberg/issues/7479#issuecomment-410988762\">need to be responsive</a>, <a href=\"https://github.com/WordPress/gutenberg/issues/9075\">scale to editors</a> with thin columns, accessibility, and accommodating long block names. </p>\n\n<p>Gutenberg technical lead Matías Ventura <a href=\"https://github.com/WordPress/gutenberg/issues/9127#issuecomment-416206202\">also commented</a> on the proposal.</p>\n\n<blockquote class=\"wp-block-quote\"><p>Just wanted to say thanks for all the constructive voices here and willingness to find better solutions. If there&#8217;s anything that is fairly clear is that the current &#8216;block switching&#8217; interaction is not as obvious as it could be.</p><p>I think using the paragraph icon instead of the one that is easily confused as alignment, <a href=\"https://github.com/jasmussen\">@jasmussen</a>&#8216;s update in <a href=\"https://github.com/WordPress/gutenberg/pull/9310\">#9310</a>, plus the addition of the drop-down arrow are a good baseline to check on the next release and see if we need something more involved. <a href=\"https://github.com/kevinwhoffman\">@kevinwhoffman</a> it&#8217;d be great to expand on your proposal and see how it might look across more blocks and nested contexts.</p><cite>Matías Ventura</cite></blockquote>\n\n<p>Depending on your workflow, changing block types will be a common action. For example, I often press enter at the end of a paragraph block which creates a new paragraph block automatically. Being able to easily identify and use the change block type option will improve my writing experience.<br /></p>\n\n<p>Those with feedback on Hoffman&#8217;s proposal are encouraged to <a href=\"https://github.com/WordPress/gutenberg/issues/9127\">respond to the issue</a> on GitHub. It&#8217;s also worth noting that the team is <a href=\"https://github.com/WordPress/gutenberg/pull/9310#issuecomment-416210915\">experimenting with using an icon</a> that&#8217;s designated specifically for changing block types. <br /></p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 28 Aug 2018 08:24:52 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Jeff Chandler\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:45;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:137:\"WPTavern: WordPress to Support Classic Editor for “Many Years to Come,” Plugin and Theme Markets Expected to Drive Gutenberg Adoption\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83528\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:141:\"https://wptavern.com/wordpress-to-support-classic-editor-for-many-years-to-come-plugin-and-theme-markets-expected-to-drive-gutenberg-adoption\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:7283:\"<p>During the <a href=\"https://wordpress.tv/2017/12/04/matt-mullenweg-state-of-the-word-2017/\" rel=\"noopener noreferrer\" target=\"_blank\">2017 State of the Word</a> address, Matt Mullenweg announced the availability of the <a href=\"https://wordpress.org/plugins/classic-editor/\" rel=\"noopener noreferrer\" target=\"_blank\">Classic Editor</a> plugin for site owners who are not ready to adopt Gutenberg when it makes its debut in WordPress 5.0. Since its release, the community has speculated about what the plugin&#8217;s active installation numbers mean and how long it will be supported.</p>\n<p>Matt Mullenweg has confirmed that support for the Classic Editor will be available for &#8220;many years to come,&#8221; which should come as a relief to those who feared that WordPress would drop support for the old editor after a year or two.</p>\n<p>&#8220;I love that people are using the Classic Editor plugin!&#8221; Mullenweg said in <a href=\"https://wptavern.com/gutenberg-and-classic-editor-plugins-pass-200000-active-installations-wordpress-4-9-9-planning-underway#comment-257369\" rel=\"noopener noreferrer\" target=\"_blank\">comment</a> on a recent post. &#8220;There is an infinite number of ways that WP can be used and not all will be ready for Gutenberg when 5.0 is released, Classic allows people to still be able to update core and stay current with releases, and with the click of a button try out Gutenberg again in the future if they want to. It’s also trivial to maintain because Gutenberg also uses TinyMCE, so Classic Editor users will still get improvements and updates to TinyMCE — I won’t say &#8216;forever&#8217; but I don’t see any reason why we can’t maintain classic for the edit screen for many years to come.&#8221;</p>\n<p>These assurances about the continued availability of the classic editor mean that WordPress product developers will need to decide if they want to provide support for both editing experiences or go full steam ahead with Gutenberg, limiting support to WordPress 5.0+. We don&#8217;t yet know how many users will be installing the Classic Editor after WordPress 5.0 is released but that may inform more product decisions in the future.</p>\n<h3>The Market Will Drive Gutenberg Adoption</h3>\n<p>During the Q&amp;A following the State of the Word in 2017, WordPress developer <a href=\"https://twitter.com/kevinwhoffman\" rel=\"noopener noreferrer\" target=\"_blank\">Kevin Hoffman</a> asked a question about the prospect of developers having to support two different editing interfaces:</p>\n<blockquote><p>Hearing you suggest the Classic Editor plugin and different ways to undeclare support for Gutenberg leads me to this idea that we are headed towards a split admin interface with no finality to the transition, meaning that I don&#8217;t see a time in the future where everyone will be on Gutenberg. We will always have these people in classic mode. As plugin and theme developers, we will always have to support two different types of users. How do we reach that point where we are past the transition, however long it might take, where we can not have this box of chocolates effect where you click &#8220;edit post type&#8221; and you never know what you&#8217;re going to get?</p></blockquote>\n<p>Mullenweg said his hope and expectation, based on how this has worked out with new interfaces in the past, is that over time product developers would adopt the latest interface. He cited the Customizer as one example where one is now very hard-pressed to find a theme developer who is rolling their own options panel after the Customizer was introduced as the new standard. It was just three years ago in 2015 when <a href=\"https://wptavern.com/wordpress-org-now-requires-theme-authors-to-use-the-customizer-to-build-theme-options\" rel=\"noopener noreferrer\" target=\"_blank\">WordPress.org began requiring theme options to be built using the Customizer</a> and now it is used everywhere.</p>\n<p>&#8220;The truth is, if you are a plugin or theme developer, people are going to expect things in Gutenberg, so you really need to develop for Gutenberg,&#8221; Mullenweg said. &#8220;And then, at some point, I&#8217;m totally ok if you drop support for the Classic [Editor]. There will be themes and plugins that will say you need to have Gutenberg, [WP] 5.0 or newer if you want to use this.</p>\n<p>&#8220;We already have that existing now. Plugins only support so far back in PHP in WordPress. There will be plugins that don&#8217;t support under WordPress 5.0. It&#8217;s not going to be that much different from supporting different WordPress versions where people choose sometimes to go way way way back, sometimes a year or several years, and support WordPress 3.8 and 3.9. And some don&#8217;t bother anymore. There&#8217;s lots of APIs and other things that changed during that time. At some point you just have to make a cost benefit analysis and do things like maybe Yoast is doing for upgrading PHP, and say, &#8216;Hey, if you really want the best of this, check out this new thing.\'&#8221;</p>\n<p>As Gutenberg blocks become the standard way of extending WordPress&#8217; editing and customization capabilities, the market will drive its adoption. This is already happening with new blocks and block collections being released every day. The new <a href=\"https://wptavern.com/gutenberg-block-library-provides-a-searchable-index-of-individual-blocks\" rel=\"noopener noreferrer\" target=\"_blank\">Gutenberg Block Library</a> offers a glimpse of that and there are many more blocks on GitHub that are not yet commercially marketed.</p>\n<p>During that December 2017 Q&amp;A, developers seemed to be excited about the Gutenberg demos they had just seen but their uneasiness was palpable in their questions. Now, eight months later, the current proliferation of Gutenberg themes and plugins demonstrates that WordPress developers are ready to embrace the new editor and build the creative extensions that Gutenberg&#8217;s creators&#8217; had always anticipated.</p>\n<p>&#8220;I’m really looking forward to seeing what the design and developer community can build with it and where their imaginations can take us from there,&#8221; Gutenberg technical lead Matías Ventura said when I <a href=\"https://wptavern.com/interview-with-matias-ventura-on-building-the-vision-for-gutenberg\" rel=\"noopener noreferrer\" target=\"_blank\">interviewed</a> him in June. &#8220;Core is going to supply the infrastructure and the main building blocks but it’s everything that can be built around it that’s going to be exciting, as always with WordPress.”</p>\n<p>The extension ecosystem that made WordPress a success in the first place is going to be a key influence in driving adoption for the new editor. Major players in the product market are not waiting to see how users react to the new editor before building their Gutenberg-compatible interfaces. Users may not be compelled by the writing experience, but Gutenberg&#8217;s block model will provide a better framework for site customization and a core standard for page builders that interface with WordPress. If the blocks pouring into the ecosystem right now are any indication, the plugin market surrounding Gutenberg is going to offer an exciting variety of tools for site building.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Tue, 28 Aug 2018 04:28:28 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:46;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:82:\"WPTavern: Gutenberg Block Library Provides a Searchable Index of Individual Blocks\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83507\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:93:\"https://wptavern.com/gutenberg-block-library-provides-a-searchable-index-of-individual-blocks\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:4439:\"<p>An avalanche of blocks is pouring into the WordPress ecosystem ahead of Gutenberg&#8217;s inclusion in core. A few block collections, such as Atomic Blocks, Stackable, and CoBlocks, can be found on <a href=\"https://wordpress.org/plugins/search/gutenberg+block/\" rel=\"noopener noreferrer\" target=\"_blank\">WordPress.org</a>, but it&#8217;s not easy to search the individual blocks they contain. Other collections and standalone blocks are spread across the web. WordPress theme developer <a href=\"https://twitter.com/dannycooper147\" rel=\"noopener noreferrer\" target=\"_blank\">Danny Cooper</a> has built a centralized <a href=\"https://editorblockswp.com/library\" rel=\"noopener noreferrer\" target=\"_blank\">library of Gutenberg blocks</a> that are currently available to extend the new editor.</p>\n<p>The library loads blocks into a grid with infinite scroll. It is searchable, so visitors can easily find individual blocks that are part of a collection. Blocks are also tagged, which makes it possible to compare a group of similar blocks. Individual listings display screenshots of the block in action and its settings panel, as well as a link to the author and a link to download.</p>\n<p><a href=\"https://i1.wp.com/wptavern.com/wp-content/uploads/2018/08/screely-1535383280324.png?ssl=1\"><img /></a></p>\n<p>The Gutenberg Block Library currently has more than four dozen blocks. Visitors and block creators can <a href=\"https://editorblockswp.com/submit-block/\" rel=\"noopener noreferrer\" target=\"_blank\">submit a block</a> that is missing from the library.</p>\n<p>Cooper is the owner of <a href=\"https://olympusthemes.com/\" rel=\"noopener noreferrer\" target=\"_blank\">Olympus Themes</a>, a small collection of free and commercial niche-focused WordPress themes. He has also created his own blocks collection called <a href=\"https://editorblockswp.com/\" rel=\"noopener noreferrer\" target=\"_blank\">Editor Blocks</a>, which focuses on blocks for business sites. His corresponding <a href=\"https://wordpress.org/themes/editor-blocks/\" rel=\"noopener noreferrer\" target=\"_blank\">Editor Blocks theme</a> is available for free on WordPress.org with support for all the business blocks.</p>\n<p>&#8220;As a theme developer I&#8217;d been waiting for a way to build themes in a way where what you see on the backend matches what you will see on the frontend,&#8221; Cooper said. &#8220;That can be achieved to some extent using the Customizer, but it&#8217;s hard to craft more than one complex page using that method.&#8221;</p>\n<p>Cooper comes from a PHP/jQuery background and said he didn&#8217;t have a strong enough understanding of ES6, Webpack, Babel, React to create Gutenberg blocks right away. The learning curve was a little steep but after getting a handle on the basics he is now able to make small contributions to the Gutenberg project.</p>\n<p>&#8220;It felt like I was hitting a brick wall every five minutes when I started,&#8221; he said. &#8220;<a href=\"https://gutenberg.courses/development/\" rel=\"noopener noreferrer\" target=\"_blank\">Zac Gordon&#8217;s course</a> helped me get past that stage. The #core-editor slack channel was a big help too. Other than that I just studied the code of the core blocks and used Google. As my knowledge increased I&#8217;ve tried to reach out by submitting bug reports to other Block Libraries and making minor contributions to the Gutenberg project on Github.&#8221;</p>\n<p>WordPress.org may be able to benefit from a centralized block library in the future, as people will be frequently searching for blocks after Gutenberg lands in core. Cooper said if WordPress.org had a library like this it might even be possible to find and install blocks from inside Gutenberg.</p>\n<p>&#8220;I could build a block that searches my library but it wouldn&#8217;t be able to install them as most are part of a &#8216;collection,\'&#8221; Cooper said. &#8220;I&#8217;m not sure if in the future the &#8216;collections&#8217; will continue to grow or people will move towards releasing individual blocks.&#8221;</p>\n<p>In the meantime, the Gutenberg Block Library provides a helpful resource for early adopters. Browsing through the listings, it&#8217;s exciting to see the variety of block functionality that the community is creating. Users who fully embrace Gutenberg in WordPress 5.0 will find dozens of blocks (and perhaps hundreds by that time) available for the new editor, if they know where to look.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Mon, 27 Aug 2018 16:45:26 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:47;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:26:\"Gary: Forking is a Feature\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:25:\"https://pento.net/?p=1603\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:50:\"https://pento.net/2018/08/26/forking-is-a-feature/\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:6868:\"<p>There&#8217;s a new WordPress fork called <a href=\"https://www.classicpress.net/\">ClassicPress</a> that&#8217;s been <a href=\"https://wptavern.com/classicpress-gutenberg-not-included\">making some waves</a> recently, with various members of the <a href=\"https://en.oxforddictionaries.com/definition/twitterati\">Twitterati</a> swinging between decrying it as an attempt to fracture the WordPress community, to it being an unnecessary over-reaction, to it being a death knell for WordPress.</p>\n\n<p>Personally, I don&#8217;t think it&#8217;s any of the above.</p>\n\n<p>Some years ago, <a href=\"https://twitter.com/anildash\">Anil Dash</a> wrote an article on this topic (which I totally <span>ripped</span> <em>forked</em> the name from), you should read it for some context.</p>\n\n\n<div class=\" content_cards_card content_cards_domain_anildash-com\">\n			<div class=\"content_cards_image\">\n				<a class=\"content_cards_image_link\" href=\"https://anildash.com/2010/09/10/forking_is_a_feature/\">\n					<img src=\"https://pento.net/wp-content/plugins/content-cards/skins/default/content-cards-placeholder.png\" alt=\"Forking is a Feature\" />				</a>\n		</div>\n	\n	<div class=\"content_cards_title\">\n		<a class=\"content_cards_title_link\" href=\"https://anildash.com/2010/09/10/forking_is_a_feature/\">\n			Forking is a Feature		</a>\n	</div>\n	<div class=\"content_cards_description\">\n		<a class=\"content_cards_description_link\" href=\"https://anildash.com/2010/09/10/forking_is_a_feature/\">\n			<p>While Linus Torvalds is best known as the creator of Linux, it’s one of his more geeky creations, and the social implications of its design, that may well end up being his greatest legacy. Because Linus has, in just a few short years, changed the social dynamic around forking,</p>\n		</a>\n	</div>\n	<div class=\"content_cards_site_name\">\n		<img src=\"https://anildash.com/favicon.png\" alt=\"Anil Dash\" class=\"content_cards_favicon\" />		Anil Dash	</div>\n</div>\n\n\n<p>With that context, I genuinely applaud ClassicPress for exercising their fundamental rights under the GPL. The <a href=\"https://wordpress.org/about/#bill-of-rights\">WordPress Bill of Rights</a> makes it quite clear that forking is not just allowed, it&#8217;s encouraged. You can and should fork WordPress if you choose to. This isn&#8217;t a flaw in the system, this is how it&#8217;s supposed to work.</p>\n\n<h2>Forks should aways be encouraged.</h2>\n\n<p>Forks are a fundamentally healthy aspect of Open Source software. A relatively recent example is the <a href=\"http://anandmanisankar.com/posts/nodejs-iojs-why-the-fork/\">io.js fork of Node.js</a>, which resulted in significant changes to how the Node.js project is governed and developed. WordPress has seen forks in the past, too: <a href=\"https://en.wikipedia.org/wiki/Lyceum_(software)\">Lyceum</a> was a fork that added multi-site support, before it existed in WordPress. WordPress MU was something of a sibling fork which also added multi-site support, and was ultimately merged back into WordPress.</p>\n\n<p>There are examples of forks that went on to become independent projects: WordPress itself is a fork of cafelog/b2. <a href=\"https://en.wikipedia.org/wiki/X.Org_Server#History\">X.org is a fork</a> of XFree86. LibreOffice is a fork of OpenOffice. <a href=\"https://en.wikipedia.org/wiki/Blink_(web_engine)\">Blink</a> is a fork of <a href=\"https://en.wikipedia.org/wiki/WebKit\">WebKit</a>, which in turn is a fork of <a href=\"https://en.wikipedia.org/wiki/KHTML\">KHTML</a>. MariaDB is a fork of MySQL. XBMC has been forked <a href=\"https://en.wikipedia.org/wiki/List_of_software_based_on_Kodi_and_XBMC\">dozens of times</a>. Joomla is a fork of Mambo. (Fun historical coincidence: I very nearly accepted a job offer from Miro, the company behind Mambo, just a couple of months before Joomla came into being!)</p>\n\n<h2>Maintaining a fork is hard, thankless work.</h2>\n\n<p>All of these independent forks have a common thread: they started with a group of people who were highly experienced in building the software they were forking (often comprising of core developers of the original software). That&#8217;s not to say that non-core developers can&#8217;t drive a fork, but it does seem to require fairly fundamental knowledge of the strengths and weaknesses of the software, in order to successfully fork it into an independent product.</p>\n\n<p>From a practical perspective, I can tell you that maintaining a fork of WordPress would require an extraordinary amount of work. For example, WordPress.com effectively maintains a fork (which happens to almost exactly match the Core codebase) of WordPress. The task of maintaining this fork falls to a talented team of devops folks, who review and merge each patch.</p>\n\n<p>Now, WordPress.com is really only an internal fork. To maintain a product fork of WordPress would require so much more effort. You&#8217;d need to maintain the web infrastructure to push out updates. As the fork diverges from WordPress Core, you would need to figure out how to maintain plugin and theme compatibility. You&#8217;d likely need to do your own bug and security fixes, on top of what&#8217;s merged from WordPress.</p>\n\n<p>I&#8217;m not saying this to dissuade anyone from forking WordPress, rather, it&#8217;s important to go into this aware of the challenges that lay ahead. For anyone who uses a fork (whether it be a fork of WordPress, or any other software product), I&#8217;m sure the maintainer would appreciate a word of thanks for the work they&#8217;ve done to make it possible. <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f642.png\" alt=\"🙂\" class=\"wp-smiley\" /></p>\n\n<h2>What&#8217;s next for ClassicPress?</h2>\n\n<p>Well, that&#8217;s ultimately up to the folks building it, and the people who use it. As a member of the WordPress core team, I certainly hold no ill-feelings towards them, and I hope they&#8217;ll be open to working with us in the future. I hope we&#8217;ll be able to learn from their work, to improve WordPress for everyone.</p>\n\n<p>It&#8217;s humbling and inspiring to build something that&#8217;s used by so many millions of sites, but at times it involves accepting that we can&#8217;t build the tool that will work for 100% of people, 100% of the time. Regardless of WordPress&#8217; future popularity, there&#8217;ll always be a place for alternatives, whether that be forks like ClassicPress, different CMSes like Drupal or Joomla, or even different publishing concepts, like MediaWiki or Mastodon.</p>\n\n<p>Ultimately, we all share the same goal: creating a free and open web, for everyone to enjoy. While ClassicPress has styled itself as a protest against Gutenberg for now, I hope they&#8217;ll find their voice <em>for</em> something, instead of just <em>against</em> something. <img src=\"https://s.w.org/images/core/emoji/11/72x72/1f496.png\" alt=\"💖\" class=\"wp-smiley\" /></p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Sun, 26 Aug 2018 04:57:45 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:4:\"Gary\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:48;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:57:\"WPTavern: WPCampus 2018 Videos Are Now Available to Watch\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83466\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:68:\"https://wptavern.com/wpcampus-2018-videos-are-now-available-to-watch\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:1710:\"<p>WPCampus 2018 was held July 12-14, 2018, at <a href=\"https://wustl.edu/\">Washington University</a> in St. Louis, Missouri. Educators, staff, and those in higher-education gathered to learn how WordPress can be and is used in higher-education environments. </p>\n\n<p>If you couldn&#8217;t attend in person or watch the live stream, you can now watch all of the sessions for free. Visit the event&#8217;s <a href=\"https://2018.wpcampus.org/schedule/\">schedule page</a> and click the Watch Session button. Alternatively, you can click on a session&#8217;s title to read a brief description and then watch the embedded video.</p>\n\n<p>Videos are hosted on YouTube which makes it easy to share and embed them. There are also links to view the presenter&#8217;s slides.</p>\n\n<p>If you have time, I recommend watching <a href=\"https://2018.wpcampus.org/schedule/gutenready-for-the-gutenpocalypse/\">GutenReady for the Gutenpocalypse</a> by Brian DeConinck and Jennifer McFarland who work at North Carolina State University in the Information and Technology Department. </p>\n\n<p>In this presentation, the duo explain what they&#8217;re doing to get staff, students, and campus sites prepared for Gutenberg. <br /></p>\n\n\n\n\n\n<p>In addition to the presentation above, I also recommend listening to <a href=\"https://wptavern.com/wpweekly-episode-324-getting-nc-state-gutenready\">episode 324</a> of WordPress Weekly where McFarland describes their experience so far in transitioning sites to Gutenberg, building custom blocks, and discussing what the future of themes might be like once the project is merged into WordPress. </p>\n\n<p>WPCampus organizers are in the beginning stages of planning next year&#8217;s event. </p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Fri, 24 Aug 2018 19:10:47 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Jeff Chandler\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}i:49;a:6:{s:4:\"data\";s:13:\"\n	\n	\n	\n	\n	\n	\n\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";s:5:\"child\";a:2:{s:0:\"\";a:5:{s:5:\"title\";a:1:{i:0;a:5:{s:4:\"data\";s:115:\"WPTavern: Gutenberg and Classic Editor Plugins Pass 200,000 Active Installations, WordPress 4.9.9 Planning Underway\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"guid\";a:1:{i:0;a:5:{s:4:\"data\";s:29:\"https://wptavern.com/?p=83475\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:4:\"link\";a:1:{i:0;a:5:{s:4:\"data\";s:124:\"https://wptavern.com/gutenberg-and-classic-editor-plugins-pass-200000-active-installations-wordpress-4-9-9-planning-underway\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:11:\"description\";a:1:{i:0;a:5:{s:4:\"data\";s:6122:\"<a href=\"https://i2.wp.com/wptavern.com/wp-content/uploads/2018/08/printing-letters.jpg?ssl=1\"><img /></a>photo credit: reingestalter <a href=\"http://www.flickr.com/photos/44668468@N00/115805043\">numeral types</a> &#8211; <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">(license)</a>\n<p>It has been three weeks since the &#8220;Try Gutenberg&#8221; prompt was sent out in WordPress 4.9.8 and the <a href=\"https://wordpress.org/plugins/gutenberg/\" rel=\"noopener noreferrer\" target=\"_blank\">plugin</a> has now passed 200,000 active installations. The callout has increased the visibility of the Gutenberg project and brought necessary feedback to the development and design of the new editor.</p>\n<p>Prior to WordPress 4.9.8, Gutenberg reviews held a 2.7-star average on WordPress.org. Negative reviews continue to pour in and the average rating has slipped to 2.3 stars. Users are reporting that the new editor is too complicated, cumbersome, and that it offers an inferior writing experience. A few positive reviews are sprinkled in between, calling the editor a &#8220;necessary step forward,&#8221; and those reviewers seem hopeful that others will feel the same once they get past the learning curve. The vast majority of reviews, both positive and negative, report that Gutenberg&#8217;s interface is not yet intuitive to use.</p>\n<p><a href=\"https://i0.wp.com/wptavern.com/wp-content/uploads/2018/08/Screen-Shot-2018-08-24-at-10.32.49-AM.png?ssl=1\"><img /></a></p>\n<p>The Gutenberg team&#8217;s responses to reviews have improved to be less &#8220;canned&#8221; since the <a href=\"https://wptavern.com/gutenberg-plugin-garners-mixed-reactions-from-new-wave-of-testers\" rel=\"noopener noreferrer\" target=\"_blank\">initial reactions</a> a few days after the Gutenprompt went out. However, the team still appears to be combing the feedback for bugs with the existing interface. Overall, the team&#8217;s responses are unified in a general unwillingness to admit that there are critical flaws preventing the interface from being more well-received.</p>\n<p>Active installations of the <a href=\"https://wordpress.org/plugins/classic-editor/\" rel=\"noopener noreferrer\" target=\"_blank\">Classic Editor</a> plugin, the official antidote for those do not wish to adopt Gutenberg when it ships in WordPress 5.0, have climbed to more than 200,000. This number is about equal to the number of sites that have Gutenberg active. The Gutenberg team does not view Classic Editor installs as an important metric for understanding Gutenberg adoption or rejection but rather see these installs as a healthy intermediary step for sites keeping the same workflow while preparing for Gutenberg.</p>\n<p>In response to recent discussion surrounding the <a href=\"https://wptavern.com/classicpress-gutenberg-not-included\" rel=\"noopener noreferrer\" target=\"_blank\">ClassicPress fork of WordPress</a>, Matt Mullenweg <a href=\"https://wptavern.com/classicpress-gutenberg-not-included#comment-256813\" rel=\"noopener noreferrer\" target=\"_blank\">said</a>, &#8220;No plans to ever have direct vote determine strategic direction in WP, but we are having a bit of a referendum in the adoption of the Gutenberg and Classic Editor plugins, people are voting with their usage. The people are deciding.&#8221;</p>\n<p>This is essentially true in that users can decide if they want to adopt Gutenberg or not, for as long as the Classic Editor is supported. The Classic Editor plugin is an option people demanded but now the reality of two different admin experiences is nearer than before. The notion of a fork, though perhaps not a serious threat to the project, makes it painfully clear what some users are willing to do in order to avoid Gutenberg.</p>\n<p>With the number of Classic Editor plugin installations on the rise, WordPress is headed towards a fractured admin experience. For some it may be a healthy transition option, but in the end, the number of Classic Editor installations indicates how many sites will be running an alternative editing experience because site owners are either not ready or not willing to adopt Gutenberg.</p>\n<p>At some point in the future, WordPress will need to unite the editing experience, either by winning these users over to Gutenberg or by discontinuing support for the Classic Editor. In the meantime, WordPress product developers will need to provide support for both editing experiences or go all in on one or the other. It has the potential to erode WordPress&#8217; momentum for a few years, especially if Gutenberg doesn&#8217;t become more intuitive.</p>\n<h3>WordPress 4.9.9 Is Expected to be a 6-8 Week Maintenance Cycle</h3>\n<p>WordPress contributors met this week to <a href=\"https://make.wordpress.org/core/2018/08/24/dev-chat-summary-august-22-2018-4-9-9-weeks-1-2/\" rel=\"noopener noreferrer\" target=\"_blank\">discuss WordPress 4.9.9</a>.</p>\n<p>&#8220;As of now there’s no specific timeline for 4.9.9,&#8221; Jeff Paul said. &#8220;That will get set once release leads are in place. However, I’d like to try and finalize leads in next week’s meeting or shortly thereafter so that we can begin 4.9.9 planning and coordination as we get into September.&#8221; Paul requested contributor submit nominations for release leads, for themselves or others, ahead of next week&#8217;s meeting.</p>\n<p>&#8220;Until we have a confirmed timeline and plan for 5.0, my assumption is that we’ll continue with our minor release cadence of ~6-8 weeks with specific focus on items needed in support of 5.0,&#8221; Paul said.</p>\n<p>During his announcement at WordCamp Europe in Belgrade, Matt Mullenweg said WordPress 5.0 could happen as early as August. It&#8217;s now looking more likely that 5.0 will drop closer to the end of the year. This gives WordPress users and developers more time to prepare their sites to be compatible with Gutenberg and ready to take advantage of the new features it offers. The <a href=\"https://make.wordpress.org/core/5-0/\" rel=\"noopener noreferrer\" target=\"_blank\">schedule for releasing WordPress 5.0</a> is not yet set but the release is expected to happen in 2018.</p>\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}s:7:\"pubDate\";a:1:{i:0;a:5:{s:4:\"data\";s:31:\"Fri, 24 Aug 2018 18:55:12 +0000\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}s:32:\"http://purl.org/dc/elements/1.1/\";a:1:{s:7:\"creator\";a:1:{i:0;a:5:{s:4:\"data\";s:13:\"Sarah Gooding\";s:7:\"attribs\";a:0:{}s:8:\"xml_base\";s:0:\"\";s:17:\"xml_base_explicit\";b:0;s:8:\"xml_lang\";s:0:\"\";}}}}}}}}}}}}}}}}s:4:\"type\";i:128;s:7:\"headers\";O:42:\"Requests_Utility_CaseInsensitiveDictionary\":1:{s:7:\"\0*\0data\";a:8:{s:6:\"server\";s:5:\"nginx\";s:4:\"date\";s:29:\"Tue, 25 Sep 2018 17:38:20 GMT\";s:12:\"content-type\";s:8:\"text/xml\";s:4:\"vary\";s:15:\"Accept-Encoding\";s:13:\"last-modified\";s:29:\"Tue, 25 Sep 2018 17:30:28 GMT\";s:15:\"x-frame-options\";s:10:\"SAMEORIGIN\";s:4:\"x-nc\";s:9:\"HIT ord 1\";s:16:\"content-encoding\";s:4:\"gzip\";}}s:5:\"build\";s:14:\"20180925173700\";}', 'no');
INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(135, '_transient_timeout_feed_mod_d117b5738fbd35bd8c0391cda1f2b5d9', '1537940304', 'no'),
(136, '_transient_feed_mod_d117b5738fbd35bd8c0391cda1f2b5d9', '1537897104', 'no'),
(137, '_transient_timeout_dash_v2_8ed47f02370e4304b3fb8352267b4572', '1537940304', 'no'),
(138, '_transient_dash_v2_8ed47f02370e4304b3fb8352267b4572', '<div class=\"rss-widget\"><ul><li><a class=\'rsswidget\' href=\'https://es.wordpress.org/2018/08/03/wordpress-4-9-8-version-de-mantenimiento/\'>WordPress 4.9.8 – Versión de mantenimiento</a></li></ul></div><div class=\"rss-widget\"><ul><li><a class=\'rsswidget\' href=\'https://wptavern.com/gutenberg-3-9-introduces-reusable-exportable-templates-for-multiple-blocks\'>WPTavern: Gutenberg 3.9 Introduces Reusable, Exportable Templates for Multiple Blocks</a></li><li><a class=\'rsswidget\' href=\'https://wptavern.com/new-commonwp-plugin-enables-wordpress-sites-to-use-the-free-jsdelivr-cdn\'>WPTavern: New commonWP Plugin Enables WordPress Sites to Use the Free jsDelivr CDN</a></li><li><a class=\'rsswidget\' href=\'https://wptavern.com/gutenstats-blog-is-live-tracking-gutenberg-beta-testing-data\'>WPTavern: Gutenstats Blog Is Live, Tracking Gutenberg Beta Testing Data</a></li></ul></div>', 'no'),
(139, '_site_transient_update_core', 'O:8:\"stdClass\":4:{s:7:\"updates\";a:1:{i:0;O:8:\"stdClass\":10:{s:8:\"response\";s:6:\"latest\";s:8:\"download\";s:59:\"https://downloads.wordpress.org/release/wordpress-4.9.8.zip\";s:6:\"locale\";s:5:\"es_CO\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:59:\"https://downloads.wordpress.org/release/wordpress-4.9.8.zip\";s:10:\"no_content\";s:70:\"https://downloads.wordpress.org/release/wordpress-4.9.8-no-content.zip\";s:11:\"new_bundled\";s:71:\"https://downloads.wordpress.org/release/wordpress-4.9.8-new-bundled.zip\";s:7:\"partial\";b:0;s:8:\"rollback\";b:0;}s:7:\"current\";s:5:\"4.9.8\";s:7:\"version\";s:5:\"4.9.8\";s:11:\"php_version\";s:5:\"5.2.4\";s:13:\"mysql_version\";s:3:\"5.0\";s:11:\"new_bundled\";s:3:\"4.7\";s:15:\"partial_version\";s:0:\"\";}}s:12:\"last_checked\";i:1537898637;s:15:\"version_checked\";s:5:\"4.9.8\";s:12:\"translations\";a:0:{}}', 'no'),
(140, 'auto_core_update_notified', 'a:4:{s:4:\"type\";s:7:\"success\";s:5:\"email\";s:23:\"jefferariza@outlook.com\";s:7:\"version\";s:5:\"4.9.8\";s:9:\"timestamp\";i:1537897111;}', 'no'),
(143, 'current_theme', 'Illdy', 'yes'),
(144, 'theme_mods_illdy', 'a:66:{i:0;b:0;s:18:\"nav_menu_locations\";a:0:{}s:18:\"custom_css_post_id\";i:-1;s:37:\"illdy_jumbotron_enable_featured_image\";i:1;s:24:\"illdy_about_general_show\";i:1;s:38:\"illdy_jumbotron_enable_parallax_effect\";i:1;s:29:\"illdy_jumbotron_general_image\";s:85:\"http://127.0.0.1/wordpress/wordpress/wp-content/uploads/2018/09/259777-P4JTS2-110.jpg\";s:25:\"illdy_about_general_title\";s:7:\"About 2\";s:25:\"illdy_about_general_entry\";s:360:\"It is an amazing one-page theme with great features that offers an incredible experience. It is easy to install, make changes, adapt for your business. A modern design with clean lines and styling for a wide variety of content, exactly how a business design should be. You can add as many images as you want to the main header area and turn them into slider. s\";s:23:\"illdy_projects_lightbox\";i:1;s:28:\"illdy_projects_general_title\";s:10:\"Projects s\";s:22:\"illdy_services_general\";i:1;s:28:\"illdy_services_general_title\";s:8:\"Services\";s:28:\"illdy_services_general_entry\";s:113:\"In order to help you grow your business, our carefully selected experts can advise you in in the following areas:\";s:22:\"illdy_preloader_enable\";i:1;s:32:\"illdy_preloader_background_color\";s:7:\"#ffffff\";s:29:\"illdy_preloader_primary_color\";s:7:\"#f1d204\";s:30:\"illdy_preloader_secondly_color\";s:7:\"#ffffff\";s:15:\"illdy_text_logo\";s:5:\"Illdy\";s:30:\"illdy_contact_bar_facebook_url\";s:1:\"#\";s:29:\"illdy_contact_bar_twitter_url\";s:1:\"#\";s:30:\"illdy_contact_bar_linkedin_url\";s:1:\"#\";s:11:\"illdy_email\";s:16:\"contact@site.com\";s:11:\"illdy_phone\";s:14:\"(555) 555-5555\";s:14:\"illdy_address1\";s:26:\"Street 221B Baker Street, \";s:14:\"illdy_address2\";s:10:\"London, UK\";s:38:\"illdy_general_footer_display_copyright\";i:1;s:22:\"illdy_footer_copyright\";s:43:\"&copy; Copyright 2016. All Rights Reserved.\";s:21:\"illdy_img_footer_logo\";s:90:\"http://127.0.0.1/wordpress/wordpress/wp-content/themes/illdy/layout/images/footer-logo.png\";s:38:\"illdy_enable_post_posted_on_blog_posts\";i:1;s:37:\"illdy_enable_post_category_blog_posts\";i:1;s:33:\"illdy_enable_post_tags_blog_posts\";i:1;s:37:\"illdy_enable_post_comments_blog_posts\";i:1;s:38:\"illdy_enable_social_sharing_blog_posts\";i:1;s:34:\"illdy_enable_author_box_blog_posts\";i:1;s:23:\"illdy_team_general_show\";i:1;s:24:\"illdy_team_general_title\";s:4:\"Team\";s:24:\"illdy_team_general_entry\";s:71:\"Meet the people that are going to take your business to the next level.\";s:31:\"illdy_testimonials_general_show\";i:1;s:32:\"illdy_testimonials_general_title\";s:12:\"Testimonials\";s:34:\"illdy_testimonials_number_of_posts\";i:4;s:29:\"illdy_contact_us_general_show\";i:1;s:30:\"illdy_contact_us_general_title\";s:10:\"Contact us\";s:30:\"illdy_contact_us_general_entry\";s:45:\"And we will get in touch as soon as possible.\";s:38:\"illdy_contact_us_general_address_title\";s:7:\"Address\";s:47:\"illdy_contact_us_general_customer_support_title\";s:16:\"Customer Support\";s:26:\"illdy_counter_general_show\";i:1;s:29:\"illdy_counter_background_type\";s:5:\"image\";s:30:\"illdy_counter_background_image\";s:108:\"http://127.0.0.1/wordpress/wordpress/wp-content/themes/illdy/layout/images/front-page/front-page-counter.jpg\";s:30:\"illdy_counter_background_color\";s:7:\"#000000\";s:29:\"illdy_jumbotron_general_entry\";s:148:\"lldy is a great one-page theme, perfect for developers and designers but also for someone who just wants a new website for his business. Try it now!\";s:42:\"illdy_jumbotron_general_first_button_title\";s:10:\"Learn more\";s:45:\"illdyilldy_jumbotron_general_first_button_url\";s:1:\"#\";s:43:\"illdy_jumbotron_general_second_button_title\";s:8:\"Download\";s:46:\"illdyilldy_jumbotron_general_second_button_url\";s:1:\"#\";s:30:\"illdy_latest_news_general_show\";i:1;s:31:\"illdy_latest_news_general_title\";s:11:\"Latest News\";s:31:\"illdy_latest_news_general_entry\";s:119:\"If you are interested in the latest articles in the industry, take a sneak peek at our blog. You have nothing to loose!\";s:29:\"illdy_latest_news_button_text\";s:8:\"See blog\";s:33:\"illdy_latest_news_number_of_posts\";i:3;s:27:\"illdy_projects_general_show\";i:1;s:28:\"illdy_projects_general_entry\";s:35:\"You\'ll love our work. Check it out!\";s:24:\"illdy_frontpage_sections\";a:9:{i:0;s:17:\"illdy_panel_about\";i:1;s:20:\"illdy_panel_projects\";i:2;s:26:\"illdy_testimonials_general\";i:3;s:20:\"illdy_panel_services\";i:4;s:25:\"illdy_latest_news_general\";i:5;s:21:\"illdy_counter_general\";i:6;s:16:\"illdy_panel_team\";i:7;s:16:\"illdy_contact_us\";i:8;s:16:\"illdy_full_width\";}s:21:\"illdy_jumbotron_title\";s:85:\"Clean<span class=\"span-dot\">.</span>Slick<span class=\"span-dot\">.</span>Pixel Perfect\";s:30:\"illdy_full_width_general_title\";s:3:\"map\";s:30:\"illdy_full_width_general_entry\";s:0:\"\";}', 'yes'),
(145, 'theme_switched', '', 'yes'),
(149, '_transient_timeout_illdy_plugin_information_transient_kiwi-social-share', '1537899121', 'no'),
(150, '_transient_illdy_plugin_information_transient_kiwi-social-share', 'O:8:\"stdClass\":18:{s:4:\"name\";s:64:\"Kiwi Social Share &#8211; Social Media Share Buttons &amp; Icons\";s:4:\"slug\";s:17:\"kiwi-social-share\";s:7:\"version\";s:5:\"2.0.8\";s:6:\"author\";s:54:\"<a href=\"https://www.machothemes.com\">Macho Themes</a>\";s:14:\"author_profile\";s:47:\"https://profiles.wordpress.org/cristianraiber-1\";s:12:\"requires_php\";b:0;s:7:\"ratings\";a:5:{i:5;i:10;i:4;i:0;i:3;i:2;i:2;i:0;i:1;i:0;}s:11:\"num_ratings\";i:12;s:15:\"support_threads\";i:3;s:24:\"support_threads_resolved\";i:3;s:8:\"homepage\";s:45:\"https://www.machothemes.com/kiwi-social-share\";s:8:\"sections\";a:5:{s:11:\"description\";s:1947:\"<p>This is by far the best &amp; easiest to use WordPress social media share plugin. A WordPress share plugin with custom icons built-in.</p>\n<h4>Plugin Options</h4>\n<ul>\n<li>Social networks available: Facebook, Twitter, LinkedIN, Pinterest, Google Plus and Flint.</li>\n<li>Turn on/off each of them, individually.</li>\n<li>Great UI with intuitive &amp; simple options.</li>\n<li>Built for the regular user.</li>\n<li>Change the style of the article bar group.</li>\n<li>Display the number of counts next to the social network icon.</li>\n<li>Enable/disable the floating bar.</li>\n<li>Change the shape of the floating bar’s social buttons.</li>\n<li>Add social identities.</li>\n<li>Add a &#8220;Click to tweet&#8221; button in WordPress editor.</li>\n<li>Google Analytics tracking.</li>\n<li>Four different Skins.</li>\n<li>The default, square style.</li>\n<li>The more futuristic approach, shift style.</li>\n<li>The friendly approach, pill (rounded corners) style.</li>\n<li>The eye-catching approach, leaf style (like a leaf in the wind).</li>\n<li>Display social icons: before content, after content or both.</li>\n<li>Amazing loading speed.</li>\n</ul>\n<h4>WordPress Social Media Widget (for website)</h4>\n<p>A WordPress Social Media Widget solution is coming soon, stay tuned.</p>\n<p><strong>About us:</strong></p>\n<p>We are a young team of WordPress aficionados who love building WordPress plugins &amp; <a href=\"https://www.machothemes.com/\" title=\"Premium WordPress themes\" rel=\"friend nofollow\">Premium WordPress themes</a> over on our theme shop. We’re also blogging and wish to help our users find the best <a href=\"https://www.machothemes.com/blog/cheap-wordpress-hosting/\" title=\"Cheap WordPress Hosting\" rel=\"friend nofollow\">Cheap WordPress hosting</a> &amp; the best <a href=\"https://www.machothemes.com/blog/best-free-wordpress-bootstrap-themes/\" title=\"Bootstrap WordPress themes\" rel=\"friend nofollow\">Bootstrap WordPress Themes</a>.</p>\n\";s:12:\"installation\";s:328:\"<p>This section describes how to install the plugin and get it working.</p>\n<ol>\n<li>Upload the whole contents of the folder <code>kiwi-social-share</code> to the <code>/wp-content/plugins/</code> directory</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress</li>\n<li>Enjoy using it 🙂</li>\n</ol>\n\";s:3:\"faq\";s:514:\"<p>Available filters (used for frontend rendering)<br />\nArticle Bar Filters<br />\n    kiwi_article_bar_list_custom_class<br />\n    kiwi_before_article_bar<br />\n    kiwi_before_first_article_bar_item<br />\n    kiwi_after_last_article_bar_item<br />\n    kiwi_after_article_bar</p>\n<p>Floating Bar Filters<br />\n    kiwi_floating_bar_list_custom_class<br />\n    kiwi_before_floating_bar<br />\n    kiwi_before_first_floating_bar_item<br />\n    kiwi_after_last_floating_bar_item<br />\n    kiwi_after_floating_bar</p>\n\";s:9:\"changelog\";s:2098:\"<h4>2.0.8</h4>\n<ul>\n<li>Added Fintel network</li>\n</ul>\n<h4>2.0.7</h4>\n<ul>\n<li>added uninstall feedback</li>\n</ul>\n<h4>2.0.6</h4>\n<ul>\n<li>WP 4.9 compatibility</li>\n<li>Remove url encode on twitter button</li>\n<li>WhatsApp button didn&#8217;t look alright on fit</li>\n</ul>\n<h4>2.0.4</h4>\n<ul>\n<li>Removed box shadow in the admin window</li>\n<li>Changed how URLS are encoded for text</li>\n<li>WhatsApp icon visibility is now handled with CSS ( wp_is_mobile function would not work on websites with cache )</li>\n</ul>\n<h4>2.0.3</h4>\n<ul>\n<li>Saving settings would cause errors on some servers</li>\n</ul>\n<h4>2.0.2</h4>\n<ul>\n<li>Ajax request failed on license activation</li>\n</ul>\n<h4>2.0.1</h4>\n<ul>\n<li>Minor bugs</li>\n</ul>\n<h4>2.0.0</h4>\n<ul>\n<li>Major upgrade</li>\n</ul>\n<h4>1.0.4</h4>\n<ul>\n<li>When checked, the Google+ icon wasn’t showing up. Fix provided via GitHub by @smartinsalmeida</li>\n</ul>\n<h4>1.0.3</h4>\n<ul>\n<li>Increased the weight on the front-end selectors so that margin &amp; padding are harder to get overwritten by themes. Feels like some themes don&#8217;t want to play nice</li>\n</ul>\n<h4>1.0.2</h4>\n<ul>\n<li>Fixed a small bug where content wasn&#8217;t being returned if kiwi was turned off on posts and pages.</li>\n<li>Added share bar margins top/bottom.</li>\n<li>Fixed a small rendering bug in the back-end for images.</li>\n<li>Fixed a small bug where content wasn&#8217;t being returned on !is_singular() pages (archives)</li>\n</ul>\n<h4>1.0.1</h4>\n<ul>\n<li>Replaced Kiwi Logo with Dashicons icon</li>\n<li>Fixed a small bug with the notifications bar overlapping the form badge</li>\n<li>Enhanced the way we control sortables. When you disable a radio within a sortable, that sortable gets it’s opacity lowered.</li>\n<li>Properly formatted JS code with PHPStorm formatting.</li>\n<li>Small assets/back-end/images/ re-organization. Now, social icons have been renamed and moved into their own folder.</li>\n<li>Slightly re-worked the sortable/draggable field to support icons. No more CSS background images</li>\n</ul>\n<h4>1.0.0</h4>\n<ul>\n<li>Initial release</li>\n</ul>\n\";s:11:\"screenshots\";s:477:\"<ol><li><a href=\"https://ps.w.org/kiwi-social-share/assets/screenshot-1.png?rev=1650215\"><img src=\"https://ps.w.org/kiwi-social-share/assets/screenshot-1.png?rev=1650215\" alt=\"Screenshot of the back-end User Interface. All options are displayed above the fold (no scrolling, no fiddling around). Really easy to use.\"></a><p>Screenshot of the back-end User Interface. All options are displayed above the fold (no scrolling, no fiddling around). Really easy to use.</p></li></ol>\";}s:17:\"short_description\";s:135:\"This is by far the best free WordPress share plugin. It is simple yet does exactly what it should with plenty of customisation options.\";s:13:\"download_link\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.8.zip\";s:11:\"screenshots\";a:1:{i:1;a:2:{s:3:\"src\";s:70:\"https://ps.w.org/kiwi-social-share/assets/screenshot-1.png?rev=1650215\";s:7:\"caption\";s:139:\"Screenshot of the back-end User Interface. All options are displayed above the fold (no scrolling, no fiddling around). Really easy to use.\";}}s:8:\"versions\";a:7:{s:5:\"2.0.0\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.0.zip\";s:5:\"2.0.3\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.3.zip\";s:5:\"2.0.4\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.4.zip\";s:5:\"2.0.5\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.5.zip\";s:5:\"2.0.7\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.7.zip\";s:5:\"2.0.8\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.8.zip\";s:5:\"trunk\";s:60:\"https://downloads.wordpress.org/plugin/kiwi-social-share.zip\";}s:5:\"icons\";a:2:{s:2:\"1x\";s:70:\"https://ps.w.org/kiwi-social-share/assets/icon-256x256.png?rev=1445882\";s:2:\"2x\";s:70:\"https://ps.w.org/kiwi-social-share/assets/icon-256x256.png?rev=1445882\";}s:12:\"contributors\";a:0:{}}', 'no'),
(153, 'recently_activated', 'a:0:{}', 'yes'),
(154, 'widget_illdy_recent_posts', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(155, 'widget_illdy_skill', 'a:4:{s:12:\"_multiwidget\";i:1;i:2;a:4:{s:5:\"title\";s:10:\"Typography\";s:10:\"percentage\";i:60;s:4:\"icon\";s:10:\"fa fa-font\";s:5:\"color\";s:7:\"#f18b6d\";}i:3;a:4:{s:5:\"title\";s:6:\"Design\";s:10:\"percentage\";i:82;s:4:\"icon\";s:12:\"fa fa-pencil\";s:5:\"color\";s:7:\"#f1d204\";}i:4;a:4:{s:5:\"title\";s:11:\"Development\";s:10:\"percentage\";i:86;s:4:\"icon\";s:10:\"fa fa-code\";s:5:\"color\";s:7:\"#6a4d8a\";}}', 'yes'),
(156, 'widget_illdy_project', 'a:5:{s:12:\"_multiwidget\";i:1;i:3;a:3:{s:5:\"title\";s:9:\"Project 1\";s:5:\"image\";s:91:\"https://cdn.colorlib.com/illdy/wp-content/uploads/sites/11/2016/03/front-page-project-1.jpg\";s:3:\"url\";s:0:\"\";}i:4;a:3:{s:5:\"title\";s:9:\"Project 2\";s:5:\"image\";s:91:\"https://cdn.colorlib.com/illdy/wp-content/uploads/sites/11/2016/03/front-page-project-2.jpg\";s:3:\"url\";s:0:\"\";}i:5;a:3:{s:5:\"title\";s:9:\"Project 3\";s:5:\"image\";s:91:\"https://cdn.colorlib.com/illdy/wp-content/uploads/sites/11/2016/03/front-page-project-3.jpg\";s:3:\"url\";s:0:\"\";}i:6;a:3:{s:5:\"title\";s:9:\"Project 4\";s:5:\"image\";s:91:\"https://cdn.colorlib.com/illdy/wp-content/uploads/sites/11/2016/03/front-page-project-4.jpg\";s:3:\"url\";s:0:\"\";}}', 'yes'),
(157, 'widget_illdy_service', 'a:4:{s:12:\"_multiwidget\";i:1;i:2;a:4:{s:5:\"title\";s:10:\"Web Design\";s:4:\"icon\";s:12:\"fa fa-pencil\";s:5:\"entry\";s:185:\"Consectetur adipiscing elit. Praesent molestie urna hendrerit erat tincidunt tempus. Aliquam a leo risus. Fusce a metus non augue dapibus porttitor at in mauris. Pellentesque commodo...\";s:5:\"color\";s:7:\"#f18b6d\";}i:3;a:4:{s:5:\"title\";s:15:\"WEB DEVELOPMENT\";s:4:\"icon\";s:10:\"fa fa-code\";s:5:\"entry\";s:185:\"Consectetur adipiscing elit. Praesent molestie urna hendrerit erat tincidunt tempus. Aliquam a leo risus. Fusce a metus non augue dapibus porttitor at in mauris. Pellentesque commodo...\";s:5:\"color\";s:7:\"#f1d204\";}i:4;a:4:{s:5:\"title\";s:12:\"SEO Analisys\";s:4:\"icon\";s:12:\"fa fa-search\";s:5:\"entry\";s:185:\"Consectetur adipiscing elit. Praesent molestie urna hendrerit erat tincidunt tempus. Aliquam a leo risus. Fusce a metus non augue dapibus porttitor at in mauris. Pellentesque commodo...\";s:5:\"color\";s:7:\"#6a4d8a\";}}', 'yes'),
(158, 'widget_illdy_counter', 'a:4:{s:12:\"_multiwidget\";i:1;i:4;a:5:{s:5:\"title\";s:8:\"Projects\";s:9:\"data_from\";i:1;s:7:\"data_to\";i:260;s:10:\"data_speed\";i:2000;s:21:\"data_refresh_interval\";i:100;}i:3;a:5:{s:5:\"title\";s:7:\"Clients\";s:9:\"data_from\";i:1;s:7:\"data_to\";i:120;s:10:\"data_speed\";i:2000;s:21:\"data_refresh_interval\";i:100;}i:2;a:5:{s:5:\"title\";s:6:\"Coffes\";s:9:\"data_from\";i:1;s:7:\"data_to\";i:260;s:10:\"data_speed\";i:2000;s:21:\"data_refresh_interval\";i:100;}}', 'yes'),
(159, 'widget_illdy_person', 'a:4:{s:12:\"_multiwidget\";i:1;i:5;a:8:{s:5:\"title\";s:13:\"Mark Lawrance\";s:5:\"image\";s:101:\"https://cdn.colorlib.com/illdy/wp-content/themes/illdy/layout/images/front-page/front-page-team-1.jpg\";s:8:\"position\";s:12:\"Web Designer\";s:5:\"entry\";s:42:\"Creative, detail-oriented, always focused.\";s:12:\"facebook_url\";s:1:\"#\";s:11:\"twitter_url\";s:1:\"#\";s:12:\"linkedin_url\";s:1:\"#\";s:5:\"color\";s:7:\"#f18b6d\";}i:4;a:8:{s:5:\"title\";s:12:\"Jane Stenton\";s:5:\"image\";s:101:\"https://cdn.colorlib.com/illdy/wp-content/themes/illdy/layout/images/front-page/front-page-team-2.jpg\";s:8:\"position\";s:14:\"SEO Specialist\";s:5:\"entry\";s:59:\"Curious, tech-geeck and gets serious when it comes to work.\";s:12:\"facebook_url\";s:1:\"#\";s:11:\"twitter_url\";s:1:\"#\";s:12:\"linkedin_url\";s:1:\"#\";s:5:\"color\";s:7:\"#f1d204\";}i:2;a:8:{s:5:\"title\";s:10:\"John Smith\";s:5:\"image\";s:101:\"https://cdn.colorlib.com/illdy/wp-content/themes/illdy/layout/images/front-page/front-page-team-3.jpg\";s:8:\"position\";s:9:\"Developer\";s:5:\"entry\";s:51:\"Enthusiastic, passionate with great sense of humor.\";s:12:\"facebook_url\";s:1:\"#\";s:11:\"twitter_url\";s:1:\"#\";s:12:\"linkedin_url\";s:1:\"#\";s:5:\"color\";s:7:\"#6a4d8a\";}}', 'yes'),
(160, 'widget_illdy_home_parallax', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(161, 'widget_illdy_testimonial', 'a:3:{s:12:\"_multiwidget\";i:1;i:1;a:3:{s:4:\"name\";s:10:\"Jane Smith\";s:5:\"image\";s:108:\"https://cdn.colorlib.com/illdy/wp-content/themes/illdy/layout/images/front-page/front-page-testimonial-1.jpg\";s:11:\"testimonial\";s:445:\"                    Awesome theme with great design and helpfull support. If you don’t know how to code your own WordPress theme, but you still want a good-looking website for your business, Illdy might be exactly what you need. It is a slick theme with a lot of of features to choose from. You can customize whatever section you want and you can rest assure that no matter what device your website is viewed on – it looks great.            \";}i:2;a:3:{s:4:\"name\";s:10:\"Jane Smith\";s:5:\"image\";s:90:\"https://cdn.colorlib.com/illdy/wp-content/uploads/sites/11/2016/02/mike-muller-127x127.jpg\";s:11:\"testimonial\";s:445:\"                    Awesome theme with great design and helpfull support. If you don’t know how to code your own WordPress theme, but you still want a good-looking website for your business, Illdy might be exactly what you need. It is a slick theme with a lot of of features to choose from. You can customize whatever section you want and you can rest assure that no matter what device your website is viewed on – it looks great.            \";}}', 'yes'),
(162, '_transient_timeout_plugin_slugs', '1537985059', 'no'),
(163, '_transient_plugin_slugs', 'a:4:{i:0;s:19:\"akismet/akismet.php\";i:1;s:36:\"contact-form-7/wp-contact-form-7.php\";i:2;s:9:\"hello.php\";i:3;s:35:\"illdy-companion/illdy-companion.php\";}', 'no'),
(176, '_site_transient_update_plugins', 'O:8:\"stdClass\":5:{s:12:\"last_checked\";i:1537898658;s:7:\"checked\";a:4:{s:19:\"akismet/akismet.php\";s:5:\"4.0.2\";s:36:\"contact-form-7/wp-contact-form-7.php\";s:5:\"5.0.4\";s:9:\"hello.php\";s:3:\"1.6\";s:35:\"illdy-companion/illdy-companion.php\";s:5:\"2.1.1\";}s:8:\"response\";a:1:{s:19:\"akismet/akismet.php\";O:8:\"stdClass\":12:{s:2:\"id\";s:21:\"w.org/plugins/akismet\";s:4:\"slug\";s:7:\"akismet\";s:6:\"plugin\";s:19:\"akismet/akismet.php\";s:11:\"new_version\";s:5:\"4.0.8\";s:3:\"url\";s:38:\"https://wordpress.org/plugins/akismet/\";s:7:\"package\";s:56:\"https://downloads.wordpress.org/plugin/akismet.4.0.8.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:59:\"https://ps.w.org/akismet/assets/icon-256x256.png?rev=969272\";s:2:\"1x\";s:59:\"https://ps.w.org/akismet/assets/icon-128x128.png?rev=969272\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:61:\"https://ps.w.org/akismet/assets/banner-772x250.jpg?rev=479904\";}s:11:\"banners_rtl\";a:0:{}s:6:\"tested\";s:5:\"4.9.8\";s:12:\"requires_php\";b:0;s:13:\"compatibility\";O:8:\"stdClass\":0:{}}}s:12:\"translations\";a:0:{}s:9:\"no_update\";a:3:{s:36:\"contact-form-7/wp-contact-form-7.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:28:\"w.org/plugins/contact-form-7\";s:4:\"slug\";s:14:\"contact-form-7\";s:6:\"plugin\";s:36:\"contact-form-7/wp-contact-form-7.php\";s:11:\"new_version\";s:5:\"5.0.4\";s:3:\"url\";s:45:\"https://wordpress.org/plugins/contact-form-7/\";s:7:\"package\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.5.0.4.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:66:\"https://ps.w.org/contact-form-7/assets/icon-256x256.png?rev=984007\";s:2:\"1x\";s:66:\"https://ps.w.org/contact-form-7/assets/icon-128x128.png?rev=984007\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:69:\"https://ps.w.org/contact-form-7/assets/banner-1544x500.png?rev=860901\";s:2:\"1x\";s:68:\"https://ps.w.org/contact-form-7/assets/banner-772x250.png?rev=880427\";}s:11:\"banners_rtl\";a:0:{}}s:9:\"hello.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:25:\"w.org/plugins/hello-dolly\";s:4:\"slug\";s:11:\"hello-dolly\";s:6:\"plugin\";s:9:\"hello.php\";s:11:\"new_version\";s:3:\"1.6\";s:3:\"url\";s:42:\"https://wordpress.org/plugins/hello-dolly/\";s:7:\"package\";s:58:\"https://downloads.wordpress.org/plugin/hello-dolly.1.6.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:63:\"https://ps.w.org/hello-dolly/assets/icon-256x256.jpg?rev=969907\";s:2:\"1x\";s:63:\"https://ps.w.org/hello-dolly/assets/icon-128x128.jpg?rev=969907\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:65:\"https://ps.w.org/hello-dolly/assets/banner-772x250.png?rev=478342\";}s:11:\"banners_rtl\";a:0:{}}s:35:\"illdy-companion/illdy-companion.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:29:\"w.org/plugins/illdy-companion\";s:4:\"slug\";s:15:\"illdy-companion\";s:6:\"plugin\";s:35:\"illdy-companion/illdy-companion.php\";s:11:\"new_version\";s:5:\"2.1.1\";s:3:\"url\";s:46:\"https://wordpress.org/plugins/illdy-companion/\";s:7:\"package\";s:58:\"https://downloads.wordpress.org/plugin/illdy-companion.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:68:\"https://ps.w.org/illdy-companion/assets/icon-256x256.jpg?rev=1492620\";s:2:\"1x\";s:68:\"https://ps.w.org/illdy-companion/assets/icon-256x256.jpg?rev=1492620\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:70:\"https://ps.w.org/illdy-companion/assets/banner-772x250.jpg?rev=1492620\";}s:11:\"banners_rtl\";a:0:{}}}}', 'no'),
(177, '_site_transient_update_themes', 'O:8:\"stdClass\":4:{s:12:\"last_checked\";i:1537898638;s:7:\"checked\";a:4:{s:5:\"illdy\";s:5:\"2.1.1\";s:13:\"twentyfifteen\";s:3:\"1.9\";s:15:\"twentyseventeen\";s:3:\"1.4\";s:13:\"twentysixteen\";s:3:\"1.4\";}s:8:\"response\";a:3:{s:13:\"twentyfifteen\";a:4:{s:5:\"theme\";s:13:\"twentyfifteen\";s:11:\"new_version\";s:3:\"2.0\";s:3:\"url\";s:43:\"https://wordpress.org/themes/twentyfifteen/\";s:7:\"package\";s:59:\"https://downloads.wordpress.org/theme/twentyfifteen.2.0.zip\";}s:15:\"twentyseventeen\";a:4:{s:5:\"theme\";s:15:\"twentyseventeen\";s:11:\"new_version\";s:3:\"1.7\";s:3:\"url\";s:45:\"https://wordpress.org/themes/twentyseventeen/\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/theme/twentyseventeen.1.7.zip\";}s:13:\"twentysixteen\";a:4:{s:5:\"theme\";s:13:\"twentysixteen\";s:11:\"new_version\";s:3:\"1.5\";s:3:\"url\";s:43:\"https://wordpress.org/themes/twentysixteen/\";s:7:\"package\";s:59:\"https://downloads.wordpress.org/theme/twentysixteen.1.5.zip\";}}s:12:\"translations\";a:0:{}}', 'no'),
(178, 'illdy_backup_settings', '18', 'yes'),
(179, 'wpcf7', 'a:2:{s:7:\"version\";s:5:\"5.0.4\";s:13:\"bulk_validate\";a:4:{s:9:\"timestamp\";i:1537898659;s:7:\"version\";s:5:\"5.0.4\";s:11:\"count_valid\";i:1;s:13:\"count_invalid\";i:0;}}', 'yes'),
(180, 'illdy_show_required_actions', 'a:1:{s:24:\"illdy-req-import-content\";b:1;}', 'yes'),
(181, '_transient_timeout_illdy_plugin_information_transient_contact-form-7', '1537900467', 'no'),
(182, '_transient_illdy_plugin_information_transient_contact-form-7', 'O:8:\"stdClass\":18:{s:4:\"name\";s:14:\"Contact Form 7\";s:4:\"slug\";s:14:\"contact-form-7\";s:7:\"version\";s:5:\"5.0.4\";s:6:\"author\";s:62:\"<a href=\"https://ideasilo.wordpress.com/\">Takayuki Miyoshi</a>\";s:14:\"author_profile\";s:43:\"https://profiles.wordpress.org/takayukister\";s:12:\"requires_php\";b:0;s:7:\"ratings\";a:5:{i:5;i:1076;i:4;i:111;i:3;i:35;i:2;i:30;i:1;i:118;}s:11:\"num_ratings\";i:1370;s:15:\"support_threads\";i:466;s:24:\"support_threads_resolved\";i:116;s:8:\"homepage\";s:25:\"https://contactform7.com/\";s:8:\"sections\";a:5:{s:11:\"description\";s:2779:\"<p>Contact Form 7 can manage multiple contact forms, plus you can customize the form and the mail contents flexibly with simple markup. The form supports Ajax-powered submitting, CAPTCHA, Akismet spam filtering and so on.</p>\n<h4>Docs &amp; Support</h4>\n<p>You can find <a href=\"https://contactform7.com/docs/\" rel=\"nofollow\">docs</a>, <a href=\"https://contactform7.com/faq/\" rel=\"nofollow\">FAQ</a> and more detailed information about Contact Form 7 on <a href=\"https://contactform7.com/\" rel=\"nofollow\">contactform7.com</a>. If you were unable to find the answer to your question on the FAQ or in any of the documentation, you should check the <a href=\"https://wordpress.org/support/plugin/contact-form-7/\" rel=\"nofollow\">support forum</a> on WordPress.org. If you can&#8217;t locate any topics that pertain to your particular issue, post a new topic for it.</p>\n<h4>Contact Form 7 Needs Your Support</h4>\n<p>It is hard to continue development and support for this free plugin without contributions from users like you. If you enjoy using Contact Form 7 and find it useful, please consider <a href=\"https://contactform7.com/donate/\" rel=\"nofollow\"><strong>making a donation</strong></a>. Your donation will help encourage and support the plugin&#8217;s continued development and better user support.</p>\n<h4>Privacy Notices</h4>\n<p>With the default configuration, this plugin, in itself, does not:</p>\n<ul>\n<li>track users by stealth;</li>\n<li>write any user personal data to the database;</li>\n<li>send any data to external servers;</li>\n<li>use cookies.</li>\n</ul>\n<p>If you activate certain features in this plugin, the contact form submitter&#8217;s personal data, including their IP address, may be sent to the service provider. Thus, confirming the provider&#8217;s privacy policy is recommended. These features include:</p>\n<ul>\n<li>reCAPTCHA (<a href=\"https://policies.google.com/?hl=en\" rel=\"nofollow\">Google</a>)</li>\n<li>Akismet (<a href=\"https://automattic.com/privacy/\" rel=\"nofollow\">Automattic</a>)</li>\n</ul>\n<h4>Recommended Plugins</h4>\n<p>The following plugins are recommended for Contact Form 7 users:</p>\n<ul>\n<li><a href=\"https://wordpress.org/plugins/flamingo/\">Flamingo</a> by Takayuki Miyoshi &#8211; With Flamingo, you can save submitted messages via contact forms in the database.</li>\n<li><a href=\"https://wordpress.org/plugins/bogo/\">Bogo</a> by Takayuki Miyoshi &#8211; Bogo is a straight-forward multilingual plugin that doesn&#8217;t cause headaches.</li>\n</ul>\n<h4>Translations</h4>\n<p>You can <a href=\"https://contactform7.com/translating-contact-form-7/\" rel=\"nofollow\">translate Contact Form 7</a> on <a href=\"https://translate.wordpress.org/projects/wp-plugins/contact-form-7\" rel=\"nofollow\"><strong>translate.wordpress.org</strong></a>.</p>\n\";s:12:\"installation\";s:414:\"<ol>\n<li>Upload the entire <code>contact-form-7</code> folder to the <code>/wp-content/plugins/</code> directory.</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress.</li>\n</ol>\n<p>You will find &#8216;Contact&#8217; menu in your WordPress admin panel.</p>\n<p>For basic usage, you can also have a look at the <a href=\"https://contactform7.com/\" rel=\"nofollow\">plugin web site</a>.</p>\n\";s:3:\"faq\";s:902:\"<p>Do you have questions or issues with Contact Form 7? Use these support channels appropriately.</p>\n<ol>\n<li><a href=\"https://contactform7.com/docs/\" rel=\"nofollow\">Docs</a></li>\n<li><a href=\"https://contactform7.com/faq/\" rel=\"nofollow\">FAQ</a></li>\n<li><a href=\"https://wordpress.org/support/plugin/contact-form-7/\" rel=\"nofollow\">Support Forum</a></li>\n</ol>\n<p><a href=\"https://contactform7.com/support/\" rel=\"nofollow\">Support</a></p>\n\n<h4>Installation Instructions</h4>\n<p>\n<ol>\n<li>Upload the entire <code>contact-form-7</code> folder to the <code>/wp-content/plugins/</code> directory.</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress.</li>\n</ol>\n<p>You will find &#8216;Contact&#8217; menu in your WordPress admin panel.</p>\n<p>For basic usage, you can also have a look at the <a href=\"https://contactform7.com/\" rel=\"nofollow\">plugin web site</a>.</p>\n</p>\n\n\";s:9:\"changelog\";s:3628:\"<p>For more information, see <a href=\"https://contactform7.com/category/releases/\" rel=\"nofollow\">Releases</a>.</p>\n<h4>5.0.4</h4>\n<ul>\n<li>Specifies the capability_type argument explicitly in the register_post_type() call to fix the privilege escalation vulnerability issue.</li>\n<li>Local File Attachment – disallows the specifying of absolute file paths referring to files outside the wp-content directory.</li>\n<li>Config Validator – adds a test item to detect invalid file attachment settings.</li>\n<li>Fixes a bug in the JavaScript fallback function for legacy browsers that do not support the HTML5 placeholder attribute.</li>\n<li>Acceptance Checkbox – unsets the form-tag&#8217;s do-not-store feature.</li>\n</ul>\n<h4>5.0.3</h4>\n<ul>\n<li>CSS: Applies the &#8220;not-allowed&#8221; cursor style to submit buttons in the &#8220;disabled&#8221; state.</li>\n<li>Acceptance Checkbox: Revises the tag-generator UI to encourage the use of better options in terms of personal data protection.</li>\n<li>Introduces wpcf7_anonymize_ip_addr() function.</li>\n<li>Introduces the consent_for:storage option for all types of form-tags.</li>\n</ul>\n<h4>5.0.2</h4>\n<ul>\n<li>Added the Privacy Notices section to the readme.txt file.</li>\n<li>Updated the Information meta-box content.</li>\n<li>Use get_user_locale() instead of get_locale() where it is more appropriate.</li>\n<li>Acceptance Checkbox: Reset submit buttons’ disabled status after a successful submission.</li>\n</ul>\n<h4>5.0.1</h4>\n<ul>\n<li>Fixed incorrect uses of _n().</li>\n<li>Config validation: Fixed incorrect count of alerts in the Additional Settings tab panel.</li>\n<li>Config validation: Fixed improper treatment for the [_site_admin_email] special mail-tag in the From mail header field.</li>\n<li>Acceptance checkbox: The class and id attributes specified were applied to the wrong HTML element.</li>\n<li>Config validation: When there is an additional mail header for mailboxes like Cc or Reply-To, but it has a possible empty value, “Invalid mailbox syntax is used” error will be returned.</li>\n<li>Explicitly specify the fourth parameter of add_action() to avoid passing unintended parameter values.</li>\n<li>Check if the target directory is empty before removing the directory.</li>\n</ul>\n<h4>5.0</h4>\n<ul>\n<li>Additional settings: on_sent_ok and on_submit have been removed.</li>\n<li>New additional setting: skip_mail</li>\n<li>Flamingo: Inbound channel title changes in conjunction with a change in the title of the corresponding contact form.</li>\n<li>DOM events: Make an entire API response object accessible through the event.detail.apiResponse property.</li>\n<li>HTML mail: Adds language-related attributes to the HTML header.</li>\n<li>File upload: Sets the accept attribute to an uploading field.</li>\n<li>Introduces the WPCF7_MailTag class.</li>\n<li>Allows aborting a mail-sending attempt using the wpcf7_before_send_mail action hook. Also, you can set a custom status and a message through the action hook.</li>\n<li>Acceptance checkbox: Allows the specifying of a statement of conditions in the form-tag’s content part.</li>\n<li>Acceptance checkbox: Supports the optional option.</li>\n<li>New special mail tags: [_site_title], [_site_description], [_site_url], [_site_admin_email], [_invalid_fields], [_user_login], [_user_email], [_user_url], [_user_first_name], [_user_last_name], [_user_nickname], and [_user_display_name]</li>\n<li>New filter hooks: wpcf7_upload_file_name, wpcf7_autop_or_not, wpcf7_posted_data_{$type}, and wpcf7_mail_tag_replaced_{$type}</li>\n<li>New form-tag features: zero-controls-container and not-for-mail</li>\n</ul>\n\";s:11:\"screenshots\";s:225:\"<ol><li><a href=\"https://ps.w.org/contact-form-7/assets/screenshot-1.png?rev=1176454\"><img src=\"https://ps.w.org/contact-form-7/assets/screenshot-1.png?rev=1176454\" alt=\"screenshot-1.png\"></a><p>screenshot-1.png</p></li></ol>\";}s:17:\"short_description\";s:54:\"Just another contact form plugin. Simple but flexible.\";s:13:\"download_link\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.5.0.4.zip\";s:11:\"screenshots\";a:1:{i:1;a:2:{s:3:\"src\";s:67:\"https://ps.w.org/contact-form-7/assets/screenshot-1.png?rev=1176454\";s:7:\"caption\";s:16:\"screenshot-1.png\";}}s:8:\"versions\";a:131:{s:3:\"1.1\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.1.1.zip\";s:4:\"1.10\";s:62:\"https://downloads.wordpress.org/plugin/contact-form-7.1.10.zip\";s:8:\"1.10.0.1\";s:66:\"https://downloads.wordpress.org/plugin/contact-form-7.1.10.0.1.zip\";s:6:\"1.10.1\";s:64:\"https://downloads.wordpress.org/plugin/contact-form-7.1.10.1.zip\";s:3:\"1.2\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.1.2.zip\";s:3:\"1.3\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.1.3.zip\";s:5:\"1.3.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.3.1.zip\";s:5:\"1.3.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.3.2.zip\";s:3:\"1.4\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.1.4.zip\";s:5:\"1.4.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.4.1.zip\";s:5:\"1.4.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.4.2.zip\";s:5:\"1.4.3\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.4.3.zip\";s:5:\"1.4.4\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.4.4.zip\";s:3:\"1.5\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.1.5.zip\";s:3:\"1.6\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.1.6.zip\";s:5:\"1.6.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.6.1.zip\";s:3:\"1.7\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.1.7.zip\";s:5:\"1.7.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.7.1.zip\";s:5:\"1.7.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.7.2.zip\";s:5:\"1.7.4\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.7.4.zip\";s:5:\"1.7.5\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.7.5.zip\";s:5:\"1.7.6\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.7.6.zip\";s:7:\"1.7.6.1\";s:65:\"https://downloads.wordpress.org/plugin/contact-form-7.1.7.6.1.zip\";s:5:\"1.7.7\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.7.7.zip\";s:7:\"1.7.7.1\";s:65:\"https://downloads.wordpress.org/plugin/contact-form-7.1.7.7.1.zip\";s:5:\"1.7.8\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.7.8.zip\";s:3:\"1.8\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.1.8.zip\";s:7:\"1.8.0.1\";s:65:\"https://downloads.wordpress.org/plugin/contact-form-7.1.8.0.1.zip\";s:7:\"1.8.0.2\";s:65:\"https://downloads.wordpress.org/plugin/contact-form-7.1.8.0.2.zip\";s:7:\"1.8.0.3\";s:65:\"https://downloads.wordpress.org/plugin/contact-form-7.1.8.0.3.zip\";s:7:\"1.8.0.4\";s:65:\"https://downloads.wordpress.org/plugin/contact-form-7.1.8.0.4.zip\";s:5:\"1.8.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.8.1.zip\";s:7:\"1.8.1.1\";s:65:\"https://downloads.wordpress.org/plugin/contact-form-7.1.8.1.1.zip\";s:3:\"1.9\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.1.9.zip\";s:5:\"1.9.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.9.1.zip\";s:5:\"1.9.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.9.2.zip\";s:7:\"1.9.2.1\";s:65:\"https://downloads.wordpress.org/plugin/contact-form-7.1.9.2.1.zip\";s:7:\"1.9.2.2\";s:65:\"https://downloads.wordpress.org/plugin/contact-form-7.1.9.2.2.zip\";s:5:\"1.9.3\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.9.3.zip\";s:5:\"1.9.4\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.9.4.zip\";s:5:\"1.9.5\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.1.9.5.zip\";s:7:\"1.9.5.1\";s:65:\"https://downloads.wordpress.org/plugin/contact-form-7.1.9.5.1.zip\";s:3:\"2.0\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.2.0.zip\";s:8:\"2.0-beta\";s:66:\"https://downloads.wordpress.org/plugin/contact-form-7.2.0-beta.zip\";s:5:\"2.0.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.0.1.zip\";s:5:\"2.0.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.0.2.zip\";s:5:\"2.0.3\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.0.3.zip\";s:5:\"2.0.4\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.0.4.zip\";s:5:\"2.0.5\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.0.5.zip\";s:5:\"2.0.6\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.0.6.zip\";s:5:\"2.0.7\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.0.7.zip\";s:3:\"2.1\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.2.1.zip\";s:5:\"2.1.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.1.1.zip\";s:5:\"2.1.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.1.2.zip\";s:3:\"2.2\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.2.2.zip\";s:5:\"2.2.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.2.1.zip\";s:3:\"2.3\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.2.3.zip\";s:5:\"2.3.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.3.1.zip\";s:3:\"2.4\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.2.4.zip\";s:5:\"2.4.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.4.1.zip\";s:5:\"2.4.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.4.2.zip\";s:5:\"2.4.3\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.4.3.zip\";s:5:\"2.4.4\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.4.4.zip\";s:5:\"2.4.5\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.4.5.zip\";s:5:\"2.4.6\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.2.4.6.zip\";s:3:\"3.0\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.3.0.zip\";s:8:\"3.0-beta\";s:66:\"https://downloads.wordpress.org/plugin/contact-form-7.3.0-beta.zip\";s:5:\"3.0.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.0.1.zip\";s:5:\"3.0.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.0.2.zip\";s:7:\"3.0.2.1\";s:65:\"https://downloads.wordpress.org/plugin/contact-form-7.3.0.2.1.zip\";s:3:\"3.1\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.3.1.zip\";s:5:\"3.1.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.1.1.zip\";s:5:\"3.1.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.1.2.zip\";s:3:\"3.2\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.3.2.zip\";s:5:\"3.2.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.2.1.zip\";s:3:\"3.3\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.3.3.zip\";s:5:\"3.3.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.3.1.zip\";s:5:\"3.3.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.3.2.zip\";s:5:\"3.3.3\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.3.3.zip\";s:3:\"3.4\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.3.4.zip\";s:5:\"3.4.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.4.1.zip\";s:5:\"3.4.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.4.2.zip\";s:3:\"3.5\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.3.5.zip\";s:5:\"3.5.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.5.1.zip\";s:5:\"3.5.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.5.2.zip\";s:5:\"3.5.3\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.5.3.zip\";s:5:\"3.5.4\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.5.4.zip\";s:3:\"3.6\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.3.6.zip\";s:3:\"3.7\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.3.7.zip\";s:5:\"3.7.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.7.1.zip\";s:5:\"3.7.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.7.2.zip\";s:3:\"3.8\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.3.8.zip\";s:5:\"3.8.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.8.1.zip\";s:3:\"3.9\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.3.9.zip\";s:8:\"3.9-beta\";s:66:\"https://downloads.wordpress.org/plugin/contact-form-7.3.9-beta.zip\";s:5:\"3.9.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.9.1.zip\";s:5:\"3.9.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.9.2.zip\";s:5:\"3.9.3\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.3.9.3.zip\";s:3:\"4.0\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.4.0.zip\";s:5:\"4.0.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.0.1.zip\";s:5:\"4.0.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.0.2.zip\";s:5:\"4.0.3\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.0.3.zip\";s:3:\"4.1\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.4.1.zip\";s:8:\"4.1-beta\";s:66:\"https://downloads.wordpress.org/plugin/contact-form-7.4.1-beta.zip\";s:5:\"4.1.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.1.1.zip\";s:5:\"4.1.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.1.2.zip\";s:3:\"4.2\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.4.2.zip\";s:8:\"4.2-beta\";s:66:\"https://downloads.wordpress.org/plugin/contact-form-7.4.2-beta.zip\";s:5:\"4.2.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.2.1.zip\";s:5:\"4.2.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.2.2.zip\";s:3:\"4.3\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.4.3.zip\";s:5:\"4.3.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.3.1.zip\";s:3:\"4.4\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.4.4.zip\";s:5:\"4.4.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.4.1.zip\";s:5:\"4.4.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.4.2.zip\";s:3:\"4.5\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.4.5.zip\";s:5:\"4.5.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.5.1.zip\";s:3:\"4.6\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.4.6.zip\";s:5:\"4.6.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.6.1.zip\";s:3:\"4.7\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.4.7.zip\";s:3:\"4.8\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.4.8.zip\";s:5:\"4.8.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.8.1.zip\";s:3:\"4.9\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.4.9.zip\";s:5:\"4.9.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.9.1.zip\";s:5:\"4.9.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.4.9.2.zip\";s:3:\"5.0\";s:61:\"https://downloads.wordpress.org/plugin/contact-form-7.5.0.zip\";s:5:\"5.0.1\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.5.0.1.zip\";s:5:\"5.0.2\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.5.0.2.zip\";s:5:\"5.0.3\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.5.0.3.zip\";s:5:\"5.0.4\";s:63:\"https://downloads.wordpress.org/plugin/contact-form-7.5.0.4.zip\";s:5:\"trunk\";s:57:\"https://downloads.wordpress.org/plugin/contact-form-7.zip\";}s:5:\"icons\";a:2:{s:2:\"1x\";s:66:\"https://ps.w.org/contact-form-7/assets/icon-128x128.png?rev=984007\";s:2:\"2x\";s:66:\"https://ps.w.org/contact-form-7/assets/icon-256x256.png?rev=984007\";}s:12:\"contributors\";a:0:{}}', 'no'),
(183, '_transient_timeout_illdy_plugin_information_transient_simple-custom-post-order', '1537900468', 'no');
INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(184, '_transient_illdy_plugin_information_transient_simple-custom-post-order', 'O:8:\"stdClass\":18:{s:4:\"name\";s:24:\"Simple Custom Post Order\";s:4:\"slug\";s:24:\"simple-custom-post-order\";s:7:\"version\";s:5:\"2.3.2\";s:6:\"author\";s:47:\"<a href=\"https://colorlib.com/wp/\">Colorlib</a>\";s:14:\"author_profile\";s:39:\"https://profiles.wordpress.org/hsameerc\";s:12:\"requires_php\";b:0;s:7:\"ratings\";a:5:{i:5;i:102;i:4;i:4;i:3;i:5;i:2;i:2;i:1;i:14;}s:11:\"num_ratings\";i:127;s:15:\"support_threads\";i:1;s:24:\"support_threads_resolved\";i:0;s:8:\"homepage\";s:58:\"https://wordpress.org/plugins-wp/simple-custom-post-order/\";s:8:\"sections\";a:5:{s:11:\"description\";s:416:\"<p>Order posts(posts, any custom post types) using a Drag and Drop Sortable JavaScript. Configuration is unnecessary. You can do directly on default WordPress administration.<br />\nExcluding custom query which uses order or orderby parameters, in get_posts or query_posts and so on.</p>\n<p>This plugins is now supported and maintained by <a href=\"//colorlib.com/wp/“\" rel=\"“friend” nofollow\">Colorlib</a>.</p>\n\";s:12:\"installation\";s:188:\"<ol>\n<li>Upload <code>plugin-name.php</code> to the <code>/wp-content/plugins/</code> directory</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress</li>\n</ol>\n\";s:3:\"faq\";s:322:\"\n<h4>Installation Instructions</h4>\n<p>\n<ol>\n<li>Upload <code>plugin-name.php</code> to the <code>/wp-content/plugins/</code> directory</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress</li>\n</ol>\n</p>\n<h4>A question that someone might have</h4>\n<p>\n<p>An answer to that question.</p>\n</p>\n\n\";s:9:\"changelog\";s:1137:\"<h4>Version 1.0 (20-07-2013)</h4>\n<ul>\n<li>Initial release.</li>\n</ul>\n<h4>Version 1.5 (25-07-2013)</h4>\n<ul>\n<li>Fix : fix errors</li>\n<li>Added Taxonomy Sort</li>\n<li>Added Taxonomy Sort option In setting Page</li>\n</ul>\n<h4>Version 2.0 (22-11-2013)</h4>\n<ul>\n<li>Fixed Undefined Notice Error in wp version 3.7.1</li>\n<li>Taxonomy Activate Checkbox removed.</li>\n</ul>\n<h4>Version 2.1 (31-12-2013)</h4>\n<ul>\n<li>Prevent Breaking autocomplete </li>\n</ul>\n<h4>Version 2.2 (02-07-2014)</h4>\n<ul>\n<li>Fixed bug: Custom Query which uses &#8216;order&#8217; or &#8216;orderby&#8217; parameters is preferred</li>\n<li>It does not depend on the designation manner of arguments( Parameters ). ( $args = &#8216;orderby=&amp;order=&#8217; or $args = array( &#8216;orderby&#8217; =&gt; &#8221;, &#8216;order&#8217; =&gt; &#8221; ) )</li>\n<li>Previous Versions Issues were Improved.</li>\n<li>Removed Taxonomy Sort( Will add in next Version 🙂 )</li>\n</ul>\n<h4>Version 2.3 (24-03-2014)</h4>\n<ul>\n<li>Fixed major bug on taxonomy and post order</li>\n</ul>\n<h4>Version 2.3.2 (17-03-2017)</h4>\n<ul>\n<li>Minor documentation and readme tweaks</li>\n</ul>\n\";s:11:\"screenshots\";s:656:\"<ol><li><a href=\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-1.png?rev=1859717\"><img src=\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-1.png?rev=1859717\" alt=\"screenshot-1\"></a><p>screenshot-1</p></li><li><a href=\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-3.png?rev=1859717\"><img src=\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-3.png?rev=1859717\" alt=\"\"></a></li><li><a href=\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-2.png?rev=1859717\"><img src=\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-2.png?rev=1859717\" alt=\"screenshot-2\"></a><p>screenshot-2</p></li></ol>\";}s:17:\"short_description\";s:114:\"Order posts(posts, any custom post types) using a Drag and Drop Sortable JavaScript. Configuration is unnecessary.\";s:13:\"download_link\";s:67:\"https://downloads.wordpress.org/plugin/simple-custom-post-order.zip\";s:11:\"screenshots\";a:3:{i:1;a:2:{s:3:\"src\";s:76:\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-1.png?rev=1859717\";s:7:\"caption\";s:12:\"screenshot-1\";}i:3;a:2:{s:3:\"src\";s:76:\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-3.png?rev=1859717\";s:7:\"caption\";s:0:\"\";}i:2;a:2:{s:3:\"src\";s:76:\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-2.png?rev=1859717\";s:7:\"caption\";s:12:\"screenshot-2\";}}s:8:\"versions\";a:5:{s:3:\"1.0\";s:71:\"https://downloads.wordpress.org/plugin/simple-custom-post-order.1.0.zip\";s:3:\"1.5\";s:71:\"https://downloads.wordpress.org/plugin/simple-custom-post-order.1.5.zip\";s:3:\"2.0\";s:71:\"https://downloads.wordpress.org/plugin/simple-custom-post-order.2.0.zip\";s:3:\"2.1\";s:71:\"https://downloads.wordpress.org/plugin/simple-custom-post-order.2.1.zip\";s:3:\"2.2\";s:71:\"https://downloads.wordpress.org/plugin/simple-custom-post-order.2.2.zip\";}s:5:\"icons\";a:2:{s:2:\"1x\";s:77:\"https://ps.w.org/simple-custom-post-order/assets/icon-256x256.jpg?rev=1859717\";s:2:\"2x\";s:77:\"https://ps.w.org/simple-custom-post-order/assets/icon-256x256.jpg?rev=1859717\";}s:12:\"contributors\";a:0:{}}', 'no'),
(185, '_transient_timeout_illdy_plugin_information_transient_fancybox-for-wordpress', '1537900469', 'no'),
(186, '_transient_illdy_plugin_information_transient_fancybox-for-wordpress', 'O:8:\"stdClass\":18:{s:4:\"name\";s:22:\"FancyBox for WordPress\";s:4:\"slug\";s:22:\"fancybox-for-wordpress\";s:7:\"version\";s:6:\"3.0.13\";s:6:\"author\";s:44:\"<a href=\"https://colorlib.com/\">Colorlib</a>\";s:14:\"author_profile\";s:46:\"https://profiles.wordpress.org/colorlibplugins\";s:12:\"requires_php\";b:0;s:7:\"ratings\";a:5:{i:5;i:32;i:4;i:3;i:3;i:1;i:2;i:1;i:1;i:7;}s:11:\"num_ratings\";i:44;s:15:\"support_threads\";i:1;s:24:\"support_threads_resolved\";i:0;s:8:\"homepage\";s:53:\"https://wordpress.org/plugins/fancybox-for-wordpress/\";s:8:\"sections\";a:5:{s:11:\"description\";s:2139:\"<p>Seamlessly integrates FancyBox into your blog: Upload, activate, and you&#8217;re done. Additional configuration optional.</p>\n<p>You can easily customize almost anything you can think about fancybox lightbox: the border, margin width and color, zoom speed, animation type, close button position, overlay color and opacity and even more advanced option like several options to group images into galleries, and more&#8230;</p>\n<p>By default, the plugin will use jQuery to apply FancyBox to ANY thumbnails that link directly to an image. This includes posts, the sidebar, etc, so you can activate it and it will be applied automatically.</p>\n<h4>Demo</h4>\n<p>You can see the plugin working on a <a href=\"http://blog.moskis.net/2012/01/20/teclado-apple-en-windows-7/\" rel=\"nofollow\">this blog</a> although there&#8217;s nothing amazing to see, just a FancyBox simple implementation, that&#8217;s the point 😉 You can take a look at the code if you&#8217;re curious, though.</p>\n<h4>Further Reading</h4>\n<p>This plugin is developed and maintained by Colorlib. Which is well know for their free <a href=\"https://colorlib.com/wp/themes/\" rel=\"nofollow\"></a>WordPress themes. However, now they are looking to extend their presence in plugin development and believe that FancyBox lightbox is a great way to start.</p>\n<p>If you are new to WordPress and want to lear more we have got you covered. Colorlib will teach you have to <a href=\"https://colorlib.com/\" rel=\"nofollow\">start a blog</a> or <a href=\"https://colorlib.com/wp/how-to-make-a-website/\" rel=\"nofollow\">create a website</a> and much more. If you are already familiar with WordPress you likely want to learn how to make it faster and more reliable. That&#8217;s when you want to look into hosting and more specifically <a href=\"http://colorlib.com/wp/wordpress-hosting\" rel=\"nofollow\">WordPress hosting</a>.</p>\n<p>If you enjoy using FancyBox lightbox for WordPress please leave a <a href=\"https://wordpress.org/support/plugin/fancybox-for-wordpress/reviews/?filter=5\" rel=\"nofollow\">positive feedback</a>. We are committed to make it the best lightbox plugin for WordPress.</p>\n\";s:12:\"installation\";s:455:\"<ol>\n<li>Upload the <code>fancybox-for-wordpress</code> folder to the <code>/wp-content/plugins/</code> directory</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress</li>\n<li>That&#8217;s it, FancyBox will be automatically applied to all your image links and galleries.</li>\n<li>If you want to customize a bit the look and feel of FancyBox, go to the Options Page under General Options in the WordPress Admin panel</li>\n</ol>\n\";s:3:\"faq\";s:2079:\"\n<h4>Installation Instructions</h4>\n<p>\n<ol>\n<li>Upload the <code>fancybox-for-wordpress</code> folder to the <code>/wp-content/plugins/</code> directory</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress</li>\n<li>That&#8217;s it, FancyBox will be automatically applied to all your image links and galleries.</li>\n<li>If you want to customize a bit the look and feel of FancyBox, go to the Options Page under General Options in the WordPress Admin panel</li>\n</ol>\n</p>\n<h4>&#8211; There was a vulnerability detected in versions 3.0.2 and lower, is my site in danger?</h4>\n<p>\n<p>This vulnerability was patched in version 3.0.3.</p>\n<p>An additional change was introduced in version 3.0.4 to make sure that the malicious code can&#8217;t be printed to visitors even if it still remains in the database.</p>\n<p>If you think your site might still be using a vulnerable version of the plugin please log in to your WordPress admin panel, disable the plugin and clear any cache if your site uses a cache system.</p>\n<p>If you wish to continue using the plugin, check that the plugin is updated to the latest version from your admin panel and enable it. Then check the plugin&#8217;s settings page and make sure there&#8217;s no abnormal code in any of the fields, especially on the Extra Calls tab. If you are not sure about the code you see in the settings please use the Revert to Defaults button at the bottom of the settings page.</p>\n<p>If you think your site might be compromised in any other way check this guide: <a href=\"https://codex.wordpress.org/FAQ_My_site_was_hacked\" rel=\"nofollow\">WordPress Codex &#8211; FAQ My site was hacked</a>.</p>\n</p>\n<h4>&#8211; Is the FancyBox script vulnerable or unsafe?</h4>\n<p>\n<p>No, there&#8217;s nothing wrong with the actual FancyBox script that i know of.</p>\n<p>The vulnerability detected in versions 3.0.2 and lower of the &#8220;FancyBox for WordPress&#8221; plugin was limited to the plugin itself. Other FancyBox plugins or manual implementations of FancyBox are unrelated to this issue.</p>\n</p>\n\n\";s:9:\"changelog\";s:10648:\"<h4>3.0.12</h4>\n<p>Fixed errors causes by WordPress SVN.</p>\n<h4>3.0.7</h4>\n<ul>\n<li>Updated Fancybox library</li>\n<li>Updated other libraries this plugins depends on such as jQuery easing and jQuery Mousewheel</li>\n<li>Tested plugin with WordPress 4.6</li>\n</ul>\n<h4>3.0.6</h4>\n<ul>\n<li>Fixes to JavaScript code for showing and hiding elements as they are needed in Settings page. (Thanks to jono55 for reporting)</li>\n</ul>\n<h4>3.0.5</h4>\n<ul>\n<li>Fixed the Revert Options button.</li>\n<li>Fixed wrong version number being shown on the plugin&#8217;s settings page.</li>\n<li>Updated plugin and author links in readme and settings page.</li>\n<li>Updated localization catalog (POT file).</li>\n<li>Updated Spanish translation with minor updates.</li>\n<li>Updated Frequently Asked Questions in readme file.</li>\n<li>Removed version number from printed html source code.</li>\n<li>Removed outdated/incomplete translation binaries.</li>\n</ul>\n<h4>3.0.4</h4>\n<ul>\n<li>Renamed the setting affected by the security issue mentioned in 3.0.3. This should stop the malicious code from appearing on sites where the plugin is updated without removing the malicious code.</li>\n</ul>\n<h4>3.0.3</h4>\n<ul>\n<li>Fixed a security issue. (Thanks to mickaelb for reporting and Konstantin Kovshenin for providing the fix)</li>\n</ul>\n<h4>3.0.2</h4>\n<ul>\n<li>Added support for disabling fancybox on individual hyperlinked images by adding class=&#8217;nolightbox&#8217;. (Thanks to Artem Russakovskii)</li>\n<li>Added a link to the github project page in the info tab in the settings page.</li>\n<li>Fixed and cleaned the installation code, new installations of the plugin should work now without need to go to the settings page.</li>\n<li>Fixed false positives in filenames. (Thanks to Artem Russakovskii)</li>\n<li>Fixed incompatibility with wordpress installations where the wp-content directory had been renamed.</li>\n<li>Fixed an issue that could cause the version of the plugin to be removed from settings when deactivating the plugin.</li>\n<li>Improved HTTPS support by using better code to retrieve the plugin url and load files.</li>\n<li>Removed legacy code to suport upgrading settings from 2.x versions of the plugin. This was done to avoid possible issues with clean installations of the plugin.</li>\n<li>Updated some CSS rules in jQuery UI</li>\n<li>Some minor reformatting and cleanup of code (PHP comments, empty lines, )</li>\n</ul>\n<h4>3.0.1</h4>\n<ul>\n<li>Updated: Localization catalog updated.</li>\n<li>Updated: Spanish localization.</li>\n<li>Fixed: Minor change in settings page that may fix options page being invisible in some cases.</li>\n</ul>\n<h4>3.0.0</h4>\n<ul>\n<li>New: Fancybox v1.3.4 support This includes many new options, like title position.</li>\n<li>New: Additional FancyBox Calls option that lets the user write their own additional code to use FancyBox on specific areas of the blog, like email subscription buttons, login, etc.</li>\n<li>New: Revert settings button added to options page. When pressed, a confirmation dialog will appear.</li>\n<li>New: Improvements in options page, irrelevant settings (settings that depend on a disabled setting) will hide on real time, meaning a cleaner look in the options page.</li>\n<li>Updated: New cleaner code to select thumbnails on which to apply the fancbox script.</li>\n<li>Updated: Many parts of plugins rewriten with many improvements in code.</li>\n<li>Updated: Options are now serialized into a single row in the database.</li>\n<li>Fixed: Plugin should be SSL friendly from now on.</li>\n<li>Fixed: Do not call jQuery option in troubleshooting section didn&#8217;t work if easing was enabled.</li>\n<li>Fixed: Load at footer options should work better now.</li>\n<li>Fixed: CSS external files now addded with wp_enqueue_style().</li>\n<li>Fixed: has_cap error: User level value for options page removed, using role now instead. Thanks to <a href=\"https://wordpress.org/support/topic/plugin-fancybox-for-wordpress-has_cap-fix\" rel=\"nofollow\">vonkanehoffen</a>.</li>\n<li>Removed: jQuery &#8220;noConflict&#8221; Mode option removed bacause jQuery bundled with WordPress always used noConflict.</li>\n<li>Removed: Base64 data (&#8220;data:image/gif;base64,AAAA&#8221;) in left and right fancybox link&#8217;s backgrounds: It didn&#8217;t seem to be working and it is usually regarded as suspicious code, so it has been removed.</li>\n</ul>\n<h4>2.7.5</h4>\n<ul>\n<li>Fixed: Callback arguments are no longer added as &#8220;null&#8221; when they are not set in options page.</li>\n</ul>\n<h4>2.7.4</h4>\n<ul>\n<li>Fixed: Little error tagging 2.7.3, a file didn&#8217;t upload and broke options page.</li>\n<li>Update: Language POT file</li>\n</ul>\n<h4>2.7.3</h4>\n<ul>\n<li>Fixed: Settings not saving in some browsers. Thanks to <a href=\"https://wordpress.org/support/topic/plugin-fancybox-for-wordpress-save-changes-button-doesnt-submit-form?replies=7#post-1765041\" rel=\"nofollow\">supertomate</a></li>\n<li>Fixed: JS being added to other plugins&#8217; configuration pages. Thanks to <a href=\"https://wordpress.org/support/topic/plugin-fancybox-for-wordpress-theres-a-problem-with-is_plugin_page?replies=1#post-1888828\" rel=\"nofollow\">Brandon Dove</a></li>\n<li>Added: Support section in options page with better information</li>\n</ul>\n<h4>2.7.2</h4>\n<ul>\n<li>Fixed: Layout problem in options page in WordPress 2.9</li>\n</ul>\n<h4>2.7.1</h4>\n<ul>\n<li>Fixed: Z-index issue was left out in previus release</li>\n<li>Fixed: Setting to close fancybox when clicking on the overlay wasn&#8217;t available in the menu</li>\n<li>Fixed: Frame width and height options are now in the &#8220;Other&#8221; tab</li>\n<li>Fixed: Tabs now translated in Spanish localization</li>\n</ul>\n<h4>2.7.0</h4>\n<ul>\n<li>New: Fancybox v1.2.6 support</li>\n<li>New: New Admin page with tabs for better organization of all the options</li>\n<li>Added: Setting to change the speed of the animation when changing gallery items</li>\n<li>Added: Setting to enable or disable Escape key to close Fancybox</li>\n<li>Added: Setting to show or hide close button</li>\n<li>Added: Setting to close fancybox when clicking on the overlay</li>\n<li>Added: Setting to enable or disable callback function on start, show and close events</li>\n<li>Added: Italian translation</li>\n<li>Added: Russian translation</li>\n<li>Added: &#8220;Load JS at Footer&#8221; option</li>\n<li>Added: New Changelog tab in  WordPress Plugin Directory</li>\n<li>Fixed: Some typos in Spanish translation</li>\n<li>Fixed: FancyBox not showing above some elements (those with zindex higher than 90)</li>\n<li>Fixed: JavaScript code being included in all admin pages instead of just the plugin&#8217;s options page.</li>\n<li>Fixed: noClonflict preventing frames to work in Fancybox</li>\n<li>Fixed: Custom frame width and height not being applied</li>\n<li>Updated: Japanese translation</li>\n<li>Updated: JS is now Minified instead of Packed</li>\n</ul>\n<h4>2.6.0</h4>\n<ul>\n<li>Optimized the JavaScript code used to apply FancyBox</li>\n<li>Updated Custom Expression section in Options Page</li>\n<li>Fixed uppercase image extensions not being recognized</li>\n<li>CSS is now loaded before the JavaScript for better parallelization</li>\n<li>jquery.easing.1.3.js compressed (from 8,10kb to 3,47kb) and renamed to jquery.easing.1.3.pack.js</li>\n<li>Added Turkish translation (some strings missing)</li>\n<li>Added Japanese translation (some strings missing)</li>\n<li>Updated Spanish translation</li>\n<li>Updated to use new Plugin API in WP2.7 for better forward compatibility</li>\n<li>Removed /wp-content/ reference in fancybox.php for better WP2.8 support</li>\n<li>Optimized some code readability</li>\n</ul>\n<h4>2.5.1</h4>\n<ul>\n<li>Fixed the plugin not working when selecting Gallery Type &#8220;By Post&#8221;</li>\n<li>Fixed a bug that would prevent the title in the IMG tag from being copied to the A tag in some cases</li>\n<li>Fixed the Custom Expression showing in the Admin panel when other gallery types are selected</li>\n</ul>\n<h4>2.5</h4>\n<ul>\n<li>Support for localizations (Spanish and German localizations included)</li>\n<li>Some parts of the code completely rewritten</li>\n<li>Fixed fancybox files being loaded on the admin pages</li>\n<li>New options for close button position, custom jquery expressions, iframe content</li>\n<li>Options page mostly rewritten, better organized</li>\n<li>Medium/advanced, troubleshooting/uninstall options collapsable, hidden by default</li>\n<li>Better support guidelines and links on options page</li>\n<li>Settings link on the Manage plugins page</li>\n<li>Custom expression hidden when not used</li>\n<li>Title atribute on IMG tags is now copied to its parent A tag for better caption support</li>\n<li>New uninstall options and better handling of new options when installing/updating</li>\n<li>Cleans any old options no longer needed when plugin is activated/updated</li>\n</ul>\n<h4>2.2</h4>\n<ul>\n<li>Updated to FancyBox 1.2.1</li>\n<li>Added new settings to Options Page: Easing, padding size, border color</li>\n<li>Tweaked CSS to prevent some themes from adding unwanted styles to fancybox (especially background colors and link outlines)</li>\n<li>Options Page reorganized in three sections: Appearance, Behaviour and Troubleshooting Settings, to make settings easier to find</li>\n</ul>\n<h4>2.1.1</h4>\n<ul>\n<li>Fixed a new bug introduced in 2.1 that prevented options from being saved. Sorry about the mess 🙁</li>\n</ul>\n<h4>2.1</h4>\n<ul>\n<li>Fixed a major bug in 2.0 that prevented it from working until plugin&#8217;s options page was visited</li>\n<li>Added two options for troubleshooting that might help in some cases if the plugin doesn&#8217;t work: disable jQuery noConflict and skip jQuery call</li>\n<li>Additional fixes to caption CSS: Captions should look better now in Hybrid theme, child themes, and other situations where general table elements are improperly styled</li>\n</ul>\n<h4>2.0</h4>\n<ul>\n<li>Brand new Options Page in Admin Panel lets you easely customize many options: fancybox auto apply, image resize to fit, opacity fade while zooming, zoom speed, overlay on/off, overlay color, overlay opacity, close fancybox on image click, keep fancybox centered while scrolling</li>\n<li>CSS completely updated for FancyBox 1.2.0</li>\n<li>Captions fixed in IE</li>\n</ul>\n<h4>1.3</h4>\n<ul>\n<li>Shadows and Close button should be fixed now</li>\n</ul>\n<h4>1.2</h4>\n<ul>\n<li>Updated to FancyBox 1.2.0</li>\n<li>Uses packed version of the JavaScript file (8kb instead of 14kb)</li>\n</ul>\n<h4>1.1</h4>\n<ul>\n<li>Fixed FancyBox not being applied to .jpeg files</li>\n<li>Fixed &#8220;Click to close&#8221; overlay text</li>\n<li>Moved images to /img/ folder</li>\n</ul>\n\";s:11:\"screenshots\";s:907:\"<ol><li><a href=\"https://ps.w.org/fancybox-for-wordpress/trunk/screenshot-1.png?rev=1864321\"><img src=\"https://ps.w.org/fancybox-for-wordpress/trunk/screenshot-1.png?rev=1864321\" alt=\"Simple example of fancybox on a post. &lt;a href=&quot;http://blog.moskis.net/2012/01/20/teclado-apple-en-windows-7/&quot;&gt;Live demo here&lt;/a&gt;\"></a><p>Simple example of fancybox on a post. <a href=\"http://blog.moskis.net/2012/01/20/teclado-apple-en-windows-7/\">Live demo here</a></p></li><li><a href=\"https://ps.w.org/fancybox-for-wordpress/trunk/screenshot-2.png?rev=1864321\"><img src=\"https://ps.w.org/fancybox-for-wordpress/trunk/screenshot-2.png?rev=1864321\" alt=\"Basic settings on Options Page in the Admin Panel. This makes it very easy to customize the plugin to your needs\"></a><p>Basic settings on Options Page in the Admin Panel. This makes it very easy to customize the plugin to your needs</p></li></ol>\";}s:17:\"short_description\";s:140:\"Seamlessly integrates FancyBox lightbox into your WordPress blog: Upload, activate, and you&#039;re done. Additional configuration optional.\";s:13:\"download_link\";s:65:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.zip\";s:11:\"screenshots\";a:2:{i:1;a:2:{s:3:\"src\";s:74:\"https://ps.w.org/fancybox-for-wordpress/trunk/screenshot-1.png?rev=1864321\";s:7:\"caption\";s:128:\"Simple example of fancybox on a post. <a href=\"http://blog.moskis.net/2012/01/20/teclado-apple-en-windows-7/\">Live demo here</a>\";}i:2;a:2:{s:3:\"src\";s:74:\"https://ps.w.org/fancybox-for-wordpress/trunk/screenshot-2.png?rev=1864321\";s:7:\"caption\";s:112:\"Basic settings on Options Page in the Admin Panel. This makes it very easy to customize the plugin to your needs\";}}s:8:\"versions\";a:29:{s:3:\"1.0\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.1.0.zip\";s:5:\"1.0.2\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.1.0.2.zip\";s:3:\"1.1\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.1.1.zip\";s:3:\"1.2\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.1.2.zip\";s:3:\"1.3\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.1.3.zip\";s:3:\"2.0\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.0.zip\";s:3:\"2.1\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.1.zip\";s:5:\"2.1.1\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.1.1.zip\";s:3:\"2.2\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.2.zip\";s:3:\"2.5\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.5.zip\";s:5:\"2.5.1\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.5.1.zip\";s:5:\"2.6.0\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.6.0.zip\";s:5:\"2.7.0\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.7.0.zip\";s:5:\"2.7.1\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.7.1.zip\";s:5:\"2.7.2\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.7.2.zip\";s:5:\"2.7.3\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.7.3.zip\";s:5:\"2.7.4\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.7.4.zip\";s:5:\"2.7.5\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.7.5.zip\";s:5:\"3.0.0\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.0.zip\";s:5:\"3.0.1\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.1.zip\";s:6:\"3.0.10\";s:72:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.10.zip\";s:5:\"3.0.2\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.2.zip\";s:5:\"3.0.3\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.3.zip\";s:5:\"3.0.4\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.4.zip\";s:5:\"3.0.5\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.5.zip\";s:5:\"3.0.6\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.6.zip\";s:5:\"3.0.7\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.7.zip\";s:5:\"3.0.8\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.8.zip\";s:5:\"3.0.9\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.9.zip\";}s:5:\"icons\";a:2:{s:2:\"1x\";s:75:\"https://ps.w.org/fancybox-for-wordpress/assets/icon-256x256.jpg?rev=1864321\";s:2:\"2x\";s:75:\"https://ps.w.org/fancybox-for-wordpress/assets/icon-256x256.jpg?rev=1864321\";}s:12:\"contributors\";a:0:{}}', 'no'),
(187, '_transient_timeout_illdy_plugin_information_transient_colorlib-login-customizer', '1537900469', 'no'),
(188, '_transient_illdy_plugin_information_transient_colorlib-login-customizer', 'O:8:\"stdClass\":18:{s:4:\"name\";s:40:\"Custom Login Page Customizer by Colorlib\";s:4:\"slug\";s:25:\"colorlib-login-customizer\";s:7:\"version\";s:5:\"1.2.0\";s:6:\"author\";s:44:\"<a href=\"https://colorlib.com/\">Colorlib</a>\";s:14:\"author_profile\";s:46:\"https://profiles.wordpress.org/colorlibplugins\";s:12:\"requires_php\";b:0;s:7:\"ratings\";a:5:{i:5;i:4;i:4;i:0;i:3;i:0;i:2;i:0;i:1;i:0;}s:11:\"num_ratings\";i:4;s:15:\"support_threads\";i:6;s:24:\"support_threads_resolved\";i:6;s:8:\"homepage\";s:0:\"\";s:8:\"sections\";a:5:{s:11:\"description\";s:6240:\"<p>Custom Login Page Customizer by Colorlib is an awesome and intuitive login page plugin that helps you personalize your login page and login form directly from the Customizer. Custom Login Page Customizer fully supports the Live Customizer feature and you can see all the changes in real time on your login page and edit them.</p>\n<p>All this plugin’s tools and options can be found by going to Appearance &gt; Customize &gt; Custom Login Page Customizer. There you have templates you can use on your login page, custom login page logo, custom login page background options, custom login page form customizations, login form custom width, login form padding and borders, and more all leading to you having a brand new and custom login page.</p>\n<p>Custom Login Page Customizer is without doubt one of the easiest to use WordPress plugins that allows the customization of the login page and login form. It was designed and developed to be powerful and user friendly so it can be enjoyed by both beginner and advanced developers. With Custom Login Page Customizer you can build a custom login page and custom login form in a matter of seconds, unlike some other login customizer plugins. Custom Login Page Customizer marks the end of a boring and bland login page and login form as you will be able to fine tune every aspect of the form to match your style and view and create a unique and custom login page.</p>\n<p>Build and personalize your WordPress login page and login form from start to finish. Custom Login Page Customizer has the following features:</p>\n<p>•   Custom login page logo options: you can add a custom login page logo and set up its height and weight.<br />\n•   Custom login page and login form background options: from here you can upload a background image or change the background’s color.<br />\n•   Custom login form options: you can change the login form’s width and height, add a background image, change the background color, add padding and borders, and change the login form’s field background color, width, and margin.<br />\n•   Miscellaneous: in here you will find the options to change the login form button’s background, color, hover state, border, shadow, and the link’s color and hover color.</p>\n<p>Custom Login Page Customizer by Colorlib detailed features:</p>\n<ul>\n<li>Custom login page templates</li>\n<li>Hide/show login logo from login page</li>\n<li>Show/hide the logo text from login page</li>\n<li>Custom logo on login page</li>\n<li>Change logo width on login page</li>\n<li>Change logo height on login page</li>\n<li>Change number of columns on your login page</li>\n<li>Customize width of the columns on your login page</li>\n<li>Change login form column alignment</li>\n<li>Customize login form vertical alignment</li>\n<li>Customize login form horizontal alignment</li>\n<li>Customize background color on the login page</li>\n<li>Add a custom background image on login page</li>\n<li>Customize login form column background color</li>\n<li>Add a custom background image for login form column</li>\n<li>Customize login form width</li>\n<li>Customize login form width</li>\n<li>Add custom background image for login form</li>\n<li>Customize the background color for login form</li>\n<li>Customize login form border radius</li>\n<li>Customize login form fields’ width</li>\n<li>Customize login form fields’ margin</li>\n<li>Customize login form fields’ border</li>\n<li>Customize login form fields’ border radius</li>\n<li>Customize login form fields’ background color</li>\n<li>Customize login form fields’ text color</li>\n<li>Customize login form fields’ label color</li>\n<li>Customize login form username label</li>\n<li>Customize login form password label</li>\n<li>Show/hide the links on login page under the login form</li>\n<li>Customize login form button background color</li>\n<li>Customize login form button hover background color</li>\n<li>Customize login form button border color</li>\n<li>Customize login form button border color on hover</li>\n<li>Customize login form button shadow</li>\n<li>Customize login form button text shadow</li>\n<li>Customize login form links color</li>\n<li>Customize login form links color on hover</li>\n<li>Hide/Show ‘Remember me?’ option on login form</li>\n<li>Custom CSS option to customize further the login form and login page</li>\n</ul>\n<p>Build and personalize your WordPress login form from start to finish. Colorlib Login Customizer has the following features:</p>\n<ul>\n<li>Logo options: you can add a custom logo and set up its height and weight.</li>\n<li>Background options: from here you can upload a background image or change the background’s color.</li>\n<li>Form options: you can change the form’s width and height, add a background image, change the background color, add padding and borders, and change the form’s field background color, width, and margin.</li>\n<li>Miscellaneous: in here you will find the options to change the button’s background, color, hover state, border, shadow, and the link’s color and hover color.</li>\n</ul>\n<h4>Further Reading</h4>\n<p>This plugin is developed and maintained by Colorlib. Which is well know for their free <a href=\"https://colorlib.com/wp/themes/\" rel=\"nofollow\"></a>WordPress themes. However, now they are looking to extend their presence in plugin development and believe that Colorlib Login Customizer is a great way to start.</p>\n<p>If you are new to WordPress and want to learn more we have got you covered. Colorlib will teach you how to <a href=\"https://colorlib.com/\" rel=\"nofollow\">start a blog</a> or <a href=\"https://colorlib.com/wp/how-to-make-a-website/\" rel=\"nofollow\">create a website</a> and much more. If you are already familiar with WordPress you likely want to learn how to make it faster and more reliable. That&#8217;s when you want to look into hosting and more specifically <a href=\"http://colorlib.com/wp/wordpress-hosting\" rel=\"nofollow\">WordPress hosting</a>.</p>\n<p>If you enjoy using Colorlib Login Customizer for WordPress please leave a <a href=\"https://wordpress.org/support/plugin/colorlib-login-customiezr/reviews/?filter=5\" rel=\"nofollow\">positive feedback</a>. We are committed to make it the best Login Customizer plugin for WordPress.</p>\n\";s:12:\"installation\";s:418:\"<ol>\n<li>Download the plugin (.zip file) on your hard drive.</li>\n<li>Unzip the zip file contents.</li>\n<li>Upload the <code>colorlib-login-customizer</code> folder to the <code>/wp-content/plugins/</code> directory.</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress.</li>\n<li>A new sub menu item <code>Colorlib Login Customizer</code> will appear in your main Settings menu.</li>\n</ol>\n\";s:9:\"changelog\";s:354:\"<h4>1.2.0</h4>\n<ul>\n<li>Implemented everything from here: https://github.com/puikinsh/colorlib-login-customizer/milestone/1?closed=1</li>\n</ul>\n<h4>1.1</h4>\n<ul>\n<li>Changed templates functionality</li>\n<li>Added new layout options</li>\n<li>Fixed live preview editing</li>\n<li>Fixed minor bugs</li>\n</ul>\n<h4>1.0</h4>\n<ul>\n<li>Initial release</li>\n</ul>\n\";s:3:\"faq\";s:464:\"\n<h4>Installation Instructions</h4>\n<p>\n<ol>\n<li>Download the plugin (.zip file) on your hard drive.</li>\n<li>Unzip the zip file contents.</li>\n<li>Upload the <code>colorlib-login-customizer</code> folder to the <code>/wp-content/plugins/</code> directory.</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress.</li>\n<li>A new sub menu item <code>Colorlib Login Customizer</code> will appear in your main Settings menu.</li>\n</ol>\n</p>\n\n\";s:11:\"screenshots\";s:805:\"<ol><li><a href=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-1.jpg?rev=1872192\"><img src=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-1.jpg?rev=1872192\" alt=\"\"></a></li><li><a href=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-2.jpg?rev=1872192\"><img src=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-2.jpg?rev=1872192\" alt=\"\"></a></li><li><a href=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-3.jpg?rev=1888161\"><img src=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-3.jpg?rev=1888161\" alt=\"\"></a></li><li><a href=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-4.jpg?rev=1888161\"><img src=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-4.jpg?rev=1888161\" alt=\"\"></a></li></ol>\";}s:17:\"short_description\";s:122:\"Colorlib Login Customizer by Colorlib is a plugin that helps you personalize your login form directly from the Customizer.\";s:13:\"download_link\";s:74:\"https://downloads.wordpress.org/plugin/colorlib-login-customizer.1.2.0.zip\";s:11:\"screenshots\";a:4:{i:1;a:2:{s:3:\"src\";s:78:\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-1.jpg?rev=1872192\";s:7:\"caption\";s:0:\"\";}i:2;a:2:{s:3:\"src\";s:78:\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-2.jpg?rev=1872192\";s:7:\"caption\";s:0:\"\";}i:3;a:2:{s:3:\"src\";s:78:\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-3.jpg?rev=1888161\";s:7:\"caption\";s:0:\"\";}i:4;a:2:{s:3:\"src\";s:78:\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-4.jpg?rev=1888161\";s:7:\"caption\";s:0:\"\";}}s:8:\"versions\";a:3:{s:5:\"1.1.0\";s:74:\"https://downloads.wordpress.org/plugin/colorlib-login-customizer.1.1.0.zip\";s:5:\"1.2.0\";s:74:\"https://downloads.wordpress.org/plugin/colorlib-login-customizer.1.2.0.zip\";s:5:\"trunk\";s:68:\"https://downloads.wordpress.org/plugin/colorlib-login-customizer.zip\";}s:5:\"icons\";a:2:{s:2:\"1x\";s:78:\"https://ps.w.org/colorlib-login-customizer/assets/icon-256x256.jpg?rev=1862920\";s:2:\"2x\";s:78:\"https://ps.w.org/colorlib-login-customizer/assets/icon-256x256.jpg?rev=1862920\";}s:12:\"contributors\";a:0:{}}', 'no'),
(190, '_site_transient_timeout_theme_roots', '1537901150', 'no'),
(191, '_site_transient_theme_roots', 'a:4:{s:5:\"illdy\";s:7:\"/themes\";s:13:\"twentyfifteen\";s:7:\"/themes\";s:15:\"twentyseventeen\";s:7:\"/themes\";s:13:\"twentysixteen\";s:7:\"/themes\";}', 'no'),
(192, '_transient_timeout_epsilon_plugin_information_transient_kiwi-social-share', '1537901153', 'no'),
(193, '_transient_epsilon_plugin_information_transient_kiwi-social-share', 'O:8:\"stdClass\":18:{s:4:\"name\";s:64:\"Kiwi Social Share &#8211; Social Media Share Buttons &amp; Icons\";s:4:\"slug\";s:17:\"kiwi-social-share\";s:7:\"version\";s:5:\"2.0.8\";s:6:\"author\";s:54:\"<a href=\"https://www.machothemes.com\">Macho Themes</a>\";s:14:\"author_profile\";s:47:\"https://profiles.wordpress.org/cristianraiber-1\";s:12:\"requires_php\";b:0;s:7:\"ratings\";a:5:{i:5;i:10;i:4;i:0;i:3;i:2;i:2;i:0;i:1;i:0;}s:11:\"num_ratings\";i:12;s:15:\"support_threads\";i:3;s:24:\"support_threads_resolved\";i:3;s:8:\"homepage\";s:45:\"https://www.machothemes.com/kiwi-social-share\";s:8:\"sections\";a:5:{s:11:\"description\";s:1947:\"<p>This is by far the best &amp; easiest to use WordPress social media share plugin. A WordPress share plugin with custom icons built-in.</p>\n<h4>Plugin Options</h4>\n<ul>\n<li>Social networks available: Facebook, Twitter, LinkedIN, Pinterest, Google Plus and Flint.</li>\n<li>Turn on/off each of them, individually.</li>\n<li>Great UI with intuitive &amp; simple options.</li>\n<li>Built for the regular user.</li>\n<li>Change the style of the article bar group.</li>\n<li>Display the number of counts next to the social network icon.</li>\n<li>Enable/disable the floating bar.</li>\n<li>Change the shape of the floating bar’s social buttons.</li>\n<li>Add social identities.</li>\n<li>Add a &#8220;Click to tweet&#8221; button in WordPress editor.</li>\n<li>Google Analytics tracking.</li>\n<li>Four different Skins.</li>\n<li>The default, square style.</li>\n<li>The more futuristic approach, shift style.</li>\n<li>The friendly approach, pill (rounded corners) style.</li>\n<li>The eye-catching approach, leaf style (like a leaf in the wind).</li>\n<li>Display social icons: before content, after content or both.</li>\n<li>Amazing loading speed.</li>\n</ul>\n<h4>WordPress Social Media Widget (for website)</h4>\n<p>A WordPress Social Media Widget solution is coming soon, stay tuned.</p>\n<p><strong>About us:</strong></p>\n<p>We are a young team of WordPress aficionados who love building WordPress plugins &amp; <a href=\"https://www.machothemes.com/\" title=\"Premium WordPress themes\" rel=\"friend nofollow\">Premium WordPress themes</a> over on our theme shop. We’re also blogging and wish to help our users find the best <a href=\"https://www.machothemes.com/blog/cheap-wordpress-hosting/\" title=\"Cheap WordPress Hosting\" rel=\"friend nofollow\">Cheap WordPress hosting</a> &amp; the best <a href=\"https://www.machothemes.com/blog/best-free-wordpress-bootstrap-themes/\" title=\"Bootstrap WordPress themes\" rel=\"friend nofollow\">Bootstrap WordPress Themes</a>.</p>\n\";s:12:\"installation\";s:328:\"<p>This section describes how to install the plugin and get it working.</p>\n<ol>\n<li>Upload the whole contents of the folder <code>kiwi-social-share</code> to the <code>/wp-content/plugins/</code> directory</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress</li>\n<li>Enjoy using it 🙂</li>\n</ol>\n\";s:3:\"faq\";s:514:\"<p>Available filters (used for frontend rendering)<br />\nArticle Bar Filters<br />\n    kiwi_article_bar_list_custom_class<br />\n    kiwi_before_article_bar<br />\n    kiwi_before_first_article_bar_item<br />\n    kiwi_after_last_article_bar_item<br />\n    kiwi_after_article_bar</p>\n<p>Floating Bar Filters<br />\n    kiwi_floating_bar_list_custom_class<br />\n    kiwi_before_floating_bar<br />\n    kiwi_before_first_floating_bar_item<br />\n    kiwi_after_last_floating_bar_item<br />\n    kiwi_after_floating_bar</p>\n\";s:9:\"changelog\";s:2098:\"<h4>2.0.8</h4>\n<ul>\n<li>Added Fintel network</li>\n</ul>\n<h4>2.0.7</h4>\n<ul>\n<li>added uninstall feedback</li>\n</ul>\n<h4>2.0.6</h4>\n<ul>\n<li>WP 4.9 compatibility</li>\n<li>Remove url encode on twitter button</li>\n<li>WhatsApp button didn&#8217;t look alright on fit</li>\n</ul>\n<h4>2.0.4</h4>\n<ul>\n<li>Removed box shadow in the admin window</li>\n<li>Changed how URLS are encoded for text</li>\n<li>WhatsApp icon visibility is now handled with CSS ( wp_is_mobile function would not work on websites with cache )</li>\n</ul>\n<h4>2.0.3</h4>\n<ul>\n<li>Saving settings would cause errors on some servers</li>\n</ul>\n<h4>2.0.2</h4>\n<ul>\n<li>Ajax request failed on license activation</li>\n</ul>\n<h4>2.0.1</h4>\n<ul>\n<li>Minor bugs</li>\n</ul>\n<h4>2.0.0</h4>\n<ul>\n<li>Major upgrade</li>\n</ul>\n<h4>1.0.4</h4>\n<ul>\n<li>When checked, the Google+ icon wasn’t showing up. Fix provided via GitHub by @smartinsalmeida</li>\n</ul>\n<h4>1.0.3</h4>\n<ul>\n<li>Increased the weight on the front-end selectors so that margin &amp; padding are harder to get overwritten by themes. Feels like some themes don&#8217;t want to play nice</li>\n</ul>\n<h4>1.0.2</h4>\n<ul>\n<li>Fixed a small bug where content wasn&#8217;t being returned if kiwi was turned off on posts and pages.</li>\n<li>Added share bar margins top/bottom.</li>\n<li>Fixed a small rendering bug in the back-end for images.</li>\n<li>Fixed a small bug where content wasn&#8217;t being returned on !is_singular() pages (archives)</li>\n</ul>\n<h4>1.0.1</h4>\n<ul>\n<li>Replaced Kiwi Logo with Dashicons icon</li>\n<li>Fixed a small bug with the notifications bar overlapping the form badge</li>\n<li>Enhanced the way we control sortables. When you disable a radio within a sortable, that sortable gets it’s opacity lowered.</li>\n<li>Properly formatted JS code with PHPStorm formatting.</li>\n<li>Small assets/back-end/images/ re-organization. Now, social icons have been renamed and moved into their own folder.</li>\n<li>Slightly re-worked the sortable/draggable field to support icons. No more CSS background images</li>\n</ul>\n<h4>1.0.0</h4>\n<ul>\n<li>Initial release</li>\n</ul>\n\";s:11:\"screenshots\";s:477:\"<ol><li><a href=\"https://ps.w.org/kiwi-social-share/assets/screenshot-1.png?rev=1650215\"><img src=\"https://ps.w.org/kiwi-social-share/assets/screenshot-1.png?rev=1650215\" alt=\"Screenshot of the back-end User Interface. All options are displayed above the fold (no scrolling, no fiddling around). Really easy to use.\"></a><p>Screenshot of the back-end User Interface. All options are displayed above the fold (no scrolling, no fiddling around). Really easy to use.</p></li></ol>\";}s:17:\"short_description\";s:135:\"This is by far the best free WordPress share plugin. It is simple yet does exactly what it should with plenty of customisation options.\";s:13:\"download_link\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.8.zip\";s:11:\"screenshots\";a:1:{i:1;a:2:{s:3:\"src\";s:70:\"https://ps.w.org/kiwi-social-share/assets/screenshot-1.png?rev=1650215\";s:7:\"caption\";s:139:\"Screenshot of the back-end User Interface. All options are displayed above the fold (no scrolling, no fiddling around). Really easy to use.\";}}s:8:\"versions\";a:7:{s:5:\"2.0.0\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.0.zip\";s:5:\"2.0.3\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.3.zip\";s:5:\"2.0.4\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.4.zip\";s:5:\"2.0.5\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.5.zip\";s:5:\"2.0.7\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.7.zip\";s:5:\"2.0.8\";s:66:\"https://downloads.wordpress.org/plugin/kiwi-social-share.2.0.8.zip\";s:5:\"trunk\";s:60:\"https://downloads.wordpress.org/plugin/kiwi-social-share.zip\";}s:5:\"icons\";a:2:{s:2:\"1x\";s:70:\"https://ps.w.org/kiwi-social-share/assets/icon-256x256.png?rev=1445882\";s:2:\"2x\";s:70:\"https://ps.w.org/kiwi-social-share/assets/icon-256x256.png?rev=1445882\";}s:12:\"contributors\";a:0:{}}', 'no'),
(194, '_transient_timeout_epsilon_plugin_information_transient_simple-custom-post-order', '1537901154', 'no');
INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(195, '_transient_epsilon_plugin_information_transient_simple-custom-post-order', 'O:8:\"stdClass\":18:{s:4:\"name\";s:24:\"Simple Custom Post Order\";s:4:\"slug\";s:24:\"simple-custom-post-order\";s:7:\"version\";s:5:\"2.3.2\";s:6:\"author\";s:47:\"<a href=\"https://colorlib.com/wp/\">Colorlib</a>\";s:14:\"author_profile\";s:39:\"https://profiles.wordpress.org/hsameerc\";s:12:\"requires_php\";b:0;s:7:\"ratings\";a:5:{i:5;i:102;i:4;i:4;i:3;i:5;i:2;i:2;i:1;i:14;}s:11:\"num_ratings\";i:127;s:15:\"support_threads\";i:1;s:24:\"support_threads_resolved\";i:0;s:8:\"homepage\";s:58:\"https://wordpress.org/plugins-wp/simple-custom-post-order/\";s:8:\"sections\";a:5:{s:11:\"description\";s:416:\"<p>Order posts(posts, any custom post types) using a Drag and Drop Sortable JavaScript. Configuration is unnecessary. You can do directly on default WordPress administration.<br />\nExcluding custom query which uses order or orderby parameters, in get_posts or query_posts and so on.</p>\n<p>This plugins is now supported and maintained by <a href=\"//colorlib.com/wp/“\" rel=\"“friend” nofollow\">Colorlib</a>.</p>\n\";s:12:\"installation\";s:188:\"<ol>\n<li>Upload <code>plugin-name.php</code> to the <code>/wp-content/plugins/</code> directory</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress</li>\n</ol>\n\";s:3:\"faq\";s:322:\"\n<h4>Installation Instructions</h4>\n<p>\n<ol>\n<li>Upload <code>plugin-name.php</code> to the <code>/wp-content/plugins/</code> directory</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress</li>\n</ol>\n</p>\n<h4>A question that someone might have</h4>\n<p>\n<p>An answer to that question.</p>\n</p>\n\n\";s:9:\"changelog\";s:1137:\"<h4>Version 1.0 (20-07-2013)</h4>\n<ul>\n<li>Initial release.</li>\n</ul>\n<h4>Version 1.5 (25-07-2013)</h4>\n<ul>\n<li>Fix : fix errors</li>\n<li>Added Taxonomy Sort</li>\n<li>Added Taxonomy Sort option In setting Page</li>\n</ul>\n<h4>Version 2.0 (22-11-2013)</h4>\n<ul>\n<li>Fixed Undefined Notice Error in wp version 3.7.1</li>\n<li>Taxonomy Activate Checkbox removed.</li>\n</ul>\n<h4>Version 2.1 (31-12-2013)</h4>\n<ul>\n<li>Prevent Breaking autocomplete </li>\n</ul>\n<h4>Version 2.2 (02-07-2014)</h4>\n<ul>\n<li>Fixed bug: Custom Query which uses &#8216;order&#8217; or &#8216;orderby&#8217; parameters is preferred</li>\n<li>It does not depend on the designation manner of arguments( Parameters ). ( $args = &#8216;orderby=&amp;order=&#8217; or $args = array( &#8216;orderby&#8217; =&gt; &#8221;, &#8216;order&#8217; =&gt; &#8221; ) )</li>\n<li>Previous Versions Issues were Improved.</li>\n<li>Removed Taxonomy Sort( Will add in next Version 🙂 )</li>\n</ul>\n<h4>Version 2.3 (24-03-2014)</h4>\n<ul>\n<li>Fixed major bug on taxonomy and post order</li>\n</ul>\n<h4>Version 2.3.2 (17-03-2017)</h4>\n<ul>\n<li>Minor documentation and readme tweaks</li>\n</ul>\n\";s:11:\"screenshots\";s:656:\"<ol><li><a href=\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-1.png?rev=1859717\"><img src=\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-1.png?rev=1859717\" alt=\"screenshot-1\"></a><p>screenshot-1</p></li><li><a href=\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-3.png?rev=1859717\"><img src=\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-3.png?rev=1859717\" alt=\"\"></a></li><li><a href=\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-2.png?rev=1859717\"><img src=\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-2.png?rev=1859717\" alt=\"screenshot-2\"></a><p>screenshot-2</p></li></ol>\";}s:17:\"short_description\";s:114:\"Order posts(posts, any custom post types) using a Drag and Drop Sortable JavaScript. Configuration is unnecessary.\";s:13:\"download_link\";s:67:\"https://downloads.wordpress.org/plugin/simple-custom-post-order.zip\";s:11:\"screenshots\";a:3:{i:1;a:2:{s:3:\"src\";s:76:\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-1.png?rev=1859717\";s:7:\"caption\";s:12:\"screenshot-1\";}i:3;a:2:{s:3:\"src\";s:76:\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-3.png?rev=1859717\";s:7:\"caption\";s:0:\"\";}i:2;a:2:{s:3:\"src\";s:76:\"https://ps.w.org/simple-custom-post-order/trunk/screenshot-2.png?rev=1859717\";s:7:\"caption\";s:12:\"screenshot-2\";}}s:8:\"versions\";a:5:{s:3:\"1.0\";s:71:\"https://downloads.wordpress.org/plugin/simple-custom-post-order.1.0.zip\";s:3:\"1.5\";s:71:\"https://downloads.wordpress.org/plugin/simple-custom-post-order.1.5.zip\";s:3:\"2.0\";s:71:\"https://downloads.wordpress.org/plugin/simple-custom-post-order.2.0.zip\";s:3:\"2.1\";s:71:\"https://downloads.wordpress.org/plugin/simple-custom-post-order.2.1.zip\";s:3:\"2.2\";s:71:\"https://downloads.wordpress.org/plugin/simple-custom-post-order.2.2.zip\";}s:5:\"icons\";a:2:{s:2:\"1x\";s:77:\"https://ps.w.org/simple-custom-post-order/assets/icon-256x256.jpg?rev=1859717\";s:2:\"2x\";s:77:\"https://ps.w.org/simple-custom-post-order/assets/icon-256x256.jpg?rev=1859717\";}s:12:\"contributors\";a:0:{}}', 'no'),
(196, '_transient_timeout_epsilon_plugin_information_transient_fancybox-for-wordpress', '1537901154', 'no'),
(197, '_transient_epsilon_plugin_information_transient_fancybox-for-wordpress', 'O:8:\"stdClass\":18:{s:4:\"name\";s:22:\"FancyBox for WordPress\";s:4:\"slug\";s:22:\"fancybox-for-wordpress\";s:7:\"version\";s:6:\"3.0.13\";s:6:\"author\";s:44:\"<a href=\"https://colorlib.com/\">Colorlib</a>\";s:14:\"author_profile\";s:46:\"https://profiles.wordpress.org/colorlibplugins\";s:12:\"requires_php\";b:0;s:7:\"ratings\";a:5:{i:5;i:32;i:4;i:3;i:3;i:1;i:2;i:1;i:1;i:7;}s:11:\"num_ratings\";i:44;s:15:\"support_threads\";i:1;s:24:\"support_threads_resolved\";i:0;s:8:\"homepage\";s:53:\"https://wordpress.org/plugins/fancybox-for-wordpress/\";s:8:\"sections\";a:5:{s:11:\"description\";s:2139:\"<p>Seamlessly integrates FancyBox into your blog: Upload, activate, and you&#8217;re done. Additional configuration optional.</p>\n<p>You can easily customize almost anything you can think about fancybox lightbox: the border, margin width and color, zoom speed, animation type, close button position, overlay color and opacity and even more advanced option like several options to group images into galleries, and more&#8230;</p>\n<p>By default, the plugin will use jQuery to apply FancyBox to ANY thumbnails that link directly to an image. This includes posts, the sidebar, etc, so you can activate it and it will be applied automatically.</p>\n<h4>Demo</h4>\n<p>You can see the plugin working on a <a href=\"http://blog.moskis.net/2012/01/20/teclado-apple-en-windows-7/\" rel=\"nofollow\">this blog</a> although there&#8217;s nothing amazing to see, just a FancyBox simple implementation, that&#8217;s the point 😉 You can take a look at the code if you&#8217;re curious, though.</p>\n<h4>Further Reading</h4>\n<p>This plugin is developed and maintained by Colorlib. Which is well know for their free <a href=\"https://colorlib.com/wp/themes/\" rel=\"nofollow\"></a>WordPress themes. However, now they are looking to extend their presence in plugin development and believe that FancyBox lightbox is a great way to start.</p>\n<p>If you are new to WordPress and want to lear more we have got you covered. Colorlib will teach you have to <a href=\"https://colorlib.com/\" rel=\"nofollow\">start a blog</a> or <a href=\"https://colorlib.com/wp/how-to-make-a-website/\" rel=\"nofollow\">create a website</a> and much more. If you are already familiar with WordPress you likely want to learn how to make it faster and more reliable. That&#8217;s when you want to look into hosting and more specifically <a href=\"http://colorlib.com/wp/wordpress-hosting\" rel=\"nofollow\">WordPress hosting</a>.</p>\n<p>If you enjoy using FancyBox lightbox for WordPress please leave a <a href=\"https://wordpress.org/support/plugin/fancybox-for-wordpress/reviews/?filter=5\" rel=\"nofollow\">positive feedback</a>. We are committed to make it the best lightbox plugin for WordPress.</p>\n\";s:12:\"installation\";s:455:\"<ol>\n<li>Upload the <code>fancybox-for-wordpress</code> folder to the <code>/wp-content/plugins/</code> directory</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress</li>\n<li>That&#8217;s it, FancyBox will be automatically applied to all your image links and galleries.</li>\n<li>If you want to customize a bit the look and feel of FancyBox, go to the Options Page under General Options in the WordPress Admin panel</li>\n</ol>\n\";s:3:\"faq\";s:2079:\"\n<h4>Installation Instructions</h4>\n<p>\n<ol>\n<li>Upload the <code>fancybox-for-wordpress</code> folder to the <code>/wp-content/plugins/</code> directory</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress</li>\n<li>That&#8217;s it, FancyBox will be automatically applied to all your image links and galleries.</li>\n<li>If you want to customize a bit the look and feel of FancyBox, go to the Options Page under General Options in the WordPress Admin panel</li>\n</ol>\n</p>\n<h4>&#8211; There was a vulnerability detected in versions 3.0.2 and lower, is my site in danger?</h4>\n<p>\n<p>This vulnerability was patched in version 3.0.3.</p>\n<p>An additional change was introduced in version 3.0.4 to make sure that the malicious code can&#8217;t be printed to visitors even if it still remains in the database.</p>\n<p>If you think your site might still be using a vulnerable version of the plugin please log in to your WordPress admin panel, disable the plugin and clear any cache if your site uses a cache system.</p>\n<p>If you wish to continue using the plugin, check that the plugin is updated to the latest version from your admin panel and enable it. Then check the plugin&#8217;s settings page and make sure there&#8217;s no abnormal code in any of the fields, especially on the Extra Calls tab. If you are not sure about the code you see in the settings please use the Revert to Defaults button at the bottom of the settings page.</p>\n<p>If you think your site might be compromised in any other way check this guide: <a href=\"https://codex.wordpress.org/FAQ_My_site_was_hacked\" rel=\"nofollow\">WordPress Codex &#8211; FAQ My site was hacked</a>.</p>\n</p>\n<h4>&#8211; Is the FancyBox script vulnerable or unsafe?</h4>\n<p>\n<p>No, there&#8217;s nothing wrong with the actual FancyBox script that i know of.</p>\n<p>The vulnerability detected in versions 3.0.2 and lower of the &#8220;FancyBox for WordPress&#8221; plugin was limited to the plugin itself. Other FancyBox plugins or manual implementations of FancyBox are unrelated to this issue.</p>\n</p>\n\n\";s:9:\"changelog\";s:10648:\"<h4>3.0.12</h4>\n<p>Fixed errors causes by WordPress SVN.</p>\n<h4>3.0.7</h4>\n<ul>\n<li>Updated Fancybox library</li>\n<li>Updated other libraries this plugins depends on such as jQuery easing and jQuery Mousewheel</li>\n<li>Tested plugin with WordPress 4.6</li>\n</ul>\n<h4>3.0.6</h4>\n<ul>\n<li>Fixes to JavaScript code for showing and hiding elements as they are needed in Settings page. (Thanks to jono55 for reporting)</li>\n</ul>\n<h4>3.0.5</h4>\n<ul>\n<li>Fixed the Revert Options button.</li>\n<li>Fixed wrong version number being shown on the plugin&#8217;s settings page.</li>\n<li>Updated plugin and author links in readme and settings page.</li>\n<li>Updated localization catalog (POT file).</li>\n<li>Updated Spanish translation with minor updates.</li>\n<li>Updated Frequently Asked Questions in readme file.</li>\n<li>Removed version number from printed html source code.</li>\n<li>Removed outdated/incomplete translation binaries.</li>\n</ul>\n<h4>3.0.4</h4>\n<ul>\n<li>Renamed the setting affected by the security issue mentioned in 3.0.3. This should stop the malicious code from appearing on sites where the plugin is updated without removing the malicious code.</li>\n</ul>\n<h4>3.0.3</h4>\n<ul>\n<li>Fixed a security issue. (Thanks to mickaelb for reporting and Konstantin Kovshenin for providing the fix)</li>\n</ul>\n<h4>3.0.2</h4>\n<ul>\n<li>Added support for disabling fancybox on individual hyperlinked images by adding class=&#8217;nolightbox&#8217;. (Thanks to Artem Russakovskii)</li>\n<li>Added a link to the github project page in the info tab in the settings page.</li>\n<li>Fixed and cleaned the installation code, new installations of the plugin should work now without need to go to the settings page.</li>\n<li>Fixed false positives in filenames. (Thanks to Artem Russakovskii)</li>\n<li>Fixed incompatibility with wordpress installations where the wp-content directory had been renamed.</li>\n<li>Fixed an issue that could cause the version of the plugin to be removed from settings when deactivating the plugin.</li>\n<li>Improved HTTPS support by using better code to retrieve the plugin url and load files.</li>\n<li>Removed legacy code to suport upgrading settings from 2.x versions of the plugin. This was done to avoid possible issues with clean installations of the plugin.</li>\n<li>Updated some CSS rules in jQuery UI</li>\n<li>Some minor reformatting and cleanup of code (PHP comments, empty lines, )</li>\n</ul>\n<h4>3.0.1</h4>\n<ul>\n<li>Updated: Localization catalog updated.</li>\n<li>Updated: Spanish localization.</li>\n<li>Fixed: Minor change in settings page that may fix options page being invisible in some cases.</li>\n</ul>\n<h4>3.0.0</h4>\n<ul>\n<li>New: Fancybox v1.3.4 support This includes many new options, like title position.</li>\n<li>New: Additional FancyBox Calls option that lets the user write their own additional code to use FancyBox on specific areas of the blog, like email subscription buttons, login, etc.</li>\n<li>New: Revert settings button added to options page. When pressed, a confirmation dialog will appear.</li>\n<li>New: Improvements in options page, irrelevant settings (settings that depend on a disabled setting) will hide on real time, meaning a cleaner look in the options page.</li>\n<li>Updated: New cleaner code to select thumbnails on which to apply the fancbox script.</li>\n<li>Updated: Many parts of plugins rewriten with many improvements in code.</li>\n<li>Updated: Options are now serialized into a single row in the database.</li>\n<li>Fixed: Plugin should be SSL friendly from now on.</li>\n<li>Fixed: Do not call jQuery option in troubleshooting section didn&#8217;t work if easing was enabled.</li>\n<li>Fixed: Load at footer options should work better now.</li>\n<li>Fixed: CSS external files now addded with wp_enqueue_style().</li>\n<li>Fixed: has_cap error: User level value for options page removed, using role now instead. Thanks to <a href=\"https://wordpress.org/support/topic/plugin-fancybox-for-wordpress-has_cap-fix\" rel=\"nofollow\">vonkanehoffen</a>.</li>\n<li>Removed: jQuery &#8220;noConflict&#8221; Mode option removed bacause jQuery bundled with WordPress always used noConflict.</li>\n<li>Removed: Base64 data (&#8220;data:image/gif;base64,AAAA&#8221;) in left and right fancybox link&#8217;s backgrounds: It didn&#8217;t seem to be working and it is usually regarded as suspicious code, so it has been removed.</li>\n</ul>\n<h4>2.7.5</h4>\n<ul>\n<li>Fixed: Callback arguments are no longer added as &#8220;null&#8221; when they are not set in options page.</li>\n</ul>\n<h4>2.7.4</h4>\n<ul>\n<li>Fixed: Little error tagging 2.7.3, a file didn&#8217;t upload and broke options page.</li>\n<li>Update: Language POT file</li>\n</ul>\n<h4>2.7.3</h4>\n<ul>\n<li>Fixed: Settings not saving in some browsers. Thanks to <a href=\"https://wordpress.org/support/topic/plugin-fancybox-for-wordpress-save-changes-button-doesnt-submit-form?replies=7#post-1765041\" rel=\"nofollow\">supertomate</a></li>\n<li>Fixed: JS being added to other plugins&#8217; configuration pages. Thanks to <a href=\"https://wordpress.org/support/topic/plugin-fancybox-for-wordpress-theres-a-problem-with-is_plugin_page?replies=1#post-1888828\" rel=\"nofollow\">Brandon Dove</a></li>\n<li>Added: Support section in options page with better information</li>\n</ul>\n<h4>2.7.2</h4>\n<ul>\n<li>Fixed: Layout problem in options page in WordPress 2.9</li>\n</ul>\n<h4>2.7.1</h4>\n<ul>\n<li>Fixed: Z-index issue was left out in previus release</li>\n<li>Fixed: Setting to close fancybox when clicking on the overlay wasn&#8217;t available in the menu</li>\n<li>Fixed: Frame width and height options are now in the &#8220;Other&#8221; tab</li>\n<li>Fixed: Tabs now translated in Spanish localization</li>\n</ul>\n<h4>2.7.0</h4>\n<ul>\n<li>New: Fancybox v1.2.6 support</li>\n<li>New: New Admin page with tabs for better organization of all the options</li>\n<li>Added: Setting to change the speed of the animation when changing gallery items</li>\n<li>Added: Setting to enable or disable Escape key to close Fancybox</li>\n<li>Added: Setting to show or hide close button</li>\n<li>Added: Setting to close fancybox when clicking on the overlay</li>\n<li>Added: Setting to enable or disable callback function on start, show and close events</li>\n<li>Added: Italian translation</li>\n<li>Added: Russian translation</li>\n<li>Added: &#8220;Load JS at Footer&#8221; option</li>\n<li>Added: New Changelog tab in  WordPress Plugin Directory</li>\n<li>Fixed: Some typos in Spanish translation</li>\n<li>Fixed: FancyBox not showing above some elements (those with zindex higher than 90)</li>\n<li>Fixed: JavaScript code being included in all admin pages instead of just the plugin&#8217;s options page.</li>\n<li>Fixed: noClonflict preventing frames to work in Fancybox</li>\n<li>Fixed: Custom frame width and height not being applied</li>\n<li>Updated: Japanese translation</li>\n<li>Updated: JS is now Minified instead of Packed</li>\n</ul>\n<h4>2.6.0</h4>\n<ul>\n<li>Optimized the JavaScript code used to apply FancyBox</li>\n<li>Updated Custom Expression section in Options Page</li>\n<li>Fixed uppercase image extensions not being recognized</li>\n<li>CSS is now loaded before the JavaScript for better parallelization</li>\n<li>jquery.easing.1.3.js compressed (from 8,10kb to 3,47kb) and renamed to jquery.easing.1.3.pack.js</li>\n<li>Added Turkish translation (some strings missing)</li>\n<li>Added Japanese translation (some strings missing)</li>\n<li>Updated Spanish translation</li>\n<li>Updated to use new Plugin API in WP2.7 for better forward compatibility</li>\n<li>Removed /wp-content/ reference in fancybox.php for better WP2.8 support</li>\n<li>Optimized some code readability</li>\n</ul>\n<h4>2.5.1</h4>\n<ul>\n<li>Fixed the plugin not working when selecting Gallery Type &#8220;By Post&#8221;</li>\n<li>Fixed a bug that would prevent the title in the IMG tag from being copied to the A tag in some cases</li>\n<li>Fixed the Custom Expression showing in the Admin panel when other gallery types are selected</li>\n</ul>\n<h4>2.5</h4>\n<ul>\n<li>Support for localizations (Spanish and German localizations included)</li>\n<li>Some parts of the code completely rewritten</li>\n<li>Fixed fancybox files being loaded on the admin pages</li>\n<li>New options for close button position, custom jquery expressions, iframe content</li>\n<li>Options page mostly rewritten, better organized</li>\n<li>Medium/advanced, troubleshooting/uninstall options collapsable, hidden by default</li>\n<li>Better support guidelines and links on options page</li>\n<li>Settings link on the Manage plugins page</li>\n<li>Custom expression hidden when not used</li>\n<li>Title atribute on IMG tags is now copied to its parent A tag for better caption support</li>\n<li>New uninstall options and better handling of new options when installing/updating</li>\n<li>Cleans any old options no longer needed when plugin is activated/updated</li>\n</ul>\n<h4>2.2</h4>\n<ul>\n<li>Updated to FancyBox 1.2.1</li>\n<li>Added new settings to Options Page: Easing, padding size, border color</li>\n<li>Tweaked CSS to prevent some themes from adding unwanted styles to fancybox (especially background colors and link outlines)</li>\n<li>Options Page reorganized in three sections: Appearance, Behaviour and Troubleshooting Settings, to make settings easier to find</li>\n</ul>\n<h4>2.1.1</h4>\n<ul>\n<li>Fixed a new bug introduced in 2.1 that prevented options from being saved. Sorry about the mess 🙁</li>\n</ul>\n<h4>2.1</h4>\n<ul>\n<li>Fixed a major bug in 2.0 that prevented it from working until plugin&#8217;s options page was visited</li>\n<li>Added two options for troubleshooting that might help in some cases if the plugin doesn&#8217;t work: disable jQuery noConflict and skip jQuery call</li>\n<li>Additional fixes to caption CSS: Captions should look better now in Hybrid theme, child themes, and other situations where general table elements are improperly styled</li>\n</ul>\n<h4>2.0</h4>\n<ul>\n<li>Brand new Options Page in Admin Panel lets you easely customize many options: fancybox auto apply, image resize to fit, opacity fade while zooming, zoom speed, overlay on/off, overlay color, overlay opacity, close fancybox on image click, keep fancybox centered while scrolling</li>\n<li>CSS completely updated for FancyBox 1.2.0</li>\n<li>Captions fixed in IE</li>\n</ul>\n<h4>1.3</h4>\n<ul>\n<li>Shadows and Close button should be fixed now</li>\n</ul>\n<h4>1.2</h4>\n<ul>\n<li>Updated to FancyBox 1.2.0</li>\n<li>Uses packed version of the JavaScript file (8kb instead of 14kb)</li>\n</ul>\n<h4>1.1</h4>\n<ul>\n<li>Fixed FancyBox not being applied to .jpeg files</li>\n<li>Fixed &#8220;Click to close&#8221; overlay text</li>\n<li>Moved images to /img/ folder</li>\n</ul>\n\";s:11:\"screenshots\";s:907:\"<ol><li><a href=\"https://ps.w.org/fancybox-for-wordpress/trunk/screenshot-1.png?rev=1864321\"><img src=\"https://ps.w.org/fancybox-for-wordpress/trunk/screenshot-1.png?rev=1864321\" alt=\"Simple example of fancybox on a post. &lt;a href=&quot;http://blog.moskis.net/2012/01/20/teclado-apple-en-windows-7/&quot;&gt;Live demo here&lt;/a&gt;\"></a><p>Simple example of fancybox on a post. <a href=\"http://blog.moskis.net/2012/01/20/teclado-apple-en-windows-7/\">Live demo here</a></p></li><li><a href=\"https://ps.w.org/fancybox-for-wordpress/trunk/screenshot-2.png?rev=1864321\"><img src=\"https://ps.w.org/fancybox-for-wordpress/trunk/screenshot-2.png?rev=1864321\" alt=\"Basic settings on Options Page in the Admin Panel. This makes it very easy to customize the plugin to your needs\"></a><p>Basic settings on Options Page in the Admin Panel. This makes it very easy to customize the plugin to your needs</p></li></ol>\";}s:17:\"short_description\";s:140:\"Seamlessly integrates FancyBox lightbox into your WordPress blog: Upload, activate, and you&#039;re done. Additional configuration optional.\";s:13:\"download_link\";s:65:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.zip\";s:11:\"screenshots\";a:2:{i:1;a:2:{s:3:\"src\";s:74:\"https://ps.w.org/fancybox-for-wordpress/trunk/screenshot-1.png?rev=1864321\";s:7:\"caption\";s:128:\"Simple example of fancybox on a post. <a href=\"http://blog.moskis.net/2012/01/20/teclado-apple-en-windows-7/\">Live demo here</a>\";}i:2;a:2:{s:3:\"src\";s:74:\"https://ps.w.org/fancybox-for-wordpress/trunk/screenshot-2.png?rev=1864321\";s:7:\"caption\";s:112:\"Basic settings on Options Page in the Admin Panel. This makes it very easy to customize the plugin to your needs\";}}s:8:\"versions\";a:29:{s:3:\"1.0\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.1.0.zip\";s:5:\"1.0.2\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.1.0.2.zip\";s:3:\"1.1\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.1.1.zip\";s:3:\"1.2\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.1.2.zip\";s:3:\"1.3\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.1.3.zip\";s:3:\"2.0\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.0.zip\";s:3:\"2.1\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.1.zip\";s:5:\"2.1.1\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.1.1.zip\";s:3:\"2.2\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.2.zip\";s:3:\"2.5\";s:69:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.5.zip\";s:5:\"2.5.1\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.5.1.zip\";s:5:\"2.6.0\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.6.0.zip\";s:5:\"2.7.0\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.7.0.zip\";s:5:\"2.7.1\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.7.1.zip\";s:5:\"2.7.2\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.7.2.zip\";s:5:\"2.7.3\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.7.3.zip\";s:5:\"2.7.4\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.7.4.zip\";s:5:\"2.7.5\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.2.7.5.zip\";s:5:\"3.0.0\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.0.zip\";s:5:\"3.0.1\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.1.zip\";s:6:\"3.0.10\";s:72:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.10.zip\";s:5:\"3.0.2\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.2.zip\";s:5:\"3.0.3\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.3.zip\";s:5:\"3.0.4\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.4.zip\";s:5:\"3.0.5\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.5.zip\";s:5:\"3.0.6\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.6.zip\";s:5:\"3.0.7\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.7.zip\";s:5:\"3.0.8\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.8.zip\";s:5:\"3.0.9\";s:71:\"https://downloads.wordpress.org/plugin/fancybox-for-wordpress.3.0.9.zip\";}s:5:\"icons\";a:2:{s:2:\"1x\";s:75:\"https://ps.w.org/fancybox-for-wordpress/assets/icon-256x256.jpg?rev=1864321\";s:2:\"2x\";s:75:\"https://ps.w.org/fancybox-for-wordpress/assets/icon-256x256.jpg?rev=1864321\";}s:12:\"contributors\";a:0:{}}', 'no'),
(198, '_transient_timeout_epsilon_plugin_information_transient_colorlib-login-customizer', '1537901154', 'no'),
(199, '_transient_epsilon_plugin_information_transient_colorlib-login-customizer', 'O:8:\"stdClass\":18:{s:4:\"name\";s:40:\"Custom Login Page Customizer by Colorlib\";s:4:\"slug\";s:25:\"colorlib-login-customizer\";s:7:\"version\";s:5:\"1.2.0\";s:6:\"author\";s:44:\"<a href=\"https://colorlib.com/\">Colorlib</a>\";s:14:\"author_profile\";s:46:\"https://profiles.wordpress.org/colorlibplugins\";s:12:\"requires_php\";b:0;s:7:\"ratings\";a:5:{i:5;i:4;i:4;i:0;i:3;i:0;i:2;i:0;i:1;i:0;}s:11:\"num_ratings\";i:4;s:15:\"support_threads\";i:6;s:24:\"support_threads_resolved\";i:6;s:8:\"homepage\";s:0:\"\";s:8:\"sections\";a:5:{s:11:\"description\";s:6240:\"<p>Custom Login Page Customizer by Colorlib is an awesome and intuitive login page plugin that helps you personalize your login page and login form directly from the Customizer. Custom Login Page Customizer fully supports the Live Customizer feature and you can see all the changes in real time on your login page and edit them.</p>\n<p>All this plugin’s tools and options can be found by going to Appearance &gt; Customize &gt; Custom Login Page Customizer. There you have templates you can use on your login page, custom login page logo, custom login page background options, custom login page form customizations, login form custom width, login form padding and borders, and more all leading to you having a brand new and custom login page.</p>\n<p>Custom Login Page Customizer is without doubt one of the easiest to use WordPress plugins that allows the customization of the login page and login form. It was designed and developed to be powerful and user friendly so it can be enjoyed by both beginner and advanced developers. With Custom Login Page Customizer you can build a custom login page and custom login form in a matter of seconds, unlike some other login customizer plugins. Custom Login Page Customizer marks the end of a boring and bland login page and login form as you will be able to fine tune every aspect of the form to match your style and view and create a unique and custom login page.</p>\n<p>Build and personalize your WordPress login page and login form from start to finish. Custom Login Page Customizer has the following features:</p>\n<p>•   Custom login page logo options: you can add a custom login page logo and set up its height and weight.<br />\n•   Custom login page and login form background options: from here you can upload a background image or change the background’s color.<br />\n•   Custom login form options: you can change the login form’s width and height, add a background image, change the background color, add padding and borders, and change the login form’s field background color, width, and margin.<br />\n•   Miscellaneous: in here you will find the options to change the login form button’s background, color, hover state, border, shadow, and the link’s color and hover color.</p>\n<p>Custom Login Page Customizer by Colorlib detailed features:</p>\n<ul>\n<li>Custom login page templates</li>\n<li>Hide/show login logo from login page</li>\n<li>Show/hide the logo text from login page</li>\n<li>Custom logo on login page</li>\n<li>Change logo width on login page</li>\n<li>Change logo height on login page</li>\n<li>Change number of columns on your login page</li>\n<li>Customize width of the columns on your login page</li>\n<li>Change login form column alignment</li>\n<li>Customize login form vertical alignment</li>\n<li>Customize login form horizontal alignment</li>\n<li>Customize background color on the login page</li>\n<li>Add a custom background image on login page</li>\n<li>Customize login form column background color</li>\n<li>Add a custom background image for login form column</li>\n<li>Customize login form width</li>\n<li>Customize login form width</li>\n<li>Add custom background image for login form</li>\n<li>Customize the background color for login form</li>\n<li>Customize login form border radius</li>\n<li>Customize login form fields’ width</li>\n<li>Customize login form fields’ margin</li>\n<li>Customize login form fields’ border</li>\n<li>Customize login form fields’ border radius</li>\n<li>Customize login form fields’ background color</li>\n<li>Customize login form fields’ text color</li>\n<li>Customize login form fields’ label color</li>\n<li>Customize login form username label</li>\n<li>Customize login form password label</li>\n<li>Show/hide the links on login page under the login form</li>\n<li>Customize login form button background color</li>\n<li>Customize login form button hover background color</li>\n<li>Customize login form button border color</li>\n<li>Customize login form button border color on hover</li>\n<li>Customize login form button shadow</li>\n<li>Customize login form button text shadow</li>\n<li>Customize login form links color</li>\n<li>Customize login form links color on hover</li>\n<li>Hide/Show ‘Remember me?’ option on login form</li>\n<li>Custom CSS option to customize further the login form and login page</li>\n</ul>\n<p>Build and personalize your WordPress login form from start to finish. Colorlib Login Customizer has the following features:</p>\n<ul>\n<li>Logo options: you can add a custom logo and set up its height and weight.</li>\n<li>Background options: from here you can upload a background image or change the background’s color.</li>\n<li>Form options: you can change the form’s width and height, add a background image, change the background color, add padding and borders, and change the form’s field background color, width, and margin.</li>\n<li>Miscellaneous: in here you will find the options to change the button’s background, color, hover state, border, shadow, and the link’s color and hover color.</li>\n</ul>\n<h4>Further Reading</h4>\n<p>This plugin is developed and maintained by Colorlib. Which is well know for their free <a href=\"https://colorlib.com/wp/themes/\" rel=\"nofollow\"></a>WordPress themes. However, now they are looking to extend their presence in plugin development and believe that Colorlib Login Customizer is a great way to start.</p>\n<p>If you are new to WordPress and want to learn more we have got you covered. Colorlib will teach you how to <a href=\"https://colorlib.com/\" rel=\"nofollow\">start a blog</a> or <a href=\"https://colorlib.com/wp/how-to-make-a-website/\" rel=\"nofollow\">create a website</a> and much more. If you are already familiar with WordPress you likely want to learn how to make it faster and more reliable. That&#8217;s when you want to look into hosting and more specifically <a href=\"http://colorlib.com/wp/wordpress-hosting\" rel=\"nofollow\">WordPress hosting</a>.</p>\n<p>If you enjoy using Colorlib Login Customizer for WordPress please leave a <a href=\"https://wordpress.org/support/plugin/colorlib-login-customiezr/reviews/?filter=5\" rel=\"nofollow\">positive feedback</a>. We are committed to make it the best Login Customizer plugin for WordPress.</p>\n\";s:12:\"installation\";s:418:\"<ol>\n<li>Download the plugin (.zip file) on your hard drive.</li>\n<li>Unzip the zip file contents.</li>\n<li>Upload the <code>colorlib-login-customizer</code> folder to the <code>/wp-content/plugins/</code> directory.</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress.</li>\n<li>A new sub menu item <code>Colorlib Login Customizer</code> will appear in your main Settings menu.</li>\n</ol>\n\";s:9:\"changelog\";s:354:\"<h4>1.2.0</h4>\n<ul>\n<li>Implemented everything from here: https://github.com/puikinsh/colorlib-login-customizer/milestone/1?closed=1</li>\n</ul>\n<h4>1.1</h4>\n<ul>\n<li>Changed templates functionality</li>\n<li>Added new layout options</li>\n<li>Fixed live preview editing</li>\n<li>Fixed minor bugs</li>\n</ul>\n<h4>1.0</h4>\n<ul>\n<li>Initial release</li>\n</ul>\n\";s:3:\"faq\";s:464:\"\n<h4>Installation Instructions</h4>\n<p>\n<ol>\n<li>Download the plugin (.zip file) on your hard drive.</li>\n<li>Unzip the zip file contents.</li>\n<li>Upload the <code>colorlib-login-customizer</code> folder to the <code>/wp-content/plugins/</code> directory.</li>\n<li>Activate the plugin through the &#8216;Plugins&#8217; menu in WordPress.</li>\n<li>A new sub menu item <code>Colorlib Login Customizer</code> will appear in your main Settings menu.</li>\n</ol>\n</p>\n\n\";s:11:\"screenshots\";s:805:\"<ol><li><a href=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-1.jpg?rev=1872192\"><img src=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-1.jpg?rev=1872192\" alt=\"\"></a></li><li><a href=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-2.jpg?rev=1872192\"><img src=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-2.jpg?rev=1872192\" alt=\"\"></a></li><li><a href=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-3.jpg?rev=1888161\"><img src=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-3.jpg?rev=1888161\" alt=\"\"></a></li><li><a href=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-4.jpg?rev=1888161\"><img src=\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-4.jpg?rev=1888161\" alt=\"\"></a></li></ol>\";}s:17:\"short_description\";s:122:\"Colorlib Login Customizer by Colorlib is a plugin that helps you personalize your login form directly from the Customizer.\";s:13:\"download_link\";s:74:\"https://downloads.wordpress.org/plugin/colorlib-login-customizer.1.2.0.zip\";s:11:\"screenshots\";a:4:{i:1;a:2:{s:3:\"src\";s:78:\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-1.jpg?rev=1872192\";s:7:\"caption\";s:0:\"\";}i:2;a:2:{s:3:\"src\";s:78:\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-2.jpg?rev=1872192\";s:7:\"caption\";s:0:\"\";}i:3;a:2:{s:3:\"src\";s:78:\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-3.jpg?rev=1888161\";s:7:\"caption\";s:0:\"\";}i:4;a:2:{s:3:\"src\";s:78:\"https://ps.w.org/colorlib-login-customizer/assets/screenshot-4.jpg?rev=1888161\";s:7:\"caption\";s:0:\"\";}}s:8:\"versions\";a:3:{s:5:\"1.1.0\";s:74:\"https://downloads.wordpress.org/plugin/colorlib-login-customizer.1.1.0.zip\";s:5:\"1.2.0\";s:74:\"https://downloads.wordpress.org/plugin/colorlib-login-customizer.1.2.0.zip\";s:5:\"trunk\";s:68:\"https://downloads.wordpress.org/plugin/colorlib-login-customizer.zip\";}s:5:\"icons\";a:2:{s:2:\"1x\";s:78:\"https://ps.w.org/colorlib-login-customizer/assets/icon-256x256.jpg?rev=1862920\";s:2:\"2x\";s:78:\"https://ps.w.org/colorlib-login-customizer/assets/icon-256x256.jpg?rev=1862920\";}s:12:\"contributors\";a:0:{}}', 'no'),
(201, '_transient_timeout_illdy_hash_update', '1537900012', 'no'),
(202, '_transient_illdy_hash_update', '61b0f82f857ef9bd5c8d72979f4fd65e', 'no');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_postmeta`
--

CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_postmeta`
--

INSERT INTO `wp_postmeta` (`meta_id`, `post_id`, `meta_key`, `meta_value`) VALUES
(1, 2, '_wp_page_template', 'default'),
(4, 5, '_edit_lock', '1537897550:1'),
(5, 7, '_edit_last', '1'),
(6, 7, '_wp_page_template', 'page-templates/no-sidebar.php'),
(7, 7, '_edit_lock', '1537897388:1'),
(8, 5, '_wp_trash_meta_status', 'publish'),
(9, 5, '_wp_trash_meta_time', '1537897577'),
(10, 10, '_edit_lock', '1537898125:1'),
(11, 11, '_wp_attached_file', '2018/09/259777-P4JTS2-110.jpg'),
(12, 11, '_wp_attachment_metadata', 'a:5:{s:5:\"width\";i:5760;s:6:\"height\";i:3840;s:4:\"file\";s:29:\"2018/09/259777-P4JTS2-110.jpg\";s:5:\"sizes\";a:11:{s:9:\"thumbnail\";a:4:{s:4:\"file\";s:29:\"259777-P4JTS2-110-150x150.jpg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";}s:6:\"medium\";a:4:{s:4:\"file\";s:29:\"259777-P4JTS2-110-300x200.jpg\";s:5:\"width\";i:300;s:6:\"height\";i:200;s:9:\"mime-type\";s:10:\"image/jpeg\";}s:12:\"medium_large\";a:4:{s:4:\"file\";s:29:\"259777-P4JTS2-110-768x512.jpg\";s:5:\"width\";i:768;s:6:\"height\";i:512;s:9:\"mime-type\";s:10:\"image/jpeg\";}s:5:\"large\";a:4:{s:4:\"file\";s:30:\"259777-P4JTS2-110-1024x683.jpg\";s:5:\"width\";i:1024;s:6:\"height\";i:683;s:9:\"mime-type\";s:10:\"image/jpeg\";}s:15:\"illdy-blog-list\";a:4:{s:4:\"file\";s:29:\"259777-P4JTS2-110-750x500.jpg\";s:5:\"width\";i:750;s:6:\"height\";i:500;s:9:\"mime-type\";s:10:\"image/jpeg\";}s:25:\"illdy-widget-recent-posts\";a:4:{s:4:\"file\";s:27:\"259777-P4JTS2-110-70x70.jpg\";s:5:\"width\";i:70;s:6:\"height\";i:70;s:9:\"mime-type\";s:10:\"image/jpeg\";}s:32:\"illdy-blog-post-related-articles\";a:4:{s:4:\"file\";s:29:\"259777-P4JTS2-110-240x206.jpg\";s:5:\"width\";i:240;s:6:\"height\";i:206;s:9:\"mime-type\";s:10:\"image/jpeg\";}s:28:\"illdy-front-page-latest-news\";a:4:{s:4:\"file\";s:29:\"259777-P4JTS2-110-250x213.jpg\";s:5:\"width\";i:250;s:6:\"height\";i:213;s:9:\"mime-type\";s:10:\"image/jpeg\";}s:29:\"illdy-front-page-testimonials\";a:4:{s:4:\"file\";s:29:\"259777-P4JTS2-110-127x127.jpg\";s:5:\"width\";i:127;s:6:\"height\";i:127;s:9:\"mime-type\";s:10:\"image/jpeg\";}s:25:\"illdy-front-page-projects\";a:4:{s:4:\"file\";s:29:\"259777-P4JTS2-110-476x476.jpg\";s:5:\"width\";i:476;s:6:\"height\";i:476;s:9:\"mime-type\";s:10:\"image/jpeg\";}s:23:\"illdy-front-page-person\";a:4:{s:4:\"file\";s:29:\"259777-P4JTS2-110-125x125.jpg\";s:5:\"width\";i:125;s:6:\"height\";i:125;s:9:\"mime-type\";s:10:\"image/jpeg\";}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:3:\"1.8\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:21:\"Canon EOS 5D Mark III\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:10:\"1517151167\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:2:\"35\";s:3:\"iso\";s:3:\"100\";s:13:\"shutter_speed\";s:5:\"0.008\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"1\";s:8:\"keywords\";a:0:{}}}'),
(13, 10, '_wp_trash_meta_status', 'publish'),
(14, 10, '_wp_trash_meta_time', '1537898153'),
(16, 12, '_customize_restore_dismissed', '1'),
(17, 13, '_wp_trash_meta_status', 'publish'),
(18, 13, '_wp_trash_meta_time', '1537898366'),
(19, 14, '_wp_trash_meta_status', 'publish'),
(20, 14, '_wp_trash_meta_time', '1537898406'),
(21, 15, '_wp_trash_meta_status', 'publish'),
(22, 15, '_wp_trash_meta_time', '1537898429'),
(23, 16, '_wp_trash_meta_status', 'publish'),
(24, 16, '_wp_trash_meta_time', '1537898443'),
(25, 17, '_wp_trash_meta_status', 'publish'),
(26, 17, '_wp_trash_meta_time', '1537898473'),
(27, 19, '_form', '<label> Your Name (required)\n    [text* your-name] </label>\n\n<label> Your Email (required)\n    [email* your-email] </label>\n\n<label> Subject\n    [text your-subject] </label>\n\n<label> Your Message\n    [textarea your-message] </label>\n\n[submit \"Send\"]'),
(28, 19, '_mail', 'a:8:{s:7:\"subject\";s:23:\"Tienda \"[your-subject]\"\";s:6:\"sender\";s:37:\"[your-name] <jefferariza@outlook.com>\";s:4:\"body\";s:181:\"From: [your-name] <[your-email]>\nSubject: [your-subject]\n\nMessage Body:\n[your-message]\n\n-- \nThis e-mail was sent from a contact form on Tienda (http://127.0.0.1/wordpress/wordpress)\";s:9:\"recipient\";s:23:\"jefferariza@outlook.com\";s:18:\"additional_headers\";s:22:\"Reply-To: [your-email]\";s:11:\"attachments\";s:0:\"\";s:8:\"use_html\";i:0;s:13:\"exclude_blank\";i:0;}'),
(29, 19, '_mail_2', 'a:9:{s:6:\"active\";b:0;s:7:\"subject\";s:23:\"Tienda \"[your-subject]\"\";s:6:\"sender\";s:32:\"Tienda <jefferariza@outlook.com>\";s:4:\"body\";s:123:\"Message Body:\n[your-message]\n\n-- \nThis e-mail was sent from a contact form on Tienda (http://127.0.0.1/wordpress/wordpress)\";s:9:\"recipient\";s:12:\"[your-email]\";s:18:\"additional_headers\";s:33:\"Reply-To: jefferariza@outlook.com\";s:11:\"attachments\";s:0:\"\";s:8:\"use_html\";i:0;s:13:\"exclude_blank\";i:0;}'),
(30, 19, '_messages', 'a:8:{s:12:\"mail_sent_ok\";s:45:\"Thank you for your message. It has been sent.\";s:12:\"mail_sent_ng\";s:71:\"There was an error trying to send your message. Please try again later.\";s:16:\"validation_error\";s:61:\"One or more fields have an error. Please check and try again.\";s:4:\"spam\";s:71:\"There was an error trying to send your message. Please try again later.\";s:12:\"accept_terms\";s:69:\"You must accept the terms and conditions before sending your message.\";s:16:\"invalid_required\";s:22:\"The field is required.\";s:16:\"invalid_too_long\";s:22:\"The field is too long.\";s:17:\"invalid_too_short\";s:23:\"The field is too short.\";}'),
(31, 19, '_additional_settings', NULL),
(32, 19, '_locale', 'es_CO'),
(33, 22, '_edit_lock', '1537899682:1'),
(34, 22, '_wp_trash_meta_status', 'publish'),
(35, 22, '_wp_trash_meta_time', '1537899713'),
(36, 24, '_edit_lock', '1537899803:1'),
(37, 24, '_wp_trash_meta_status', 'publish'),
(38, 24, '_wp_trash_meta_time', '1537899807'),
(39, 25, '_edit_lock', '1537899923:1'),
(40, 25, '_wp_trash_meta_status', 'publish'),
(41, 25, '_wp_trash_meta_time', '1537899945'),
(42, 26, '_wp_trash_meta_status', 'publish'),
(43, 26, '_wp_trash_meta_time', '1537899998'),
(45, 27, '_customize_restore_dismissed', '1'),
(46, 28, '_edit_lock', '1537900381:1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_posts`
--

CREATE TABLE `wp_posts` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `post_author` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_posts`
--

INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(1, 1, '2018-09-25 17:38:02', '2018-09-25 17:38:02', 'Bienvenido a WordPress. Esta es tu primera entrada. Edítala o bórrala, ¡y comienza a escribir!', '¡Hola mundo!', '', 'publish', 'open', 'open', '', 'hola-mundo', '', '', '2018-09-25 17:38:02', '2018-09-25 17:38:02', '', 0, 'http://127.0.0.1/wordpress/wordpress/?p=1', 0, 'post', '', 1),
(2, 1, '2018-09-25 17:38:02', '2018-09-25 17:38:02', 'Esta es una página de ejemplo, Es diferente a una entrada de un blog porque se mantiene estática y se mostrará en la barra de navegación (en la mayoría de temas). Casi todo el mundo comienza con una página Sobre mí para presentarse a los potenciales visitantes. Podría ser algo así: <blockquote>¡Hola!: Soy mensajero por el día, aspirante a actor por la noche y esta es mi web. Vivo en Madrid, tengo perrazo llamado Juan y me encantan las piñas coladas (y que me pille un chaparrón)</blockquote> … o algo así: <blockquote>La empresa Calcetines XYZ se fundó en 1971, y ha estado produciendo calcetines de calidad para sus clientes desde entonces. Ubicada en Gothan, la empresa XYZ tiene más de 2.000 empleados e intenta ayudar en lo que puede para mejorar la vida en Gothan</blockquote> Si eres nuevo en WordPress deberías ir a <a href=\"http://127.0.0.1/wordpress/wordpress/wp-admin/\">tu escritorio</a> para borrar esta página y crear algunas nuevas con tu contenido. ¡Pásalo bien!', 'Página de ejemplo', '', 'publish', 'closed', 'open', '', 'pagina-ejemplo', '', '', '2018-09-25 17:38:02', '2018-09-25 17:38:02', '', 0, 'http://127.0.0.1/wordpress/wordpress/?page_id=2', 0, 'page', '', 0),
(3, 1, '2018-09-25 17:38:17', '0000-00-00 00:00:00', '', 'Borrador automático', '', 'auto-draft', 'open', 'open', '', '', '', '', '2018-09-25 17:38:17', '0000-00-00 00:00:00', '', 0, 'http://127.0.0.1/wordpress/wordpress/?p=3', 0, 'post', '', 0),
(5, 1, '2018-09-25 17:46:17', '2018-09-25 17:46:17', '{\n    \"illdy::illdy_jumbotron_enable_featured_image\": {\n        \"value\": 1,\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 17:46:17\"\n    },\n    \"show_on_front\": {\n        \"value\": \"page\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 17:46:17\"\n    },\n    \"page_on_front\": {\n        \"value\": \"7\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 17:46:17\"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '5da73229-7d00-41bf-8e34-3ac6b62cd73b', '', '', '2018-09-25 17:46:17', '2018-09-25 17:46:17', '', 0, 'http://127.0.0.1/wordpress/wordpress/?p=5', 0, 'customize_changeset', '', 0),
(6, 1, '2018-09-25 17:44:29', '0000-00-00 00:00:00', '', 'Borrador automático', '', 'auto-draft', 'closed', 'closed', '', '', '', '', '2018-09-25 17:44:29', '0000-00-00 00:00:00', '', 0, 'http://127.0.0.1/wordpress/wordpress/?page_id=6', 0, 'page', '', 0),
(7, 1, '2018-09-25 17:44:53', '2018-09-25 17:44:53', '', 'h', '', 'publish', 'closed', 'closed', '', 'h', '', '', '2018-09-25 17:45:14', '2018-09-25 17:45:14', '', 0, 'http://127.0.0.1/wordpress/wordpress/?page_id=7', 0, 'page', '', 0),
(8, 1, '2018-09-25 17:44:53', '2018-09-25 17:44:53', '', 'h', '', 'inherit', 'closed', 'closed', '', '7-revision-v1', '', '', '2018-09-25 17:44:53', '2018-09-25 17:44:53', '', 7, 'http://127.0.0.1/wordpress/wordpress/2018/09/25/7-revision-v1/', 0, 'revision', '', 0),
(9, 1, '2018-09-25 17:45:24', '2018-09-25 17:45:24', '', 'h', '', 'inherit', 'closed', 'closed', '', '7-autosave-v1', '', '', '2018-09-25 17:45:24', '2018-09-25 17:45:24', '', 7, 'http://127.0.0.1/wordpress/wordpress/2018/09/25/7-autosave-v1/', 0, 'revision', '', 0),
(10, 1, '2018-09-25 17:55:53', '2018-09-25 17:55:53', '{\n    \"illdy::illdy_jumbotron_enable_featured_image\": {\n        \"value\": true,\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 17:49:16\"\n    },\n    \"illdy::illdy_about_general_show\": {\n        \"value\": true,\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 17:48:50\"\n    },\n    \"illdy::illdy_jumbotron_enable_parallax_effect\": {\n        \"value\": true,\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 17:49:16\"\n    },\n    \"illdy::illdy_jumbotron_general_image\": {\n        \"value\": \"http://127.0.0.1/wordpress/wordpress/wp-content/uploads/2018/09/259777-P4JTS2-110.jpg\",\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 17:55:53\"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'b7ea71eb-4aa9-462b-a405-b53e918bab5d', '', '', '2018-09-25 17:55:53', '2018-09-25 17:55:53', '', 0, 'http://127.0.0.1/wordpress/wordpress/?p=10', 0, 'customize_changeset', '', 0),
(11, 1, '2018-09-25 17:55:30', '2018-09-25 17:55:30', '', '259777-P4JTS2-110', '', 'inherit', 'open', 'closed', '', '259777-p4jts2-110', '', '', '2018-09-25 17:55:30', '2018-09-25 17:55:30', '', 0, 'http://127.0.0.1/wordpress/wordpress/wp-content/uploads/2018/09/259777-P4JTS2-110.jpg', 0, 'attachment', 'image/jpeg', 0),
(12, 1, '2018-09-25 17:58:13', '0000-00-00 00:00:00', '{\n    \"show_on_front\": {\n        \"value\": \"page\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 17:58:13\"\n    },\n    \"page_on_front\": {\n        \"value\": \"7\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 17:58:13\"\n    },\n    \"page_for_posts\": {\n        \"value\": \"7\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 17:58:13\"\n    }\n}', '', '', 'auto-draft', 'closed', 'closed', '', 'b8b03cdb-60d1-434b-8a76-4f977ed8daf8', '', '', '2018-09-25 17:58:13', '0000-00-00 00:00:00', '', 0, 'http://127.0.0.1/wordpress/wordpress/?p=12', 0, 'customize_changeset', '', 0),
(13, 1, '2018-09-25 17:59:25', '2018-09-25 17:59:25', '{\n    \"show_on_front\": {\n        \"value\": \"page\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 17:59:25\"\n    },\n    \"page_for_posts\": {\n        \"value\": \"2\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 17:59:25\"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'de7189bd-c170-4e25-9fe8-f8e830f886df', '', '', '2018-09-25 17:59:25', '2018-09-25 17:59:25', '', 0, 'http://127.0.0.1/wordpress/wordpress/2018/09/25/de7189bd-c170-4e25-9fe8-f8e830f886df/', 0, 'customize_changeset', '', 0),
(14, 1, '2018-09-25 18:00:05', '2018-09-25 18:00:05', '{\n    \"illdy::illdy_about_general_title\": {\n        \"value\": \"About 2\",\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:00:05\"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '1ca04008-30f3-4cda-81ea-1bdb541db881', '', '', '2018-09-25 18:00:05', '2018-09-25 18:00:05', '', 0, 'http://127.0.0.1/wordpress/wordpress/2018/09/25/1ca04008-30f3-4cda-81ea-1bdb541db881/', 0, 'customize_changeset', '', 0),
(15, 1, '2018-09-25 18:00:29', '2018-09-25 18:00:29', '{\n    \"illdy::illdy_about_general_show\": {\n        \"value\": true,\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:00:29\"\n    },\n    \"illdy::illdy_about_general_entry\": {\n        \"value\": \"It is an amazing one-page theme with great features that offers an incredible experience. It is easy to install, make changes, adapt for your business. A modern design with clean lines and styling for a wide variety of content, exactly how a business design should be. You can add as many images as you want to the main header area and turn them into slider. s\",\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:00:29\"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '03fe4297-9e1d-439b-92ad-473b286bd4d9', '', '', '2018-09-25 18:00:29', '2018-09-25 18:00:29', '', 0, 'http://127.0.0.1/wordpress/wordpress/2018/09/25/03fe4297-9e1d-439b-92ad-473b286bd4d9/', 0, 'customize_changeset', '', 0),
(16, 1, '2018-09-25 18:00:42', '2018-09-25 18:00:42', '{\n    \"illdy::illdy_projects_lightbox\": {\n        \"value\": true,\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:00:42\"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '65ad44c2-3d15-47b3-a25d-312b3074663c', '', '', '2018-09-25 18:00:42', '2018-09-25 18:00:42', '', 0, 'http://127.0.0.1/wordpress/wordpress/2018/09/25/65ad44c2-3d15-47b3-a25d-312b3074663c/', 0, 'customize_changeset', '', 0),
(17, 1, '2018-09-25 18:01:13', '2018-09-25 18:01:13', '{\n    \"illdy::illdy_projects_general_title\": {\n        \"value\": \"Projects s\",\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:01:13\"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '0ff9b3be-57c0-4bac-8740-b85a55ac0417', '', '', '2018-09-25 18:01:13', '2018-09-25 18:01:13', '', 0, 'http://127.0.0.1/wordpress/wordpress/2018/09/25/0ff9b3be-57c0-4bac-8740-b85a55ac0417/', 0, 'customize_changeset', '', 0),
(18, 0, '2018-09-25 18:26:38', '0000-00-00 00:00:00', '', 'Illdy Backup Settings', '', 'draft', 'closed', 'closed', '', '', '', '', '2018-09-25 18:26:38', '2018-09-25 18:26:38', '', 0, 'http://127.0.0.1/wordpress/wordpress/?page_id=18', 0, 'page', '', 0),
(19, 1, '2018-09-25 18:04:19', '2018-09-25 18:04:19', '<label> Your Name (required)\n    [text* your-name] </label>\n\n<label> Your Email (required)\n    [email* your-email] </label>\n\n<label> Subject\n    [text your-subject] </label>\n\n<label> Your Message\n    [textarea your-message] </label>\n\n[submit \"Send\"]\nTienda \"[your-subject]\"\n[your-name] <jefferariza@outlook.com>\nFrom: [your-name] <[your-email]>\nSubject: [your-subject]\n\nMessage Body:\n[your-message]\n\n-- \nThis e-mail was sent from a contact form on Tienda (http://127.0.0.1/wordpress/wordpress)\njefferariza@outlook.com\nReply-To: [your-email]\n\n0\n0\n\nTienda \"[your-subject]\"\nTienda <jefferariza@outlook.com>\nMessage Body:\n[your-message]\n\n-- \nThis e-mail was sent from a contact form on Tienda (http://127.0.0.1/wordpress/wordpress)\n[your-email]\nReply-To: jefferariza@outlook.com\n\n0\n0\nThank you for your message. It has been sent.\nThere was an error trying to send your message. Please try again later.\nOne or more fields have an error. Please check and try again.\nThere was an error trying to send your message. Please try again later.\nYou must accept the terms and conditions before sending your message.\nThe field is required.\nThe field is too long.\nThe field is too short.', 'Contact form 1', '', 'publish', 'closed', 'closed', '', 'contact-form-1', '', '', '2018-09-25 18:04:19', '2018-09-25 18:04:19', '', 0, 'http://127.0.0.1/wordpress/wordpress/?post_type=wpcf7_contact_form&p=19', 0, 'wpcf7_contact_form', '', 0),
(20, 1, '2018-09-25 18:04:21', '2018-09-25 18:04:21', '', 'Front Page', '', 'publish', 'closed', 'closed', '', 'front-page', '', '', '2018-09-25 18:04:21', '2018-09-25 18:04:21', '', 0, 'http://127.0.0.1/wordpress/wordpress/front-page/', 0, 'page', '', 0),
(21, 1, '2018-09-25 18:04:21', '2018-09-25 18:04:21', '', 'Blog', '', 'publish', 'closed', 'closed', '', 'blog', '', '', '2018-09-25 18:04:21', '2018-09-25 18:04:21', '', 0, 'http://127.0.0.1/wordpress/wordpress/blog/', 0, 'page', '', 0),
(22, 1, '2018-09-25 18:21:52', '2018-09-25 18:21:52', '{\n    \"illdy::illdy_full_width_general_title\": {\n        \"value\": \"map\",\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:16:24\"\n    },\n    \"illdy::illdy_full_width_general_entry\": {\n        \"value\": \"<iframe src=\\\"https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d5701.557247325895!2d-74.80578400685714!3d10.975619207683588!3m2!1i1024!2i768!4f13.1!5e0!3m2!1ses-419!2sco!4v1537899507346\\\" width=\\\"600\\\" height=\\\"450\\\" frameborder=\\\"0\\\" style=\\\"border:0\\\" allowfullscreen></iframe>\",\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:19:16\"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', '2bec7ba0-7f8d-452c-9759-f71639eec97f', '', '', '2018-09-25 18:21:52', '2018-09-25 18:21:52', '', 0, 'http://127.0.0.1/wordpress/wordpress/?p=22', 0, 'customize_changeset', '', 0),
(23, 1, '2018-09-25 18:21:52', '2018-09-25 18:21:52', '', 'Illdy Backup Settings', '', 'inherit', 'closed', 'closed', '', '18-revision-v1', '', '', '2018-09-25 18:21:52', '2018-09-25 18:21:52', '', 18, 'http://127.0.0.1/wordpress/wordpress/2018/09/25/18-revision-v1/', 0, 'revision', '', 0),
(24, 1, '2018-09-25 18:23:27', '2018-09-25 18:23:27', '{\n    \"illdy::illdy_full_width_general_entry\": {\n        \"value\": \"<iframe style=\\\"border: 0;height:300px;wight:500px\\\" src=\\\"https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d5701.557247325895!2d-74.80578400685714!3d10.975619207683588!3m2!1i1024!2i768!4f13.1!5e0!3m2!1ses-419!2sco!4v1537899507346\\\" width=\\\"600\\\" height=\\\"450\\\" frameborder=\\\"0\\\" allowfullscreen=\\\"\\\"></iframe>\",\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:23:17\"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'c56f57ea-10ee-41b4-a706-a327b22464de', '', '', '2018-09-25 18:23:27', '2018-09-25 18:23:27', '', 0, 'http://127.0.0.1/wordpress/wordpress/?p=24', 0, 'customize_changeset', '', 0),
(25, 1, '2018-09-25 18:25:45', '2018-09-25 18:25:45', '{\n    \"illdy::illdy_full_width_general_entry\": {\n        \"value\": \"\",\n        \"type\": \"theme_mod\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:25:45\"\n    },\n    \"sidebars_widgets[front-page-full-width-sidebar]\": {\n        \"value\": [\n            \"custom_html-3\"\n        ],\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:25:20\"\n    },\n    \"widget_custom_html[3]\": {\n        \"value\": {\n            \"encoded_serialized_instance\": \"YToyOntzOjU6InRpdGxlIjtzOjA6IiI7czo3OiJjb250ZW50IjtzOjI3MjoiPGlmcmFtZSBzcmM9Imh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vbWFwcy9lbWJlZD9wYj0hMW0xMCExbTghMW0zITFkNTcwMS41NTcyNDczMjU4OTUhMmQtNzQuODA1Nzg0MDA2ODU3MTQhM2QxMC45NzU2MTkyMDc2ODM1ODghM20yITFpMTAyNCEyaTc2OCE0ZjEzLjEhNWUwITNtMiExc2VzLTQxOSEyc2NvITR2MTUzNzg5OTUwNzM0NiIgd2lkdGg9IjgwMCIgaGVpZ2h0PSI2MDAiIGZyYW1lYm9yZGVyPSIwIiBzdHlsZT0iYm9yZGVyOjAiIGFsbG93ZnVsbHNjcmVlbj48L2lmcmFtZT4iO30=\",\n            \"title\": \"\",\n            \"is_widget_customizer_js_value\": true,\n            \"instance_hash_key\": \"2a88ddadcde91d978d599e8af272fbca\"\n        },\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:25:20\"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'b0224741-b015-442f-b02e-826f0f1e7cd3', '', '', '2018-09-25 18:25:45', '2018-09-25 18:25:45', '', 0, 'http://127.0.0.1/wordpress/wordpress/?p=25', 0, 'customize_changeset', '', 0),
(26, 1, '2018-09-25 18:26:38', '2018-09-25 18:26:38', '{\n    \"widget_custom_html[3]\": {\n        \"value\": {\n            \"encoded_serialized_instance\": \"YToyOntzOjU6InRpdGxlIjtzOjA6IiI7czo3OiJjb250ZW50IjtzOjI3MzoiPGlmcmFtZSBzcmM9Imh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vbWFwcy9lbWJlZD9wYj0hMW0xMCExbTghMW0zITFkNTcwMS41NTcyNDczMjU4OTUhMmQtNzQuODA1Nzg0MDA2ODU3MTQhM2QxMC45NzU2MTkyMDc2ODM1ODghM20yITFpMTAyNCEyaTc2OCE0ZjEzLjEhNWUwITNtMiExc2VzLTQxOSEyc2NvITR2MTUzNzg5OTUwNzM0NiIgd2lkdGg9IjEwMCUiIGhlaWdodD0iNDAwIiBmcmFtZWJvcmRlcj0iMCIgc3R5bGU9ImJvcmRlcjowIiBhbGxvd2Z1bGxzY3JlZW4+PC9pZnJhbWU+Ijt9\",\n            \"title\": \"\",\n            \"is_widget_customizer_js_value\": true,\n            \"instance_hash_key\": \"e73b8fc4685b5d15aa7e6eff917b62d8\"\n        },\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:26:38\"\n    }\n}', '', '', 'trash', 'closed', 'closed', '', 'f8184b9b-b53a-4115-9b29-7823dd1f96b1', '', '', '2018-09-25 18:26:38', '2018-09-25 18:26:38', '', 0, 'http://127.0.0.1/wordpress/wordpress/2018/09/25/f8184b9b-b53a-4115-9b29-7823dd1f96b1/', 0, 'customize_changeset', '', 0),
(27, 1, '2018-09-25 18:30:08', '0000-00-00 00:00:00', '{\n    \"widget_illdy_counter[4]\": {\n        \"value\": {\n            \"encoded_serialized_instance\": \"YTo1OntzOjU6InRpdGxlIjtzOjg6IlByb2plY3RzIjtzOjk6ImRhdGFfZnJvbSI7aToxO3M6NzoiZGF0YV90byI7aToyNjA7czoxMDoiZGF0YV9zcGVlZCI7aTo5OTk5OTk5O3M6MjE6ImRhdGFfcmVmcmVzaF9pbnRlcnZhbCI7aToxMDAwO30=\",\n            \"title\": \"Projects\",\n            \"is_widget_customizer_js_value\": true,\n            \"instance_hash_key\": \"485f90c65aecd5337b16f34edb6959bc\"\n        },\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:30:08\"\n    }\n}', '', '', 'auto-draft', 'closed', 'closed', '', '2cf5c9db-71ac-4f92-b827-a80c7efa62b7', '', '', '2018-09-25 18:30:08', '0000-00-00 00:00:00', '', 0, 'http://127.0.0.1/wordpress/wordpress/?p=27', 0, 'customize_changeset', '', 0),
(28, 1, '2018-09-25 18:32:35', '0000-00-00 00:00:00', '{\n    \"widget_illdy_counter[4]\": {\n        \"value\": {\n            \"encoded_serialized_instance\": \"YTo1OntzOjU6InRpdGxlIjtzOjg6IlByb2plY3RzIjtzOjk6ImRhdGFfZnJvbSI7aToxO3M6NzoiZGF0YV90byI7aToyNjA7czoxMDoiZGF0YV9zcGVlZCI7aTo5OTkwMDA7czoyMToiZGF0YV9yZWZyZXNoX2ludGVydmFsIjtpOjEwMDt9\",\n            \"title\": \"Projects\",\n            \"is_widget_customizer_js_value\": true,\n            \"instance_hash_key\": \"691ccd0e0e5105147c8eb8f415e1c3e8\"\n        },\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2018-09-25 18:32:35\"\n    }\n}', '', '', 'auto-draft', 'closed', 'closed', '', 'dc19e922-f570-4d5a-8944-b6eefab2653e', '', '', '2018-09-25 18:32:35', '0000-00-00 00:00:00', '', 0, 'http://127.0.0.1/wordpress/wordpress/?p=28', 0, 'customize_changeset', '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_termmeta`
--

CREATE TABLE `wp_termmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_terms`
--

CREATE TABLE `wp_terms` (
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_terms`
--

INSERT INTO `wp_terms` (`term_id`, `name`, `slug`, `term_group`) VALUES
(1, 'Sin categoría', 'sin-categoria', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_term_relationships`
--

CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_term_relationships`
--

INSERT INTO `wp_term_relationships` (`object_id`, `term_taxonomy_id`, `term_order`) VALUES
(1, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_term_taxonomy`
--

CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_term_taxonomy`
--

INSERT INTO `wp_term_taxonomy` (`term_taxonomy_id`, `term_id`, `taxonomy`, `description`, `parent`, `count`) VALUES
(1, 1, 'category', '', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_usermeta`
--

CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_usermeta`
--

INSERT INTO `wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES
(1, 1, 'nickname', 'admin'),
(2, 1, 'first_name', ''),
(3, 1, 'last_name', ''),
(4, 1, 'description', ''),
(5, 1, 'rich_editing', 'true'),
(6, 1, 'syntax_highlighting', 'true'),
(7, 1, 'comment_shortcuts', 'false'),
(8, 1, 'admin_color', 'fresh'),
(9, 1, 'use_ssl', '0'),
(10, 1, 'show_admin_bar_front', 'true'),
(11, 1, 'locale', ''),
(12, 1, 'wp_capabilities', 'a:1:{s:13:\"administrator\";b:1;}'),
(13, 1, 'wp_user_level', '10'),
(14, 1, 'dismissed_wp_pointers', ''),
(15, 1, 'show_welcome_panel', '1'),
(16, 1, 'session_tokens', 'a:1:{s:64:\"5fb9244599031de69fff96ceec900afb2dd629472afbb797392ffa8ae8de853d\";a:4:{s:10:\"expiration\";i:1538069894;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:115:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36\";s:5:\"login\";i:1537897094;}}'),
(17, 1, 'wp_dashboard_quick_press_last_post_id', '3'),
(18, 1, 'community-events-location', 'a:1:{s:2:\"ip\";s:9:\"127.0.0.0\";}'),
(19, 1, 'wp_user-settings', 'editor=tinymce&libraryContent=browse'),
(20, 1, 'wp_user-settings-time', '1537900250');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wp_users`
--

CREATE TABLE `wp_users` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wp_users`
--

INSERT INTO `wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES
(1, 'admin', '$P$BSoKupJ8jhORR3EBC0V2fSBzXBlYtG.', 'admin', 'jefferariza@outlook.com', '', '2018-09-25 17:38:01', '', 0, 'admin');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `wp_commentmeta`
--
ALTER TABLE `wp_commentmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indices de la tabla `wp_comments`
--
ALTER TABLE `wp_comments`
  ADD PRIMARY KEY (`comment_ID`),
  ADD KEY `comment_post_ID` (`comment_post_ID`),
  ADD KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  ADD KEY `comment_date_gmt` (`comment_date_gmt`),
  ADD KEY `comment_parent` (`comment_parent`),
  ADD KEY `comment_author_email` (`comment_author_email`(10));

--
-- Indices de la tabla `wp_links`
--
ALTER TABLE `wp_links`
  ADD PRIMARY KEY (`link_id`),
  ADD KEY `link_visible` (`link_visible`);

--
-- Indices de la tabla `wp_options`
--
ALTER TABLE `wp_options`
  ADD PRIMARY KEY (`option_id`),
  ADD UNIQUE KEY `option_name` (`option_name`);

--
-- Indices de la tabla `wp_postmeta`
--
ALTER TABLE `wp_postmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indices de la tabla `wp_posts`
--
ALTER TABLE `wp_posts`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `post_name` (`post_name`(191)),
  ADD KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  ADD KEY `post_parent` (`post_parent`),
  ADD KEY `post_author` (`post_author`);

--
-- Indices de la tabla `wp_termmeta`
--
ALTER TABLE `wp_termmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `term_id` (`term_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indices de la tabla `wp_terms`
--
ALTER TABLE `wp_terms`
  ADD PRIMARY KEY (`term_id`),
  ADD KEY `slug` (`slug`(191)),
  ADD KEY `name` (`name`(191));

--
-- Indices de la tabla `wp_term_relationships`
--
ALTER TABLE `wp_term_relationships`
  ADD PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  ADD KEY `term_taxonomy_id` (`term_taxonomy_id`);

--
-- Indices de la tabla `wp_term_taxonomy`
--
ALTER TABLE `wp_term_taxonomy`
  ADD PRIMARY KEY (`term_taxonomy_id`),
  ADD UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  ADD KEY `taxonomy` (`taxonomy`);

--
-- Indices de la tabla `wp_usermeta`
--
ALTER TABLE `wp_usermeta`
  ADD PRIMARY KEY (`umeta_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indices de la tabla `wp_users`
--
ALTER TABLE `wp_users`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_login_key` (`user_login`),
  ADD KEY `user_nicename` (`user_nicename`),
  ADD KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `wp_commentmeta`
--
ALTER TABLE `wp_commentmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp_comments`
--
ALTER TABLE `wp_comments`
  MODIFY `comment_ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `wp_links`
--
ALTER TABLE `wp_links`
  MODIFY `link_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp_options`
--
ALTER TABLE `wp_options`
  MODIFY `option_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=203;

--
-- AUTO_INCREMENT de la tabla `wp_postmeta`
--
ALTER TABLE `wp_postmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `wp_posts`
--
ALTER TABLE `wp_posts`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `wp_termmeta`
--
ALTER TABLE `wp_termmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wp_terms`
--
ALTER TABLE `wp_terms`
  MODIFY `term_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `wp_term_taxonomy`
--
ALTER TABLE `wp_term_taxonomy`
  MODIFY `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `wp_usermeta`
--
ALTER TABLE `wp_usermeta`
  MODIFY `umeta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `wp_users`
--
ALTER TABLE `wp_users`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
