<?php

namespace Model;

class Usuario extends ActiveRecord{
    protected static $tabla = 'usuario';
    protected static $columnasDB = ['id', 'nombre','apellido','cedula','direccion','usuario', 'psw', 'rol_id', 'correo'];

    public function __construct($args = []){
        $this->id = $args['id'] ?? null;
        $this->nombre = $args['nombre'] ?? '';
        $this->apellido = $args['apellido'] ?? '';
        $this->cedula = $args['cedula'] ?? '';
        $this->direccion = $args['direccion'] ?? '';
        $this->usuario = $args['usuario'] ?? '';
        $this->	psw = $args['psw'] ?? '';
        $this->rol_id = $args['rol_id'] ?? '';
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