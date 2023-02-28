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
        child: cartItem(context),
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
                model!.aula_id.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model!.bloque_id.toString(),
                style: const TextStyle(color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model!.usuario_id.toString(),
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
}
