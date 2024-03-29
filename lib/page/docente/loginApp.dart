import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_plataforma/config.dart';
import 'package:proyecto_plataforma/models/user.dart';
import 'package:proyecto_plataforma/page/docente/home.dart';
import 'package:proyecto_plataforma/page/docente/listar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../widgets/cabecera.dart';
import '../../widgets/footer.dart';

class loginApp extends StatefulWidget {
  const loginApp({super.key});
  @override
  State<loginApp> createState() => _loginApp();
}

class _loginApp extends State<loginApp> {
  static var client = http.Client();
  UserModel? model;
  Function? onDelete;
  bool existe = false;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isEditMode = false;
  List<dynamic> UserList = [];
  final _email = TextEditingController();
  final _psw = TextEditingController();
  String name = "";
  String dato = "";
  int rol = 0;
  String nameRol = '';
  int id = 0;
  String correo = '';
  List<String> _correo = [];
  List<String> _contra = [];
  List<int> _rol = [];
  List<String> _nameRol = [];
  List<int> _id = [];

  @override
  void initState() {
    super.initState();
    getUsuarios();
    model = UserModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        model = arguments['model'];
        //isEditMode = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        // ignore: prefer_const_literals_to_create_immutables
        child: Column(
          children: <Widget>[
            const Cabecera(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: prefer_const_constructors
                    const Text(
                      'App de soporte',
                      style: TextStyle(
                        fontSize: 35.0,
                        color: Color.fromARGB(255, 13, 77, 130),
                      ),
                    ),

                    _wemail(),
                    _wpsw(),

                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _bottoonLogin(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const footer(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  } // build

  _wemail() => TextFormField(
        keyboardType: TextInputType.emailAddress,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9@]+"))
        ],
        decoration: const InputDecoration(
            labelText: "Ingrese correo electrónico",
            icon: Icon(Icons.email),
            //border: InputBorder.none,
            hintText: "Email"),
        controller: _email,
        validator: (value) {
          if (value!.isEmpty) {
            return "Por favor ingresa el correo electrónico";
          } else if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return "correo electrónico NO VALIDO";
          } else {
            return null;
          }
        },
      );

  _wpsw() => Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          obscureText: true, // <-- Agrega esta propiedad
          keyboardType: TextInputType.name,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(
                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9@$%&-_]+"))
          ],
          decoration: const InputDecoration(
              labelText: "Contraseña",
              icon: Icon(Icons.password),
              //border: InputBorder.none,
              hintText: "Ingrese su contraseña"),
          controller: _psw,
          maxLength: 16,
          //maxLength: 2,

          validator: (value) {
            if (value!.isEmpty) {
              return "Por favor ingrese su contraseña";
            } else {
              return null;
            }
          },
          //onSaved: (val) => _contact.psw = String.parse(val!.trim()),
        ),
      );

  Widget _bottoonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Padding(
        padding: const EdgeInsets.all(6.5),
        child: ElevatedButton(
          onPressed: () async {
            UserList.forEach((objeto) {
              final correo = objeto['correo'];
              final password = objeto['psw'];
              final rol = objeto['rol_id'];
              final idUser = objeto['id'];
              final nombre_rol = objeto['nombre_rol'];
              _correo.add(correo);
              _contra.add(password);
              _rol.add(rol);
              _nameRol.add(nombre_rol);
              _id.add(idUser);
            });

            String dato = _email.text.toLowerCase();
            String datopsw = _psw.text;

            for (int i = 0; i < _correo.length; i++) {
              if (dato == _correo[i] && datopsw == _contra[i]) {
                existe = true;
                name = _correo[i];
                id = _correo[i] == dato ? _id[i] : 0;
                rol = (_correo[i] == dato ? _rol[i] : 0);
                nameRol = (_correo[i] == dato ? _nameRol[i] : '');
                //print(nameRol);
                break;
              } else {
                existe = false;
              }
            }

            if (existe) {
              if (rol == 2) {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setInt('name', id);
                Navigator.pushNamed(context, "/splash");
              } else if (rol == 3 || rol == 4 ) {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setString('name', nameRol);
                Navigator.pushNamed(context, "/splashSoporte");
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Datos inválidos'),
                      content: const Text(
                          'El usuario y/o la contraseña que ha ingresado son incorrectos.'),
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
            } else {
              // datos inválidos, mostrar alerta
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Datos inválidos'),
                    content: const Text(
                        'El usuario y/o la contraseña que ha ingresado son incorrectos.'),
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(200, 161, 183, 243),
            ),
          ),
          child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: const Text(
                "Iniciar Sesion",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ),
      );
    });
  }

  Future getUsuarios() async {
    var url = Uri.http(
      Config.apiURL,
      Config.userAPI,
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
        //print(response.body);
        setState(() {
          UserList = data["usuario"];
        });
        //return usuariosFromJson(data["usuario"]);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
