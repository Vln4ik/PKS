import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/car.dart';
import 'car_grid_page.dart';
import 'favorites_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import 'car_details_page.dart';
import 'add_car_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Car> favorites = [];
  final Map<Car, int> cart = {};
  late Future<List<Car>> cars;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  Future<void> _loadCars() async {
    setState(() {
      cars = _apiService.fetchCars();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      FutureBuilder<List<Car>>(
        future: cars,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет машин.'));
          } else {
            return CarGridPage(
              onFavoriteToggle: _toggleFavorite,
              onAddToCart: _addToCart,
              favorites: favorites,
              onCarTap: _navigateToCarDetails,
              cars: snapshot.data!,
            );
          }
        },
      ),
      FavoritesPage(favorites: favorites, onFavoriteToggle: _toggleFavorite),
      CartPage(cart: cart, onRemoveFromCart: _removeFromCart, onUpdateQuantity: _updateCartQuantity),
      ProfilePage(
        initialName: 'Иван Иванов',
        initialEmail: 'ivan@example.com',
        initialPhone: '+7 900 123 4567',
        initialImage: 'https://example.com/default_image.png',
      ),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
        onPressed: _addNewCar,
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
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Корзина'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }

  void _addNewCar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCarPage(
          onCarAdded: (newCar) async {
            await _apiService.addCar(newCar);
            _loadCars(); // Обновляем список машин
          },
        ),
      ),
    );
  }

  void _navigateToCarDetails(Car car) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarDetailsPage(
          car: car,
          onDeleteCar: (deletedCar) async {
            await _apiService.deleteCar(deletedCar.id);
            _loadCars(); // Обновляем список машин
          },
        ),
      ),
    );
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

  void _addToCart(Car car) {
    setState(() {
      if (cart.containsKey(car)) {
        cart[car] = cart[car]! + 1;
      } else {
        cart[car] = 1;
      }
    });
  }

  void _removeFromCart(Car car) {
    setState(() {
      cart.remove(car);
    });
  }

  void _updateCartQuantity(Car car, int quantity) {
    setState(() {
      if (quantity > 0) {
        cart[car] = quantity;
      } else {
        cart.remove(car);
      }
    });
  }
}
