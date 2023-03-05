import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto_plataforma/models/solicitudes2.dart';

import '../config.dart';
import '../models/aulas.dart';
import '../models/bloques.dart';
import '../models/solicitud.dart';
import '../models/user.dart';

class ApiService {
  static var client = http.Client();

  static Future<List<UserModel>?> getUsuarios() async {
    var url = Uri.http(
      Config.apiURL,
      Config.userAPI,
    );

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        //print(response.body);
        return usuariosFromJson(data["usuario"]);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<BloqueModel>?> getBloques() async {
    var url = Uri.http(
      Config.apiURL,
      Config.bloqueAPI,
    );

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return bloqueFromJson(data["bloques"]);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<AulaModel>?> getAulas() async {
    var url = Uri.http(
      Config.apiURL,
      Config.aulaAPI,
    );

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return aulasFromJson(data["aulas"]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<SolicitudModel>?> getSolicitudes() async {
    var url = Uri.http(
      Config.apiURL,
      Config.soliAPI,
    );

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return solicitudesFromJson(data["solicitud"]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> saveSolicitudes(
    SolicitudModel solimodel,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.soliAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: json.encode(
        solimodel,
      ),
      /*body: json.encode(
        model.toJson(),        
      ),*/
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<SolicitudModel2>?> getSolicitudes2(
    SolicitudModel2 model,
  ) async {
    var url = Uri.http(
      Config.apiURL,
      Config.soliAPI2 + "/" + model.user.toString(),
    );

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return solicitudesFromJson2(data["data"]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteUser(userId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.aulaAPI + "/delete_employee/" + userId,
    );

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
