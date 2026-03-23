import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final String title;
  final bool showBackButton;

  const MainLayout({
    super.key,
    required this.body,
    this.title = "PASALUBONG",
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true, // This allows the body to flow behind the floating nav bar
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.juliusSansOne(
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: showBackButton 
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color:Color.fromARGB(255, 200, 80, 80), size: 20),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      ),
      body: body,
      
      // --- THE FLOATING PILL NAVIGATION BAR ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 30), // L, T, R, B (Floating effect)
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 0, 0), // The warm yellow/mango color from your pic
            borderRadius: BorderRadius.circular(40), // Perfect pill shape
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.location_on, true), // Map/Home Active
              _buildNavItem(Icons.pie_chart_outline, false),
              _buildNavItem(Icons.home_outlined, false),
              _buildNavItem(Icons.trending_up, false),
              _buildNavItem(Icons.person_outline, false),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build the individual icons
  Widget _buildNavItem(IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // If active, we give it a subtle dark circle like the first icon in your pic
        color: isActive ? Colors.black.withOpacity(0.1) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: isActive ? Color.fromARGB(255, 255, 255, 255) :Color.fromARGB(255, 255, 255, 255).withOpacity(0.6),
        size: 26,
      ),
    );
  }
}