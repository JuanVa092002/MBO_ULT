import 'package:flutter/material.dart';
import 'package:mesa_servicio_ctpi/models/usuario_model.dart';
import 'package:mesa_servicio_ctpi/screens/home_tecnico_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mesa_servicio_ctpi/controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  final Usuario usuario;
  const ProfileScreen({super.key, required this.usuario});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Usuario usuario;
  @override
  void initState() {
    super.initState();
    usuario = widget.usuario;
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        height: 450,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(222, 217, 217, 1),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                         Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeTechnicianScreen(usuario: usuario,)),
                          (route) => false, // Esto elimina todas las rutas anteriores
                        );
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.person),
                  ),
              // CircleAvatar(
              //   backgroundImage: (usuario.foto != null && usuario.foto!.url.isNotEmpty)
              //     ? NetworkImage(usuario.foto!.url)
              //     : null, // Si no hay imagen, dejamos null para usar el icono
              //   // backgroundColor: Colors.green,
              //   child: (usuario.foto == null || usuario.foto!.url.isEmpty)
              //     ? Icon(Icons.person, size: 40, color: Colors.white) // Icono de persona por defecto
              //     : Icon(Icons.person, size: 40, color: Colors.white), // No se muestra nada si hay imagen
              // ),
              const SizedBox(height: 20),
              Text(
                usuario.nombre,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'CORREO',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(usuario.correo),
              ),
              const SizedBox(height: 20),
              const Text(
                'ROL',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(usuario.rol),
              ),
              const SizedBox(height: 20),
              const Text(
                'TELEFONO',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(usuario.telefono.toString()),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
