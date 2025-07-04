import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/hotel_details_screen.dart';

void main() {
  runApp(const HotelBookingApp());
}

class HotelBookingApp extends StatelessWidget {
  const HotelBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Booking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00C569),
          primary: const Color(0xFF00C569),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const HotelDetailsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


