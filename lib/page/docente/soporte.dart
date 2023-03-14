import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_plataforma/widgets/cabeceraBack.dart';
import 'package:proyecto_plataforma/widgets/footer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../../Servicios/api_service.dart';
import '../../config.dart';
import '../../models/bloques.dart';
import '../../models/solicitud.dart';

int finalName = 0;

class soporte extends StatefulWidget {
  const soporte({super.key});

  @override
  State<soporte> createState() => _soporteState();
}

class _soporteState extends State<soporte> {
  static var client = http.Client();

  SolicitudModel? solimodel;
  BloqueModel? bloquemodel;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isBloquesSelect = false;
  TextEditingController textarea = TextEditingController();
  bool isAulasSelect = false;
  List bloquesList = [];
  List aulasList = [];
  List tiposList = [];
  List _bloquesList = [];
  List Aula_bloquesList = [];
  bool isApiCallProcess = false;
  List<Object> images = [];
  List filteredAulasList = [];
  bool isEditMode = false;
  bool isImageSelected = false;
  var bloquevalue;
  var tipovalue;
  var aulavalue;
  var aulavalue2;
  var laboratoriovalue;
  String? estado = 'pendiente';
  String? fecha_inicial = DateTime.now().toString();
  String? fecha_final = DateTime.now().toString();
//Obtener fecha actual

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        // ignore: sort_child_properties_last
        child: Column(
          children: [
            const CabeceraBack(),
            Form(
              key: globalFormKey,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    userForm(),
                  ],
                ),
              ),
            ),
            const footer(),
          ],
        ),

        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }

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

    getBloques();
    getAula_Bloques();
    getTipos();
    solimodel = SolicitudModel();

    Future.delayed(Duration.zero, () async {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        solimodel = arguments['model'];
        isEditMode = true;
        setState(() {});
      }

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var obtName = sharedPreferences.getInt('name');
      print('$finalName');

      // Si no hay ningún valor guardado, utilizamos una cadena vacía
      setState(() {
        finalName = obtName! as int;
      });
    });
  }

  Widget userForm() {
    return Column(
      children: <Widget>[
        //Text('$finalName'),
        const Text(
          'Solicitar soporte',
          style: TextStyle(
            fontSize: 35.0,
            color: Color.fromARGB(255, 13, 77, 130),
          ),
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (bloquesList.isEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: DropdownButton<String>(
                  value: null,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(
                        'De momento no hay edificios disponibles',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                  onChanged: null,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: DropdownButton<String>(
                  value: bloquevalue,
                  hint: const Text('Elige un edificio'),
                  items: bloquesList.map((item) {
                    return DropdownMenuItem(
                      value: item['nombre_bloque'].toString(),
                      child: Text(item['nombre_bloque'].toString()),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      bloquevalue = newVal;
                      filteredAulasList = Aula_bloquesList.where((aula) =>
                              aula['nombre_bloque'].toString() == bloquevalue)
                          .toList();
                      aulavalue = null;
                    });
                  },
                ),
              ),
            if (filteredAulasList.isEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: DropdownButton<String>(
                  value: null,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(
                        bloquevalue == null
                            ? 'Elige primero un edificio'
                            : 'De momento no hay aulas disponibles',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                  onChanged: null,
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: DropdownButton<String>(
                  value: aulavalue,
                  hint: const Text('Elige un aula'),
                  items: filteredAulasList.map((aula) {
                    return DropdownMenuItem(
                      value: aula['id'].toString(),
                      child: Text(aula['nombre_aulas'].toString()),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      aulavalue = newVal;
                    });
                  },
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
            bottom: 10,
            top: 10,
          ),
          child: DropdownButton(
            hint: const Text('Elija un tipo de soporte'),
            items: tiposList
                .where((item) =>
                    item['nombre_tipo'].startsWith('mantenimiento') ||
                    item['nombre_tipo'].startsWith('laboratorista'))
                .map((item) {
              return DropdownMenuItem(
                value: item['id'].toString(),
                child: Text(item['nombre_tipo'].toString()),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                tipovalue = newVal;
                isAulasSelect = true;
                if (isAulasSelect) {
                  _mensajeSoporte();
                }
              });
            },
            value: tipovalue,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
            bottom: 10,
            top: 0,
          ),
          child: FormHelper.inputFieldWidget(
            context,
            //const Icon(Icons.person),
            "Detalle",
            "Detalle del usuario",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'Detalle del usuario.';
              }

              final RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
              if (!regex.hasMatch(onValidateVal)) {
                return 'Solo se permiten letras y espacios en blanco.';
              }
              return null;
            },
            (onSavedVal) => {
              solimodel!.detalle = onSavedVal,
            },
            //initialValue:
            //  userModel!.edad != 0 ? "" : userModel!.edad.toString(),
            obscureText: false,
            borderFocusColor: Colors.black,
            borderColor: Colors.black,
            textColor: Colors.black,
            hintColor: Colors.black.withOpacity(0.6),
            borderRadius: 10,
            showPrefixIcon: false,
            suffixIcon: const Icon(Icons.text_fields),
          ),
        ),
        Center(
          child: FormHelper.submitButton(
            "Save",
            () {
              bloquesList.forEach((element) {
                final bloque = element['nombre_bloque'];
                _bloquesList.add(bloque);
              });
              for (int i = 0; i < _bloquesList.length; i++) {
                if (bloquevalue == _bloquesList[i] && aulavalue == null) {
                   FormHelper.showSimpleAlertDialog(
                  context,
                  "Error detectado",
                  "Hay campos vacios, favor de seleccionar la opcion faltante",
                  "OK",
                  () {
                    Navigator.of(context).pop();
                  },
                );
                return;
                } 
              }
              if (bloquevalue == null ||
                  (bloquevalue == 'A' && aulavalue == null) ||
                  (bloquevalue == 'B' && aulavalue == null) ||
                  (bloquevalue == 'C' && aulavalue == null) ||
                  (bloquevalue == 'D' && aulavalue == null) ||
                  (bloquevalue == 'E' && aulavalue == null) ||
                  (tipovalue == null)) {
                FormHelper.showSimpleAlertDialog(
                  context,
                  "Error detectado",
                  "Hay campos vacios, favor de seleccionar la opcion faltante",
                  "OK",
                  () {
                    Navigator.of(context).pop();
                  },
                );
                return;
              } else if (validateAndSave()) {
                solimodel!.usuario_id = '$finalName';
                solimodel!.aula_id = aulavalue;
                solimodel!.estado = estado;
                solimodel!.bloque_id = bloquevalue;
                solimodel!.tipo_id = tipovalue;
                solimodel!.fecha_inicial = fecha_inicial;
                solimodel!.fecha_final = fecha_final;

                //print(solimodel!.toJson());

                setState(() {
                  isApiCallProcess = true;
                });

                ApiService.saveSolicitudes(
                  solimodel!,
                ).then(
                  (response) {
                    setState(() {
                      isApiCallProcess = false;
                    });

                    if (response) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Solicitud ingresada'),
                            content: const Text(
                                'Su solicitud ha sido ingresada correctamente, puede revisar el estado de la misma en su historial.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cerrar'),
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/home',
                                    (route) => false,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "Error occur",
                        "OK",
                        () {},
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Solicitud Fallida'),
                            content: const Text(
                                'Su solicitud no ha sido ingresada correctamente'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cerrar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                );
              }
            },
            btnColor: HexColor("283B71"),
            borderColor: Colors.white,
            txtColor: Colors.white,
            borderRadius: 10,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
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

  Future getAula_Bloques() async {
    var url = Uri.http(
      Config.apiURL,
      Config.aulaBloque,
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
      //print(data);
      setState(() {
        Aula_bloquesList = data["data"];
      });
    }
  }

  Future getTipos() async {
    var url = Uri.http(
      Config.apiURL,
      Config.tipoAPI,
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
          tiposList = data["tipos"];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _mensajeSoporte() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Importante'),
          content: const Text(
              'Al seleccionar el tipo de mantenimiento tenga en cuenta que si desea un soporte sobre los equipos del laboratorio, debe seleccionar el tipo de mantenimiento "laboratorista"'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
