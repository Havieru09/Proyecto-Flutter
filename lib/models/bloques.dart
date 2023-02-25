List<BloqueModel> bloqueFromJson(dynamic str) =>
    List<BloqueModel>.from((str).map((x) => BloqueModel.fromJson(x)));

class BloqueModel {
  late String? nombre_bloque;
  late int? id_bloque;

  BloqueModel({
    this.nombre_bloque,
    this.id_bloque,
  });

  BloqueModel.fromJson(Map<String, dynamic> json) {
    nombre_bloque = json['nombre_bloque'];
    id_bloque = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre_bloque'] = nombre_bloque;
    _data['id'] = id_bloque;
    return _data;
  }
}
