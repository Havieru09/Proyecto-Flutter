-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3308
-- Tiempo de generación: 05-03-2023 a las 20:12:51
-- Versión del servidor: 5.7.36
-- Versión de PHP: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbsolicitud`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aulas`
--

DROP TABLE IF EXISTS `aulas`;
CREATE TABLE IF NOT EXISTS `aulas` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `nombre_aulas` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `aulas`
--

INSERT INTO `aulas` (`id`, `nombre_aulas`) VALUES
(1, 'Laboratorio E4'),
(2, 'Laboratorio E5'),
(3, 'Aula B300'),
(4, 'Aula D301');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bloques`
--

DROP TABLE IF EXISTS `bloques`;
CREATE TABLE IF NOT EXISTS `bloques` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `nombre_bloque` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `bloques`
--

INSERT INTO `bloques` (`id`, `nombre_bloque`) VALUES
(1, 'E'),
(2, 'D'),
(3, 'B');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud`
--

DROP TABLE IF EXISTS `solicitud`;
CREATE TABLE IF NOT EXISTS `solicitud` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(12) NOT NULL,
  `bloque_id` int(12) NOT NULL,
  `aula_id` int(12) NOT NULL,
  `tipo_id` int(12) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `detalle` text NOT NULL,
  `estado` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_aula_id` (`aula_id`),
  KEY `FK_bloque_id` (`bloque_id`),
  KEY `FK_usuario_id` (`usuario_id`),
  KEY `FK_tipo_id` (`tipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `solicitud`
--



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

DROP TABLE IF EXISTS `tipo`;
CREATE TABLE IF NOT EXISTS `tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`id`, `nombre_tipo`) VALUES
(1, 'mantenimiento'),
(2, 'laboratorista');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(25) NOT NULL,
  `correo` varchar(25) NOT NULL,
  `psw` varchar(25) NOT NULL,
  `rol` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `usuario`, `correo`, `psw`, `rol`) VALUES
(1, 'Pepe', '', '1234', 'soporte'),
(4, 'Joe Llerena', '', 'undefined', 'soporte'),
(5, 'Yajaira Bermeo', '', 'undefined', '5'),
(6, 'Gabriel', '', 'undefined', 'undefined'),
(7, 'Javier', '', 'undefined', 'undefined');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `solicitud`
--
ALTER TABLE `solicitud`
  ADD CONSTRAINT `FK_aula_id` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`),
  ADD CONSTRAINT `FK_bloque_id` FOREIGN KEY (`bloque_id`) REFERENCES `bloques` (`id`),
  ADD CONSTRAINT `FK_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `FK_tipo_id` FOREIGN KEY (`tipo_id`) REFERENCES `tipo` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;