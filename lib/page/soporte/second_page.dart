import 'package:flutter/material.dart';
import 'package:proyecto_plataforma/models/solicitudes2.dart';
import 'package:proyecto_plataforma/widgets/cabeceraBack.dart';
import 'package:proyecto_plataforma/widgets/footer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../Servicios/api_service.dart';
import '../../models/solicitud.dart';
import 'listar.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool isApiCallProcess = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      try {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        var obtName = sharedPreferences.getString('name');
        if (obtName == null || obtName == '') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error en inicio de sesión'),
                content: const Text(
                    'Primer debe iniciar sesión para poder acceder a esta sección'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
        // Si no hay ningún valor guardado, utilizamos una cadena vacía
        setState(() {
          finalName = obtName!;
        });
      } on Exception catch (e) {
        print(e);
      }
    });
    super.initState();
  }


  Future<void> _refresh() async {
    // Aquí podrías hacer una llamada a una API o actualizar datos desde una base de datos
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
return Scaffold(
      backgroundColor: Colors.grey[200],
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ProgressHUD(
          // ignore: sort_child_properties_last
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CabeceraBack(),
                loadUsers(),
              ],
            ),
          ),
      
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget loadUsers() {
    return FutureBuilder(
      future: ApiService.getSolicitudes3(SolicitudModel2(tipo: finalName == 'laboratorista'? 'mantenimiento' : 'laboratorista')),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<SolicitudModel2>?> model,
      ) {
        //print(model.data);
        if (model.hasData) {
          return SecondPage(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget SecondPage(users) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: users.length, // Se utiliza para indicar el número de elementos en la lista
                itemBuilder: (context, index) { // Se utiliza para generar los elementos en la lista
                  return listar(
                    model: users[index],
                    
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
