import 'package:flutter/material.dart';
import 'package:mesa_servicio_ctpi/controllers/request_controller.dart';
import 'package:mesa_servicio_ctpi/models/usuario_model.dart';
import 'package:mesa_servicio_ctpi/screens/form_request_screen.dart';
import 'package:mesa_servicio_ctpi/widgets/appBar_widget.dart';

class HomeTechnicianScreen extends StatefulWidget {
  final Usuario usuario;
  const HomeTechnicianScreen({super.key, required this.usuario});

  @override
  State<HomeTechnicianScreen> createState() => _HomeTechnicianScreenState();
}

class _HomeTechnicianScreenState extends State<HomeTechnicianScreen> {
  String? _error;
  final RequestAssignedController _controller = RequestAssignedController();
  late Future<List<dynamic>> _assignedRequests;

  @override
  void initState() {
    super.initState();
    _assignedRequests = _loadAssignedRequests();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _assignedRequests = _loadAssignedRequests();
  }

  // Obtener solicitudes asignadas del backend
  Future<List<dynamic>> _loadAssignedRequests() async {
    try {
      List<dynamic> solicitudes = await _controller.getAssignedRequests();
      return solicitudes;
    } catch (e) {
      setState(() {
        _error = 'Error al cargar las solicitudes: $e';
      });
      return []; // Retornamos una lista vacía en caso de error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(100), child: AppbarWidget(usuario: widget.usuario ,)), // Se instancia el widget AppBarWidget
      body: FutureBuilder<List<dynamic>>(
        future: _assignedRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay solicitudes asignadas',style: TextStyle(
              color: Colors.black45,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            )));
          } else {
            // Construir la lista de solicitudes
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final request = snapshot.data![index];
                final estado = request['estado'] ?? 'Sin estado';
                return Card(
                  key: ValueKey(request['_id']),
                  margin: const EdgeInsets.all(8.0),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(request['descripcion'] ?? 'Sin descripción',style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),),
                              Text(request['usuario']?['nombre'] ?? 'Sin nombre',style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),),
                              Text(request['fecha'] ?? 'Sin fecha',style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Estado: $estado'),
                              if (estado == 'asignado' || estado == 'pendiente')
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context) => FormRequestScreen(idSolicitud: request['_id'], usuario: widget.usuario,)),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    foregroundColor: Colors.white,
                                    backgroundColor: estado == 'pendiente' ? const Color .fromRGBO(186, 16, 8, 1)
                                     : const Color.fromRGBO(57, 169, 0, 1),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                    textStyle: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: const Text('Dar Solución'),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(222, 217, 217, 1),
        onPressed: () {
          setState(() {
            _assignedRequests = _loadAssignedRequests();
          });
        },
        child: const Icon(Icons.refresh,color: Color.fromRGBO(57, 169, 0, 1),),
      ),
    );
  }
}

