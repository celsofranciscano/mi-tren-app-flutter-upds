import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../map_screen.dart';
import '../screens/ticket_selection_screen.dart';
import '../database_helper.dart';

class TrainRouteSelector extends StatefulWidget {
  const TrainRouteSelector({super.key});

  @override
  State<TrainRouteSelector> createState() => _TrainRouteSelectorState();
}

class _TrainRouteSelectorState extends State<TrainRouteSelector> {
  String? selectedLine;
  String? selectedOriginStation;
  String? selectedDestinationStation;

  final Map<String, List<Map<String, dynamic>>> linesWithStations = {
    'Línea Roja': [
      {
        'name': 'Estación Central San Antonio',
        'location': LatLng(-17.411778, -66.154444)
      },
      {'name': 'El Arco', 'location': LatLng(-17.423583, -66.154222)},
      {'name': 'Santa Bárbara', 'location': LatLng(-17.428750, -66.152250)},
      {'name': 'Alejo Calatayud', 'location': LatLng(-17.434083, -66.148611)},
      {'name': 'OTB Universitario', 'location': LatLng(-17.440222, -66.144417)},
      {'name': 'Politécnico', 'location': LatLng(-17.444694, -66.139500)},
      {'name': 'El Molino', 'location': LatLng(-17.447194, -66.135167)},
      {
        'name': 'Estación UMSS Agronomía',
        'location': LatLng(-17.451333, -66.129972)
      },
      {'name': 'Santa Vera Cruz', 'location': LatLng(-17.459694, -66.123861)},
      {
        'name': 'Kiñiloma (En construcción)',
        'location': LatLng(-17.466417, -66.118500)
      },
    ],
    'Línea Verde': [
      {
        'name': 'Estación Central San Antonio',
        'location': LatLng(-17.411778, -66.154444)
      },
      {'name': 'Cementerio', 'location': LatLng(-17.411194, -66.160972)},
      {'name': 'Aeropuerto', 'location': LatLng(-17.407500, -66.168722)},
      {
        'name': 'Parque Mariscal Santa Cruz',
        'location': LatLng(-17.402333, -66.178750)
      },
      {'name': 'Beijing', 'location': LatLng(-17.400500, -66.187639)},
      {'name': 'Villa Busch', 'location': LatLng(-17.400278, -66.195667)},
      {
        'name': 'Señora de La Merced',
        'location': LatLng(-17.399889, -66.208417)
      },
      {'name': 'Santa Rosa', 'location': LatLng(-17.399556, -66.219917)},
      {
        'name': 'Barrio Ferroviario',
        'location': LatLng(-17.399278, -66.229472)
      },
      {
        'name': 'Estación Colcapirhua',
        'location': LatLng(-17.398972, -66.243194)
      },
      {'name': 'Piñami', 'location': LatLng(-17.398639, -66.252417)},
      {'name': 'Cotapachi', 'location': LatLng(-17.398722, -66.265556)},
      {
        'name': 'Avenida Ferroviaria',
        'location': LatLng(-17.400889, -66.274167)
      },
      {
        'name': 'Estación Quillacollo',
        'location': LatLng(-17.402056, -66.281806)
      },
      {
        'name': 'Cementerio de Quillacollo',
        'location': LatLng(-17.401833, -66.292611)
      },
      {'name': 'Miguel Mercado', 'location': LatLng(-17.401611, -66.302222)},
      {'name': 'Estación Vinto', 'location': LatLng(-17.399194, -66.316472)},
      {'name': 'Río Khora', 'location': LatLng(-17.403306, -66.323417)},
      {'name': 'Vinto Chico', 'location': LatLng(-17.414806, -66.326111)},
      {'name': 'Cruce Payacollo', 'location': LatLng(-17.431194, -66.327583)},
      {'name': 'Río Viloma', 'location': LatLng(-17.440528, -66.328333)},
      {'name': 'Sorata Huancarani', 'location': LatLng(-17.453389, -66.330111)},
      {'name': 'Pueblo Nuevo', 'location': LatLng(-17.464417, -66.331389)},
      {
        'name': 'Estación Suticollo',
        'location': LatLng(-17.473306, -66.331667)
      },
    ],
  };

  void _selectStation(String station) async {
    await DatabaseHelper.instance.addRecentStation(station);
    setState(() {});
  }

  bool _isTicketPurchasable() {
    return selectedLine != null &&
        selectedOriginStation != null &&
        selectedDestinationStation != null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Fondo blanco
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDropdownField(Icons.train, 'Seleccione Línea', selectedLine,
                  linesWithStations.keys.toList(), (value) {
                setState(() {
                  selectedLine = value;
                  selectedOriginStation = null;
                  selectedDestinationStation = null;
                });
              }),
              const SizedBox(height: 10),

              _buildDropdownField(
                  Icons.location_on,
                  'Estación de origen',
                  selectedOriginStation,
                  selectedLine == null
                      ? []
                      : linesWithStations[selectedLine!]!
                          .map((station) => station['name'] as String)
                          .toList(), (value) {
                setState(() {
                  selectedOriginStation = value;
                  _selectStation(value!);
                });
              }),
              const SizedBox(height: 10),

              _buildDropdownField(
                  Icons.flag,
                  'Estación de destino',
                  selectedDestinationStation,
                  selectedLine == null
                      ? []
                      : linesWithStations[selectedLine!]!
                          .map((station) => station['name'] as String)
                          .toList(), (value) {
                setState(() {
                  selectedDestinationStation = value;
                  _selectStation(value!);
                });
              }),
              const SizedBox(height: 5),
// Botones en fila con íconos y textos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.map,
                            color: Colors.blueAccent, size: 40),
                        onPressed: () {
                          if (_isTicketPurchasable()) {
                            _navigateToMap(context);
                          }
                        },
                      ),
                      const Text(
                        'Ver en el mapa',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.local_activity,
                            color: Colors.blueAccent, size: 40),
                        onPressed: () {
                          if (_isTicketPurchasable()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TicketSelectionScreen(
                                  selectedLine: selectedLine!,
                                  originStation: selectedOriginStation!,
                                  destinationStation:
                                      selectedDestinationStation!,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      const Text(
                        'Pagar',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dropdown personalizado con íconos
  Widget _buildDropdownField(IconData icon, String hintText, String? value,
      List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            const TextStyle(color: Colors.black54), // Cambiado a negro suave
        prefixIcon: Icon(icon, color: Colors.black54), // Cambiado a negro suave
        filled: true,
        fillColor: Colors.white, // Fondo blanco
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Borde más pequeño
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Future<void> _navigateToMap(BuildContext context) async {
    final List<Map<String, dynamic>> stations =
        linesWithStations[selectedLine!]!;
    final int startIndex = stations
        .indexWhere((station) => station['name'] == selectedOriginStation);
    final int endIndex = stations
        .indexWhere((station) => station['name'] == selectedDestinationStation);

    List<LatLng> polylinePoints = [];
    if (startIndex != -1 && endIndex != -1) {
      polylinePoints = stations
          .sublist(startIndex < endIndex ? startIndex : endIndex,
              (startIndex < endIndex ? endIndex : startIndex) + 1)
          .map((station) => station['location'] as LatLng)
          .toList();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          stationName: selectedOriginStation!,
          stationLocation: stations[startIndex]['location'],
          allStations: stations,
          polylinePoints: polylinePoints,
          selectedLine: selectedLine!,
        ),
      ),
    );
  }
}
