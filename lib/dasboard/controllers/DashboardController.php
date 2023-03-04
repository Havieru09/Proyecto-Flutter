<?php

namespace Controllers;
use Model\Proyecto;
use MVC\Router;

class DashboardController {
    public static function index(Router $router){

        session_start();
        isAuth();

        $id = $_SESSION['id'];

        $proyectos = Proyecto::WhereAll('propietarioId', $id);
         
        // debuguear($proyectos);
    
        session_start();
        $router->render('dashboard/index', [
            'titulo' => 'Proyectos',
            'proyectos' => $proyectos
        ]);
    }
    public static function crear_proyecto(Router $router){

        session_start();
        isAuth();
        
        $alertas = [];
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $proyecto = new Proyecto($_POST);
            $alertas = $proyecto->validarProyecto(); 

            if (empty($alertas)) {
                //Generar una URL unica
                $proyecto->url = md5(uniqid());

                //Almacenar el creador del proyecto
                $proyecto->propietarioId = $_SESSION['id'];

                //Guardar el proyecto
                $resultado = $proyecto->guardar();

                if ($resultado) {
                    header('Location: /proyecto?id='.$proyecto->url);
                }
                 
            }

        }
        session_start();
        $router->render('dashboard/crear-proyecto', [
            'titulo' => 'Crear Proyecto',
            'alertas' => $alertas
        ]);
    }

    public static function proyecto(Router $router){

        session_start();
        isAuth();

        $token = $_GET['id'];
        // http://localhost:3000/proyecto?id=8fb306d7544293b70391ae6521491cdc
        if (!$token) header('Location: /dashboard') ;

        $proyecto = Proyecto::where('url', $token);
        
        if ($proyecto->propietarioId !== $_SESSION['id']) {
            header('Location: /dashboard');
        }

        // Revisar que la persona que visita el proyecto, es quien lo creo
        $router->render('dashboard/proyecto', [
            'titulo' => $proyecto->proyecto,
            
        ]);
    }

    public static function perfil(Router $router){

        session_start();
        isAuth();

        session_start();
        $router->render('dashboard/perfil', [
            'titulo' => 'Perfil'
        ]);
    }


}