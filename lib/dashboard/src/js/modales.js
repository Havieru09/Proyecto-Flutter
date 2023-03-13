

const solicitudes = document.querySelectorAll('.solicitudes');
solicitudes.forEach(solicitud => {
    solicitud.addEventListener('click', function (e) {
        const id = solicitud.querySelector(".id").innerHTML;
        const modal = EnvioId(id.trim(), 'http://localhost:3001/solicitudes');
    });
});

const usuarios = document.querySelectorAll('.usuarios');
usuarios.forEach(usuario => {
    usuario.addEventListener('click', function (e) {
        const id = usuario.querySelector(".id").innerHTML;
        const modal = EnvioId(id.trim(), 'http://localhost:3001/usuario');
    });
});

const salones = document.querySelectorAll('.salones');
salones.forEach(salon => {
    salon.addEventListener('click', function (e) {
        const id = salon.querySelector(".id").innerHTML;
        const modal = EnvioId(id.trim(), 'http://localhost:3001/salon');
    });
});

const bloques = document.querySelectorAll('.bloques');
bloques.forEach(bloque => {
    bloque.addEventListener('click', function (e) {
        const id = bloque.querySelector(".id").innerHTML;
        const modal = EnvioId(id.trim(), 'http://localhost:3001/bloque');
    });
});

function envioUsuario() {
    var modal = modalNuevoUsuario();
    // mostrarModal(modal);
    return;
}

function envioSalon() {
    var modal = modalNuevoSalon();
    // mostrarModal(modal);
    return;
}

function envioBloque() {
    var modal = modalNuevoBloque();
    mostrarModal(modal);
    return;
}

function EnvioId(id, url) {
    console.log(id);
    if (id !== null) {
        var datos = new FormData();
        datos.append('id', id);
    }
    try {

        const resultados = consultaApi(url, datos);
        resultados.then(function (resultado) {
            if (resultado.remitente == "soporte") {
                var modal = modalServicios(resultado);
            } else if (resultado.remitente == "docente") {
                console.log(resultado);
                // return;
                var modal = modalUsuarios(resultado);
            } else if (resultado.remitente == "salon") {
                console.log(resultado.bloque);
                // return;
                var modal = modalSalon(resultado, resultado.id, resultado.bloque);
            } else if (resultado.remitente == "bloque") {
                console.log(resultado);
                var modal = modalBloque(resultado);
            }
            mostrarModal(modal, resultado.id);
        });
    } catch (error) {
        console.log(error);
    }
}

