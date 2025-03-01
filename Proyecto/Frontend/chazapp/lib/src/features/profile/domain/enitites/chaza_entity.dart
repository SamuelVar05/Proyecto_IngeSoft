import 'package:equatable/equatable.dart';

class ChazaEntity extends Equatable {
  final String id;
  final String nombre;
  final String descripcion;
  final String? ubicacion;
  final int? fotoId;

  const ChazaEntity({
    required this.id,
    required this.nombre,
    required this.descripcion,
    this.ubicacion,
    this.fotoId,
  });
  
  @override
  List<Object?> get props => [id, nombre, descripcion, ubicacion, fotoId];
}
