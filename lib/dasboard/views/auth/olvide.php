<div class="contenedor olvide">
    <?php include_once __DIR__ . '/../templates/nombre-sitio.php' ?>
    <div class="contenedor-sm">
        <p class="descripcion-pagina">Recupera tu acceso UpTask</p>
        <?php include_once __DIR__ . '/../templates/alertas.php'; ?>
        <form action="" class="formulario" method="POST">
            <div class="campo">
                <label for="email">Email</label>
                <input type="email" id="email" placeholder="Tu Email" name="email">
            </div>
            <input type="submit" class="boton" value="Enviar">
        </form>
        <div class="acciones">
            <a href="/crear">¿Aún no tienes una cuenta? Obtener una</a>
            <a href="/">¿Ya tienes cuenta? Iniciar Sesión</a>

        </div>
    </div> <!-- Contenedor-sm -->
</div>