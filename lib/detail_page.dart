import 'package:flutter/material.dart';
import 'models/vehicle.dart';
import 'models/car.dart';
import 'models/motorcycle.dart';

import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final Vehicle vehicle;

  const DetailPage({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail ${vehicle.type}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.1),
                    child: _getVehicleIcon(vehicle.type, size: 60),
                  ),
                ),
                const SizedBox(height: 20),
                _buildDetailRow("ID Kendaraan:", vehicle.id),
                _buildDetailRow("Nama Pemilik:", vehicle.ownerName),
                _buildDetailRow("Plat Nomor:", vehicle.licensePlate),
                _buildDetailRow("Jenis Kendaraan:", vehicle.type),
                _buildDetailRow("Warna:", vehicle.color),
                _buildDetailRow(
                  "Terakhir Dicuci:",
                  DateFormat('dd MMMM yyyy').format(vehicle.lastWashDate),
                ),
                if (vehicle is Car)
                  _buildDetailRow("Jumlah Pintu:",
                      (vehicle as Car).numberOfDoors.toString()),
                if (vehicle is Motorcycle)
                  _buildDetailRow("Ada Sespan:",
                      (vehicle as Motorcycle).hasSidecar ? "Ya" : "Tidak"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Icon _getVehicleIcon(String type, {double size = 40}) {
    switch (type) {
      case 'Car':
        return Icon(Icons.directions_car, color: Colors.blue, size: size);
      case 'Motorcycle':
        return Icon(Icons.two_wheeler, color: Colors.green, size: size);

      default:
        return Icon(Icons.help_outline, color: Colors.grey, size: size);
    }
  }
}
