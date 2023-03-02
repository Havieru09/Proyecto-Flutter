(function () {
    const suma = 2+2;
    suma 
    const solicitudes = document.querySelectorAll('.solicitud');
    solicitudes.forEach(solicitud => {
        solicitud.addEventListener('click', function (e) {
            const id = solicitud.querySelector("div").innerHTML;
            const modal = mostrarModal(id.trim());
        });
    });

    async function mostrarModal(id) {
        const datos = new FormData();
        datos.append('id', id);
        try {
            const url = 'http://localhost:3001/dashboard';
            const respuesta = await fetch(url, {
                method: 'POST',
                body: datos
            });
            // console.log(respuesta.json());
            const resultado = await respuesta.json();
            var respuesta1 = resultado.estado==="Completa" ? "completa" : "espera";
            const modal = document.createElement('DIV');
            modal.classList.add('modal');
            modal.innerHTML = `
            <form class="formulario nueva-tarea"> 
                <legend class="`+respuesta1+`">Solicitud `+ resultado.estado+ ` </legend>           
                <div class="campo">
                    <label>Tipo</label>
                    <label>`+resultado.tipo+`</label>
                </div>
                <div class="campo">
                    <label>Bloque</label>
                    <label>`+resultado.bloque+`</label>
                </div>
                <div class="campo">
                    <label>Aula</label>
                    <label>`+resultado.aula+`</label>
                </div>
                <div class="campo">
                    <label>Usuario</label>
                    <label>`+resultado.usuario+`</label>
                </div>
                <div class="campo">
                    <label>Detalle</label>
                    <label>`+resultado.detalle+`</label>
                </div>                
                <div class="opciones">
                    <button type="button" class="cerrar-modal">Volver</button>
                </div>
            </form>
        `;
            setTimeout(() => {
                const formulario = document.querySelector('.formulario');
                formulario.classList.add('animar');
            }, 100);
            modal.addEventListener('click', function (e) {
                e.preventDefault();

                if (e.target.classList.contains('cerrar-modal')) {
                    const formulario = document.querySelector('.formulario');
                    formulario.classList.add('cerrar');
                    setTimeout(() => {
                        modal.remove();
                    }, 500);
                }
                if (e.target.classList.contains('submit-nueva-tarea')) {
                    // submitFormularioNuevaTarea();
                }
            });
            document.querySelector('.dashboard').appendChild(modal);
        } catch (error) {
            console.log(error);
        }
    }

})()