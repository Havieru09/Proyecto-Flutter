<?php

namespace Model;

class Usuario extends ActiveRecord{
    protected static $tabla = 'usuario';
    protected static $columnasDB = ['id', 'usuario', 'psw', 'rol'];

    public function __construct($args = []){
        $this->id = $args['id'] ?? null;
        $this->usuario = $args['usuario'] ?? '';
        $this->	psw = $args['psw'] ?? '';
        $this->rol = $args['rol'] ?? '';
    }

    public function validarLogin(){
        if (!$this->usuario) {
            self::$alertas['error'][] = 'El Usuario es obligatorio';
        }
        if (!$this->psw) {
            self::$alertas['error'][] = 'El Password no puede ir vacio';
        }
        return self::$alertas;
    }
}