<div class="contenedor login">
    <?php include_once __DIR__ . '/../templates/nombre-sitio.php' ?>
    <div class="contenedor-sm">
        <p class="descripcion-pagina">Iniciar sesion</p>
        <?php include_once __DIR__ . '/../templates/alertas.php'; ?>
        <form action="/" class="formulario" method="POST">
            <div class="campo">
                <label for="usuario">Usuario</label>
                <input type="text" id="usuario" placeholder="Tu Usuario" name="usuario">
            </div>

            <div class="campo">
                <label for="password">Password</label>
                <input type="password" id="password" placeholder="Tu Password" name="contraseña">
            </div>

            <input type="submit" class="boton" value="Iniciar Sesión">
        </form>
        <!-- <div class="acciones">
            <a href="/crear">¿Aún no tienes una cuenta? Obtener una</a>
            <a href="/olvide">¿Olvidaste tu Password?</a>

        </div> -->
    </div> <!-- Contenedor-sm -->
</div>