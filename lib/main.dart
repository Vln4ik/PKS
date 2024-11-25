import 'package:flutter/material.dart';

void main() {
  runApp(const CarSalesApp());
}

class CarSalesApp extends StatelessWidget {
  const CarSalesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Sales',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CarListPage(),
    );
  }
}

class Car {
  final String name;
  final int price;
  final String image;
  final String description;

  Car({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });
}

// List of cars (initial data)
List<Car> cars = [
  Car(
    name: 'BMW X5',
    price: 65000,
    image: 'https://i.pinimg.com/236x/e0/da/a6/e0daa637768e1451dbc34109a9a5fc2c.jpg',
    description:
    'Здесь могло быть ваше описание БМВ',
  ),
  Car(
    name: 'Audi Q7',
    price: 72000,
    image: 'https://i.pinimg.com/236x/48/02/68/480268e6ba635f568a928182d32b4ba7.jpg',
    description:
    'Здесь могло быть ваше описание ауди',
  ),
  Car(
    name: 'Tesla Model 3',
    price: 55000,
    image: 'https://i.pinimg.com/236x/70/47/85/704785b540d975eb91e1d5ddadd990d9.jpg',
    description:
    'Здесь могло быть ваше описание теслы',
  ),
  Car(
    name: 'Mercedes-Benz C-Class',
    price: 58000,
    image: 'https://i.pinimg.com/236x/dd/11/92/dd119233d54067bfecb592cde3746ba6.jpg',
    description:
    'Здесь могло быть ваше описание мерседеса',
  ),
  Car(
    name: 'Ford Mustang',
    price: 45000,
    image: 'https://i.pinimg.com/236x/0a/94/59/0a945982ba6ab00e616bbf74b01c731f.jpg',
    description:
    'Здесь могло быть ваше описание мустанга',
  ),
];

class CarListPage extends StatefulWidget {
  const CarListPage({super.key});

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  // Function to remove a car with confirmation
  void _removeCar(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Подтвердить удаление'),
        content: const Text('Вы точно уверены, что хотите удалить эту машину?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: const Text('Отменить'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                cars.removeAt(index);
              });
              Navigator.pop(context); // Close dialog
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  // Navigate to AddCarPage
  void _navigateToAddCarPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddCarPage(),
      ),
    ).then((newCar) {
      if (newCar != null && newCar is Car) {
        setState(() {
          cars.add(newCar);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Машины на продажу'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddCarPage,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.network(car.image, width: 80, fit: BoxFit.cover),
              title: Text(car.name),
              subtitle: Text('\$${car.price}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailPage(car: car),
                  ),
                );
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeCar(index),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CarDetailPage extends StatelessWidget {
  final Car car;

  const CarDetailPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(car.image, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              car.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${car.price}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              car.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _addCar() {
    final name = _nameController.text;
    final price = int.tryParse(_priceController.text) ?? 0;
    final image = _imageController.text;
    final description = _descriptionController.text;

    if (name.isNotEmpty && price > 0 && image.isNotEmpty && description.isNotEmpty) {
      final newCar = Car(
        name: name,
        price: price,
        image: image,
        description: description,
      );
      Navigator.pop(context, newCar); // Return the new car
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить новую машину'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Имя машины'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Цена'),
            ),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'Ссылка на фото'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Описание'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addCar,
              child: const Text('Добавить машину'),
            ),
          ],
        ),
      ),
    );
  }
}
