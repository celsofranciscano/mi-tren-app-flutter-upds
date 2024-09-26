import 'package:flutter/material.dart';

class StationButton extends StatelessWidget {
  final String stationName;
  final String stationAddress;
  final List<IconData> icons;
  final VoidCallback onTap;
  final int stationNumber;  // Asegúrate de que este parámetro esté definido

  const StationButton({
    required this.stationName,
    required this.stationAddress,
    required this.icons,
    required this.onTap,
    required this.stationNumber,  // Asegúrate de que este parámetro esté aquí
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Text(
            '$stationNumber',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          title: Text(stationName),
          subtitle: Text(stationAddress),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: icons.map((icon) => Icon(icon)).toList(),
          ),
        ),
      ),
    );
  }
}
