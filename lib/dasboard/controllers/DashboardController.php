<?php

namespace Controllers;

use Model\Solicitud;
use MVC\Router;

class DashboardController
{
    public static function index(Router $router)
    {
        session_start();
        isAuth();
        $solicitudes = [];
        $url = 'http://localhost:3000/solicitudes';
        $data = file_get_contents($url);
        $obj = json_decode($data);
        $solicitudes = $obj->solicitud;


        $router->render('dashboard/index', [
            'titulo' => 'Solicitudes',
            'solicitudes' => $solicitudes
        ]);
    }
    public static function getRequest(Router $router)
    {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $id = $_POST['id'];
            // debuguear($id);
            $url = "http://localhost:3000/solicitudes/{$id}";
            $data = file_get_contents($url);
            
            $obj = json_decode($data);
            $resultado = $obj->data;
            $solicitud = array_shift($resultado);
            // debuguear($solicitud);
        
            // debuguear($solicitudId);
            $respuesta = [
                'usuario' => $solicitud->usuario,
                'bloque' => $solicitud->nombre_bloque,
                'aula' => $solicitud->nombre_aulas,
                'tipo' => $solicitud->tipo,
                'detalle' => $solicitud->detalle,
                'estado' => $solicitud->estado
            ];
            // debuguear($respuesta);
            echo json_encode($respuesta);

        }
    }
    public static function usuario(Router $router)
    {

        // session_start();
        // isAuth();

        session_start();
        $router->render('dashboard/usuario/usuario', [
            'titulo' => 'Gestionar Docentes'
        ]);
    }
    public static function crear_usuario(Router $router)
    {

        // session_start();
        // isAuth();

        session_start();
        $router->render('dashboard/usuario/crear-usuario', [
            'titulo' => 'Crea un nuevo usuario'
        ]);
    }

    public static function usuario_actualizar(Router $router)
    {

        // session_start();
        // isAuth();

        session_start();
        $router->render('dashboard/usuario/usuario-actualizar', [
            'titulo' => 'Editar usuario'
        ]);
    }

    public static function salon(Router $router)
    {
        $router->render('dashboard/salon/salon', [
            'titulo' => 'Gestionar Salones'
        ]);
    }
    public static function crear_salon(Router $router)
    {

        // session_start();
        // isAuth();

        $router->render('dashboard/salon/crear-salon', [
            'titulo' => 'Agrega un nuevo Salon'
        ]);
    }
    public static function bloque(Router $router)
    {

        // session_start();
        // isAuth();

        $router->render('dashboard/bloque/bloque', [
            'titulo' => 'Gestionar Bloques'
        ]);
    }
    public static function crear_bloque(Router $router)
    {

        // session_start();
        // isAuth();

        $router->render('dashboard/bloque/crear-bloque', [
            'titulo' => 'Agrega un nuevo Bloque'
        ]);
    }
}