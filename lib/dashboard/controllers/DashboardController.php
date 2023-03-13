<?php

namespace Controllers;

use Model\Solicitud;
use Model\Usuario;
use MVC\Router;

class DashboardController
{
    //Solicitudes
    public static function dashboard(Router $router)
    {
        session_start();
        isAuth();
        $url = 'http://localhost:3000/tipos';
        $data = file_get_contents($url);
        $obj = json_decode($data);
        $tipos = $obj->tipos;
        $router->render('dashboard/dashboard', [
            'titulo' => 'Dashboard',
            'tipos' => $tipos
        ]);
    }
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

            // debuguear($solicitud);
            $respuesta = [
                'usuario' => $solicitud->usuario,
                'bloque' => $solicitud->nombre_bloque,
                'aula' => $solicitud->nombre_aulas,
                'tipo' => $solicitud->tipo,
                'detalle' => $solicitud->detalle,
                'estado' => $solicitud->estado,
                'fecha_inicial' => $solicitud->fecha_inicial,
                'fecha_final' => $solicitud->fecha_final,
                'remitente' => 'soporte'
            ];
            echo json_encode($respuesta);

        }
    }

    //Usuarios
    public static function usuario(Router $router)
    {

        session_start();
        isAuth();
        $usuarios = [];
        $url = 'http://localhost:3000/usuarios';
        $objU = json_decode(file_get_contents($url));
        // debuguear($objU);
        // $usuarios = new Usuario($objU->usuario);
        $usuarios = $objU->usuario;
        // debuguear($usuarios);
        $url_rol = 'http://localhost:3000/usuarios_rol';
        $obj = json_decode(file_get_contents($url_rol));
        $rol = $obj->rol;
        $seleccionado = "";
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            // debuguear();
            if ($_POST['roles'] != "todos") {
                $seleccionado = $_POST['roles'];
                $usuarios = array_filter($objU->usuario, function ($usuario) {

                    return $usuario->rol_id == $_POST['roles'];
                });

                // $seleccionado = $_POST['roles'];
            }
        }
        session_start();
        $router->render('dashboard/usuario/usuario', [
            'titulo' => 'Gestionar Docentes',
            'usuarios' => $usuarios,
            'roles' => $rol,
            'seleccionado' => $seleccionado
        ]);
    }
    public static function getUser(Router $router)
    {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $id = $_POST['id'];
            $url = "http://localhost:3000/usuarios/{$id}";
            $data = file_get_contents($url);
            // debuguear($data);
            $obj = json_decode($data);
            $resultado = $obj->usuario;
            $usuario = array_shift($resultado);

            $respuesta = [
                'id' => $usuario->id,
                'correo' => $usuario->correo,
                'nombre' => $usuario->nombre,
                'apellido' => $usuario->apellido,
                'cedula' => $usuario->cedula,
                'direccion' => $usuario->direccion,
                'psw' => $usuario->psw,
                'usuario' => $usuario->usuario,
                'rol_id' => $usuario->rol_id,
                'remitente' => 'docente'
            ];
            echo json_encode($respuesta);

        }
    }

    //Salones
    public static function salon(Router $router)
    {
        session_start();
        isAuth();
        $seleccionado = "";
        $aulas = [];
        $url = 'http://localhost:3000/aulasAll';
        $data = file_get_contents($url);
        $obj = json_decode($data);
        $url_bloque = 'http://localhost:3000/bloques';

        $obj_bloque = json_decode(file_get_contents($url_bloque));
        $bloques = $obj_bloque->bloques;
        // debuguear($obj);
        $aulas = $obj->aulas;
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            // debuguear($aulas);
            if ($_POST['bloques'] != "todos") {
                $seleccionado = $_POST['bloques'];
                $aulas = array_filter($obj->aulas, function ($aula) {
                    return $aula->id_bloque == $_POST['bloques'];
                });

                // $seleccionado = $_POST['roles'];
            }
        }

        $router->render('dashboard/salon/salon', [
            'titulo' => 'Gestionar Salones',
            'aulas' => $aulas,
            'seleccionado' => $seleccionado,
            'bloques' => $bloques
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
                'bloque' => $salon->nombre_bloque,
                'remitente' => 'salon'
            ];
            echo json_encode($respuesta);

        }

    }

    //bloque
    public static function bloque(Router $router)
    {
        session_start();
        isAuth();
        $bloques = [];
        $url = 'http://localhost:3000/bloques';
        $data = file_get_contents($url);
        $obj = json_decode($data);
        $bloques = $obj->bloques;
        // debuguear($solicitudes);

        $router->render('dashboard/bloque/bloque', [
            'titulo' => 'Gestionar Bloques',
            'bloques' => $bloques
        ]);
    }
    public static function getBloque(Router $router)
    {

        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $id = $_POST['id'];
            $url = "http://localhost:3000/bloques/{$id}";
            $data = file_get_contents($url);
            // debuguear($id);
            $obj = json_decode($data);
            $resultado = $obj->bloques;
            $bloque = array_shift($resultado);
            // debuguear($bloque);       
            $respuesta = [
                'id' => $bloque->id,
                'bloque' => $bloque->nombre_bloque,
                'remitente' => 'bloque'
            ];
            echo json_encode($respuesta);

        }
    }
// public static function getBloques(Router $router)
// {

//     if ($_SERVER['REQUEST_METHOD'] == 'POST') {
//         $id = $_POST['id'];
//         $url = "http://localhost:3000/bloques";
//         $data = file_get_contents($url);
//         // debuguear($id);
//         $obj = json_decode($data);
//         $resultado = $obj->bloques;
//         $bloque = array_shift($resultado);     
//         // debuguear($bloque);       
//         $respuesta = [
//             'id' => $bloque->id,
//             'bloque' => $bloque->nombre_bloque,
//             'remitente' => 'bloque'
//         ];
//         echo json_encode($respuesta);

//     }
// }
}