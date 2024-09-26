import 'package:flutter/material.dart';
import '../database_helper.dart'; // Importa el helper de la base de datos

class FavoriteStationsWidget extends StatefulWidget {
  const FavoriteStationsWidget({Key? key}) : super(key: key);

  @override
  _FavoriteStationsWidgetState createState() => _FavoriteStationsWidgetState();
}

class _FavoriteStationsWidgetState extends State<FavoriteStationsWidget> {
  late Future<List<Map<String, dynamic>>> _recentStationsFuture;

  @override
  void initState() {
    super.initState();
    _loadRecentStations();
  }

  void _loadRecentStations() {
    _recentStationsFuture = DatabaseHelper.instance.getRecentStations();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _recentStationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar estaciones más recientes'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay estaciones recientes'));
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final station = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.train, color: Colors.blue),
                    title: Text(
                      station['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        print('Intentando eliminar estación con ID: ${station['id']}');
                        int result = await DatabaseHelper.instance.deleteRecentStation(station['id']);
                        
                        if (result > 0) {
                          print('Estación eliminada correctamente');
                        } else {
                          print('Error al eliminar la estación');
                        }

                        setState(() {
                          _loadRecentStations(); // Recarga las estaciones recientes después de eliminar
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
