import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:proyecto_plataforma/models/user.dart';
import 'package:proyecto_plataforma/page/docente/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../widgets/cabecera.dart';
import '../../widgets/footer.dart';

// ignore: camel_case_types
class fromLogin extends StatelessWidget {
  final UserModel? model;
  final Function? onDelete;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  String name = "";
  String dato = "";

  final _name = TextEditingController(text: 'miguel');
  final _psw = TextEditingController();

  fromLogin({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      body: Form(
          key: _formKey,
          // ignore: prefer_const_literals_to_create_immutables
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Cabecera(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: prefer_const_constructors
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          'App de soporte',
                          style: TextStyle(
                            fontSize: 35.0,
                            color: Color.fromARGB(255, 13, 77, 130),
                          ),
                        ),
                      ),

                      _wname(),
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
                const footer(),
              ],
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  } // build

  _wname() => TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Nombre",
          icon: Icon(Icons.person),
          //suffixText: etiquetaFin,

          //border: InputBorder.none,
          //border: OutlineInputBorder(),
          hintText: "ingrese nombre",
        ),

        controller: _name,
        maxLength: 30,
        //onSaved: (val) => _contact.name = val!,
        //onSaved: (val) => setState(() => _contact.name = val!),
        validator: (val) => (val!.isEmpty ? 'Por favor ingresa nombre' : null),
        /*validator: (value) {
          if (value!.isEmpty) {
            return "Por favor ingresa nombre";
          } else {
            return null;
          }
        },*/
      );

  _wpsw() => Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
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
            //dato = model!.usuario!;
            name = _name.text;
            //name = (_name.text == model!.usuario ? _name : null) as String;
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString('name', _name.text);
            // print(_name);
            // print('name: '+name);
            //print(model!.id_usuario);
            //print(dato);

            Navigator.pushNamed(context, "/splash");
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
}

// _wemail() => Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: TextFormField(
  //         keyboardType: TextInputType.emailAddress,
  //         inputFormatters: <TextInputFormatter>[
  //           FilteringTextInputFormatter.allow(
  //               RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9@]+"))
  //         ],
  //         decoration: const InputDecoration(
  //             labelText: "Correo institucional",
  //             icon: Icon(Icons.),
  //             //border: InputBorder.none,
  //             hintText: "Ingrese Correo institucional"),
  //         controller: _email,
  //         //onSaved: (val) => _contact.email = val!,
  //         validator: (value) {
  //           if (value!.isEmpty) {
  //             return "Por favor ingresa el correo electrónico";
  //           } else if (!RegExp(
  //                   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //               .hasMatch(value)) {
  //             return "correo electrónico NO VALIDO";
  //           } else {
  //             return null;
  //           }
  //         },
  //       ),
  //     );

    // void _okSmartAlert(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: const Text('Mensaje del Sistema'),
  //       content: const Text('Login exitoso'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, 'ok'),
  //           child: const Text('Listo'),
  //         ),
  //         /*TextButton(
  //           onPressed: () => Navigator.pop(context, 'OK'),
  //           child: const Text('OK'),
  //         ),*/
  //       ],
  //     ),
  //   );
  // }