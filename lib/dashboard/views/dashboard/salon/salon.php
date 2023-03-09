<?php include_once __DIR__ . '/../header-dashboard.php' ?>

<?php if (count($aulas) === 0) { ?>
    <p class="no-solicitudes">No hay Salones aun</p>
<?php } else { ?>

    <button class="nuevoSalon boton" id="agregar-salon" onclick="envioSalon()">Agregar Salon</button>

    <ul class="listado-solicitudes">
        <?php foreach ($aulas as $aula) { ?>
            <div class="card salones">
                <li>
                    <span class="titulo">
                        Salon:
                        <?php echo $aula->nombre_aulas ?>
                    </span>
                    <div class="imagen-base <?php echo $resultado = (stripos($aula->nombre_aulas, "laboratorio") !== false) ? "laboratorio" : "aula"?>">
                    </div>
                    <label>
                        <?php echo $aula->nombre_aulas ?>
                    </label>
                    <div class="id">
                        <?php echo $aula->id ?>
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