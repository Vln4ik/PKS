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
      home: const MainPage(),
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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Car> favorites = [];
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      CarGridPage(onFavoriteToggle: _toggleFavorite, favorites: favorites),
      FavoritesPage(favorites: favorites, onFavoriteToggle: _toggleFavorite),
      const ProfilePage(),
    ]);
  }

  void _toggleFavorite(Car car) {
    setState(() {
      if (favorites.contains(car)) {
        favorites.remove(car);
      } else {
        favorites.add(car);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCarPage(onCarAdded: (newCar) {
                setState(() {
                  cars.add(newCar);
                });
              }),
            ),
          );
        },
        child: const Icon(Icons.add),
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Машины'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Избранное'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}

class CarGridPage extends StatelessWidget {
  final Function(Car) onFavoriteToggle;
  final List<Car> favorites;

  const CarGridPage({
    super.key,
    required this.onFavoriteToggle,
    required this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Машины')),
      body: GridView.builder(
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CarDetailsPage(
                    car: car,
                    onCarDeleted: () {
                      cars.removeAt(index);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(car.image, height: 120, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(car.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('\$${car.price}', style: const TextStyle(color: Colors.green)),
                  ),
                  IconButton(
                    icon: Icon(
                      favorites.contains(car) ? Icons.favorite : Icons.favorite_border,
                      color: favorites.contains(car) ? Colors.red : null,
                    ),
                    onPressed: () => onFavoriteToggle(car),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddCarPage extends StatefulWidget {
  final Function(Car) onCarAdded;

  const AddCarPage({super.key, required this.onCarAdded});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String imageUrl = '';
  String description = '';
  int price = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить машину')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Название'),
                onSaved: (value) => name = value!,
                validator: (value) => value!.isEmpty ? 'Введите название' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ссылка на изображение'),
                onSaved: (value) => imageUrl = value!,
                validator: (value) => value!.isEmpty ? 'Введите ссылку на изображение' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Описание'),
                onSaved: (value) => description = value!,
                validator: (value) => value!.isEmpty ? 'Введите описание' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
                onSaved: (value) => price = int.parse(value!),
                validator: (value) => value!.isEmpty ? 'Введите цену' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.onCarAdded(Car(
                      name: name,
                      price: price,
                      image: imageUrl,
                      description: description,
                    ));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Добавить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarDetailsPage extends StatelessWidget {
  final Car car;
  final VoidCallback onCarDeleted;

  const CarDetailsPage({super.key, required this.car, required this.onCarDeleted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(car.image),
            const SizedBox(height: 10),
            Text(car.description, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            ElevatedButton(
              onPressed: onCarDeleted,
              child: const Text('Удалить'),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<Car> favorites;
  final Function(Car) onFavoriteToggle;

  const FavoritesPage({super.key, required this.favorites, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: GridView.builder(
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
                Image.network(car.image, height: 120, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(car.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('ФИО: Иван Иванов'),
            Text('Группа: IT-21'),
            Text('Номер телефона: +7 123 456 7890'),
            Text('Почта: ivan.ivanov@example.com'),
          ],
        ),
      ),
    );
  }
}
