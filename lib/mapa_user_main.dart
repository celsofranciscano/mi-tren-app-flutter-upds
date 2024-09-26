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
      await mapState._requestLocationPermission(context);
    }
  }

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _setMarkersAndPolyline();
  }

  Future<void> _requestLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        _showSnackBar(context, 'Los permisos fueron denegados permanentemente.');
        return;
      }
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      _getCurrentLocation(context);
    } else {
      _showSnackBar(context, 'Permisos de ubicación denegados.');
    }
  }

  Future<void> _getCurrentLocation(BuildContext context) async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _setMarkersAndPolyline();
      });
      _showSnackBar(context, 'Ubicación obtenida: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      _showSnackBar(context, 'Error al obtener la ubicación: $e');
    }
  }

  void _setMarkersAndPolyline() {
    _markers.clear();
    _polylines.clear();

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

    if (_currentLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentLocation!,
          infoWindow: const InfoWindow(title: 'Ubicación Actual'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

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

  LatLngBounds _calculateBounds() {
    double south = double.infinity;
    double north = -double.infinity;
    double west = double.infinity;
    double east = -double.infinity;

    for (var station in widget.allStations) {
      final LatLng position = station['location'];
      if (position.latitude < south) south = position.latitude;
      if (position.latitude > north) north = position.latitude;
      if (position.longitude < west) west = position.longitude;
      if (position.longitude > east) east = position.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
        controller.animateCamera(
          CameraUpdate.newLatLngBounds(_calculateBounds(), 50),
        );
      },
    );
  }
}
