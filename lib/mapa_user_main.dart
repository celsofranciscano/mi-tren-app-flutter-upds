import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

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

  static Future<void> enableLocation(BuildContext context) async {
    _MapScreenState? mapState = context.findAncestorStateOfType<_MapScreenState>();
    if (mapState != null) {
      await mapState._enableLocation();
    }
  }

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _setMarkersAndPolyline();
  }

  Future<void> _enableLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _setMarkersAndPolyline();
    });
  }

  void _setMarkersAndPolyline() {
    _markers.clear();
    _polylines.clear();

    // Crear marcadores para cada estación
    for (var station in widget.allStations) {
      final markerColor = station['name'] == widget.stationName
          ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)
          : (widget.selectedLine == 'Línea Roja'
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));

      _markers.add(
        Marker(
          markerId: MarkerId(station['name']),
          position: station['location'],
          infoWindow: InfoWindow(title: station['name']),
          icon: markerColor,
        ),
      );
    }

    // Marcar la ubicación actual del usuario
    if (_currentLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentLocation!,
          infoWindow: const InfoWindow(title: 'Ubicación Actual'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

      // Encontrar la estación más cercana
      final nearestStation = _findNearestStation(_currentLocation!);
      if (nearestStation != null) {
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('user_to_station'),
            color: Colors.blueAccent,
            width: 5,
            points: [_currentLocation!, nearestStation['location']],
          ),
        );
      }
    }
  }

  Map<String, dynamic>? _findNearestStation(LatLng userLocation) {
    Map<String, dynamic>? nearestStation;
    double shortestDistance = double.infinity;

    for (var station in widget.allStations) {
      double distance = Geolocator.distanceBetween(
        userLocation.latitude,
        userLocation.longitude,
        station['location'].latitude,
        station['location'].longitude,
      );

      if (distance < shortestDistance) {
        shortestDistance = distance;
        nearestStation = station;
      }
    }
    return nearestStation;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.stationLocation,
        zoom: 14,
      ),
      markers: _markers,
      polylines: _polylines,
      onMapCreated: (controller) {
        _mapController = controller;
      },
    );
  }
}
