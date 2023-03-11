<?php include_once __DIR__ . '/header-dashboard.php' ?>
<div class="botones-dash">
  <a class="boton mostrarDash" id="agregar-Usuario" href="/dashboard">Mostar dashboard</a>
  <a class="boton mostrarSoli" id="agregar-Usuario" href="/solicitudes">Mostar Solicitudes</a>
  <!-- <input type="date"> -->
</div>
<!-- <div class="contenedorGraficos"> -->
<?php //debuguear($tipos)  ?>
<div id="chart_div" class="chart" onload="mostarGrafico()"></div>
<form class="formulario">
  <div class="fechas">
    <div class="campo">
      <label class="subtitulo">Desde:</label>
      <input type="date" name="fecha_inicio" id="fecha_inicio" />
    </div>
    <div class="campo">
      <label class="subtitulo">Hasta:</label>
      <input type="date" name="fecha_final" id="fecha_final" />
    </div>
  </div>
  <div class="campo">
    <label class="subtitulo">Tipo:</label>
    <select name="tipo" id="tipo">
      <?php foreach ($tipos as $tipo) { ?>
        <option value="<?php echo $tipo->id ?>"><?php echo $tipo->nombre_tipo ?></option>
      <?php } ?>
    </select>
  </div>
  <button type="button" class="boton mostrarSoli" id="" onclick="graficoFiltro()">Buscar</button>
</form>


<div id="chart_div2" class="chart" onload="graficoFiltro()"></div>
<!-- </div> -->
<?php include_once __DIR__ . '/footer-dashboard.php' ?>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chartist@0.11.4/dist/chartist.min.css"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/chartist@0.11.4/dist/chartist.min.js"></script> -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<?php
$script = '<script src="build/js/modales.js"></script>';
$script = '<script src="build/js/graficos.js"></script>';
?>