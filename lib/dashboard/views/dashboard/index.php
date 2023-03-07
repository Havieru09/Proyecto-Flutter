<?php include_once __DIR__ . '/header-dashboard.php' ?>

<!-- <a href="/crear" class="boton">Agregar nuevo conductor</a> -->
<?php if (count($solicitudes) === 0) { ?>
    <p class="no-solicitudes">No hay proyectos aun</p>
<?php } else { ?>
    <ul class="listado-solicitudes">
        <?php foreach ($solicitudes as $solicitud) { ?>
            <?php //debuguear($solicitudes)?>           
            <div class="card solicitudes">
                <li>
                    <span class="titulo">
                        Solicitud:
                        <?php echo $resultado = ($solicitud->estado == "en_camino") ? 'en camino' : $solicitud->estado; ?>
                    </span>

                    <div class="imagen-base  <?php if ($solicitud->estado == "terminado") {
                        echo "completa";
                    } elseif ($solicitud->estado == "pendiente") {
                        echo "pendiente";
                    } else {
                        echo "camino";
                    }
                    ; ?>">

                    </div>
                    <label>
                        <?php echo $solicitud->tipo ?>
                    </label>            
                    <div class="id">
                        <?php echo $solicitud->id ?>
                    </div>
                    
                </li>
            </div>
        <?php } ?>
    </ul>
<?php } ?>

<?php include_once __DIR__ . '/footer-dashboard.php' ?>
<?php
$script = '<script src="build/js/modales.js"></script>';
?>