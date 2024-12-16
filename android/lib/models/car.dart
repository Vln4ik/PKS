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
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Неизвестно',
      description: json['description'] ?? 'Описание отсутствует',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? 'https://example.com/default_image.png',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
  };
}
