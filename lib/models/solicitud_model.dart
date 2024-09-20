import 'package:mesa_servicio_ctpi/models/ambiente_model.dart';
import 'package:mesa_servicio_ctpi/models/storage_model.dart';
import 'package:mesa_servicio_ctpi/models/usuario_model.dart';

class Solicitud {
  final String id;
  final String descripcion;
  final String fecha;
  final String estado;
  final Usuario usuario;
  final Ambiente ambiente;
  final Usuario tecnico;
  final String codigoCaso;
  final String telefono;
  final Storage? foto;

  Solicitud({
    required this.id,
    required this.descripcion,
    required this.fecha,
    required this.estado,
    required this.usuario,
    required this.ambiente,
    required this.tecnico,
    required this.codigoCaso,
    required this.telefono,
    this.foto,
  });

  factory Solicitud.fromJson(Map<String, dynamic> json) {
    return Solicitud(
      id: json['id'],
      descripcion: json['descripcion'],
      fecha: json['fecha'],
      estado: json['estado'],
      usuario: json['usuario'],
      ambiente: json['ambiente'],
      tecnico: json['tecnico'],
      codigoCaso: json['codigoCaso'],
      telefono: json['telefono'],
      foto: json['foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descripcion': descripcion,
      'fecha': fecha,
      'estado': estado,
      'usuario': usuario,
      'ambiente': ambiente,
      'tecnico': tecnico,
      'telefono': telefono,
      'codigoCaso': codigoCaso,
      'foto': foto,
    };
  }
}