import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/delicacy_model.dart';
import '../services/database_service.dart';

class DelicacyInfoPage extends StatelessWidget {
  final Delicacy delicacy;
  final DatabaseService _dbService = DatabaseService();

  DelicacyInfoPage({super.key, required this.delicacy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Pure white background
      appBar: AppBar(
        title: Text(
          delicacy.name.toUpperCase(),
          style: GoogleFonts.juliusSansOne(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. HERO IMAGE (The "Showcase" Frame)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: delicacy.imageUrl != null 
                    ? Image.network(
                        delicacy.imageUrl!, 
                        height: 300, 
                        width: double.infinity, 
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 250, 
                        color: const Color(0xFFF5F5F5), 
                        child: const Icon(Icons.restaurant, size: 80, color: Colors.white),
                      ),
                ),
              ),
            ),

            // 2. DESCRIPTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Text(
                delicacy.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: Colors.grey[700],
                  fontSize: 14,
                  height: 1.8,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 3. STORE LIST SECTION HEADER
            Text(
              "AVAILABLE AT",
              style: GoogleFonts.juliusSansOne(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                letterSpacing: 4,
                color: Colors.black,
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Thin decorative line
            Container(
              width: 40,
              height: 2,
              color: Color.fromARGB(255, 200, 80, 80), // Mango Pulse Accent
            ),

            const SizedBox(height: 20),

            // 4. STORES LIST
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _dbService.fetchStoresForDelicacy(delicacy.name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: CircularProgressIndicator(color: Color(0xFF4A4A4A)),
                  );
                }
                
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("No stores listed yet.", style: GoogleFonts.montserrat(color: Colors.grey)),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final store = snapshot.data![index];
                    return _buildStoreCard(store);
                  },
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreCard(Map<String, dynamic> store) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Light Gray frame
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (store['image_url'] != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
              child: Image.network(
                store['image_url'], 
                height: 180, 
                width: double.infinity, 
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store['store_name'].toString().toUpperCase(), 
                        style: GoogleFonts.juliusSansOne(
                          fontWeight: FontWeight.bold, 
                          fontSize: 16,
                          letterSpacing: 1.2,
                        )
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "PRICE RANGE: ${store['price_info']}", 
                        style: GoogleFonts.montserrat(
                          color: Colors.grey[600], 
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )
                      ),
                    ],
                  ),
                ),
                // GO TO STORE BUTTON
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                      )
                    ]
                  ),
                  child: const Icon(Icons.near_me, color: Color.fromARGB(255, 200, 80, 80), size: 20),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}