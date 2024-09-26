import 'package:flutter/material.dart';

class TicketSelectionScreen extends StatefulWidget {
  final String selectedLine;
  final String originStation;
  final String destinationStation;

  const TicketSelectionScreen({
    required this.selectedLine,
    required this.originStation,
    required this.destinationStation,
    Key? key,
  }) : super(key: key);

  @override
  _TicketSelectionScreenState createState() => _TicketSelectionScreenState();
}

class _TicketSelectionScreenState extends State<TicketSelectionScreen> {
  String? selectedTicketType;
  bool showPreferenceInfo = false; // Para controlar la visibilidad del mensaje explicativo
  int generalTicketCount = 0;
  int preferenceTicketCount = 0;
  int schoolTicketCount = 0;

  final Map<String, Map<String, double>> ticketPrices = {
    'Línea Roja': {
      'General': 2.50,
      'Preferencia': 2.00,
      'Escolar': 1.00,
    },
    'Línea Verde': {
      'General': 2.50,
      'Preferencia': 2.00,
      'Escolar': 1.00,
    },
  };

  double get generalPrice => ticketPrices[widget.selectedLine]!['General']!;
  double get preferencePrice => ticketPrices[widget.selectedLine]!['Preferencia']!;
  double get schoolPrice => ticketPrices[widget.selectedLine]!['Escolar']!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pagar - ${widget.selectedLine}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue, // Fondo azul
        iconTheme: const IconThemeData(color: Colors.white), // Icono en blanco
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Seleccione el tipo de ticket:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Sección de selección de tickets con íconos y contador
            _buildTicketSelector(
              Icons.directions_walk, 
              'General', 
              generalPrice, 
              generalTicketCount, 
              () {
                setState(() {
                  if (generalTicketCount > 0) generalTicketCount--;
                });
              }, 
              () {
                setState(() {
                  generalTicketCount++;
                });
              }
            ),
            _buildTicketSelector(
              Icons.accessibility_new, 
              'Preferencia', 
              preferencePrice, 
              preferenceTicketCount, 
              () {
                setState(() {
                  if (preferenceTicketCount > 0) preferenceTicketCount--;
                });
              }, 
              () {
                setState(() {
                  preferenceTicketCount++;
                  showPreferenceInfo = true;  // Mostrar información para "Preferencia"
                });
              }
            ),
            _buildTicketSelector(
              Icons.school, 
              'Escolar', 
              schoolPrice, 
              schoolTicketCount, 
              () {
                setState(() {
                  if (schoolTicketCount > 0) schoolTicketCount--;
                });
              }, 
              () {
                setState(() {
                  schoolTicketCount++;
                });
              }
            ),
            const SizedBox(height: 20),
            // Mensaje explicativo para Preferencia
            if (showPreferenceInfo)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Tarifa Preferencia:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text('- Adultos mayores (60 años en adelante)'),
                    Text('- Niños (5 a 12 años)'),
                    Text('- Personas con discapacidad'),
                    Text('- Universitarios'),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            // Mostrar el total calculado
            Text(
              'Total: ${(generalTicketCount * generalPrice) + (preferenceTicketCount * preferencePrice) + (schoolTicketCount * schoolPrice)} Bs',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Botón Confirmar Compra
            ElevatedButton(
              onPressed: () {
                _showPurchaseSummary(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Botón azul
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Confirmar Compra',
                style: TextStyle(fontSize: 18, color: Colors.white), // Texto en blanco
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir un selector de tickets con icono y contador
  Widget _buildTicketSelector(IconData icon, String type, double price, int count, VoidCallback onDecrement, VoidCallback onIncrement) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blue), // Icono azul
            const SizedBox(width: 10),
            Text('$type - $price Bs'),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: onDecrement,
              icon: const Icon(Icons.remove_circle, color: Colors.blue),
            ),
            Text('$count'),
            IconButton(
              onPressed: onIncrement,
              icon: const Icon(Icons.add_circle, color: Colors.blue),
            ),
          ],
        ),
      ],
    );
  }

  // Método para mostrar el modal con el resumen de compra
  void _showPurchaseSummary(BuildContext context) {
    final totalTickets = generalTicketCount + preferenceTicketCount + schoolTicketCount;
    final totalAmount = (generalTicketCount * generalPrice) +
                        (preferenceTicketCount * preferencePrice) +
                        (schoolTicketCount * schoolPrice);

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Resumen de Compra',
                style: TextStyle(
                  fontSize: 22, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.blue
                ),
              ),
              const Divider(),
              Row(
                children: [
                  const Icon(Icons.train, color: Colors.blue),
                  const SizedBox(width: 10),
                  Text('Línea: ${widget.selectedLine}', style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.blue),
                  const SizedBox(width: 10),
                  Text('Origen: ${widget.originStation}', style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.flag, color: Colors.blue),
                  const SizedBox(width: 10),
                  Text('Destino: ${widget.destinationStation}', style: const TextStyle(fontSize: 16)),
                ],
              ),
              const Divider(),
              _buildTicketDetail(Icons.directions_walk, 'General', generalTicketCount, generalPrice),
              _buildTicketDetail(Icons.accessibility_new, 'Preferencia', preferenceTicketCount, preferencePrice),
              _buildTicketDetail(Icons.school, 'Escolar', schoolTicketCount, schoolPrice),
              const Divider(),
              Text(
                'Total: $totalAmount Bs',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Cierra el modal
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Compra confirmada para $totalTickets ticket(s):\nTotal: $totalAmount Bs.',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Botón azul
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Confirmar',
                  style: TextStyle(fontSize: 18, color: Colors.white), // Texto en blanco
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Construir detalles de tickets para el modal
  Widget _buildTicketDetail(IconData icon, String ticketType, int count, double price) {
    if (count > 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 10),
                Text('$ticketType x $count'),
              ],
            ),
            Text('${count * price} Bs'),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
