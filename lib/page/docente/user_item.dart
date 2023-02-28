import 'package:flutter/material.dart';

import 'package:snippet_coder_utils/FormHelper.dart';

import '../../models/solicitud.dart';

class UserItem extends StatelessWidget {
  final SolicitudModel? model;
  final Function? onDelete;

  UserItem({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

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

  Widget cartItem(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model!.aula_id!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model!.bloque_id!,
                style: const TextStyle(color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model!.usuario_id!,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model!.detalle!,
                style:
                    const TextStyle(color: Color.fromARGB(255, 11, 218, 114)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model!.estado!,
                style:
                    const TextStyle(color: Color.fromARGB(255, 11, 218, 114)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.edit),
                      onTap: null,
                      /*onTap: () {
                        Navigator.of(context).pushNamed(
                          '/edit-user',
                          arguments: {
                            'model': model,
                          },
                        );
                      },*/
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: null,
                      /*onTap: () {
                        onDelete!(model);
                      },*/
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

   Widget cartItem1(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            "Bloque: "+model!.bloque_id! + " - "+model!.aula_id! 
            
          ),
          trailing: Column(
            children: [
              Icon(
                model!.estado! == "terminado" || model!.estado! == "TERMINADO"
                    ? Icons.check_circle
                    : Icons.check_circle_outline,
                color: model!.estado! == "terminado" || model!.estado! == "TERMINADO"
                    ? Colors.green
                    : Colors.grey,
              ),
            ],
          ),
          // leading: Image.network(
          //   (model!.img == null || model!.img == "")
          //       ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.png"
          //       : model!.img!,
          //   height: 70,
          //   fit: BoxFit.scaleDown,
          // ),
          // ignore: prefer_interpolation_to_compose_strings
          subtitle: Text("Solicitado por: " + model!.usuario_id! +" - "
          + " Tipo de soporte: "+model!.tipo! +" - "
          + " Detalle: "+model!.detalle!),
          isThreeLine: true,
        ),
      ],
    );
  }
}
