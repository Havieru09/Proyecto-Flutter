List<UserModel> usuariosFromJson(dynamic str) =>
    List<UserModel>.from((str).map((x) => UserModel.fromJson(x)));

class UserModel {
  late String? usuario;
  late String? psw;
  late String? id_usuario;

  UserModel({
    this.usuario,
    this.psw,
    this.id_usuario,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    usuario = json['usuario'];
    psw = json['contraseña'];
    id_usuario = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['usuario'] = usuario;
    _data['contraseña'] = psw;
    _data['id'] = id_usuario;
    return _data;
  }
}
