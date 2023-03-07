<?php

namespace Controllers;

use Model\Usuario;
use MVC\Router;

class LoginController
{
    public static function login(Router $router)
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $auth = new Usuario($_POST);
            $alertas = $auth->validarLogin();

            if (empty($alertas)) {
                $usuario = Usuario::where('correo', $auth->correo);

                if (!$usuario || $usuario->rol !== 'admin') {
                    Usuario::setAlerta('error', 'El usuario no existe o no tiene acceso');
                } else {
                    if ($_POST['contraseña'] == $usuario->contraseña) {
                        session_start();
                        $_SESSION['login'] = true;
                        $_SESSION['id'] = $usuario->id;
                        $_SESSION['usuario'] = $usuario->usuario;
                        $_SESSION['contraseña'] = $usuario->contraseña;
                        $_SESSION['rol'] = $usuario->rol;                        

                        //Redireccionar
                        header('Location: /dashboard');
                    } else {
                        Usuario::setAlerta('error', 'Password incorrecto');
                    }
                    
                }

                //debuguear($usuario);
            }
        }
        $alertas = Usuario::getAlertas();


        // Render a la vista
        $router->render('auth/login', [
            'titulo' => 'Iniciar sesion',
            'alertas' => $alertas
        ]);
    }
    public static function logout()
    {
        session_start();
        $_SESSION = [];
        header('Location: /');
    }
}