import 'package:flutter/material.dart';

class RedLineBar extends StatelessWidget {
  final int stationNumber;
  final bool isFirst;
  final bool isLast;

  const RedLineBar({
    required this.stationNumber,
    this.isFirst = false,
    this.isLast = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Línea superior
        Container(
          width: 2,
          height: isFirst ? 30 : 60,
          color: Colors.red, // Sin sombra
        ),
        // Círculo con el número de estación
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$stationNumber',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        // Línea inferior
        Container(
          width: 2,
          height: isLast ? 30 : 60,
          color: Colors.red, // Sin sombra
        ),
      ],
    );
  }
}
