import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../map_screen.dart';

class RedLineStations extends StatelessWidget {
  final List<Map<String, dynamic>> redLineStations = [
    {
      'name': 'Estación Central San Antonio',
      'location': LatLng(-17.411778, -66.154444),
      'mainStreet': 'Av. 6 de Agosto',
      'address': 'Avenida 6 de agosto entre calle Angostura y avenida Barrientos',
      'icons': [Icons.directions_bus, Icons.train, Icons.wifi, Icons.wheelchair_pickup]
    },
    {
      'name': 'Parada El Arco',
      'location': LatLng(-17.423583, -66.154222),
      'mainStreet': 'Av. Petrolera',
      'address': 'Avenida Petrolera y Avenida Independencia',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Parada Santa Bárbara',
      'location': LatLng(-17.428750, -66.152250),
      'mainStreet': 'Av. Petrolera',
      'address': 'Avenida Petrolera y Avenida Independencia',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Parada Alejo Calatayud',
      'location': LatLng(-17.434083, -66.148611),
      'mainStreet': 'Av. Petrolera',
      'address': 'Avenida Petrolera y Avenida Independencia',
      'icons': [Icons.accessible, Icons.local_hospital]
    },
    {
      'name': 'Parada OTB Universitario',
      'location': LatLng(-17.440222, -66.144417),
      'mainStreet': 'Av. Petrolera',
      'address': 'Avenida Petrolera y Avenida Independencia',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Parada Politécnico',
      'location': LatLng(-17.444694, -66.139500),
      'mainStreet': 'Av. Petrolera',
      'address': 'Avenida Petrolera y Avenida Independencia',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Parada El Molino',
      'location': LatLng(-17.447194, -66.135167),
      'mainStreet': 'Av. Petrolera',
      'address': 'Avenida Petrolera y Avenida Independencia',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Estación UMSS Agronomía',
      'location': LatLng(-17.451333, -66.129972),
      'mainStreet': 'Av. Petrolera',
      'address': 'Avenida Petrolera y Avenida Independencia',
      'icons': [Icons.accessible, Icons.school, Icons.house]
    },
    {
      'name': 'Parada Santa Vera Cruz',
      'location': LatLng(-17.459694, -66.123861),
      'mainStreet': 'Av. Petrolera',
      'address': 'Avenida Petrolera y Avenida Independencia',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Parada Kiñiloma (En construcción)',
      'location': LatLng(-17.466417, -66.118500),
      'mainStreet': 'Av. Petrolera',
      'address': 'Avenida Petrolera y Avenida Independencia',
      'icons': [Icons.accessible]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Línea Roja - Estaciones',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: redLineStations.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> station = redLineStations[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: const Color(0xFFFFEBEE), // Fondo rojo suave
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  "${index + 1}. ${station['name']}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Row(
                  children: [
                   
                    const SizedBox(width: 4),
                    Text(
                      station['mainStreet'],
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                children: [
                  const Divider(color: Colors.redAccent), // Separador entre el título y los detalles
                  // Dirección
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.place, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            station['address'],
                            style: const TextStyle(color: Colors.black87, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Información adicional
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.info, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          '',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            station['name'] == 'Estación Central San Antonio'
                                ? 'Salidas cada 30min desde las 6:38am'
                                : 'Otra información relevante.',
                            style: const TextStyle(color: Colors.black87, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Botón para ver en el mapa
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.map, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                    stationName: station['name'],
                                    stationLocation: station['location'],
                                    allStations: redLineStations,
                                    selectedLine: 'Línea Roja',
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Ver en el mapa',
                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                collapsedIconColor: Colors.red,
                iconColor: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}