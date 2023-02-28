import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import '../../models/bloques.dart';
import '../../models/solicitud.dart';
import '../../widgets/cabeceraBack.dart';
import '../../widgets/footer.dart';

class open extends StatefulWidget {
  const open({super.key});

  @override
  State<open> createState() => _openState();
}

class _openState extends State<open> {
  static var client = http.Client();
  SolicitudModel? solimodel;
  BloqueModel? bloquemodel;
  bool isBloquesSelect = false;
  bool isAulasSelect = false;
  var bloquevalue;
  var aulavalue;
  List bloquesList = [];
  List aulasList = [];

  @override
  void initState() {
    super.initState();
    getBloques();
    getAulas();
    solimodel = SolicitudModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        solimodel = arguments['model'];
        //isEditMode = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const CabeceraBack(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Abrir puerta',
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Color.fromARGB(255, 13, 77, 130),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8.0),
                        // ignore: unnecessary_const
                        child: const Text(
                          "Bloque: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        )),
                    _dropdownBloque(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      // ignore: unnecessary_const
                      child: const Text(
                        '    Aula: ',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    _dropdownAula(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _bottoonSolicitud(),
                    //_bottoonBack()
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(41.0),
              ),
              const footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropdownBloque() {
    return DropdownButton<String>(
      value: bloquevalue,
      hint: Text('Elige un edificio'),
      items: bloquesList.map((item) {
        return DropdownMenuItem(
          value: item['id'].toString(),
          child: Text(item['nombre_bloque'].toString()),
        );
      }).toList(),
      onChanged: (newVal) {
        setState(() {
          bloquevalue = newVal;
        });
        (onSavedVal) => {
              solimodel!.bloque_id = bloquevalue,
            };
        isBloquesSelect = true;
      },
    );
  }

  Widget _dropdownAula() {
    return DropdownButton(
      hint: Text('Elige una aula'),
      items: aulasList.map((item) {
        return DropdownMenuItem(
          value: item['id'].toString(),
          child: Text(item['nombre_aulas'].toString()),
        );
      }).toList(),
      onChanged: (newVal) {
        setState(() {
          aulavalue = newVal;
          isAulasSelect = true;
        });
        (onSavedVal) => {
              solimodel!.aula_id = aulavalue,
            };
      },
      value: aulavalue,
    );
  }

  Widget _bottoonSolicitud() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Padding(
        padding: const EdgeInsets.all(6.5),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/home");
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(200, 161, 183, 243),
            ),
          ),
          child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: const Text(
                "Solicitar",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ),
      );
    });
  }

//==================================================================API

  Future getBloques() async {
    var url = Uri.http(
      Config.apiURL,
      Config.bloqueAPI,
    );

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      setState(() {
        bloquesList = data["bloques"];
      });
    }
  }

  Future getAulas() async {
    var url = Uri.http(
      Config.apiURL,
      Config.aulaAPI,
    );

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        setState(() {
          aulasList = data["aulas"];
        });
      }
    } catch (e) {
      print(e);
    }
  }
}

Widget _bottoonBack() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.all(6.5),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/home");
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(200, 161, 183, 243),
          ),
        ),
        child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text(
              "Regresar",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      ),
    );
  });
}
