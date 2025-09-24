import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/car.dart';
import 'models/motorcycle.dart';
import 'models/vehicle.dart';
import 'customer_home_page.dart';

class CustomerFormPage extends StatefulWidget {
  const CustomerFormPage({super.key});

  @override
  State<CustomerFormPage> createState() => _CustomerFormPageState();
}

class _CustomerFormPageState extends State<CustomerFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _ownerName = '';
  String _licensePlate = '';
  String _color = '';
  String _vehicleType = 'Car';
  int _numberOfDoors = 4;
  bool _hasSidecar = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Vehicle newVehicle;
      String newId = 'CUST-${DateTime.now().millisecondsSinceEpoch}';
      DateTime now = DateTime.now();

      if (_vehicleType == 'Car') {
        newVehicle = Car(
          id: newId,
          ownerName: _ownerName,
          licensePlate: _licensePlate,
          color: _color,
          lastWashDate: now,
          numberOfDoors: _numberOfDoors,
        );
      } else {
        newVehicle = Motorcycle(
          id: newId,
          ownerName: _ownerName,
          licensePlate: _licensePlate,
          color: _color,
          lastWashDate: now,
          hasSidecar: _hasSidecar,
        );
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerHomePage(customerVehicle: newVehicle),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Kendaraan Anda"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nama Pemilik',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama pemilik tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _ownerName = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Plat Nomor',
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Plat nomor tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _licensePlate = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Warna Kendaraan',
                  prefixIcon: Icon(Icons.color_lens_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Warna kendaraan tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _color = value!;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Jenis Kendaraan',
                  prefixIcon: Icon(Icons.directions_car_filled),
                ),
                value: _vehicleType,
                items: const [
                  DropdownMenuItem(value: 'Car', child: Text('Mobil')),
                  DropdownMenuItem(value: 'Motorcycle', child: Text('Motor')),
                ],
                onChanged: (value) {
                  setState(() {
                    _vehicleType = value!;
                  });
                },
                onSaved: (value) {
                  _vehicleType = value!;
                },
              ),
              const SizedBox(height: 16),
              if (_vehicleType == 'Car')
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Pintu',
                    prefixIcon: Icon(Icons.meeting_room_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: _numberOfDoors.toString(),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null) {
                      return 'Jumlah pintu harus angka';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _numberOfDoors = int.parse(value!);
                  },
                ),
              if (_vehicleType == 'Motorcycle')
                SwitchListTile(
                  title: const Text('Ada Sespan?'),
                  value: _hasSidecar,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (value) {
                    setState(() {
                      _hasSidecar = value;
                    });
                  },
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Lanjutkan ke Pencucian'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}