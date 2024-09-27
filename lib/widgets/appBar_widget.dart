import 'package:flutter/material.dart';
// import 'package:mesa_servicio_ctpi/controllers/profile_controller.dart';
import 'package:mesa_servicio_ctpi/models/usuario_model.dart';
import 'package:mesa_servicio_ctpi/screens/login_screen.dart';
import 'package:mesa_servicio_ctpi/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppbarWidget extends StatefulWidget {
  final Usuario usuario;
  const AppbarWidget({super.key, required this.usuario});

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
}

@override
Size get preferredSize => const Size.fromHeight(kToolbarHeight);
class _AppbarWidgetState extends State<AppbarWidget> {

  late Usuario usuario;
  @override
     void initState() {
    super.initState();
    usuario = widget.usuario;
  }
  
  
  // Obtener el token almacenado en SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/icons/chat.png",
            height: 60,
            width: 60,
            fit: BoxFit.contain,
          ),
        ),
        title: Text('Hola, ${usuario.nombre}',style: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),),
        actions: [
          Row(
            children: [
              
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen(usuario: usuario,)),
                      (route) => false, // Esto elimina todas las rutas anteriores
                    );
                  },
                  child:
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.person),
                  )

                  // CircleAvatar(
                  //   backgroundImage: (usuario.foto != null && usuario.foto!.url.isNotEmpty)
                  //       ? NetworkImage(usuario.foto!.url)
                  //       : null, // Si no hay imagen, dejamos null para usar el icono
                  //   // backgroundColor: Colors.green,
                  //   child: (usuario.foto == null || usuario.foto!.url.isEmpty)
                  //       ? Icon(Icons.person, size: 40, color: Colors.white) // Icono de persona por defecto
                  //       : null, // No se muestra nada si hay imagen
                  // ),
                ),
                
              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}