<?php

namespace Controllers;

use Model\Usuario;
use MVC\Router;
use Classes\Email;

class LoginController
{
    public static function login(Router $router)
    {

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $auth = new Usuario($_POST);

            $alertas = $auth->validarLogin();
            if (empty($alertas)) {
                $usuario = Usuario::where('email', $auth->email);

                if (!$usuario || !$usuario->confirmado) {
                    Usuario::setAlerta('error', 'El usuario no existe o no esta confirmado');  
                }else{
                    if (password_verify($_POST['password'], $usuario->password)) {
                        //Inicia Sesion
                        session_start();
                        $_SESSION['id'] = $usuario->id;
                        $_SESSION['nombre'] = $usuario->nombre;
                        $_SESSION['email'] = $usuario->email;
                        $_SESSION['login'] = true;

                        //Redireccionar
                        header('Location: /dashboard');

                        
                    }else{
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
            'alertas' =>$alertas
        ]);
    }


    public static function logout()
    {
        session_start();
        $_SESSION = [];
        header('Location: /');
    }

    public static function crear(Router $router)
    {
        $alertas = [];
        $usuario = new Usuario;

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $usuario->sincronizar($_POST);
            $alertas = $usuario->validarNuevaCuenta();
            //debuguear($usuario);
            if (empty($alertas)) {
                $existeUsuario = Usuario::where('email', $usuario->email);
                
                if ($existeUsuario) {
                    Usuario::setAlerta('error', 'El usuario ya esta registrado');
                    $alertas = Usuario::getAlertas();
                }else{
                    $usuario->hasPassword();
                    unset($usuario->password2);
                    
                    $usuario->crearToken();
                    
                    $resultado = $usuario->guardar();
                    //debuguear($resultado);
                    $email = new Email($usuario->email, $usuario->nombre, $usuario->token);
                    $email->enviarConfirmacion();
                    
                    //debuguear($resultado);
                    if ($resultado) {
                        header('Location: /mensaje');
                    }
                }
            }
        }

        $router->render('auth/crear', [
            'titulo' => 'Crear',
            'usuario' => $usuario,
            'alertas' => $alertas
        ]);
    }

    public static function olvide(Router $router){
        $alertas = [];
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $usuario = new Usuario($_POST);
            $alertas = $usuario->validarEmail();
            if (empty($alertas)) {
                $usuario = Usuario::where('email', $usuario->email); 
                if ($usuario && $usuario->confirmado === "1") {
                    //Generar un token
                    $usuario->crearToken();     
                    
                    unset($usuario->password2);

                    $usuario->guardar();

                    $email = new Email($usuario->email, $usuario->nombre, $usuario->token);
                    $email->enviarInstucciones();

                    Usuario::setAlerta('exito','Hemos enviado las instrucciones a tu email');

                }else{
                    Usuario::setAlerta('error', 'El usuario no existe o no esta confirmado');
                   
                }
                
                
            }
        }
        $alertas = Usuario::getAlertas();
        $router->render('auth/olvide', [
            'titulo' => 'Olvide mi password',
            'alertas' => $alertas
        ]);
    }

    public static function reestablecer(Router $router)
    {
        $token = s($_GET['token']);
        $mostrar = true;
        if (!$token) header('Location: /');

        $usuario = Usuario::where('token', $token);

        if (empty($usuario)) {
            Usuario::setAlerta('error', 'Token No Valido');
            $mostrar = false;
        }

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {

            //Añadir nuevo password
            $usuario->sincronizar($_POST);
            //validar Password
            $alertas = $usuario->validarPassword();

            if (empty($alertas)) {

                $usuario->hasPassword();

                $usuario->token = null;

                $resultado = $usuario->guardar();
                if ($resultado) {
                    header('Location: /');
                }
            }

        }

        $alertas = Usuario::getAlertas();

        $router->render('auth/reestablecer', [
            'titulo' => 'confirmar cuenta',
            'alertas' => $alertas,
            'mostrar' => $mostrar
        ]);
    }

    public static function mensaje(Router $router)
    {
        $router->render('auth/mensaje', [
            'titulo' => 'confirmar cuenta'
        ]);
    }
    public static function confirmar(Router $router){
        $token = $_GET['token'];

        if (!$token) header('Location: /');

        //Encontrar al usuario con el token

        $usuario = Usuario::where('token', $token);

        if (empty($usuario)) {
            //No hay usuario con ese token
            Usuario::setAlerta('error','Token no valido');
        }else {
            $usuario->confirmado = 1;
            $usuario->token = null;
            unset($usuario->password2);
        
            $usuario->guardar();
            Usuario::setAlerta('exito', 'Cuenta Comprobada correctamente');
        }

        $alertas = Usuario::getAlertas();

        $router->render('auth/confirmar', [
            'titulo' => 'Confirmar tu cuenta UpTask',
            'alertas' => $alertas
        ]);
    }
}