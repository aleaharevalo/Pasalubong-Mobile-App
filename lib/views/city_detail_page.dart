import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/database_service.dart';
import '../models/delicacy_model.dart';
import 'delicacy_info_page.dart';

class CityDetailPage extends StatelessWidget {
  final String cityName;
  final DatabaseService _dbService = DatabaseService();

  CityDetailPage({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Matching Home Page Background
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          cityName.toUpperCase(),
          style: GoogleFonts.juliusSansOne(
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Delicacy>>(
        future: _dbService.fetchDelicaciesByCity(cityName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF4A4A4A)));
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No delicacies found yet!",
                style: GoogleFonts.montserrat(color: Colors.grey),
              ),
            );
          }

          final delicacies = snapshot.data!;

          return Column(
            children: [
              // Subtle Sub-header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "LOCAL SPECIALTIES",
                  style: GoogleFonts.juliusSansOne(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: delicacies.length,
                  itemBuilder: (context, index) {
                    final item = delicacies[index];
                    return _buildDelicacyCard(context, item);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDelicacyCard(BuildContext context, Delicacy item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DelicacyInfoPage(delicacy: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 110,
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8), // Soft off-white/gray
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            // Image "Frame"
            Hero(
              tag: item.name, // Smooth transition to info page
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(25)),
                child: Container(
                  width: 110,
                  height: double.infinity,
                  color: Colors.grey[200],
                  child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                      ? Image.network(item.imageUrl!, fit: BoxFit.cover)
                      : const Icon(Icons.restaurant, color: Colors.white, size: 30),
                ),
              ),
            ),
            // Details Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.name.toUpperCase(),
                      style: GoogleFonts.juliusSansOne(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey[500],
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.priceRange,
                      style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 0, 0, 0), // Mango Pulse as small accent
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFFE0E0E0), size: 14),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}