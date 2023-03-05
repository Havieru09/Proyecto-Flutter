-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 02-03-2023 a las 02:14:13
-- Versión del servidor: 5.7.40
-- Versión de PHP: 8.0.26

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `aulas`
--

INSERT INTO `aulas` (`id`, `nombre_aulas`) VALUES
(1, 'Laboratorio E4'),
(2, 'Laboratorio E5'),
(3, 'B300');

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
  `tipo` varchar(20) NOT NULL,
  `detalle` text NOT NULL,
  `estado` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_aula_id` (`aula_id`),
  KEY `FK_bloque_id` (`bloque_id`),
  KEY `FK_usuario_id` (`usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `solicitud`
--

INSERT INTO `solicitud` (`id`, `usuario_id`, `bloque_id`, `aula_id`, `tipo`, `detalle`, `estado`) VALUES
(1, 1, 1, 1, 'Abrir Aula', 'Ejemplo', 'pendiente'),
(3, 4, 1, 2, 'abrir puerta', '', 'terminado'),
(4, 4, 3, 3, 'soporte', 'Encender proyector', 'en_camino'),
(5, 1, 1, 3, 'aire acondicionado', 'encender aire', 'pendiente'),
(6, 1, 1, 1, 'prueba', 'probando antes de pegar', 'pendiente'),
(7, 1, 1, 2, 'hola', 'como estas', 'pendiente');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `usuario`, 'correo', `psw`, `rol`) VALUES
(1, 'Pepe', '', '123', 'admin'),
(4, 'Joe Llerena', '', '1234', 'docente'),
(5, 'Yajaira Bermeo', '', '1234', 'docente'),
(6, 'Gabriel', '', 'admin123', 'admin');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `solicitud`
--
ALTER TABLE `solicitud`
  ADD CONSTRAINT `FK_aula_id` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`),
  ADD CONSTRAINT `FK_bloque_id` FOREIGN KEY (`bloque_id`) REFERENCES `bloques` (`id`),
  ADD CONSTRAINT `FK_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
