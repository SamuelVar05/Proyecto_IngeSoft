// ignore_for_file: non_constant_identifier_names

class ChazaRequestEntity {
  final String id_usuario;
  final String nombre;
  final String descripcion;
  final String? ubicacion;
  final int? foto_id;

  ChazaRequestEntity({
    required this.id_usuario,
    required this.nombre,
    required this.descripcion,
    this.ubicacion,
    this.foto_id,
  });
}
