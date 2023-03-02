<?php include_once __DIR__ . '/../header-dashboard.php' ?>

<a href="/crear-salon" class="boton-dash">Agregar Salon</a>
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
                Laboratori E4
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
                Laboratori E3
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