function modalServicios(resultado) {
    var fecha
    if (resultado.estado === "terminado") {
        var respuesta1 = "completa";
        fecha = resultado.fecha_final;
    } else if (resultado.estado === "en_camino") {
        var respuesta1 = "camino";
        fecha = resultado.fecha_final;
    } else {
        var respuesta1 = "pendiente";
        fecha = resultado.fecha_inicial;
    }
    const fechaCompleta = fecha;
    const fecha1 = new Date(fechaCompleta);
    const fechaString = fecha1.toLocaleDateString('es-ES');


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
            <div class="campo">
                <label class="subtitulo">Detalle:</label>
                <label>`+ fechaString + `</label>
            </div>              
            <div class="opciones-unica">
                <button type="button" class="cerrar-modal">Volver</button>
            </div>
        </form>
    `;
    return modal;
}

function modalUsuarios(resultado) {
    // var resultado_docente = "";
    // var resultado_soporte = "";
    // if (resultado.rol == "docente") {
    //     resultado_docente = 'selected';
    // } else {
    //     resultado_soporte = 'selected';
    // }
    const modal = document.createElement('DIV');
    modal.classList.add('modal');
    LeerApi('http://localhost:3000/usuarios_rol')
        .then(json => {
            modal.innerHTML = `
            <form class="formulario" >
                <legend>Usuario: `+ resultado.usuario + `</legend>                
                <div class="campo">
                    <label class="subtitulo">Nombre</label>
                    <input
                        type= "text"
                        name = "nombre"
                        placeholder="Ingresa el nombre de usuario"
                        value="`+ resultado.nombre + `"
                        id="nombre"
                    />
                </div>
                <div class="campo">
                    <label class="subtitulo">Apellido</label>
                    <input
                        type= "text"
                        name = "apellido"
                        placeholder="Ingresa el nombre de usuario"
                        value="`+ resultado.apellido + `"
                        id="apellido"
                    />
                </div>
                <div class="campo">
                    <label class="subtitulo">Direccion</label>
                    <input
                        type= "text"
                        name = "direccion"
                        placeholder="Ingresa el nombre de usuario"
                        value="`+ resultado.direccion + `"
                        id="direccion"
                    />
                </div>
                <div class="campo">
                    <label class="subtitulo">Usuario</label>
                    <input
                        type= "text"
                        name = "usuario"
                        placeholder="Ingresa el nombre de usuario"
                        value="`+ resultado.usuario + `"
                        id="usuario"
                    />
                </div>
                <div class="campo">
                    <label class="subtitulo">Contraseña</label>
                    <input
                        type= "password"
                        name = "psw"
                        placeholder="Ingresa el nombre de usuario"
                        value="`+ resultado.psw + `"
                        id="psw"
                    />
                </div>
                <div class="campo">
                    <label class="subtitulo">Rol</label>
                    <select id="usuario-select">

                    </select>
                </div>
                <div class="opciones">
                    <input type="submit" class="submit-actualizar-usuario" value="Actualizar"/>
                    <button type="button" class="cerrar-modal">Cancelar</button>
                </div>
            </form>
        `;
            const select = modal.querySelector('#usuario-select');
            json.rol.forEach(rol => {
                const option = document.createElement('option');
                option.value = rol.id;
                option.text = rol.nombre_rol;

                select.add(option);
            });
            mostrarModal(modal)
        })
        .catch(error => {
            console.error(error); // manejo de errores
        });


    return modal;
}

function modalNuevoUsuario() {
    const modal = document.createElement('DIV');
    modal.classList.add('modal');
    LeerApi('http://localhost:3000/usuarios_rol')
        .then(json => {
            modal.innerHTML = `
            <form action="/usuarios" class="formulario">
                <legend>Añadir nuevo Usuario</legend>
                <div class="campo">
                    <label class="subtitulo">Cedula</label>
                    <input
                        type= "number"
                        name = "cedula"
                        placeholder="Ingresa la cedula del usuario"
                        id="cedula"
                    />
                </div>
                <div class="campo">
                    <label class="subtitulo">Nombre</label>
                    <input
                        type= "text"
                        name = "nombre"
                        placeholder="Ingresa el nombre del usuario"
                        id="nombre"
                    />
                </div>
                <div class="campo">
                    <label class="subtitulo">Apellido</label>
                    <input
                        type= "text"
                        name = "apellido"
                        placeholder="Ingresa el apellido del usuario"
                        id="apellido"
                    />
                </div>
                <div class="campo">
                    <label class="subtitulo">Direccion</label>
                    <input
                        type= "text"
                        name = "direccion"
                        placeholder="Ingresa la direccion del usuario"
                        id="direccion"
                    />
                </div>
                <div class="campo">
                    <label class="subtitulo">Correo</label>
                    <input
                        type= "email"
                        name = "correo"
                        placeholder="Ingresa el correo del usuario"
                        id="correo"
                    />
                </div>
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
                    <select id="usuario-select">
                        
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
            const select = modal.querySelector('#usuario-select');
            json.rol.forEach(rol => {
                const option = document.createElement('option');
                option.value = rol.id;
                option.text = rol.nombre_rol;

                select.add(option);
            });
            mostrarModal(modal)
        })
        .catch(error => {
            console.error(error); // manejo de errores
        });
    return modal;
}

