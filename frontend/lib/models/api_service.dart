import 'dart:async';

import 'package:dio/dio.dart';
import 'package:front/models/user_model.dart';
import 'product_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://192.168.50.65:8080'));

//получение списка продуктов
  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      if (response.statusCode == 200) {
        List<Product> products = (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

//получение данных продукта по id
  Future<Product> getProductById(int id) async {
    try {
      final response = await _dio.get('/products/$id');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

//создание продукта
  Future<void> createProduct(Product product) async {
    try {
      final response = await _dio.post('/products/create', data: {
        'Name': product.name,
        'ImageURL': product.imageUrl,
        'Price': product.price,
        'Description': product.description,
        'IsFavourite': product.isFavourite,
        'Features': product.feature,
        'IsInCart': product.isInCart,
        'Quantity': product.quantity,
      });
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

//удаление продукта по id
  Future<void> deleteProduct(int id) async {
    print("deleteProduct function called");
    try {
      final response = await _dio.delete('/products/delete/$id');
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

//изменение статуса продукта по id
  Future<void> changeProductStatus(Product product) async {
    print("changeProductStatus function called");
    try {
      final response = await _dio.put('/products/update/${product.id}', data: {
        'ImageURL': product.imageUrl,
        'Name': product.name,
        'Description': product.description,
        'Price': product.price,
        'Features': product.feature,
        'IsFavourite': product.isFavourite,
        'IsInCart': product.isInCart,
        'Quantity': product.quantity,
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to change Product Status');
      }
    } catch (e) {
      throw Exception('Error changing Product Status: $e');
    }
  }

// КОРЗИНА
//список корзины
  Future<List<Product>> getCart() async {
    print("getCart function called");
    try {
      final response = await _dio.get('/cart');
      print("Response status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        List<Product> cartProducts = (response.data as List)
            .map((item) => Product.fromJson(item))
            .toList();
        return cartProducts;
      } else {
        print('Error');
        throw Exception('Failed to load cart');
      }
    } catch (e) {
      throw Exception('Error fetching cart: $e');
    }
  }

  Future<int> getCountShopCartProducts() async {
    try {
      final response = await _dio.get('/cart');
      if (response.statusCode == 200) {
        int count = (response.data as List).toList().length;
        return count;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

// ИЗБРАННОЕ
//список избранного
  Future<List<Product>> getFavorites() async {
    try {
      final response = await _dio.get('/favourites');
      if (response.statusCode == 200) {
        List<Product> products = (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();

        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

// ПОЛЬЗОВАТЕЛЬ
//найти пользователя по id
  Future<User> getUserById(int id) async {
    try {
      final response = await _dio.get('/users/${id.toString()}');
      if (response.statusCode == 200) {
        User data = User.fromJson(response.data);
        print(data);
        return data;
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }

//обновить данные пользователя по id
  Future<void> updateUser(User user) async {
    try {
      final response =
      await _dio.put('/users/update/${user.id}', data: {
        'Name': user.name,
        'Image': user.image,
        'Phone': user.phoneNumber,
        'Mail': user.email,
      });
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to update User');
      }
    } catch (e) {
      throw Exception('Error updating User: $e');
    }
  }
}
