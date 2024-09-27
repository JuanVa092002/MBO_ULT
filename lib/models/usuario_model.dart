import 'package:mesa_servicio_ctpi/models/storage_model.dart';

class Usuario {
  final String id;
  final String nombre;
  final String correo;
  final String? password; // Esto puede ser nulo
  final String rol;
  final String telefono;
  final bool activo;
  final bool estado;
  final Storage? foto; // Esto puede ser nulo si la foto no existe

  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    this.password, 
    required this.rol,
    required this.telefono,
    required this.activo,
    required this.estado,
    this.foto, // Es opcional
  });

  // Método para convertir un JSON en un objeto Usuario
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['_id'] ?? '', // Valor predeterminado vacío si es null
      nombre: json['nombre'] ?? 'No name', // Valor predeterminado si es null
      correo: json['correo'] ?? 'No email', // Valor predeterminado si es null
      password: json['password'], // Puede ser nulo
      rol: json['rol'] ?? 'No role', // Valor predeterminado si es null
      telefono: json['telefono'] ?? 'No phone', // Valor predeterminado si es null
      activo: json['activo'] ?? false, // Valor predeterminado si es null
      estado: json['estado'] ?? false, // Valor predeterminado si es null
      foto: json['foto'] != null ? Storage.fromJson(json['foto']) : null, // Verifica si hay una foto
    );
  }
}
