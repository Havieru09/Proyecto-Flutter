List<TipoModel> tipoFromJson(dynamic str) =>
    List<TipoModel>.from((str).map((x) => TipoModel.fromJson(x)));

class TipoModel {
  late String? nombre_tipo;
  late int? id_tipo;

  TipoModel({
    this.nombre_tipo,
    this.id_tipo,
  });

  TipoModel.fromJson(Map<String, dynamic> json) {
    nombre_tipo = json['nombre_tipo'];
    id_tipo = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre_tipo'] = nombre_tipo;
    _data['id'] = id_tipo;
    return _data;
  }
}
