(function () {

    const Salones = document.querySelectorAll('.salones');
    Salones.forEach(Salon => {        
        Salon.addEventListener('click', function (e) {
            const id = Salon.querySelector(".id").innerHTML;
            const modal = EnvioId(id.trim(), "actualizar-salon");
        });
    });

    const nuevoSalon = document.querySelector('.nuevoSalon');
    nuevoSalon.addEventListener('click', function () {
        EnvioId(null, "agregar-nuevoSalon");
    });

    function EnvioId(id, tarea) {
        if (id !== null) {
            var datos = new FormData();
            datos.append('id', id);
        }
        try {
            if (tarea == "agregar-nuevoSalon") {
                var modal = modalNuevoSalon();
                mostrarModal(modal);
                return;
            }else if (tarea == "actualizar-salon") {
                console.log("url");
                var url = 'http://localhost:3001/salon';
            }
            const resultados = consultaApi(url, datos);
            resultados.then(function (resultado) {
                if (resultado.remitente == "salon") {
                    var modal = modalSalon(resultado);
                    // var modal = modalUsuarios(resultado);
                }
                mostrarModal(modal, resultado.id);
            });
        } catch (error) {
            console.log(error);
        }
    }
    async function consultaApi(url, datos) {
        const respuesta = await fetch(url, {
            method: 'POST',
            body: datos
        });
        // console.log(respuesta.json());
        const resultado = await respuesta.json();
        return resultado;
    }

    function modalSalon(resultado) {
        const modal = document.createElement('DIV');
        modal.classList.add('modal');
        modal.innerHTML = `
        <form class="formulario">
                <legend>Añadir nuevo Salon</legend>
                <div class="campo">
                    <label class="subtitulo">Nombre del Salon</label>
                    <input
                        type= "text"
                        name = "salon"
                        placeholder="Ingresa el nombre del salon"
                        value="`+resultado.salon+`"
                        id="salon"
                    />
                </div>
                <div class="opciones">
                    <input type="submit" class="submit-actualiza-salon" value="Actualizar Salon"/>
                    <button type="button" class="cerrar-modal">Cancelar</button>
                </div>
            </form>
    `;
        return modal;
    }

    function modalNuevoSalon() {
        const modal = document.createElement('DIV');
        modal.classList.add('modal');
        modal.innerHTML = `
        <form class="formulario">
                <legend>Añadir nuevo Salon</legend>
                <div class="campo">
                    <label class="subtitulo">Nombre del Salon</label>
                    <input
                        type= "text"
                        name = "salon"
                        placeholder="Ingresa el nombre del salon"
                        id="salon"
                    />
                </div>
                <div class="opciones">
                    <input type="submit" class="submit-nuevo-salon" value="Crear Salon"/>
                    <button type="button" class="cerrar-modal">Cancelar</button>
                </div>
            </form>
    `;
        return modal;
    }

    async function submitNuevoSalon() {
        var cantidad = 0;
        var expresionSalon = /^(laboratorio|aula)\s[\w\s]*$/;        
        const salon = document.querySelector('#salon').value.trim().toUpperCase();
        if (salon == "") {
            mostrarAlertaAfter("El nombre del salon no debe ir vacio", "error", document.querySelector('legend'));
            return;
        }else if(!expresionSalon.test(salon.toLowerCase())){
            mostrarAlertaAfter("El texto debe iniciar con aula o laboratorio seguidos de un espacio", "error", document.querySelector('legend'));
            return;
        }

        var datos = { nombre_aulas: `${salon}`};
        console.log(datos);
        
        var datosJSON = JSON.stringify(datos);
        enviarDatosApi("http://localhost:3000/aulas", datosJSON)
    }

    async function enviarDatosApi(url, datos, method = 'POST') {
        try {
            const respuesta = await fetch(url, {
                method: method,
                headers: {
                    'Content-Type': 'application/json'
                },
                body: datos
            });

            const resultado = await respuesta.json();
            if (resultado.message == "Updated") {
                alert("Actualizado");
            } else if (resultado.message == "Saved") {
                alert("Salon Creado");
            }
            location.reload()
            return;
        } catch (error) {
            console.log(error);
        }
    }

    function animar() {
        setTimeout(() => {
            const formulario = document.querySelector('.formulario');
            formulario.classList.add('animar');
        }, 100);
    }

    function mostrarModal(modal, id = "") {
        animar();
        modal.addEventListener('click', function (e) {
            e.preventDefault();

            if (e.target.classList.contains('cerrar-modal')) {
                const formulario = document.querySelector('.formulario');
                formulario.classList.add('cerrar');
                setTimeout(() => {
                    modal.remove();
                }, 500);
            }
            if (e.target.classList.contains('submit-nuevo-salon')) {
                submitNuevoSalon();
            }
        });
        document.querySelector('.dashboard').appendChild(modal);
    }

    function mostrarAlertaAfter(mensaje, tipo, referencia) {
        // Previene la creacion de multiples alertas
        const alertaPrevia = document.querySelector('.alerta')
        if (alertaPrevia) {
            alertaPrevia.remove();
        }

        const alerta = document.createElement('DIV');
        alerta.classList.add('alerta', tipo);
        alerta.textContent = mensaje;
        referencia.parentElement.insertBefore(alerta, referencia.nextElementSibling); //Con nextElementSibling traemos el siguiente elemento del que hicimos referencias

        //Eliminar la alerta despues de 5 seg 

        setTimeout(() => {
            alerta.remove();
        }, 5000);
    }
})()