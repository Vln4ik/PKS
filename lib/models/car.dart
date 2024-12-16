class Car {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Car({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Нет названия',
      description: json['description'] as String? ?? 'Нет описания',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: (json['imageUrl'] as String?)?.isNotEmpty == true
          ? json['imageUrl']
          : 'https://via.placeholder.com/150', // Плейсхолдер изображения
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
