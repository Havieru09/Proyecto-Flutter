<div class="contenedor login">
    <?php include_once __DIR__ . '/../templates/nombre-sitio.php' ?>
    <div class="contenedor-sm">
        <p class="descripcion-pagina">Iniciar sesion</p>
        <?php include_once __DIR__ . '/../templates/alertas.php'; ?>
        <form action="/" class="formulario" method="POST">
            <div class="campo">
                <label for="usuario">Correo</label>
                <input type="email" id="usuario" placeholder="Tu Correo" name="correo">
            </div>

            <div class="campo">
                <label for="password">Password</label>
                <input type="password" id="password" placeholder="Tu Password" name="psw">
            </div>

            <input type="submit" class="boton" value="Iniciar Sesión">
        </form>
        <!-- <div class="acciones">
            <a href="/crear">¿Aún no tienes una cuenta? Obtener una</a>
            <a href="/olvide">¿Olvidaste tu Password?</a>

        </div> -->
    </div> <!-- Contenedor-sm -->
</div>