function modalSalon(resultado, id, Nombre_bloque) {
    console.log(Nombre_bloque);
    const modal = document.createElement('DIV');
    modal.classList.add('modal');
    LeerApi('http://localhost:3000/bloques')
        .then(json => {
            modal.innerHTML = `
            <form class="formulario">
                <legend>Actualizar Salon</legend>
                <div class="campo">
                    <label class="subtitulo">Nombre del Salon</label>
                    <input
                        type= "text"
                        name = "salon"
                        placeholder="Ingresa el nombre del salon"
                        value="`+ resultado.salon + `"
                        id="salon"
                    />
                </div>
                <div class="campo">
                    <label class="subtitulo">Bloque</label>
                    <select id="bloque-select">

                    </select>
                </div>
                
                <div class="opciones">
                    <input type="submit" class="submit-actualiza-salon" value="Actualizar Salon"/>
                    <button type="button" class="cerrar-modal">Cancelar</button>
                </div>
            </form>
            `;
            const select = modal.querySelector('#bloque-select');
            json.bloques.forEach(bloque => {
                const option = document.createElement('option');
                option.value = bloque.id;
                option.text = bloque.nombre_bloque;
                if (Nombre_bloque == bloque.nombre_bloque) {
                    option.selected = true;
                }

                // console.log(option);
                select.add(option);
            });
            // return;
            mostrarModal(modal, id)
            return modal; // el resultado de la solicitud HTTP en formato JSON
        })
        .catch(error => {
            console.error(error); // manejo de errores
        });
    return;
    //     const modal = document.createElement('DIV');
    //     modal.classList.add('modal');
    //     modal.innerHTML = `
    //     <form class="formulario">
    //             <legend>Actualizar Salon</legend>
    //             <div class="campo">
    //                 <label class="subtitulo">Nombre del Salon</label>
    //                 <input
    //                     type= "text"
    //                     name = "salon"
    //                     placeholder="Ingresa el nombre del salon"
    //                     value="`+ resultado.salon + `"
    //                     id="salon"
    //                 />
    //             </div>
    //             <div class="opciones">
    //                 <input type="submit" class="submit-actualiza-salon" value="Actualizar Salon"/>
    //                 <button type="button" class="cerrar-modal">Cancelar</button>
    //             </div>
    //         </form>
    // `;
    //     return modal;
}

function modalBloque(resultado) {
    const modal = document.createElement('DIV');
    modal.classList.add('modal');
    modal.innerHTML = `
    <form class="formulario">
            <legend>Actualizar Bloque</legend>
            <div class="campo">
                <label class="subtitulo">Nombre del Bloque</label>
                <input
                    type= "text"
                    name = "bloque"
                    placeholder="Ingresa el nombre del bloque"
                    value="`+ resultado.bloque + `"
                    id="bloque"
                />
            </div>
            <div class="opciones">
                <input type="submit" class="submit-actualiza-bloque" value="Actualizar Bloque"/>
                <button type="button" class="cerrar-modal">Cancelar</button>
            </div>
        </form>
`;
    return modal;
}

function modalNuevoBloque() {
    const modal = document.createElement('DIV');
    modal.classList.add('modal');
    modal.innerHTML = `
    <form class="formulario">
            <legend>Agrega un nuevo Bloque</legend>
            <div class="campo">
                <label class="subtitulo">Nombre del Bloque</label>
                <input
                    type= "text"
                    name = "bloque"
                    placeholder="Ingresa el nombre del bloque"
                    id="bloque"
                />
            </div>
            <div class="opciones">
                <input type="submit" class="submit-nuevo-bloque" value="Crear Bloque"/>
                <button type="button" class="cerrar-modal">Cancelar</button>
            </div>
        </form>
`;
    return modal;
}

