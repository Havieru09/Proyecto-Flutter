import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_plataforma/models/solicitudes2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../../config.dart';
import '../../models/solicitud.dart';

  int finalName = 0;

class UserItem extends StatefulWidget {
  final SolicitudModel2? model;
  final Function? onDelete;
    

  UserItem({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  void initState() {
    super.initState();


    Future.delayed(Duration.zero, () async {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var obtName = sharedPreferences.getInt('name');
      
      // print('$finalName');
      // print(widget.model!.user);

      // Si no hay ningún valor guardado, utilizamos una cadena vacía
      setState(() {
        finalName = obtName! as int;
      });
    });
  }

  static var client = http.Client();
  List<dynamic> UserList = [];
  
  //String get id => '$finalName';
  String id = '$finalName' as String;


  



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
        child: cartItem1(context),
      ),
    );
  }

  Widget cartItem1(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if(widget.model!.usuario_id == '$finalName'){
          
        // },
        ListTile(
          title: Text("Bloque: " +
              widget.model!.bloque_id! +
              " - " +
              widget.model!.aula_id!),
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
          subtitle: Text(
              "Tipo de soporte: " +
              widget.model!.tipo! +
              "                " +
              " Estado: " +
              widget.model!.estado!),
          isThreeLine: true,
        ),
      ],
    );
  }

//--------------------------------------------------------------------------------------------------------------




}



// Widget cartItem(context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         width: 120,
  //         alignment: Alignment.center,
  //         margin: EdgeInsets.all(10),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               model!.aula_id!,
  //               style: const TextStyle(
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               model!.bloque_id!,
  //               style: const TextStyle(color: Colors.blue),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               model!.usuario_id!,
  //               style: const TextStyle(color: Colors.red),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               model!.detalle!,
  //               style:
  //                   const TextStyle(color: Color.fromARGB(255, 11, 218, 114)),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               model!.estado!,
  //               style:
  //                   const TextStyle(color: Color.fromARGB(255, 11, 218, 114)),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Container(
  //               width: MediaQuery.of(context).size.width - 180,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   GestureDetector(
  //                     child: const Icon(Icons.edit),
  //                     onTap: null,
  //                     /*onTap: () {
  //                       Navigator.of(context).pushNamed(
  //                         '/edit-user',
  //                         arguments: {
  //                           'model': model,
  //                         },
  //                       );
  //                     },*/
  //                   ),
  //                   GestureDetector(
  //                     child: const Icon(
  //                       Icons.delete,
  //                       color: Colors.red,
  //                     ),
  //                     onTap: null,
  //                     /*onTap: () {
  //                       onDelete!(model);
  //                     },*/
  //                   ),
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
