import 'package:flutter/material.dart';
import '../models/car.dart';

class CartPage extends StatelessWidget {
  final Map<Car, int> cart;
  final Function(Car) onRemoveFromCart;
  final Function(Car, int) onUpdateQuantity;

  const CartPage({
    super.key,
    required this.cart,
    required this.onRemoveFromCart,
    required this.onUpdateQuantity,
  });

  @override
  Widget build(BuildContext context) {
    int total = cart.entries.fold(0, (sum, entry) => sum + (entry.key.price * entry.value));

    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final car = cart.keys.elementAt(index);
                final quantity = cart[car]!;
                return ListTile(
                  leading: Image.network(car.image, width: 50, height: 50),
                  title: Text(car.name),
                  subtitle: Text('\$${car.price} x $quantity = \$${car.price * quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => onUpdateQuantity(car, quantity - 1),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => onUpdateQuantity(car, quantity + 1),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => onRemoveFromCart(car),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Общая сумма: \$${total}', style: const TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
