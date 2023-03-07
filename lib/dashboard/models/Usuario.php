<?php

namespace Model;

class Usuario extends ActiveRecord{
    protected static $tabla = 'usuario';
    protected static $columnasDB = ['id', 'usuario', 'psw', 'rol', 'correo'];

    public function __construct($args = []){
        $this->id = $args['id'] ?? null;
        $this->usuario = $args['usuario'] ?? '';
        $this->	psw = $args['psw'] ?? '';
        $this->rol = $args['rol'] ?? '';
        $this->correo = $args['correo'] ?? '';
    }

    public function validarLogin(){
        if (!$this->correo) {
            self::$alertas['error'][] = 'El Correo es obligatorio';
        }
        if (!$this->psw) {
            self::$alertas['error'][] = 'El Password no puede ir vacio';
        }
        return self::$alertas;
    }
}