//import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:proyecto_plataforma/models/aulas.dart';
import 'package:proyecto_plataforma/page/soporte/third_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/solicitud.dart';

class listar extends StatefulWidget {
  final SolicitudModel? model;
  final Function? onDelete;

  const listar({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

  @override
  _MyApiState createState() => _MyApiState();
}

int finalName = 0;

class _MyApiState extends State<listar> {
  @override
  void initState() {
//response = fetchUsers();
    super.initState();

    // Future.delayed(Duration.zero, () async {
    //   final SharedPreferences sharedPreferences =
    //       await SharedPreferences.getInstance();
    //   var obtName = sharedPreferences.getInt('name');
    //   print('$finalName');

    //   // Si no hay ningún valor guardado, utilizamos una cadena vacía
    //   setState(() {
    //     finalName = obtName! as int;
    //   });
    // });
  }

  /*Future<List<dynamic>> fetchUsers() async {
    var result =
        await http.get(Uri.parse("https://gorest.co.in/public/v2/users?page=1"));
    return jsonDecode(result.body);
  }
*/
 Widget  myApiWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if(widget.model!.usuario_id == '$finalName'){

        // },
        ListTile(
          
          title: Text("Solicitud: " +
              widget.model!.tipo! 
              ),
          trailing: Column(
            children: [
              Icon(
                widget.model!.estado! == "terminado" ||
                        widget.model!.estado! == "TERMINADO"
                    ? Icons.check_circle
                    : widget.model!.estado! == "en_camino"
                        ? Icons.run_circle
                        : Icons.check_circle_outline,
                color: widget.model!.estado! == "terminado" ||
                        widget.model!.estado! == "TERMINADO"
                    ? Colors.green
                    : widget.model!.estado! == "en_camino"
                        ? Colors.amber
                        : Colors.grey,
              ),
            ],
          ),
// leading: Image.network(
// (widget.model!.img == null || widget.model!.img == "")
// ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.png"
// : widget.model!.img!,
// height: 70,
// fit: BoxFit.scaleDown,
// ),
// ignore: prefer_interpolation_to_compose_strings
          subtitle: Text("Solicitado por: " +
              widget.model!.usuario_id! +
              " - " 
              ),
          isThreeLine: true,
          onTap: () async{
            if (widget.model!.tipo! == "soporte"){
              // Navigator.pushNamed(context, "/third");

               /*Navigator.of(context).push(PageRouteBuilder(pageBuilder: (BuildContext context,_, __)=> ThirdPage(
                    number: widget.model!.usuario_id!)));
                   */
var testi= "texto de prueba";
Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThirdPage(contacts: jsonEncode(widget.model!))));
            //
            } else {
              Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThirdPage(contacts:  jsonEncode(widget.model!))));
            }
          },
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: myApiWidget(context),
      ),
    );
  }
}


