List<SolicitudModel2> solicitudesFromJson2(dynamic str) =>
    List<SolicitudModel2>.from((str).map((x) => SolicitudModel2.fromJson(x)));

class SolicitudModel2 {
  late String? usuario_id;
  late int? user;
  late String? bloque_id;
  late String? aula_id;
  late String? tipo;
  late String? detalle;
  late String? estado;

  SolicitudModel2({
    this.usuario_id,
    this.user,
    this.bloque_id,
    this.aula_id,
    this.tipo,
    this.detalle,
    this.estado,
  });

  SolicitudModel2.fromJson(Map<String, dynamic> json) {
    usuario_id = json['usuario'];
    user = json['usuario_id'];
    bloque_id = json['nombre_bloque'];
    aula_id = json['nombre_aulas'];
    tipo = json['tipo'];
    detalle = json['detalle'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['usuario_id'] = usuario_id;
    _data['user'] = user;
    _data['bloque_id'] = bloque_id;
    _data['aula_id'] = aula_id;
    _data['tipo'] = tipo;
    _data['detalle'] = detalle;
    _data['estado'] = estado;
    return _data;
  }
}
