import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/database_service.dart';
import 'city_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _dbService = DatabaseService();

  // Logic to fetch city details when a MAP PIN is tapped
  void _handlePinTap(BuildContext context, String cityName) async {
    final cityData = await _dbService.fetchCityByName(cityName);
    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 420,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cityName.toUpperCase(),
                style: GoogleFonts.juliusSansOne(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                cityData?.description ?? "Discover the local flavors and heritage of this destination.",
                style: GoogleFonts.montserrat(fontSize: 14, height: 1.6, color: Colors.black87),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CityDetailPage(cityName: cityName)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Color.fromARGB(255, 200, 80, 80), // Mango Pulse
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    "VIEW DELICACIES",
                    style: GoogleFonts.juliusSansOne(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "PASALUBONG",
          style: GoogleFonts.juliusSansOne(fontWeight: FontWeight.bold, letterSpacing: 4),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      // SingleChildScrollView allows the user to scroll down to the regions
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- SECTION 1: TALL DARK MAP CARD ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 550, // Much longer map card for better visual impact
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF4A4A4A),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.asset(
                          'assets/negros_map.png', 
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    
                    // Pins - Positioned relative to the tall container
                    Positioned(
                      top: 130,
                      left: MediaQuery.of(context).size.width * 0.35,
                      child: _buildMapPin("Bacolod"),
                    ),
                    Positioned(
                      top: 85,
                      left: MediaQuery.of(context).size.width * 0.40,
                      child: _buildMapPin("Silay"),
                    ),
                    Positioned(
                      bottom: 120,
                      right: MediaQuery.of(context).size.width * 0.30,
                      child: _buildMapPin("Dumaguete"),
                    ),

                    Positioned(
                      bottom: 25,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          "Negros Island Region",
                          style: GoogleFonts.juliusSansOne(color: Colors.white70, fontSize: 16, letterSpacing: 1.2),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- SECTION 2: CENTERED HEADER ---
            Text(
              "THE NIR REGION",
              style: GoogleFonts.juliusSansOne(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                letterSpacing: 2
              ),
            ),

            const SizedBox(height: 20),

            // --- SECTION 3: WIDE PROVINCE CARDS ---
            SizedBox(
              height: 300, // Taller for the wide aspect ratio
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildProvinceCard("Negros Occidental", "assets/occidental.jpg"),
                  _buildProvinceCard("Negros Oriental", "assets/oriental.jpg"),
                  _buildProvinceCard("Siquijor", "assets/siquijor.jpg"),
                ],
              ),
            ),

            // --- SECTION 4: FULL DESCRIPTION ---
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 30, 35, 50),
              child: Text(
                "The Negros Island Region (NIR), established as an administrative region in the Philippines by Republic Act No. 12000 in 2024, comprises the provinces of Negros Occidental, Negros Oriental, and Siquijor. It aims to accelerate social and economic development by consolidating administration and regional services.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 13, 
                  color: Colors.grey[700], 
                  height: 1.8,
                  fontStyle: FontStyle.italic
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapPin(String name) {
    return GestureDetector(
      onTap: () => _handlePinTap(context, name),
      child: Column(
        children: [
          const Icon(Icons.location_on, color: Color.fromARGB(255, 200, 80, 80), size: 44),
          Text(
            name,
            style: GoogleFonts.juliusSansOne(
              color: Colors.white, 
              fontSize: 11, 
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProvinceCard(String title, String imagePath) {
    return Container(
      width: 320, // Wide cinematic frame
      margin: const EdgeInsets.only(right: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFC4C2BA), // Beige-Gray from your reference
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              child: Container(
                width: double.infinity,
                color: Colors.grey[400],
                // child: Image.asset(imagePath, fit: BoxFit.cover),
                child: const Icon(Icons.image, color: Colors.white, size: 50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              title.toUpperCase(),
              style: GoogleFonts.juliusSansOne(
                fontWeight: FontWeight.bold, 
                fontSize: 13,
                letterSpacing: 1.5
              ),
            ),
          ),
        ],
      ),
    );
  }
}