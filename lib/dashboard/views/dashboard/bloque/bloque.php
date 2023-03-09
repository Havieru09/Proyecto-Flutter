<?php include_once __DIR__ . '/../header-dashboard.php' ?>

<?php if (count($bloques) === 0) { ?>
    <p class="no-solicitudes">No hay Bloques aun <button class="nuevoSalon boton" id="agregar-salon" onclick="envioBloque()">Agregar Bloque</button></p>
<?php } else { ?>

    <button class="nuevoSalon boton" id="agregar-salon" onclick="envioBloque()">Agregar Bloque</button>

    <ul class="listado-solicitudes">
        <?php foreach ($bloques as $bloque) { ?>
            <div class="card bloques">
                <li>
                    <span class="titulo">
                        Bloque:
                        <?php echo $bloque->nombre_bloque ?>
                    </span>
                    <div class="imagen-base bloques">
                    </div>
                    <label>
                        <?php echo $bloque->nombre_bloque ?>
                    </label>
                    <div class="id">
                        <?php echo $bloque->id ?>
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