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
  bool _isSubmitting = false; // Блокировка повторных нажатий

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
              onPressed: _isSubmitting
                  ? null
                  : () async {
                print('Кнопка нажата');
                setState(() {
                  _isSubmitting = true;
                });

                try {
                  final car = Car(
                    id: 0,
                    name: _nameController.text.trim(),
                    description: _descriptionController.text.trim(),
                    price: double.tryParse(_priceController.text) ?? 0.0,
                    imageUrl: _imageUrlController.text.trim().isNotEmpty
                        ? _imageUrlController.text.trim()
                        : 'https://via.placeholder.com/150',
                  );

                  print('Подготовка к добавлению машины: ${car.toJson()}');
                  await _apiService.addCar(car);
                  widget.onCarAdded(car);

                  Navigator.pop(context, true);
                } catch (e) {
                  print('Ошибка: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ошибка: ${e.toString()}')),
                  );
                } finally {
                  setState(() {
                    _isSubmitting = false;
                  });
                }
              },
              child: _isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
