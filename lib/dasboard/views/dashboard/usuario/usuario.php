<?php include_once __DIR__ . '/../header-dashboard.php' ?>

<a href="/crear-usuario" class="boton-dash">Agregar Usuario</a>
<table class="tabla">

    <thead>
        <tr>
            <th>ID</th>
            <th>Usuario</th>
            <th>Contraseña</th>
            <th>Rol</th>
            <th>acciones</th>
        </tr>
    </thead>
    <tbody>
        
        <tr>
            <td>
                2
            </td>
            <td>
                Carlos
            </td>
            <td>
                123456
            </td>
            <td>
                docente
            </td>
            <td class="acciones">
                <a href="/usuario-actualizar" class="boton-amarillo-block">Actualizar</a>
                <form method="POST" class="w-100" >
                    <input type="hidden" name="id" value="">
                    
                    <input type="submit" class="boton-rojo-block" value="Eliminar">
                </form>
            </td>
        </tr>
        <tr>
            <td>
                3
            </td>
            <td>
                Gabriel
            </td>
            <td>
                123456
            </td>
            <td>
                soporte
            </td>
            <td class="acciones">
                <a href="/actualizar" class="boton-amarillo-block">Actualizar</a>
                <form method="POST" class="w-100" >
                    <input type="hidden" name="id" value="">
                    
                    <input type="submit" class="boton-rojo-block" value="Eliminar">
                </form>
            </td>
        </tr>
    </tbody>
</table>

<?php include_once __DIR__ . '/../footer-dashboard.php' ?>