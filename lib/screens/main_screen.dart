import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../mapa_user_main.dart'; // Asegúrate de importar MapScreen
import 'red_line.dart';
import 'green_line.dart';
import 'payments_screen.dart';
import 'user_profile_screen.dart';
import '../widgets/train_route_selector.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(), // Pantalla principal
    RedLineStations(), // Pantalla de la Línea Roja
    GreenLineStations(), // Pantalla de la Línea Verde
    const PaymentsScreen(), // Pantalla de Pagos
    const UserProfileScreen(), // Pantalla de Usuario
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.train, color: Colors.redAccent, size: 30), label: 'Roja'),
              BottomNavigationBarItem(icon: Icon(Icons.train, color: Colors.green, size: 30), label: 'Verde'),
              BottomNavigationBarItem(icon: Icon(Icons.payment, size: 30), label: 'Pagos'),
              BottomNavigationBarItem(icon: Icon(Icons.person, size: 30), label: 'Usuario'),
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla Home (pantalla principal)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Mapa que ocupa el 40% de la pantalla
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: MapScreen(
              stationName: 'Estación Central San Antonio',
              stationLocation: LatLng(-17.411778, -66.154444),
              allStations: const [
                {'name': 'Estación Central San Antonio', 'location': LatLng(-17.411778, -66.154444)},
                {'name': 'El Arco', 'location': LatLng(-17.423583, -66.154222)},
              ],
              selectedLine: 'Línea Roja',
            ),
          ),
          // Botón para habilitar la ubicación
          Positioned(
            top: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                // Habilitar la ubicación en el MapScreen
                MapScreen.enableLocation(context);
              },
              child: const Icon(Icons.my_location),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const TrainRouteSelector(),
          ),
        ],
      ),
    );
  }
}
