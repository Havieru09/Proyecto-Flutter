<?php 

require_once __DIR__ . '/../includes/app.php';

use MVC\Router;
use Controllers\LoginController;
use Controllers\DashboardController;
$router = new Router();

$router->get('/',[LoginController::class, 'login']);
$router->post('/',[LoginController::class, 'login']);
$router->get('/logout',[LoginController::class, 'logout']);
$router->get('/dashboard',[DashboardController::class, 'dashboard']);
$router->get('/solicitudes',[DashboardController::class, 'index']);
$router->post('/solicitudes',[DashboardController::class, 'getRequest']);


$router->get('/usuarios',[DashboardController::class, 'usuario']);
$router->post('/usuarios',[DashboardController::class, 'usuario']);
$router->post('/usuario',[DashboardController::class, 'getUser']);

$router->get('/perfil',[DashboardController::class, 'perfil']);
$router->get('/salon',[DashboardController::class, 'salon']);
$router->post('/salon2',[DashboardController::class, 'salon']);
$router->post('/salon',[DashboardController::class, 'getSalon']);
$router->get('/crear-salon',[DashboardController::class, 'crear_salon']);

$router->get('/bloque',[DashboardController::class, 'bloque']);
$router->post('/bloque',[DashboardController::class, 'getBloque']);
$router->get('/bloque_select',[DashboardController::class, 'getBloques']);

// Comprueba y valida las rutas, que existan y les asigna las funciones del Controlador
$router->comprobarRutas();