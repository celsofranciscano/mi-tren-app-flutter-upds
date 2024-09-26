import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final String stationName;
  final LatLng stationLocation;
  final List<Map<String, dynamic>> allStations;
  final List<LatLng>? polylinePoints;
  final String selectedLine;

  const MapScreen({
    required this.stationName,
    required this.stationLocation,
    required this.allStations,
    this.polylinePoints,
    required this.selectedLine,
    Key? key,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setMarkersAndPolyline();
  }

  void _setMarkersAndPolyline() {
    // Limpiar conjuntos de marcadores y polilíneas antes de agregar nuevos
    _markers.clear();
    _polylines.clear();

    // Crear marcadores para cada estación
    for (var station in widget.allStations) {
      final markerColor = station['name'] == widget.stationName
          ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet) // Violeta para la estación seleccionada
          : (widget.selectedLine == 'Línea Roja'
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)  // Rojo para estaciones de la Línea Roja
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)); // Verde para estaciones de la Línea Verde

      _markers.add(
        Marker(
          markerId: MarkerId(station['name']),
          position: station['location'],
          infoWindow: InfoWindow(
            title: station['name'],
          ),
          icon: markerColor,
        ),
      );
    }

    // Crear una Polyline solo para conectar las estaciones entre origen y destino seleccionados
    if (widget.polylinePoints != null && widget.polylinePoints!.isNotEmpty) {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('selected_route'),
          color: widget.selectedLine == 'Línea Roja' ? Colors.red : Colors.green,
          width: 6,
          points: widget.polylinePoints!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Fondo azul
        title: Text(
          'Mapa - ${widget.stationName}',
          style: const TextStyle(color: Colors.white), // Texto en blanco
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Íconos en blanco
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.stationLocation,
          zoom: 14,
        ),
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
