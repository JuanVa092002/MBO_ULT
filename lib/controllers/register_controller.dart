import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterUsers {
  final String _baseUrl = 'https://backendnodeproyectomesaservicio.onrender.com/api/auth';

  Future<Map<String, dynamic>> registerUser({
    required String nombre,
    required String correo,
    required String rol,
    required String telefono,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$_baseUrl/register');

    // Verificar si las contraseñas coinciden
    if (password != confirmPassword) {
      return {'success': false, 'message': 'Las contraseñas no coinciden'};
    }

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': nombre,
          'correo': correo,
          'rol': rol,
          'telefono': telefono,
          'password': password,
          'confirmPassword': confirmPassword,
        }),
      );

      // Manejar la respuesta del servidor
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['message'],
          'data': data['data'],
        };
      } else {
        final errorData = jsonDecode(response.body);
        print(errorData);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Error desconocido',
        };
      }
    } catch (error) {
      // Capturar cualquier error de red o de decodificación JSON
      print('Error al registrar usuario: $error');
      return {'success': false, 'message': 'Error al registrar usuario'};
    }
  }
}