List<SolicitudModel> solicitudesFromJson(dynamic str) =>
    List<SolicitudModel>.from((str).map((x) => SolicitudModel.fromJson(x)));

class SolicitudModel {
  late int? id;
  late String? usuario_id;
  late String? bloque_id;
  late String? aula_id;
  late String? tipo_id;
  late String? detalle;
  late String? estado;
  late String? fecha_inicial;
  late String? fecha_final;

  SolicitudModel({
    this.id,
    this.usuario_id,
    this.bloque_id,
    this.aula_id,
    this.tipo_id,
    this.detalle,
    this.estado,
    this.fecha_inicial,
    this.fecha_final,
  });

  SolicitudModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuario_id = json['usuario'];
    bloque_id = json['nombre_bloque'];
    aula_id = json['nombre_aulas'];
    tipo_id = json['tipo'];
    detalle = json['detalle'];
    estado = json['estado'];
    fecha_inicial = json['fecha_inicial'];
    fecha_final = json['fecha_final'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['usuario_id'] = usuario_id;
    _data['bloque_id'] = bloque_id;
    _data['aula_id'] = aula_id;
    _data['tipo_id'] = tipo_id;
    _data['detalle'] = detalle;
    _data['estado'] = estado;
    _data['fecha_inicial'] = fecha_inicial;
    _data['fecha_final'] = fecha_final;
    return _data;
  }
}
