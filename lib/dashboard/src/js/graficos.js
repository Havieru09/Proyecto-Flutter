async function LeerApi(url) {
    const respuesta = await fetch(url);
    const resultado = await respuesta.json();
    // console.log(resultado.aulas);
    const jsonString = JSON.stringify(resultado);
    // console.log(jsonString);
    return resultado;
}

async function enviarDatosApi(url, datos, method = 'POST') {
    console.log(url, datos, method);
    try {
        const respuesta = await fetch(url, {
            method: method,
            headers: {
                'Content-Type': 'application/json'
            },
            body: datos
        });
        console.log(respuesta);
        const resultado = await respuesta.json();
        console.log(resultado);
        return resultado;
    } catch (error) {
        console.log(error);
    }
}

(function () {
    mostrarGrafico();
    function mostrarGrafico() {
        google.charts.load('current', { 'packages': ['corechart'] });
        google.charts.setOnLoadCallback(drawChart);
        function drawChart() {
            LeerApi('http://localhost:3000/solicitudesAll')
                .then(json => {
                    console.log(json.solicitudes);

                    const dataArray = [['Solicitudes', 'Cantidad']];
                    json.solicitudes.forEach(d => {
                        dataArray.push([d.tipo, d.cantidad]);
                    });
                    const chartData = google.visualization.arrayToDataTable(dataArray);

                    // Define las opciones del gráfico
                    var options = {
                        title: 'Solicitudes General',
                        is3D: true,
                        fontSize: 16,
                        backgroundColor: '#f3f4f6',
                        padding: '0'
                    };

                    // Crea el gráfico y lo muestra en el elemento con id "chart_div"
                    const chart = new google.visualization.PieChart(document.getElementById('chart_div'));
                    chart.draw(chartData, options);
                    // }
                })
        }

        // -----------------------------------------------


    }
})()

function graficoFiltro() {
    const desde = document.getElementById('fecha_inicio');
    const id = document.getElementById('tipo');
    const hasta = document.getElementById('fecha_final');
    if (validarDatos(desde,hasta)) {
        var datos = { fecha_inicial: `${desde.value}`, fecha_final: `${hasta.value}`, id: `${id.value}` };
        var datosJSON = JSON.stringify(datos);
        enviarDatosApi('http://localhost:3000/solicitudesDate', datosJSON)
            .then(json => {
                console.log(json);
                // 3. Preparar los datos para el gráfico
                const chartData = [['Fecha', 'Cantidad']];

                json.solicitudes.forEach((d) => {
                    const fecha1 = new Date(d.fecha);
                    var fechaString = fecha1.toLocaleDateString('es-ES');
                    chartData.push([fechaString, d.cantidad]);
                });
                console.log(chartData);
                // 4. Dibujar el gráfico
                google.charts.load('current', { packages: ['corechart'] });
                google.charts.setOnLoadCallback(drawChart);

                function drawChart() {
                    const data = google.visualization.arrayToDataTable(chartData);

                    const options = {
                        title: `Solicitudes de tipo  desde hasta `,
                        hAxis: {
                            title: 'Fecha',
                            titleTextStyle: { color: '#333' },

                        },
                        backgroundColor: '#f3f4f6',
                        vAxis: {
                            minValue: 0,
                        },
                    };

                    const chart = new google.visualization.ColumnChart(document.getElementById('chart_div2'));
                    chart.draw(data, options);
                }
            })
    }


    // 2. Filtrar los datos según el rango de fecha desde-hasta y el tipo de solicitud seleccionado

}

function validarDatos(desde, hasta) {
    const desdeFecha = new Date(desde.value);
    const hastaFecha = new Date(hasta.value);
    console.log(desdeFecha < hastaFecha);
    if (hastaFecha < desdeFecha) {
        // La fecha "desde" es menor que la fecha "hasta"
        mostrarAlertaAfter('La fecha desde no puede ser mayor que la fecha hasta', 'error', document.querySelector('.formulario'));
        return false;
    } 
    if(hastaFecha=="" & desdeFecha=="") {
        // La fecha "desde" es mayor o igual que la fecha "hasta"
        mostrarAlertaAfter('Las fechas no pueden estar vacias', 'error', document.querySelector('.formulario'));
    }
    return true;
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