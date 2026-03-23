import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/database_service.dart';
import '../widgets/main_layout.dart'; 
import 'city_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _dbService = DatabaseService();

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
                    backgroundColor: const Color.fromARGB(255, 200, 80, 80), 
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
    return MainLayout(
      showBackButton: false, 
      title: "PASALUBONG",
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- SECTION 1: TALL DARK MAP CARD ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 550, 
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Stack(
                  children: [
                    // NIR Region Header now INSIDE the dark card
                    Positioned(
                      top: 30,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          "THE NIR REGION",
                          style: GoogleFonts.juliusSansOne(
                            fontSize: 20, 
                            fontWeight: FontWeight.bold, 
                            letterSpacing: 2,
                            color: Colors.white, // Changed to white
                          ),
                        ),
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.asset(
                          'assets/negros_map.png', 
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    
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

            const SizedBox(height: 10),

            // Province Header
            Text(
              "PROVINCES",
              style: GoogleFonts.juliusSansOne(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                letterSpacing: 2,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 300, 
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildProvinceCard("Negros Occidental", "assets/occidental.png"),
                  _buildProvinceCard("Negros Oriental", "assets/oriental.png"),
                  _buildProvinceCard("Siquijor", "assets/siquijor.png"),
                ],
              ),
            ),
            const SizedBox(height: 100), // Space for floating nav bar
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
      width: 320, 
      margin: const EdgeInsets.only(right: 18),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0), // Black card
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              title.toUpperCase(),
              style: GoogleFonts.juliusSansOne(
                fontWeight: FontWeight.bold, 
                fontSize: 13,
                letterSpacing: 1.5,
                color: Colors.white, // Changed to white for visibility
              ),
            ),
          ),
        ],
      ),
    );
  }
}