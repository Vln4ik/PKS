import 'package:flutter/material.dart';
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
  String name = 'Харабрин Кирилл';
  String group = 'ЭФБО-03-22';
  String phone = '+7 987 59 99 999';
  String email = 'zaglushka@mail.com';
  String profileImage = 'https://i.pinimg.com/236x/7d/6a/c3/7d6ac3c03c9af3c39b41e1d82403b30f.jpg';

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CarGridPage(
        onFavoriteToggle: _toggleFavorite,
        onAddToCart: _addToCart,
        favorites: favorites,
        onCarTap: _navigateToCarDetails,
      ),
      FavoritesPage(favorites: favorites, onFavoriteToggle: _toggleFavorite),
      CartPage(cart: cart, onRemoveFromCart: _removeFromCart, onUpdateQuantity: _updateCartQuantity),
      ProfilePage(
        name: name,
        group: group,
        phone: phone,
        email: email,
        profileImage: profileImage,
        onProfileSave: _updateProfile,
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
        backgroundColor: Colors.green[800],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Машины'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Избранное'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Корзина'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
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

  void _navigateToCarDetails(Car car) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarDetailsPage(
          car: car,
          onAddToCart: _addToCart,
          onDeleteCar: (carToDelete) {
            setState(() {
              cars.remove(carToDelete);
            });
          },
        ),
      ),
    );
  }

  void _addNewCar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCarPage(
          onCarAdded: (newCar) {
            setState(() {
              cars.add(newCar);
            });
          },
        ),
      ),
    );
  }

  void _updateProfile(String newName, String newGroup, String newPhone, String newEmail, String newImage) {
    setState(() {
      name = newName;
      group = newGroup;
      phone = newPhone;
      email = newEmail;
      profileImage = newImage;
    });
  }
}
