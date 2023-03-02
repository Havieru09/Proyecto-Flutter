// (function () {

//     infoApi();
//     // // create a function to get and send information from api
//     async function infoApi() {
//         await fetch('http://localhost:3000/solicitudes')
//             .then(response => response.json())
//             .then(data => {
//                 const { solicitud } = data;
//                 const lista = document.querySelector('.listado-solicitudes');
//                 // console.log(data);
//                 // console.log(data['solicitud']);
//                 if (solicitud.length > 0) {
//                     solicitud.forEach(function (soli) {
                        
//                         const enlace = document.createElement('a');
//                         // modal.classList.add('modal');
//                         enlace.setAttribute('href', '/proyecto?id=' + soli.id);
//                         enlace.setAttribute('class', 'solicitud');
//                         setTimeout(() => {
//                             if (soli.estado === "Completa") {
//                                 console.log('Si entra');
//                                 const titulo = document.querySelector('.titulo');
//                                 const estado = document.querySelector('.completa');
//                                 titulo.classList.remove();
//                                 titulo.classList.add('completa');
//                                 // lista.setAttribute('class', 'listado-solicitudes completa');
//                             }
//                         }, 0);
//                         console.log(soli.estado);
//                         enlace.innerHTML = `
//                                 <li> 
//                                     <span class="titulo">
//                                         Solicitud: `+soli.estado+`
//                                     </span>
//                                     <label>`
//                                         +soli.tipo+`
//                                     </label>
//                                 </li>
//                         `;
//                         lista.appendChild(enlace);
//                     });
//                 }else{
//                     const mensaje = document.createElement('P');
//                     mensaje.innerHTML= `No hay proyectos aún`;
//                     lista.appendChild(mensaje);
//                 }
//             })
//             .catch(error => {
//                 console.error('Error al obtener los datos:', error);
//             });
//     }
// })()