function modalNuevoSalon() {
    var jsonString
    const modal = document.createElement('DIV');
    modal.classList.add('modal');
    // var resultado = LeerApi('http://localhost:3000/bloques');
    LeerApi('http://localhost:3000/bloques')
        .then(json => {
            console.log(json.bloques);
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
                <div class="campo">
                    <label class="subtitulo">Bloque</label>
                    <select id="bloque-select">

                    </select>
                </div>
                
                <div class="opciones">
                    <input type="submit" class="submit-nuevo-salon" value="Crear Salon"/>
                    <button type="button" class="cerrar-modal">Cancelar</button>
                </div>
            </form>
            `;
            const select = modal.querySelector('#bloque-select');
            json.bloques.forEach(bloque => {
                const option = document.createElement('option');
                option.value = bloque.id;
                option.text = bloque.nombre_bloque;

                select.add(option);
            });
            mostrarModal(modal)
            return modal; // el resultado de la solicitud HTTP en formato JSON
        })
        .catch(error => {
            console.error(error); // manejo de errores
        });
}

async function submitNuevoSalon() {
    var cantidad = 0;
    // var expresionSalon = /^(laboratorio|aula)\s[\w\s]*$/;
    var expresionSalon = /^[a-zA-Z0-9\s]*$/;
    const salon = document.querySelector('#salon').value.trim().toUpperCase();
    const bloque = document.querySelector('#bloque-select').value.trim().toUpperCase();
    if (salon != "") {
        const respuesta = await fetch("http://localhost:3000/aulas_nombre/" + salon + "&" + bloque);
        const resultado = await respuesta.json();
        cantidad = Object.keys(resultado.aulas).length;
    }
    if (cantidad > 0) {
        mostrarAlertaAfter("El Salon ya existe", "error", document.querySelector('legend'));
        return;
    }
    if (salon == "") {
        mostrarAlertaAfter("El nombre del salon no debe ir vacio", "error", document.querySelector('legend'));
        return;
    } else if (!expresionSalon.test(salon.toLowerCase())) {
        mostrarAlertaAfter("El texto debe iniciar con aula o laboratorio seguidos de un espacio", "error", document.querySelector('legend'));
        return;
    }

    var datos = { nombre_aulas: `${salon}`, bloque_id: `${bloque}` };
    console.log(datos);

    var datosJSON = JSON.stringify(datos);
    enviarDatosApi("http://localhost:3000/aulas", datosJSON)
}

async function submitNuevoBloque() {
    var cantidad = 0;
    var expresionBloque = /^[a-zA-Z]$/;
    const bloque = document.querySelector('#bloque').value.trim().toUpperCase();
    if (bloque != "") {
        const respuesta = await fetch("http://localhost:3000/bloque_nombre/" + bloque);
        const resultado = await respuesta.json();
        cantidad = Object.keys(resultado.bloques).length;
        console.log(resultado);
        console.log("http://localhost:3000/bloque_nombre/" + bloque);
    }
    if (cantidad > 0) {
        mostrarAlertaAfter("El Bloque ya existe", "error", document.querySelector('legend'));
        return;
    }
    if (bloque == "") {
        mostrarAlertaAfter("El nombre del Bloque no debe ir vacio", "error", document.querySelector('legend'));
        return;
    } else if (!expresionBloque.test(bloque.toUpperCase())) {
        mostrarAlertaAfter("El nombre del bloque solo es una letra", "error", document.querySelector('legend'));
        return;
    }

    var datos = { nombre_bloques: `${bloque}` };
    console.log(datos);

    var datosJSON = JSON.stringify(datos);
    enviarDatosApi("http://localhost:3000/bloques", datosJSON)
}

async function submitActualizarSalon(id) {

    var cantidad = 0;
    // var expresionSalon = /^(laboratorio|aula)\s[\w\s]*$/;
    var expresionSalon = /^[a-zA-Z0-9\s]*$/;
    const salon = document.querySelector('#salon').value.trim().toUpperCase();
    const bloque = document.querySelector('#bloque-select').value.trim().toUpperCase();

    console.log(salon);
    if (salon != "") {
        const respuesta = await fetch("http://localhost:3000/aulas_nombre/" + salon + "&" + bloque);
        const resultado = await respuesta.json();
        // console.log("LO que me trae"+resultado);
        cantidad = Object.keys(resultado.aulas).length;
    }
    if (cantidad > 0) {
        mostrarAlertaAfter("El Salon ya existe", "error", document.querySelector('legend'));
        return;
    }
    if (salon == "") {
        mostrarAlertaAfter("El nombre del salon no debe ir vacio", "error", document.querySelector('legend'));
        return;
    } else if (!expresionSalon.test(salon.toLowerCase())) {
        mostrarAlertaAfter("El texto debe iniciar con aula o laboratorio seguidos de un espacio", "error", document.querySelector('legend'));
        return;
    }

    var datos = { nombre_aulas: `${salon}`, bloque_id: `${bloque}` };
    console.log(datos);

    var datosJSON = JSON.stringify(datos);
    console.log(datosJSON);
    enviarDatosApi("http://localhost:3000/aulas/" + id, datosJSON, 'PUT')
}

async function submitActualizarBloque(id) {
    var expresionBloque = /^[a-zA-Z]$/;
    const bloque = document.querySelector('#bloque').value.trim().toUpperCase();
    if (bloque != "") {
        const respuesta = await fetch("http://localhost:3000/bloque_nombre/" + bloque);
        const resultado = await respuesta.json();
        cantidad = Object.keys(resultado.bloques).length;
        console.log(resultado);
        console.log("http://localhost:3000/bloque_nombre/" + bloque);
    }
    if (cantidad > 0) {
        mostrarAlertaAfter("El Bloque ya existe", "error", document.querySelector('legend'));
        return;
    }
    if (bloque == "") {
        mostrarAlertaAfter("El nombre del bloque no debe ir vacio", "error", document.querySelector('legend'));
        return;
    } else if (!expresionBloque.test(bloque.toLowerCase())) {
        mostrarAlertaAfter("El nombre del bloque solo es una letra", "error", document.querySelector('legend'));
        return;
    }

    var datos = { nombre_bloques: `${bloque}` };

    var datosJSON = JSON.stringify(datos);
    console.log(datosJSON);
    enviarDatosApi("http://localhost:3000/bloques/" + id, datosJSON, 'PUT')
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
        console.log(id);
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
        if (e.target.classList.contains('submit-nuevo-salon')) {
            submitNuevoSalon();
        }
        if (e.target.classList.contains('submit-actualiza-bloque')) {
            submitActualizarBloque(id);
        }
        if (e.target.classList.contains('submit-nuevo-bloque')) {
            submitNuevoBloque(id);
        }
        if (e.target.classList.contains('submit-actualiza-salon')) {
            // console.log(id);
            submitActualizarSalon(id);
        }
    });
    document.querySelector('.dashboard').appendChild(modal);
}

async function submitActualizarUsuario(id) {
    console.log('aqui');
    var expresionUsuario = /^[a-zA-Z\s]+$/;
    var expresionDireccion = /^[a-zA-Z0-9\s,'-]*$/;
    const nombre = document.querySelector('#nombre').value.trim().toLowerCase();
    const apellido = document.querySelector('#apellido').value.trim().toLowerCase();
    // const correo = document.querySelector('#correo').value.trim().toLowerCase();

    const direccion = document.querySelector('#direccion').value.trim().toLowerCase();
    const rol = document.querySelector('#usuario-select').value.trim().toLowerCase();
    const usuario = document.querySelector('#usuario').value.trim();
    const psw = document.querySelector('#psw').value.trim();
    if (usuario == "" || psw == "") {
        mostrarAlertaAfter("El usuario y el password no puede ir vacio", "error", document.querySelector('legend'));
        return;

    } 
    // else if (!expresionUsuario.test(usuario)) {
    //     mostrarAlertaAfter("El usuario solo debe contener letras", "error", document.querySelector('legend'));
    //     return;
    // }
    else if (!direccion) {
        mostrarAlertaAfter("La direccion no puede ir vacia", "error", document.querySelector('legend'));
        return;
    }
    else if (!expresionDireccion.test(direccion)) {
        mostrarAlertaAfter("Direccion no valida", "error", document.querySelector('legend'));
        return;
    }
    else if (!expresionUsuario.test(nombre)) {
        mostrarAlertaAfter("El nombre solo debe contener letras", "error", document.querySelector('legend'));
        return;
    }else if (!expresionUsuario.test(apellido)) {
        mostrarAlertaAfter("El apellido solo debe contener letras", "error", document.querySelector('legend'));
        return;
    }
    var datos = { nombre: `${nombre}`,apellido: `${apellido}`,direccion: `${direccion}`, rol_id: `${rol}`, usuario: `${usuario}`, psw: `${psw}` };
    var datosJSON = JSON.stringify(datos);
    const url = `http://localhost:3000/usuarios/` + id;
    enviarDatosApi(url, datosJSON, 'PUT');
}

async function submitNuevaUsuario() {
    let existe = false;
    var cantidad = 0;
    var expresionUsuario = /^[a-zA-Z\s]+$/;
    var expresionCorreo = /@ups\.edu\.ec$/;
    var expresionDireccion = /^[a-zA-Z0-9\s,'-]*$/;
    const cedula = document.querySelector('#cedula').value.trim();
    const nombre = document.querySelector('#nombre').value.trim().toLowerCase();
    const apellido = document.querySelector('#apellido').value.trim().toLowerCase();const direccion = document.querySelector('#direccion').value.trim().toLowerCase();
    const correo = document.querySelector('#correo').value.trim().toLowerCase();
    const rol = document.querySelector('#usuario-select').value;
    const usuario = document.querySelector('#usuario').value.trim();
    const psw = document.querySelector('#psw').value.trim();
    if (correo != "" || cedula !="") {
        const respuesta1 = await fetch("http://localhost:3000/usuarios2/" + correo+"&"+cedula);
        const resultado2 = await respuesta1.json();
        cantidad = Object.keys(resultado2.usuario).length;
    }    
    if (cantidad > 0) {
        mostrarAlertaAfter("El usuario ya existe", "error", document.querySelector('legend'));
        return;
    } 
    else if (existe == true) {
        mostrarAlertaAfter("El usuario ya existe", "error", document.querySelector('legend'));
        return;
    }
    else if (!cedula) {
        mostrarAlertaAfter("La cedula ", "error", document.querySelector('legend'));
        return;
    }
    else if (!direccion) {
        mostrarAlertaAfter("La direccion no puede ir vacia", "error", document.querySelector('legend'));
        return;
    }
    else if (!expresionDireccion.test(direccion)) {
        mostrarAlertaAfter("Direccion no valida", "error", document.querySelector('legend'));
        return;
    }
    else if (usuario == "" || psw == "" || correo == "") {
        mostrarAlertaAfter("El usuario, password y el correo no puede ir vacio", "error", document.querySelector('legend'));
        return;
    } else if (rol == "ninguno") {
        mostrarAlertaAfter("Debe elegir un rol", "error", document.querySelector('legend'));
        return;
    } else if (!expresionUsuario.test(usuario)) {
        mostrarAlertaAfter("El usuario solo debe contener letras", "error", document.querySelector('legend'));
        return;
    } else if (!expresionCorreo.test(correo)) {
        mostrarAlertaAfter("El correo debe contener '@ups.edu.ec'", "error", document.querySelector('legend'));
        return;
    }else if (!expresionUsuario.test(nombre)) {
        mostrarAlertaAfter("El nombre solo debe contener letras", "error", document.querySelector('legend'));
        return;
    }else if (!expresionUsuario.test(apellido)) {
        mostrarAlertaAfter("El apellido solo debe contener letras", "error", document.querySelector('legend'));
        return;
    }
    var datos = { cedula: `${cedula}`,correo: `${correo}`, nombre: `${nombre}`,apellido: `${apellido}`,direccion: `${direccion}`, rol_id: `${rol}`, usuario: `${usuario}`, psw: `${psw}`  };
    
    
    var datosJSON = JSON.stringify(datos);
    console.log(datosJSON);
    // return;
    enviarDatosApi("http://localhost:3000/usuarios", datosJSON)
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
        console.log(resultado);
        if (resultado.message == "Updated") {
            alert("Actualizado");
        } else if (resultado.message == "Saved") {
            alert("Creado");
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

async function LeerApi(url) {
    const respuesta = await fetch(url);
    const resultado = await respuesta.json();
    // console.log(resultado.aulas);
    const jsonString = JSON.stringify(resultado);
    // console.log(jsonString);
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
