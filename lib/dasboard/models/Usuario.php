<?php

namespace Model;

class Usuario extends ActiveRecord{
    protected static $tabla = 'usuario';
    protected static $columnasDB = ['id', 'usuario', 'contraseña', 'rol'];

    public function __construct($args = []){
        $this->id = $args['id'] ?? null;
        $this->usuario = $args['usuario'] ?? '';
        $this->contraseña = $args['contraseña'] ?? '';
        $this->rol = $args['rol'] ?? '';
    }

    public function validarLogin(){
        if (!$this->usuario) {
            self::$alertas['error'][] = 'El Usuario es obligatorio';
        }
        if (!$this->contraseña) {
            self::$alertas['error'][] = 'El Password no puede ir vacio';
        }
        return self::$alertas;
    }
}