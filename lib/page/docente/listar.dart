import 'package:flutter/material.dart';
import 'package:proyecto_plataforma/widgets/cabeceraBack.dart';
import 'package:proyecto_plataforma/widgets/footer.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../Servicios/api_service.dart';
import '../../models/solicitud.dart';
import 'user_item.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
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
    );
  }

  Widget loadUsers() {
    return FutureBuilder(
      future: ApiService.getSolicitudes(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<SolicitudModel>?> model,
      ) {
        print(model.data);
        if (model.hasData) {
          return userList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget userList(users) {
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
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserItem(
                    model: users[index],
                    onDelete: (SolicitudModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      ApiService.deleteUser(model.aula_id).then(
                        (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        },
                      );
                    },
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
