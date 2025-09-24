import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'customer_form.dart';
import 'customer_home_page.dart';
import 'detail_page.dart';
import 'payment_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/vehicle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final MaterialColor primaryColor = const MaterialColor(
    0xFF0A4174,
    <int, Color>{
      50: Color(0xFFE5EBF1),
      100: Color(0xFFBFCAD8),
      200: Color(0xFF94A9BE),
      300: Color(0xFF6B87A6),
      400: Color(0xFF476D92),
      500: Color(0xFF23557F),
      600: Color(0xFF0A4174),
      700: Color(0xFF083762),
      800: Color(0xFF052D50),
      900: Color(0xFF02213D),
    },
  );

  final Color darkBlue = const Color(0xFF001D39);
  final Color lightBlue = const Color(0xFFBDD8E9);
  final Color accentBlue = const Color(0xFF4E8EA2);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Pencucian Mobil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primaryColor,
          backgroundColor: lightBlue,
        ).copyWith(
          secondary: accentBlue,
          surface: Colors.white,
          onSurface: darkBlue,
          primary: primaryColor,
          onPrimary: Colors.white,
        ),
        scaffoldBackgroundColor: lightBlue,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: BorderSide(color: primaryColor, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          labelStyle: GoogleFonts.poppins(color: primaryColor),
          hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/adminHome': (context) => const HomePage(),
        '/customerForm': (context) => const CustomerFormPage(),
      },
    );
  }
}
