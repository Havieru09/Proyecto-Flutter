<?php include_once __DIR__ . '/../header-dashboard.php' ?>

<!-- <a href="/crear" class="boton">Agregar nuevo conductor</a> -->
<?php if (count($usuarios) === 0) { ?>
    <p class="no-solicitudes">No hay usuarios aun</p>
<?php } else { ?>
    <?php //debuguear($usuarios)?>
    <div class="contenedor-opciones">
        <button class="boton nuevoUser" id="agregar-Usuario" onclick="envioUsuario()">Agregar Usuario</button>
        <form action="/usuarios" class="buscador" method="post">
            <select name="roles">
                <option class="opciones" value="todos">TODOS</option>
                <?php foreach ($roles as $rol) { ?>
                    <option class="opciones" value="<?php echo $rol->id ?>" ><?php echo strtoupper($rol->nombre_rol)?></option>
                <?php } ?>
            </select>
            <input type="submit" value="buscar">
        </form>
    </div>
    <ul class="listado-solicitudes">
        <?php foreach ($usuarios as $usuario) { ?>
            <div class="card usuarios">
                <li>
                    <span class="titulo">
                        Usuario:
                        <?php echo $usuario->usuario ?>
                    </span>
                    <div class="imagen-base  <?php if ($usuario->rol == "docente") {
                        echo "docente";
                    } else {
                        echo "soporte";
                    } ?>">

                    </div>
                    <label>
                        <?php echo $usuario->nombre_rol ?>
                    </label>
                    <div class="id">
                        <?php echo $usuario->id ?>
                    </div>
                </li>
            </div>
        <?php } ?>
    </ul>
<?php } ?>

<?php include_once __DIR__ . '/../footer-dashboard.php' ?>
<?php
$script = '<script src="build/js/modales.js"></script>';
?>