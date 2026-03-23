import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light gray background
      body: Stack(
        children: [
          // 1. THE TOPOGRAPHIC/MAP BACKGROUND
          // This fills the whole screen behind the text
          Positioned.fill(
            child: Opacity(
              opacity: 0.15, // Makes it subtle like your reference
              child: Image.asset(
                'assets/philippines_map_white.png', 
                fit: BoxFit.cover, 
              ),
            ),
          ),

          // 2. THE CONTENT LAYER
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "PASALUBONG",
                      style: GoogleFonts.juliusSansOne(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 8,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "/,päsə'lōōbäNG/",
                      style: GoogleFonts.jura(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Filipino word for a gift or souvenir given to a friend or relative by a person who has returned from a trip or arrived for a visit.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.jura(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // 3. THE "GET STARTED" BUTTON
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50), // Fully pill-shaped
                        ),
                        child: Text(
                          "GET STARTED",
                          style: GoogleFonts.juliusSansOne(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}