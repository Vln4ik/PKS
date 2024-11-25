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
      title: 'Продажа машин',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CarListPage(),
    );
  }
}

// List of cars
final List<Car> cars = [
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

// Home page
class CarListPage extends StatelessWidget {
  const CarListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Машины на продажу'),
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
            ),
          );
        },
      ),
    );
  }
}

// Detail page
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
