import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'models/vehicle.dart';
import 'models/car.dart';
import 'models/motorcycle.dart';
import 'payment_page.dart';

class CustomerHomePage extends StatelessWidget {
  final Vehicle customerVehicle;

  const CustomerHomePage({super.key, required this.customerVehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Paket Pencucian"),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVehicleInfoCard(context),
            const SizedBox(height: 24),
            Text(
              "Pilih Paket Pencucian untuk ${customerVehicle.type}:",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark,
                  ),
            ),
            const SizedBox(height: 16),
            _buildWashPackageCard(
              context,
              'Paket Biasa',
              'Pencucian standar, bersih luar dalam.',
              'Rp 30.000',
              Icons.local_car_wash,
              Theme.of(context).colorScheme.primary,
              () {
                _showPackageDetail(
                  context,
                  'Paket Biasa',
                  'Pencucian standar, bersih luar dalam. Termasuk cuci bodi, vakum interior, dan pembersihan kaca.',
                  'Rp 30.000',
                );
              },
            ),
            const SizedBox(height: 16),
            _buildWashPackageCard(
              context,
              'Paket Cepat',
              'Pencucian cepat, cocok untuk yang terburu-buru.',
              'Rp 45.000',
              Icons.speed,
              Theme.of(context).colorScheme.secondary,
              () {
                _showPackageDetail(
                  context,
                  'Paket Cepat',
                  'Pencucian cepat dengan fokus pada kebersihan eksterior dan interior dasar. Ideal untuk waktu terbatas.',
                  'Rp 45.000',
                );
              },
            ),
            const SizedBox(height: 16),
            _buildWashPackageCard(
              context,
              'Paket Premium',
              'Pencucian menyeluruh dengan wax dan poles.',
              'Rp 75.000',
              Icons.star,
              Colors.orange.shade700,
              () {
                _showPackageDetail(
                  context,
                  'Paket Premium',
                  'Pencucian lengkap dengan detailing interior, wax premium, dan poles bodi untuk kilau maksimal.',
                  'Rp 75.000',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleInfoCard(BuildContext context) {
    return GFCard(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      elevation: 6,
      title: GFListTile(
        titleText: "Informasi Kendaraan Anda",
        subTitleText: "",
        icon: const Icon(Icons.directions_car),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(context, "Nama Pemilik:", customerVehicle.ownerName),
          _buildInfoRow(context, "Plat Nomor:", customerVehicle.licensePlate),
          _buildInfoRow(context, "Jenis Kendaraan:", customerVehicle.type),
          _buildInfoRow(context, "Warna:", customerVehicle.color),
          if (customerVehicle is Car)
            _buildInfoRow(context, "Jumlah Pintu:",
                (customerVehicle as Car).numberOfDoors.toString()),
          if (customerVehicle is Motorcycle)
            _buildInfoRow(context, "Ada Sespan:",
                (customerVehicle as Motorcycle).hasSidecar ? "Ya" : "Tidak"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  // ✅ GFCard untuk pilihan paket
  Widget _buildWashPackageCard(
    BuildContext context,
    String title,
    String description,
    String price,
    IconData icon,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return GFCard(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(16),
      elevation: 6,
      color: Theme.of(context).cardColor,
      title: GFListTile(
        avatar: Icon(icon, size: 40, color: iconColor),
        titleText: title,
        subTitleText: description,
        icon: Icon(Icons.arrow_forward_ios,
            color: Colors.grey.shade400, size: 20),
        onTap: onTap,
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              price,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            GFButton(
              onPressed: onTap,
              size: GFSize.MEDIUM,
              color: Theme.of(context).primaryColor,
              text: "Pilih Paket",
              icon: const Icon(Icons.check_circle_outline,
                  color: Colors.white, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Dialog detail paket
  void _showPackageDetail(
      BuildContext context, String title, String fullDescription, String price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(fullDescription,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 16),
              Text(
                "Harga: $price",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Pilih Paket Ini'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      vehicle: customerVehicle,
                      packageName: title,
                      packagePrice: price,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
