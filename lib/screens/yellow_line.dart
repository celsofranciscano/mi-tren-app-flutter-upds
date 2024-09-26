import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../map_screen.dart';
import '../widgets/yellow_line_bar.dart'; // Asegúrate de que esta ruta y el nombre sean correctos

class YellowLineStations extends StatelessWidget {
  final List<Map<String, dynamic>> yellowLineStations = [
    {
      'name': 'Estación San Antonio',
      'location': LatLng(-17.411778, -66.154444),
      'mainStreet': 'Av. 6 de Agosto',
      'address': 'Avenida 6 de agosto esquina Barrientos y Peralta',
      'icons': [Icons.directions_bus, Icons.train, Icons.wifi, Icons.wheelchair_pickup]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Línea Amarilla - Estación'),
        backgroundColor: Colors.yellow[700],
      ),
      body: ListView.builder(
        itemCount: yellowLineStations.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              YellowLineBar(
                stationNumber: index + 1,
                isFirst: index == 0,
                isLast: index == yellowLineStations.length - 1,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    title: Text(
                      yellowLineStations[index]['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: yellowLineStations[index]['mainStreet'].isNotEmpty
                        ? Text(yellowLineStations[index]['mainStreet'])
                        : null,
                    children: [
                      ListTile(
                        leading: Icon(Icons.info, color: Colors.yellow[700]),
                        title: Text('Detalles:'),
                        subtitle: yellowLineStations[index]['address'].isNotEmpty
                            ? Text(yellowLineStations[index]['address'])
                            : Text('Sin dirección adicional disponible.'),
                      ),
                      ListTile(
                        leading: Icon(Icons.map, color: Colors.yellow[700]),
                        title: Text('Ver en el mapa'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(
                                stationName: yellowLineStations[index]['name'],
                                stationLocation: yellowLineStations[index]['location'],
                                allStations: yellowLineStations,
                                selectedLine: 'Línea Amarilla',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    collapsedIconColor: Colors.yellow[700], // Color del ícono colapsado
                    iconColor: Colors.yellow[700], // Color del ícono expandido
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
