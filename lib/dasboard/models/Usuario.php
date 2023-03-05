<?php

namespace Model;

class Usuario extends ActiveRecord{
    protected static $tabla = 'usuarios';
    protected static $columnasDB = ['id', 'nombre', 'email', 'password', 'token', 'confirmado'];

    public function __construct($args = []){
        $this->id = $args['id'] ?? null;
        $this->nombre = $args['nombre'] ?? '';
        $this->email = $args['email'] ?? '';
        $this->password = $args['password'] ?? '';$this->confirmado = $args['confirmado'] ?? '';
        $this->password2 = $args['password2'] ?? '';
        $this->token = $args['token'] ?? '';
        $this->confirmado = $args['confirmado'] ?? 0;            
    }

    public function validarLogin(){
        if (!$this->email) {
            self::$alertas['error'][] = 'El Email del Usuario es obligatorio';
        }
        if (!filter_var($this->email, FILTER_VALIDATE_EMAIL)) {
            self::$alertas['error'][] = 'Email no valido';
        }
        if (!$this->password) {
            self::$alertas['error'][] = 'El Password no puede ir vacio';
        }
        return self::$alertas;
    }

    // Validacion para cuentas nuevas
    public function validarNuevaCuenta(){
        if (!$this->nombre) {
            self::$alertas['error'][] = 'El Nombre del Usuario es obligatorio';
        }
        if (!$this->email) {
            self::$alertas['error'][] = 'El Email del Usuario es obligatorio';
        }
        if (!$this->password) {
            self::$alertas['error'][] = 'El Password no puede ir vacio';
        }else{
            if (strlen($this->password) < 6) {
                self::$alertas['error'][] = 'El Password debe contener al menos 6 caracteres';
            }
        }
        if (!$this->password2) {
            self::$alertas['error'][] = 'El campo repetir password no puede ir vacio';
        }
        if ($this->password and $this->password2) {
            if ($this->password !== $this->password2)  {
                self::$alertas['error'][] = 'Los password son difrentes';
            }
        }
        
        return self::$alertas;
    }

    //Valida un email
    public function validarEmail(){
        if (!$this->email) {
            self::$alertas['error'][] = 'El email es obligatorio';
        }
        if (!filter_var($this->email, FILTER_VALIDATE_EMAIL)) {
            self::$alertas['error'][] = 'Email no valido';
        }

        if (empty($alertas)) {
            
        }

        return self::$alertas;
    }

    public function hasPassword(){
        $this->password = password_hash($this->password, PASSWORD_BCRYPT);
    }

    public function crearToken(){
        $this->token = uniqid();
    }
    public function validarPassword(){
        if (!$this->password) {
            self::$alertas['error'][] = 'El Password no puede ir vacio';
        }else{
            if (strlen($this->password) < 6) {
                self::$alertas['error'][] = 'El Password debe contener al menos 6 caracteres';
            }
        }
        return self::$alertas;
    }
}