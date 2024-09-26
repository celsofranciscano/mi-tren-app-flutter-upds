import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../map_screen.dart';

class GreenLineStations extends StatelessWidget {
  final List<Map<String, dynamic>> greenLineStations = [
    {
      'name': 'Estación Central San Antonio',
      'location': LatLng(-17.411778, -66.154444),
      'mainStreet': 'Av. 6 de agosto',
      'address': 'Avenida 6 de agosto entre calle Angostura y avenida Barrientos',
      'icons': [Icons.directions_bus, Icons.train, Icons.wifi, Icons.wheelchair_pickup]
    },
    {
      'name': 'Parada Cementerio',
      'location': LatLng(-17.411194, -66.160972),
      'mainStreet': 'Av. Sajama',
      'address': 'Avenida Sajama e ingreso del Cementerio General',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Parada Aeropuerto',
      'location': LatLng(-17.407500, -66.168722),
      'mainStreet': 'Av. Sajama',
      'address': 'Avenida Sajama y Avenida Manco Capac',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Parada Parque Mariscal Santa Cruz',
      'location': LatLng(-17.402333, -66.178750),
      'mainStreet': 'C. Arquimedes',
      'address': 'Calle Arquímedes y Avenida Daniel Campos',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Parada Beijing',
      'location': LatLng(-17.400500, -66.187639),
      'mainStreet': 'Av. Arquímedes',
      'address': 'Avenida Arquímedes y Av. Beijing',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Parada Villa Busch',
      'location': LatLng(-17.399889, -66.208417),
      'mainStreet': 'Av. Arquímedes',
      'address': 'Avenida Arquímedes con Max Von Laile',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Parada Señora de La Merced',
      'location': LatLng(-17.399889, -66.208417),
      'mainStreet': 'Av. Arquímedes',
      'address': 'Avenida Arquímedes con Santiago Sunyer',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Parada Santa Rosa',
      'location': LatLng(-17.399556, -66.219917),
      'mainStreet': 'Av. Arquímedes',
      'address': 'Avenida Arquímedes con Avenida Comercio (Colcapirhua)',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Parada Barrio Ferroviario',
      'location': LatLng(-17.399278, -66.229472),
      'mainStreet': 'Av. Arquímedes',
      'address': 'Avenida Arquímedes con Avenida 14 de Febrero',
      'icons': [Icons.accessible]
    },
    {
      'name': 'Estación Colcapirhua',
      'location': LatLng(-17.398972, -66.243194),
      'mainStreet': 'Av. Arquímedes',
      'address': 'Avenida Arquímedes con calle Sucre (Colcapirhua)',
      'icons': [Icons.accessible, Icons.local_hospital]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Línea Verde - Estaciones',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: greenLineStations.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> station = greenLineStations[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: const Color(0xFFE8F5E9), // Fondo verde suave
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
                  const Divider(color: Colors.green), // Separador entre el título y los detalles
                  // Dirección
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.place, color: Colors.green, size: 20),
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
                        const Icon(Icons.info, color: Colors.green, size: 20),
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
                        const Icon(Icons.map, color: Colors.green, size: 20),
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
                                    allStations: greenLineStations,
                                    selectedLine: 'Línea Verde',
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Ver en el mapa',
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                collapsedIconColor: Colors.green,
                iconColor: Colors.green,
              ),
            ),
          );
        },
      ),
    );
  }
}
