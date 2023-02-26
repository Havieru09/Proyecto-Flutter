import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/cabecera.dart';
import '../../widgets/footer.dart';
import 'listar.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(
            children: <Widget>[
              const Cabecera(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        // ignore: unnecessary_const
                        child: const Text(
                          'Menu principal',
                          style: TextStyle(
                            fontSize: 35.0,
                            color: Color.fromARGB(255, 13, 77, 130),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                _botonOpen(),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              _botonClose(),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                _botonSupport(),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              _botonList(),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _bottoonSalir(),
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
        ));
  }

  Widget _botonOpen() {
    // ignore: prefer_const_constructors
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/open"),
      child: CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.grey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                '../img/open.png',
                height: 50,
              ),
            ),
            const Text(
              "Abrir puerta",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _botonClose() {
    // ignore: prefer_const_constructors
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/close"),
      child: CircleAvatar(
        radius: 50.0,
        backgroundColor: Color.fromARGB(255, 158, 158, 158),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                '../img/close.png',
                height: 50,
              ),
            ),
            const Text(
              "Cerrar puerta",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _botonSupport() {
    // ignore: prefer_const_constructors
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/soporte"),
      child: CircleAvatar(
        radius: 50.0,
        backgroundColor: Color.fromARGB(200, 161, 183, 243),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                '../img/support1.png',
                height: 50,
              ),
            ),
            const Text(
              "Pedir soporte",
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _botonList() {
    // ignore: prefer_const_constructors
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/list"),
      child: CircleAvatar(
        radius: 50.0,
        backgroundColor: Color.fromARGB(200, 161, 183, 243),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                '../img/list.png',
                height: 50,
              ),
            ),
            const Text(
              "Historial",
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottoonSalir() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/");
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
              "Salir",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      );
    });
  }
}