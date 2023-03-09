<?php include_once __DIR__ . '/header-dashboard.php' ?>
<div class="botones-dash">
        <a class="boton mostrarDash" id="agregar-Usuario" href="/dashboard">Mostar dashboard</a>
        <a class="boton mostrarSoli" id="agregar-Usuario" href="/solicitudes">Mostar Solicitudes</a>
        <button class="boton mostrarSoli" id="" onclick="mostrarGrafico()">Mostar Grafico</button>
        <!-- <input type="date"> -->
    </div>
    <div id="chart_div" class="chart" onload="mostarGrafico()"></div>
    <div class="ct-chart ct-perfect-fourth"></div>

<?php include_once __DIR__ . '/footer-dashboard.php' ?>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chartist@0.11.4/dist/chartist.min.css"> -->
  <!-- <script src="https://cdn.jsdelivr.net/npm/chartist@0.11.4/dist/chartist.min.js"></script> -->
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<?php
$script = '<script src="build/js/modales.js"></script>';
?>