<?php include_once __DIR__ . '/header-dashboard.php' ?>

<!-- <a href="/crear" class="boton">Agregar nuevo conductor</a> -->
<?php if (count($solicitudes) === 0) { ?>
    <p class="no-solicitudes">No hay proyectos aun</p>
<?php } else { ?>
    <ul class="listado-solicitudes">
        <?php foreach ($solicitudes as $solicitud) { ?>
            <div class="solicitud" href="/dashboard?id=<?php echo $solicitud->id?>">
                <li>
                    <span class="titulo <?php echo $resultado = ($solicitud->estado == "Completa") ?  'completa' : '' ;?>">
                        Solicitud: <?php  echo $solicitud->estado ?>
                    </span>
                    <label>
                        <?php  echo $solicitud->tipo ?>
                    </label>
                    <div class="id">
                        <?php  echo $solicitud->id ?>
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