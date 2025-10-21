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


  late Animation<double> _logoScaleAnimation;

 
  late Animation<double> _appNameFadeAnimation;
  late Animation<Offset> _appNameSlideAnimation;


  late Animation<double> _developerFadeAnimation;

  @override
  void initState() {
    super.initState();


    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _appNameFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );
    _appNameSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), 
      end: Offset.zero, 
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _developerFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    Timer(const Duration(milliseconds: 4500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 600),
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
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1976D2); // Biru Gelap
    const Color backgroundColor = Color(0xFFE3F2FD); // Biru Muda Sangat Terang

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScaleTransition(
              scale: _logoScaleAnimation,
              child: Image.asset(
                'assets/app_logo.png',
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 24),

            SlideTransition(
              position: _appNameSlideAnimation,
              child: FadeTransition(
                opacity: _appNameFadeAnimation,
                child: const Text(
                  'WashApp',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 120),

            FadeTransition(
              opacity: _developerFadeAnimation,
              child: const Column(
                children: [
                  Text(
                    'Dibuat oleh:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF616161),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Mochammad Abid Sunaryo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
