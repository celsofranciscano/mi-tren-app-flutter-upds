import 'package:flutter/material.dart';

class GreenLineBar extends StatelessWidget {
  final int stationNumber;
  final bool isFirst;
  final bool isLast;

  const GreenLineBar({
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
          color: Colors.green,
        ),
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.green,
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
          color: Colors.green,
        ),
      ],
    );
  }
}
