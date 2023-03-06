//import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_plataforma/widgets/cabeceraBack.dart';
import 'package:proyecto_plataforma/widgets/footer.dart';

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
    super.initState();
    final jsonResponse = json.decode(widget.contacts!) as Map<String, dynamic>;
  }

  Future<void> _refresh() async {
    // Aquí podrías hacer una llamada a una API o actualizar datos desde una base de datos
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                child: Column(
                  children: <Widget>[
                    const CabeceraBack()
                    , _dsoli(context)
                    ],
                ),
              ),
              const footer(),
            ],
          ),
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
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 247, 252, 255), //EDE8E1
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(66, 0, 0, 0),
                    blurRadius: 6,
                    offset: Offset(0, 2))
              ]),
          constraints: const BoxConstraints(maxHeight: 60, maxWidth: 200),
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              const Text(
                "Bloque:",
                style: TextStyle(
                  color: Color.fromRGBO(0, 2, 114, 0.612),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "${jsonResponse['bloque_id']}",
                style: const TextStyle(
                  color: Color.fromRGBO(0, 55, 114, 100),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 350),
          child: Text(
            "${jsonResponse['aula_id']}",
            style: const TextStyle(
              color: Color.fromRGBO(0, 55, 114, 100),
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Tipo:",
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
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 350),
          child: Text(
            "${jsonResponse['tipo_id']}",
            style: const TextStyle(
              color: Color.fromRGBO(0, 55, 114, 100),
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 350),
          child: Text(
            "${jsonResponse['detalle']}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 40.0),
        _botones(),
      ],
    );
  }

  Widget _botones() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Wrap(
        spacing: 50,
        children: [
          FilledButton.icon(
              onPressed: () async {


                
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
              onPressed: () {},
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
