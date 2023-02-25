import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_plataforma/models/user.dart';

import '../../widgets/cabecera.dart';
import '../../widgets/footer.dart';

// ignore: camel_case_types
class fromLogin extends StatelessWidget {
  fromLogin({Key? key}) : super(key: key);
  final user _contact = user(id: 0, email: "", psw: "");
  final List<user> _contacts = [];

  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  final _email = TextEditingController(text: '');
  final _psw = TextEditingController(text: '');

  final String titulo = "Login";

  void _okSmartAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Mensaje del Sistema'),
        content: const Text('Login exitoso'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'ok'),
            child: const Text('Listo'),
          ),
          /*TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),*/
        ],
      ),
    );
  }

  _onSubmit(BuildContext context) async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      // ignore: avoid_print
      print('''
            Nombre : ${_contact.email}
            contraseña: ${_contact.psw}
    ''');
      _contacts.add(user(id: -1, email: _contact.email, psw: _contact.psw));
      form.reset();
      _okSmartAlert(context);
      /*showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("My Super title"),
              content: new Text("Hello World"),
            );0
      });*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          key: _formKey,
          // ignore: prefer_const_literals_to_create_immutables
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
              const footer(),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  } // build

  _wemail() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(
                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9@]+"))
          ],
          decoration: const InputDecoration(
              labelText: "Correo institucional",
              icon: Icon(Icons.email),
              //border: InputBorder.none,
              hintText: "Ingrese Correo institucional"),
          controller: _email,
          onSaved: (val) => _contact.email = val!,
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
        ),
      );

  _wpsw() => Padding(
        padding: const EdgeInsets.all(8.0),
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
