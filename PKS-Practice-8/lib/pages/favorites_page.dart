import 'package:flutter/material.dart';
import '../models/car.dart';

class FavoritesPage extends StatelessWidget {
  final List<Car> favorites;
  final Function(Car) onFavoriteToggle;

  const FavoritesPage({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: favorites.isEmpty
          ? const Center(child: Text('Нет избранных машин.'))
          : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final car = favorites[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(car.imageUrl, height: 120, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    car.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => onFavoriteToggle(car),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
