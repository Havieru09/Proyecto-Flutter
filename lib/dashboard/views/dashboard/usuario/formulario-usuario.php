<!-- <input type="button" class="boton" value="Atras"> -->
<div class="campo">
    <label for="nombre">Usuario</label>
    <input type="text" id="nombre" placeholder="El Nombre de Usuario" name="nombre" value="">
</div>
<div class="campo">
    <label for="placa">Contraseña</label>
    <input type="text" id="placa" placeholder="La Contraseña del Usuario" name="placa"
        value="<?php //echo $usuario->placa; ?>">
</div>

<div class="campo">
    <label for="telefono">Rol</label>
    <select name="propiedad[vendedorId]" id="vendedor">
        <option value="">--Seleccione el ROL--</option>
        
            <option>docente</option>
            <option>soporte</option>
        
    </select>
</div>
