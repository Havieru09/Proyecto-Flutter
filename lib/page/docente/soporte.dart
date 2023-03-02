import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_plataforma/widgets/cabeceraBack.dart';
import 'package:proyecto_plataforma/widgets/footer.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../../Servicios/api_service.dart';
import '../../config.dart';
import '../../models/bloques.dart';
import '../../models/solicitud.dart';

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
  bool isApiCallProcess = false;
  List<Object> images = [];
  bool isEditMode = false;
  bool isImageSelected = false;
  var bloquevalue;
  var aulavalue;
  var aulavalue2;
  var laboratoriovalue;
  String? estado = 'pendiente';
  String? usuario_id = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        // ignore: sort_child_properties_last
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CabeceraBack(),
              Form(
                key: globalFormKey,
                child: userForm(),
              ),
              const Padding(
                padding: EdgeInsets.all(3.5),
              ),
              const footer(),
            ],
          ),
        ),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    );
  }

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
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget userForm() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Solicitar soporte',
              style: TextStyle(
                fontSize: 35.0,
                color: Color.fromARGB(255, 13, 77, 130),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (bloquesList.isEmpty)
                const Center(child: CircularProgressIndicator())
              else
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: DropdownButton<String>(
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
                        isBloquesSelect = true;
                      });
                    },
                  ),
                ),
              if (bloquevalue == '1')
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                  ),
                  child: DropdownButton(
                    hint: Text('Elija un laboratorio'),
                    items: aulasList
                        .where((item) =>
                            item['nombre_aulas'].startsWith('Laboratorio E'))
                        .map((item) {
                      return DropdownMenuItem(
                        value: item['id'].toString(),
                        child: Text(item['nombre_aulas'].toString()),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        laboratoriovalue = newVal;
                        isAulasSelect = true;
                      });
                    },
                    value: laboratoriovalue,
                  ),
                ),
              if (bloquevalue == '2')
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                  ),
                  child: DropdownButton(
                    hint: Text('Elija un aula'),
                    items: aulasList
                        .where(
                            (item) => item['nombre_aulas'].startsWith('Aula D'))
                        .map((item) {
                      return DropdownMenuItem(
                        value: item['id'].toString(),
                        child: Text(item['nombre_aulas'].toString()),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        aulavalue2 = newVal;
                        isAulasSelect = true;
                      });
                    },
                    value: aulavalue2,
                  ),
                ),
              if (bloquevalue == '3')
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                  ),
                  child: DropdownButton(
                    hint: Text('Elija un aula'),
                    items: aulasList
                        .where(
                            (item) => item['nombre_aulas'].startsWith('Aula B'))
                        .map((item) {
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
                    },
                    value: aulavalue,
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
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "Tipo",
              "Tipo de solicitud",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Tipo de solicitud.';
                }

                return null;
              },
              (onSavedVal) => {
                solimodel!.tipo = onSavedVal,
              },
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.mail),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
              bottom: 10,
              top: 10,
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
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.monetization_on),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Save",
              () {
                if (validateAndSave()) {
                  solimodel!.usuario_id = usuario_id;
                  solimodel!.estado = estado;
                  solimodel!.bloque_id = bloquevalue;
                  if (bloquevalue == '1' && laboratoriovalue != null)
                    solimodel!.aula_id = laboratoriovalue;
                  if (bloquevalue == '2' && aulavalue2 != null)
                    solimodel!.aula_id = aulavalue2;
                  if (bloquevalue == '3' && aulavalue != null)
                    solimodel!.aula_id = aulavalue;

                  print(solimodel!.toJson());

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
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Error occur",
                          "OK",
                          () {
                            Navigator.of(context).pop();
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
      ),
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
  // Widget _dropdownBloque() {
  //   return DropdownButton<String>(
  //     value: bloquevalue,
  //     hint: Text('Elige un edificio'),
  //     items: bloquesList.map((item) {
  //       return DropdownMenuItem(
  //         value: item['id'].toString(),
  //         child: Text(item['nombre_bloque'].toString()),
  //       );
  //     }).toList(),
  //     onChanged: (newVal) {
  //       setState(() {
  //         bloquevalue = newVal;
  //       });
  //       (onSavedVal) => {
  //             solimodel!.bloque_id = bloquevalue,
  //           };
  //       isBloquesSelect = true;
  //     },
  //   );
  // }

  // Widget _dropdownAula() {
  //   return DropdownButton(
  //     hint: Text('Elige una aula'),
  //     items: aulasList.map((item) {
  //       return DropdownMenuItem(
  //         value: item['id'].toString(),
  //         child: Text(item['nombre_aulas'].toString()),
  //       );
  //     }).toList(),
  //     onChanged: (newVal) {
  //       setState(() {
  //         aulavalue = newVal;
  //         isAulasSelect = true;
  //       });
  //       (onSavedVal) => {
  //             solimodel!.aula_id = aulavalue,
  //           };
  //     },
  //     value: aulavalue,
  //   );
  // }

  // _bottoonSolicitud() {
  //   return FormHelper.submitButton(
  //     "Save",
  //     () {
  //       if (validateAndSave()) {
  //         print(solimodel!.toJson());

  //         setState(() {
  //           isApiCallProcess = true;
  //         });

  //         ApiService.saveSolicitudes(
  //           solimodel!,
  //         ).then(
  //           (response) {
  //             setState(() {
  //               isApiCallProcess = false;
  //             });

  //             if (response) {
  //               Navigator.pushNamedAndRemoveUntil(
  //                 context,
  //                 '/home',
  //                 (route) => false,
  //               );
  //             } else {
  //               FormHelper.showSimpleAlertDialog(
  //                 context,
  //                 Config.appName,
  //                 "Error occur",
  //                 "OK",
  //                 () {
  //                   Navigator.of(context).pop();
  //                 },
  //               );
  //             }
  //           },
  //         );
  //       }
  //     },
  //     btnColor: HexColor("283B71"),
  //     borderColor: Colors.white,
  //     txtColor: Colors.white,
  //     borderRadius: 10,
  //   );
  // return StreamBuilder(
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //   return Padding(
  //     padding: const EdgeInsets.all(6.5),
  //     child: ElevatedButton(
  //       onPressed: () {
  //         Navigator.pushNamed(context, "/home");
  //       },
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.all<Color>(
  //           const Color.fromARGB(200, 161, 183, 243),
  //         ),
  //       ),
  //       child: Container(
  //           padding:
  //               const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
  //           child: const Text(
  //             "Solicitar",
  //             style: TextStyle(
  //               color: Colors.white,
  //             ),
  //           )),
  //     ),
  //   );
  // });
  //}

  // Widget _dropdownTipo() {
  //   return
  // }

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
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, "/home");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: const Text('Regresar'),
      ),
    );
  });
}
