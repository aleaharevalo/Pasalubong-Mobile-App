class City {
  final String name;
  final String description;
  final String imageUrl; // Add this

  City({required this.name, required this.description, required this.imageUrl});

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['image_url'] ?? '', // Match your SQL column name
    );
  }
}