<?php include_once __DIR__ . '/../header-dashboard.php' ?>

<a href="/crear-bloque" class="boton-dash">Agregar Bloque</a>
<table class="tabla">

    <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Acciones</th>
            
        </tr>
    </thead>
    <tbody>
        
        <tr>
            <td>
                1
            </td>
            <td>
                E
            </td>
            
            <td class="acciones">
                <a href="/actualizar" class="boton-amarillo-block">Actualizar</a>
                <form method="POST" class="w-100" >
                    <input type="hidden" name="id" value="">
                    
                    <input type="submit" class="boton-rojo-block" value="Eliminar">
                </form>
            </td>
        </tr>
        <tr>
            <td>
                2
            </td>
            <td>
                B
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