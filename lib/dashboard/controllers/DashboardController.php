<?php

namespace Controllers;

use Model\Solicitud;
use MVC\Router;

class DashboardController
{
    //Solicitudes
    public static function index(Router $router)
    {
        session_start();
        isAuth();
        $solicitudes = [];
        $url = 'http://localhost:3000/solicitudes';
        $data = file_get_contents($url);
        $obj = json_decode($data);
        $solicitudes = $obj->solicitud;
        // debuguear($solicitudes);
        $router->render('dashboard/index', [
            'titulo' => 'Solicitudes',
            'solicitudes' => $solicitudes
        ]);
    }
    public static function getRequest(Router $router){
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $id = $_POST['id'];
            // debuguear($id);
            $url = "http://localhost:3000/solicitudes/{$id}";
            $data = file_get_contents($url);
            $obj = json_decode($data);
            $resultado = $obj->data;
            $solicitud = array_shift($resultado);
            // debuguear($solicitud);

            // debuguear($solicitud);
            $respuesta = [
                'usuario' => $solicitud->usuario,
                'bloque' => $solicitud->nombre_bloque,
                'aula' => $solicitud->nombre_aulas,
                'tipo' => $solicitud->tipo,
                'detalle' => $solicitud->detalle,
                'estado' => $solicitud->estado,
                'remitente' => 'soporte'
            ];
            echo json_encode($respuesta);

        }
    }
    //Usuarios
    public static function usuario(Router $router){

        session_start();
        isAuth();
        $usuarios = [];
        $url = 'http://localhost:3000/usuarios';
        $data = file_get_contents($url);
        $obj = json_decode($data);
        $usuarios = $obj->usuario;
        $seleccionado = "";
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            if ($_POST['roles'] == 'docente') {
                $usuarios = array_filter($obj->usuario, function ($usuario) {
                    return $usuario->rol == 'docente';
                });
                $seleccionado = $_POST['roles'];
            } elseif ($_POST['roles'] == 'soporte') {
                $usuarios = array_filter($obj->usuario, function ($usuario) {
                    return $usuario->rol == 'soporte';
                });
                $seleccionado = $_POST['roles'];
            }
        }
        session_start();
        $router->render('dashboard/usuario/usuario', [
            'titulo' => 'Gestionar Docentes',
            'usuarios' => $usuarios,
            'selects' => $obj->usuario,
            'seleccionado' => $seleccionado
        ]);
    }
    public static function getUser(Router $router){
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $id = $_POST['id'];
            $url = "http://localhost:3000/usuarios/{$id}";
            $data = file_get_contents($url);

            $obj = json_decode($data);
            $resultado = $obj->usuario;
            $usuario = array_shift($resultado);
            // debuguear($usuario);
            $respuesta = [
                'id' => $usuario->id,
                'correo' => $usuario->correo,
                'psw' => $usuario->psw,
                'usuario' => $usuario->usuario,
                'rol' => $usuario->rol,
                'remitente' => 'docente'
            ];
            echo json_encode($respuesta);

        }
    }

    //Salones
    public static function salon(Router $router){
        session_start();
        isAuth();
        $aulas = [];
        $url = 'http://localhost:3000/aulas';
        $data = file_get_contents($url);
        $obj = json_decode($data);
        // debuguear($obj);
        $aulas = $obj->aulas;
        $seleccionado = "";
        $router->render('dashboard/salon/salon', [
            'titulo' => 'Gestionar Salones',
            'aulas' => $aulas
        ]);
    }
    public static function getSalon(Router $router)
    {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $id = $_POST['id'];
            $url = "http://localhost:3000/aulas/{$id}";
            $data = file_get_contents($url);

            $obj = json_decode($data);
            $resultado = $obj->aulas;
            $salon = array_shift($resultado);            
            $respuesta = [
                'id' => $salon->id,
                'salon' => $salon->nombre_aulas,
                'remitente' => 'salon'
            ];
            echo json_encode($respuesta);

        }

    }

    //bloque
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