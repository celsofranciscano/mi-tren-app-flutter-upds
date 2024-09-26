import 'package:flutter/material.dart';

class YellowLineBar extends StatelessWidget {
  final int stationNumber;
  final bool isFirst;
  final bool isLast;

  const YellowLineBar({
    required this.stationNumber,
    this.isFirst = false,
    this.isLast = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 2,
          height: isFirst ? 30 : 60,
          color: Colors.yellow[700], // Color amarillo para la línea
        ),
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.yellow[700], // Color del círculo amarillo
            shape: BoxShape.circle,
          ),
          child: Text(
            '$stationNumber',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          width: 2,
          height: isLast ? 30 : 60,
          color: Colors.yellow[700], // Color amarillo para la línea
        ),
      ],
    );
  }
}
