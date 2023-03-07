<?php 

require_once __DIR__ . '/../includes/app.php';

use MVC\Router;
use Controllers\LoginController;
use Controllers\DashboardController;
$router = new Router();

$router->get('/',[LoginController::class, 'login']);
$router->post('/',[LoginController::class, 'login']);
$router->get('/logout',[LoginController::class, 'logout']);
$router->get('/dashboard',[DashboardController::class, 'index']);
$router->post('/dashboard',[DashboardController::class, 'getRequest']);


$router->get('/usuarios',[DashboardController::class, 'usuario']);
$router->post('/usuarios',[DashboardController::class, 'usuario']);
$router->post('/usuario',[DashboardController::class, 'getUser']);

$router->get('/perfil',[DashboardController::class, 'perfil']);
$router->get('/salon',[DashboardController::class, 'salon']);
$router->post('/salon',[DashboardController::class, 'getSalon']);
$router->get('/crear-salon',[DashboardController::class, 'crear_salon']);

$router->get('/bloque',[DashboardController::class, 'bloque']);
$router->get('/crear-bloque',[DashboardController::class, 'crear_bloque']);

$router->get('/usuario-actualizar',[DashboardController::class, 'usuario_actualizar']);

// Comprueba y valida las rutas, que existan y les asigna las funciones del Controlador
$router->comprobarRutas();