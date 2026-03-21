class Delicacy {
  final String name;
  final String description;
  final String priceRange;
  final String? imageUrl;

  Delicacy({
    required this.name, 
    required this.description, 
    required this.priceRange, 
    this.imageUrl
  });

  factory Delicacy.fromMap(Map<String, dynamic> map) {
    return Delicacy(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      priceRange: map['price_range'] ?? '',
      imageUrl: map['image_url'],
    );
  }
}