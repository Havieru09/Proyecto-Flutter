<?php

namespace Model;

class Solicitud extends ActiveRecord{
    protected static $tabla = 'solicitud';
    protected static $columnasDB = ['id', 'usuario', 'nombre_bloque', 'nombre_aulas', 'tipo', 'detalle', 'estado'];

    public function __construct($args = []){
        $this->id = $args['id'] ?? null;
        $this->usuario = $args['usuario'] ?? '';
        $this->nombre_bloque = $args['nombre_bloque'] ?? '';
        $this->nombre_aulas = $args['nombre_aulas'] ?? '';
        $this->tipo = $args['tipo'] ?? '';
        $this->detalle = $args['detalle'] ?? '';
        $this->estado = $args['estado'] ?? 'Espera';
    }
}