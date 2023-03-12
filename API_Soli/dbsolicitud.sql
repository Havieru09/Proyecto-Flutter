-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3308
-- Tiempo de generación: 12-03-2023 a las 17:18:10
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_aulas` varchar(15) NOT NULL,
  `bloque_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_aula_idx` (`bloque_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `aulas`
--

INSERT INTO `aulas` (`id`, `nombre_aulas`, `bloque_id`) VALUES
(13, 'Laboratorio E4', 18),
(14, 'Laboratorio E3', 18),
(15, 'Aula 309', 15),
(16, 'Sala I', 14),
(17, 'Aula 108', 17);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bloques`
--

DROP TABLE IF EXISTS `bloques`;
CREATE TABLE IF NOT EXISTS `bloques` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_bloque` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `bloques`
--

INSERT INTO `bloques` (`id`, `nombre_bloque`) VALUES
(14, 'A'),
(15, 'B'),
(16, 'C'),
(17, 'D'),
(18, 'E');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id`, `nombre_rol`) VALUES
(1, 'admin'),
(2, 'cliente'),
(3, 'mantenimiento'),
(4, 'laboratorista');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud`
--

DROP TABLE IF EXISTS `solicitud`;
CREATE TABLE IF NOT EXISTS `solicitud` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `aula_id` int(11) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  `detalle` text NOT NULL,
  `estado` varchar(20) NOT NULL,
  `fecha_inicial` date NOT NULL,
  `fecha_final` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_aula_id` (`aula_id`),
  KEY `FK_usuario_id` (`usuario_id`),
  KEY `FK_tipo_id` (`tipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `solicitud`
--

INSERT INTO `solicitud` (`id`, `usuario_id`, `aula_id`, `tipo_id`, `detalle`, `estado`, `fecha_inicial`, `fecha_final`) VALUES
(1, 9, 13, 3, 'Abrir puerta', 'terminado', '2023-03-01', '2023-03-09'),
(2, 9, 13, 3, 'Abrir puerta', 'terminado', '2023-03-09', '2023-03-09'),
(3, 9, 14, 3, 'Abrir puerta', 'terminado', '2023-03-09', '2023-03-09'),
(4, 9, 15, 3, 'Abrir puerta', 'terminado', '2023-03-09', '2023-03-09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

DROP TABLE IF EXISTS `tipo`;
CREATE TABLE IF NOT EXISTS `tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`id`, `nombre_tipo`) VALUES
(1, 'mantenimiento'),
(2, 'laboratorista'),
(3, 'abrir puerta'),
(4, 'cerrar puerta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) NOT NULL,
  `apellido` varchar(25) NOT NULL,
  `cedula` varchar(10) NOT NULL,
  `direccion` varchar(25) NOT NULL,
  `usuario` varchar(25) NOT NULL,
  `correo` varchar(25) NOT NULL,
  `psw` varchar(25) NOT NULL,
  `rol_id` int(12) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_rol_id` (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `apellido`, `cedula`, `direccion`, `usuario`, `correo`, `psw`, `rol_id`) VALUES
(8, 'Juan', 'Valdez', '0934567899', 'Av Orellana', 'juan', 'juan@ups.edu.ec', '123', 1),
(9, 'Joe', 'Llerena', '0934567899', 'Av Orellana', 'joelle', 'joe@ups.edu.ec', '123', 3),
(10, 'Javier', 'Murillo', '0952903839', 'Av Orellana', 'havieru', 'jmurillor2@ups.edu.ec', '123', 2);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `aulas`
--
ALTER TABLE `aulas`
  ADD CONSTRAINT `fk_aula` FOREIGN KEY (`bloque_id`) REFERENCES `bloques` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `solicitud`
--
ALTER TABLE `solicitud`
  ADD CONSTRAINT `FK_aula_id` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`),
  ADD CONSTRAINT `FK_tipo_id` FOREIGN KEY (`tipo_id`) REFERENCES `tipo` (`id`),
  ADD CONSTRAINT `FK_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `FK_rol_id` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`id`),
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
