<?php include_once __DIR__ . '/../header-dashboard.php' ?>

<!-- <a href="/crear" class="boton">Agregar nuevo conductor</a> -->
<?php if (count($usuarios) === 0) { ?>
    <p class="no-solicitudes">No hay usuarios aun</p>
<?php } else { ?>
    <div class="contenedor-opciones">
        <button class="nuevoUser" id="agregar-Usuario">Agregar Usuario</button>
        <form action="/usuarios" class="buscador" method="post">
            <select name="roles">
                <option class="opciones" value="todos">TODOS</option>
                <option class="opciones" value="soporte" <?php echo $resultado = "soporte" == $seleccionado ? 'selected' : '' ?>>SOPORTE</option>
                <option class="opciones" value="docente" <?php echo $resultado = "docente" == $seleccionado ? 'selected' : '' ?>>DOCENTE</option>
                <!-- <?php foreach ($selects as $select) { ?>
                    <option class="opciones" value="<?php echo $select->rol ?>" <?php echo $resultado = $select->rol == $seleccionado ? 'selected' : '' ?>><?php echo $select->rol ?></option>
                <?php } ?> -->
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
                        <?php echo $usuario->rol ?>
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