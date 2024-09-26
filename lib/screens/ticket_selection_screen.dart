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
        title: Text('Seleccionar Tipo de Ticket - ${widget.selectedLine}'),
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
            // Sección de selección de tickets con contador
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('General - ${generalPrice} Bs'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (generalTicketCount > 0) generalTicketCount--;
                        });
                      },
                      icon: const Icon(Icons.remove_circle),
                    ),
                    Text('$generalTicketCount'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          generalTicketCount++;
                        });
                      },
                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Preferencia - ${preferencePrice} Bs'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (preferenceTicketCount > 0) preferenceTicketCount--;
                        });
                      },
                      icon: const Icon(Icons.remove_circle),
                    ),
                    Text('$preferenceTicketCount'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          preferenceTicketCount++;
                          showPreferenceInfo = true;  // Mostrar información para "Preferencia"
                        });
                      },
                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Escolar - ${schoolPrice} Bs'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (schoolTicketCount > 0) schoolTicketCount--;
                        });
                      },
                      icon: const Icon(Icons.remove_circle),
                    ),
                    Text('$schoolTicketCount'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          schoolTicketCount++;
                        });
                      },
                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                ),
              ],
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
                final totalTickets = generalTicketCount + preferenceTicketCount + schoolTicketCount;
                final totalAmount = (generalTicketCount * generalPrice) +
                                    (preferenceTicketCount * preferencePrice) +
                                    (schoolTicketCount * schoolPrice);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Compra confirmada para $totalTickets ticket(s):\n'
                      'Línea: ${widget.selectedLine}\n'
                      'Origen: ${widget.originStation}\n'
                      'Destino: ${widget.destinationStation}\n'
                      'Total: $totalAmount Bs.',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Confirmar Compra',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
