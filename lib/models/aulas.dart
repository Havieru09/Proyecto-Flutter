List<AulaModel> aulasFromJson(dynamic str) =>
    List<AulaModel>.from((str).map((x) => AulaModel.fromJson(x)));

class AulaModel {
  late String? nombre_aula;
  late String? id_aula;

  AulaModel({
    this.nombre_aula,
    this.id_aula,
  });

  AulaModel.fromJson(Map<String, dynamic> json) {
    nombre_aula = json['nombre_aula'];
    id_aula = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre_aula'] = nombre_aula;
    _data['id'] = id_aula;
    return _data;
  }
}
