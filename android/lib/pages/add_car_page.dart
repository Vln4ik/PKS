import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/api_service.dart';

class AddCarPage extends StatefulWidget {
  final Function(Car) onCarAdded;

  const AddCarPage({super.key, required this.onCarAdded});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить машину')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Описание'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Цена'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'Ссылка на изображение'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final car = Car(
                  id: 0, // ID будет сгенерирован сервером
                  name: _nameController.text,
                  description: _descriptionController.text,
                  price: double.parse(_priceController.text),
                  imageUrl: _imageUrlController.text,
                );
                await _apiService.addCar(car);
                widget.onCarAdded(car);
                Navigator.pop(context, true);
              },
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
