import 'package:flutter/material.dart';
import '../models/car.dart';

class CarDetailsPage extends StatelessWidget {
  final Car car;
  final Function(Car) onDeleteCar;

  const CarDetailsPage({super.key, required this.car, required this.onDeleteCar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(car.imageUrl, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(car.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(car.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Цена: \$${car.price}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onDeleteCar(car);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Удалить машину'),
            ),
          ],
        ),
      ),
    );
  }
}
