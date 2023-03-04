(function () {
    const nuevaTareaBtn = document.querySelector('#agregar-tarea');
    nuevaTareaBtn.addEventListener('click', mostrarFormuario);

    function mostrarFormuario() {
        const modal = document.createElement('DIV');
        modal.classList.add('modal');
        modal.innerHTML = `
            <form class="formulario nueva-tarea">
                <legend>Añade una nueva Tarea</legend>
                <div class="campo">
                    <label>Tarea</label>
                    <input
                        type= "text"
                        name = "tarea"
                        placeholder="Añadir Tarea al proyecto Actual"
                        id="tarea"
                    />
                </div>
                <div class="opciones">
                    <input type="submit" class="submit-nueva-tarea" value="Añadir Tarea"/>
                    <button type="button" class="cerrar-modal">Cancelar</button>
                </div>
            </form>
        `;
        setTimeout(() => {
            const formulario = document.querySelector('.formulario');
            formulario.classList.add('animar');
        }, 0);

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
                submitFormularioNuevaTarea();
            }
        });

        document.querySelector('.dashboard').appendChild(modal);
    }
    function submitFormularioNuevaTarea() {
        const tarea = document.querySelector('#tarea').value.trim();
        if (tarea === '') {
            //Mostrar alerta de error
            mostrarAlertaAfter('El nombre de la tarea es obligatorio', 'error', document.querySelector('.formulario legend'));
            return;
        }

        agregarTarea(tarea);
    }
    // Muestra mensaje en la interfaz
    function mostrarAlertaAfter(mensaje, tipo, referencia) {
        // Previene la creacion de multiples alertas
        const alertaPrevia = document.querySelector('.alerta')
        if (alertaPrevia) {
            alertaPrevia.remove();
        }

        const alerta = document.createElement('DIV');
        alerta.classList.add('alerta', tipo);
        alerta.textContent = mensaje;
        //Inserta la alerta antes del legend
        //El insert before agrega en un elemento antes 
        referencia.parentElement.insertBefore(alerta, referencia.nextElementSibling); //Con nextElementSibling traemos el siguiente elemento del que hicimos referencias

        //Eliminar la alerta despues de 5 seg 

        setTimeout(() => {
            alerta.remove();
        }, 5000);
    }
    function mostrarAlertaBefore(mensaje, tipo, referencia) {
        // Previene la creacion de multiples alertas
        const alertaPrevia = document.querySelector('.alerta')
        if (alertaPrevia) {
            alertaPrevia.remove();
        }

        const alerta = document.createElement('DIV');
        alerta.classList.add('alerta', tipo);
        alerta.textContent = mensaje;
        //Inserta la alerta antes del legend
        //El insert before agrega en un elemento antes 
        referencia.parentElement.insertBefore(alerta, referencia); //Con nextElementSibling traemos el siguiente elemento del que hicimos referencias

        //Eliminar la alerta despues de 5 seg 

        setTimeout(() => {
            alerta.remove();
        }, 5000);
    }

    async function agregarTarea(tarea) {
        // Construir peticion 
        const datos = new FormData();
        datos.append('nombre', tarea);
        datos.append('proyectoId', obtenerProyecto());

        try {
            const url = 'http://localhost:3000/api/tarea';
            const respuesta = await fetch(url, {
                method: 'POST',
                body: datos
            });

            const resultado = await respuesta.json();

            console.log(resultado);



            if (resultado.tipo === 'exito') {
                mostrarAlertaAfter(resultado.mensaje, resultado.tipo, document.querySelector('.nombre-pagina'));
                const modal = document.querySelector('.modal');
                // setTimeout(() => {
                modal.remove();
                // }, 3000);

            }

        } catch (error) {
            console.log(error);
        }
    }

    function obtenerProyecto() {
        const proyectoParams = new URLSearchParams(window.location.search);
        // Con esto traemos todos los parametros de la url agrupnadolos en un array
        const proyecto = Object.fromEntries(proyectoParams.entries());
        return proyecto.id;
    }
})();