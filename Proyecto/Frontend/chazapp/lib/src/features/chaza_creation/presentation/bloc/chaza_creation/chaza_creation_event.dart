import 'package:equatable/equatable.dart';

abstract class ChazaCreationEvent extends Equatable {
  const ChazaCreationEvent();

  @override
  List<Object> get props => [];
}

class ChazaCreationRequested extends ChazaCreationEvent {
  final String nombre;
  final String descripcion;
  final String ubicacion;
  final String? idPhoto;

  final String token;

  const ChazaCreationRequested({
    required this.nombre,
    required this.descripcion,
    required this.ubicacion,
    this.idPhoto,
    required this.token,
  });
}
