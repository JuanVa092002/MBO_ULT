import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SolucionCasoController {
  final String baseUrl = "https://backendnodeproyectomesaservicio.onrender.com/api";

  Future<String?> enviarSolucionCaso({
    required String idSolicitud,
    required String descripcionSolucion,
    required String tipoCaso,
    required String tipoSolucion,
    XFile? evidencia,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception('Token de autenticación no disponible');

    try {
      // Crear la solicitud multipart
      final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/solucionCaso/$idSolicitud'))
        ..headers['Authorization'] = 'Bearer $token'
        ..fields.addAll({
          'descripcionSolucion': descripcionSolucion,
          'tipoCaso': tipoCaso,
          'tipoSolucion': tipoSolucion,
        });

      if (evidencia != null) {
        request.files.add(await http.MultipartFile.fromPath('evidencia', evidencia.path));
      }

      // Enviar la solicitud
      final response = await http.Response.fromStream(await request.send());

      // Verificar el estado de la respuesta
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['message'];
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      return null;
    }
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
