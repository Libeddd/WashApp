import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'models/vehicle.dart';
import 'models/car.dart';
import 'models/motorcycle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Vehicle> _vehicles = [
    Car(
      id: 'V001',
      ownerName: 'Budi Santoso',
      licensePlate: 'B 1234 ABC',
      color: 'Merah',
      lastWashDate: DateTime(2023, 10, 20),
      numberOfDoors: 4,
    ),
    Motorcycle(
      id: 'V002',
      ownerName: 'Siti Aminah',
      licensePlate: 'D 5678 EF',
      color: 'Hitam',
      lastWashDate: DateTime(2023, 10, 22),
      hasSidecar: false,
    ),
    Car(
      id: 'V004',
      ownerName: 'Dewi Lestari',
      licensePlate: 'A 3456 IJ',
      color: 'Putih',
      lastWashDate: DateTime(2023, 10, 25),
      numberOfDoors: 2,
    ),
    Motorcycle(
      id: 'V005',
      ownerName: 'Agus Salim',
      licensePlate: 'F 7890 KL',
      color: 'Hijau',
      lastWashDate: DateTime(2023, 10, 21),
      hasSidecar: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Kendaraan (Admin)"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        itemCount: _vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = _vehicles[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: _getVehicleIcon(vehicle.type),
              ),
              title: Text(
                vehicle.ownerName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                '${vehicle.licensePlate} - ${vehicle.type}',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(vehicle: vehicle),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Tambah data customer belum diimplementasikan")),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Icon _getVehicleIcon(String type) {
    switch (type) {
      case 'Car':
        return const Icon(Icons.directions_car, color: Colors.blue);
      case 'Motorcycle':
        return const Icon(Icons.two_wheeler, color: Colors.green);
      default:
        return const Icon(Icons.help_outline, color: Colors.grey);
    }
  }
}