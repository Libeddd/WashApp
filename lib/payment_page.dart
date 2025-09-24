import 'package:flutter/material.dart';
import 'dart:async';
import 'models/vehicle.dart';
import 'login_page.dart';

class PaymentPage extends StatefulWidget {
  final Vehicle vehicle;
  final String packageName;
  final String packagePrice;

  const PaymentPage({
    super.key,
    required this.vehicle,
    required this.packageName,
    required this.packagePrice,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  bool _isProcessingPayment = false;
  bool _paymentSuccess = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 0.8, end: 1.2).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _processPayment() async {
    setState(() {
      _isProcessingPayment = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isProcessingPayment = false;
      _paymentSuccess = true;
    });

    Timer(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _paymentSuccess
              ? _buildWashCompleteScreen(context)
              : _buildPaymentForm(context),
        ),
      ),
    );
  }

  Widget _buildPaymentForm(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Detail Pesanan Pencucian",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            _buildDetailRow("Jenis Kendaraan:", widget.vehicle.type),
            _buildDetailRow("Plat Nomor:", widget.vehicle.licensePlate),
            _buildDetailRow("Paket Dipilih:", widget.packageName),
            _buildDetailRow("Harga Paket:", widget.packagePrice),
            const SizedBox(height: 24),
            _isProcessingPayment
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _processPayment,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Bayar Sekarang"),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildWashCompleteScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: _animation,
          child: Icon(
            Icons.check_circle_outline,
            color: Theme.of(context).primaryColor,
            size: 120,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Kendaraan Anda Telah Selesai Dicuci!",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorDark,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          "Terima kasih telah menggunakan layanan kami.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 30),
        const CircularProgressIndicator(),
        const SizedBox(height: 10),
        const Text("Mengalihkan ke halaman login..."),
      ],
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
}
