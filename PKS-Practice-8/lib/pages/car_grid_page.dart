import 'package:flutter/material.dart';
import '../models/car.dart';

class CarGridPage extends StatelessWidget {
  final Function(Car) onFavoriteToggle;
  final Function(Car) onAddToCart;
  final Function(Car) onCarTap;
  final List<Car> favorites;
  final List<Car> cars;

  const CarGridPage({
    super.key,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.onCarTap,
    required this.favorites,
    required this.cars,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: cars.length,
      itemBuilder: (context, index) {
        final car = cars[index];
        return GestureDetector(
          onTap: () => onCarTap(car),
          child: Card(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '\$${car.price}',
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        favorites.contains(car) ? Icons.favorite : Icons.favorite_border,
                        color: favorites.contains(car) ? Colors.red : null,
                      ),
                      onPressed: () => onFavoriteToggle(car),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () => onAddToCart(car),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
