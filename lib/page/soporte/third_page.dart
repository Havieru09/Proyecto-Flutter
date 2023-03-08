//import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proyecto_plataforma/widgets/cabeceraBack.dart';
import 'package:proyecto_plataforma/widgets/footer.dart';

int finalName = 0;

class ThirdPage extends StatefulWidget {
  final String? contacts;

  //List contacts=[];
  //Map valueMap = json.decode(contacts);
  //Map<String, dynamic> contacts ;
  const ThirdPage({
    Key? key,
    this.contacts,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      try {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        var obtName = sharedPreferences.getInt('name');
        if (obtName == null || obtName == 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error en inicio de sesión'),
                content: const Text(
                    'Primer debe iniciar sesión para poder acceder a esta sección'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
        // Si no hay ningún valor guardado, utilizamos una cadena vacía
        setState(() {
          finalName = obtName! as int;
        });
      } on Exception catch (e) {
        print(e);
      }
    });

    super.initState();
    final jsonResponse = json.decode(widget.contacts!) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const CabeceraBack(),
            Form(
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[_dsoli(context)],
                ),
              ),
            ),
            const footer(),
          ],
        ),
      ),
    );
  }

  Widget _dsoli(BuildContext context) {
    final dynamic jsonResponse =
        json.decode(widget.contacts!) as Map<String, dynamic>;

    print(jsonResponse);
    // size = MediaQuery.of(context).size;

    return Column(
      //Column

      mainAxisAlignment: MainAxisAlignment.start, //centrado
      children: <Widget>[
        const Text(
          "Detalle de la Solicitud",
          style: TextStyle(
            color: Color.fromRGBO(0, 2, 114, 0.612),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 238, 239, 240),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(66, 12, 12, 12),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          constraints: const BoxConstraints(
            maxHeight: 200,
            maxWidth: 350,
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Bloque:",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 2, 114, 0.612),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " ${jsonResponse['bloque_id']}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Aula:",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 2, 114, 0.612),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " ${jsonResponse['aula_id']}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Tipo:",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 2, 114, 0.612),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " ${jsonResponse['tipo_id']}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: jsonResponse['detalle'] != "Abrir puerta" &&
              jsonResponse['detalle'] != "Cerrar puerta",
          child: Column(
            children: [
              const Text(
                "Detalle:",
                style: TextStyle(
                  color: Color.fromRGBO(0, 2, 114, 0.612),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ]),
                padding: const EdgeInsets.all(10),
                constraints:
                    const BoxConstraints(maxHeight: 500, maxWidth: 350),
                child: Text(
                  "${jsonResponse['detalle']}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40.0),
        _botones(),
      ],
    );
  }

  Widget _botones() {
    final dynamic jsonResponse =
        json.decode(widget.contacts!) as Map<String, dynamic>;

    String id = "${jsonResponse['id']}";

    String apiUrl = "http://127.0.0.1:3000/solicitudes/$id";
    print(apiUrl);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Wrap(
        spacing: 50,
        children: [
          FilledButton.icon(
              onPressed: () async {
                var response = await http.put(
                  Uri.parse(apiUrl),
                  headers: {
                    "Content-Type": "application/json",
                  },
                  body: json.encode({
                    "estado": "en_camino",
                    "fecha_final": DateTime.now().toString(),
                    
                    //
                  }),
                );
                if (response.statusCode == 200) {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Solicitud Actualizada'),
                        content: const Text(
                            'La Solicitud ha sido actualizada con exito'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cerrar'),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/second',
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                            'Lo sentimos, hubo un problema al actualizar la solicitud intente nuevamente'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cerrar'),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/second',
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              icon: const Icon(
                Icons.directions_walk_outlined,
                size: 30,
              ),
              label: const Text(
                "En camino",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xff231F47)),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
              )),
          FilledButton.icon(
              onPressed: () async {
                var response = await http.put(
                  Uri.parse(apiUrl),
                  headers: {
                    "Content-Type": "application/json",
                  },
                  body: json.encode({
                    "estado": "terminado",
                    "fecha_final": DateTime.now().toString(),

                    //
                  }),
                );
                if (response.statusCode == 200) {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Solicitud Actualizada'),
                        content: const Text(
                            'La Solicitud ha sido actualizada con exito'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cerrar'),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/second',
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                            'Lo sentimos, hubo un problema al actualizar la solicitud intente nuevamente'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cerrar'),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/second',
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              icon: const Icon(
                Icons.check_box_rounded,
                size: 30,
              ),
              label: const Text(
                "Realizado",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 31, 71, 43)),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
              )),
        ],
      ),
    );
  }
}
