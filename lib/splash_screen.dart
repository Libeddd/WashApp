import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Mengatur controller untuk animasi fade-in yang perlahan
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Mengatur animasi dari 0.0 (transparan) ke 1.0 (penuh)
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Memulai animasi fade-in
    _controller.forward();

    // Menunggu 3 detik sebelum navigasi, memberikan waktu untuk fade-in
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        // Menggunakan PageRouteBuilder untuk transisi memudar yang halus
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginPage(),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = const Color(0xFFBDD8E9);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'assets/splash_logo.png',
            width: 180,
            height: 180,
          ),
        ),
      ),
    );
  }
}
