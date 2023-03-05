(function () {
    const solicitudes = document.querySelectorAll('.solicitudes');
    solicitudes.forEach(solicitud => {
        solicitud.addEventListener('click', function (e) {
            const id = solicitud.querySelector(".id").innerHTML;
            const modal = EnvioId(id.trim(), "solicitudes");
        });
    });

    const usuarios = document.querySelectorAll('.usuarios');
    usuarios.forEach(usuario => {
        usuario.addEventListener('click', function (e) {
            const id = usuario.querySelector(".id").innerHTML;
            const modal = EnvioId(id.trim(), "usuarios");
        });
    });

    const Nuevousuario = document.querySelector('.nuevoUser');
    Nuevousuario.addEventListener('click', function (e) {
        const modal = EnvioId(null, "agregar-Usuario");
    });

    function EnvioId(id, tarea) {
        if (id !== null) {
            var datos = new FormData();
            datos.append('id', id);
        }
        try {
            // 
            if (tarea == "solicitudes") {
                var url = 'http://localhost:3001/dashboard';
            } else if (tarea == "usuarios") {
                var url = 'http://localhost:3001/usuario'
            } else if (tarea == "agregar-Usuario") {
                var modal = modalNuevoUsuario();
                mostrarModal(modal);
                return;
            }


            const resultados = consultaApi(url, datos);
            resultados.then(function (resultado) {
                if (resultado.remitente == "soporte") {
                    var modal = modalServicios(resultado);
                } else if (resultado.remitente == "docente") {
                    var modal = modalUsuarios(resultado);
                }

                mostrarModal(modal, resultado.id);
            });
        } catch (error) {
            console.log(error);
        }
    }

    function modalServicios(resultado) {
        if (resultado.estado === "terminado") {
            var respuesta1 = "completa";
        } else if (resultado.estado === "en_camino") {
            var respuesta1 = "camino";
        } else {
            var respuesta1 = "pendiente";
        }
        const modal = document.createElement('DIV');
        modal.classList.add('modal');
        var Titulo = resultado.estado === "en_camino" ? "En Camino" : resultado.estado;
        modal.innerHTML = `
        <form class="formulario"> 
            <div class="contenedor-titulo">
            <legend class="">Solicitud ` + Titulo + ` </legend> 
            <div class="imagen-estado `+ respuesta1 + `"></div>
            </div>          
            <div class="campo">
                <label class="subtitulo" >Tipo:</label>
                <label>`+ resultado.tipo + `</label>
            </div>
            <div class="campo">
                <label class="subtitulo">Bloque:</label>
                <label>`+ resultado.bloque + `</label>
            </div>
            <div class="campo">
                <label class="subtitulo">Aula:</label>
                <label>`+ resultado.aula + `</label>
            </div>
            <div class="campo">
                <label class="subtitulo">Usuario:</label>
                <label>`+ resultado.usuario + `</label>
            </div>
            <div class="campo">
                <label class="subtitulo">Detalle:</label>
                <label>`+ resultado.detalle + `</label>
            </div>                
            <div class="opciones-unica">
                <button type="button" class="cerrar-modal">Volver</button>
            </div>
        </form>
    `;
        return modal;
    }

    function modalUsuarios(resultado) {
        var resultado_docente = "";
        var resultado_soporte = "";
        if (resultado.rol == "docente") {
            resultado_docente = 'selected';
        } else {
            resultado_soporte = 'selected';
        }
        const modal = document.createElement('DIV');
        modal.classList.add('modal');
        modal.innerHTML = `
        <form class="formulario" >
                <legend>Usuario: `+ resultado.usuario + `</legend>
                <div class="campo">
                    <label class="subtitulo">Rol</label>
                    <select id="rol">
                        <option `+ resultado_docente + ` value="docente">Docente</option>
                        <option `+ resultado_soporte + ` value="soporte">Soporte</option>
                    </select>
                </div>
                <div class="opciones">
                    <input type="submit" class="submit-actualizar-usuario" value="Actualizar"/>
                    <button type="button" class="cerrar-modal">Cancelar</button>
                </div>
            </form>
    `;
        return modal;
    }

    function modalNuevoUsuario() {
        const modal = document.createElement('DIV');
        modal.classList.add('modal');
        modal.innerHTML = `
        <form action="/usuarios" class="formulario">
                <legend>Añadir nuevo Usuario</legend>
                <div class="campo">
                    <label class="subtitulo">Usuario</label>
                    <input
                        type= "text"
                        name = "usuario"
                        placeholder="Ingresa el nombre de usuario"
                        id="usuario"
                    />
                </div>
                <div class="campo">
                    <label class="subtitulo">Rol</label>
                    <select id="rol">
                        <option value="ninguno">--Selecciona un Rol--</option>
                        <option value="docente">Docente</option>
                        <option value="soporte">Soporte</option>
                    </select>
                </div>
                <div class="campo">
                    <label class="subtitulo">Password</label>
                    <input
                        type= "password"
                        name = "psw"
                        placeholder="Ingresa el password del usuario"
                        id="psw"
                    />
                </div>
                <div class="opciones">
                    <input type="submit" class="submit-nuevo-usuario" value="Crear Usuario"/>
                    <button type="button" class="cerrar-modal">Cancelar</button>
                </div>
            </form>
    `;
        return modal;
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
            if (e.target.classList.contains('submit-actualizar-usuario')) {
                submitActualizarUsuario(id);
            }
            if (e.target.classList.contains('submit-nuevo-usuario')) {
                submitNuevaUsuario();
            }
        });
        document.querySelector('.dashboard').appendChild(modal);
    }

    async function submitActualizarUsuario(id) {
        const rol = document.querySelector('#rol').value.trim();
        var datos = { rol: `${rol}` };
        // console.log(datos);
        var datosJSON = JSON.stringify(datos);
        const url = `http://localhost:3000/usuarios/` + id;
        enviarDatosApi(url, datosJSON, 'PUT');
    }

    function submitNuevaUsuario() {
        var expresionUsuario = /^[a-zA-Z]+$/;
        const rol = document.querySelector('#rol').value.trim();
        const usuario = document.querySelector('#usuario').value.trim();
        const psw = document.querySelector('#psw').value.trim();
        if (usuario == "" || psw == "") {
            mostrarAlertaAfter("El usuario y el password no puede ir vacio", "error", document.querySelector('legend'));
            return;
        } else if (rol == "ninguno") {
            mostrarAlertaAfter("Debe elegir un rol", "error", document.querySelector('legend'));
            return;
        } else if (!expresionUsuario.test(usuario)) {
            mostrarAlertaAfter("El usuario solo debe contener letras", "error", document.querySelector('legend'));
            return;
        }

        var datos = { rol: `${rol}`, usuario: `${usuario}`, psw: `${psw}` };
        // console.log(datos);
        var datosJSON = JSON.stringify(datos);
        enviarDatosApi("http://localhost:3000/usuarios",datosJSON)
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
            }else if(resultado.message == "Saved"){
                alert("Usuario Creado");
            }            
            location.reload()
            return;
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

})()