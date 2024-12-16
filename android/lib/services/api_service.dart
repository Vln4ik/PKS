import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/car.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8080'));
  static const _localKey = 'cars';

  // Fetch cars: загружаем машины из локального хранилища или сервера
  Future<List<Car>> fetchCars() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final carsJson = prefs.getString(_localKey);

      if (carsJson != null) {
        print('Загружены машины из локального хранилища');
        final carsList = jsonDecode(carsJson) as List<dynamic>;
        return carsList.map((json) => Car.fromJson(json)).toList();
      }

      // Если локальных данных нет, загрузить с сервера
      final cars = await fetchCarsFromServer();
      await _saveCarsToLocal(cars);
      return cars;
    } catch (e) {
      print('Ошибка при загрузке машин: $e');
      return [];
    }
  }

  // Fetch cars from server
  Future<List<Car>> fetchCarsFromServer() async {
    try {
      final response = await _dio.get('/products');
      print('Загружены машины с сервера: ${response.data}');
      if (response.data != null && response.data is List) {
        return (response.data as List)
            .map((car) => Car.fromJson(car as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      print('Ошибка при загрузке машин с сервера: $e');
      throw Exception('Failed to fetch cars from server');
    }
  }

  // Add car: добавляем машину на сервер и обновляем локальное хранилище
  Future<void> addCar(Car car) async {
    try {
      final newCar = Car(
        id: DateTime.now().millisecondsSinceEpoch,
        name: car.name,
        description: car.description,
        price: car.price,
        imageUrl: car.imageUrl,
      );

      // Отправляем данные на сервер
      await _dio.post('/products/create', data: newCar.toJson());
      print('Машина добавлена на сервер: ${newCar.toJson()}');

      // Обновляем локальное хранилище
      final cars = await fetchCarsFromServer();
      await _saveCarsToLocal(cars);
    } catch (e) {
      print('Ошибка при добавлении машины: $e');
      throw Exception('Failed to add car');
    }
  }

  // Delete car: удаляем машину на сервере и обновляем локальное хранилище
  Future<void> deleteCar(int id) async {
    try {
      await _dio.delete('/products/delete/$id');
      print('Машина удалена на сервере: ID = $id');

      // Обновляем локальное хранилище
      final cars = await fetchCarsFromServer();
      await _saveCarsToLocal(cars);
    } catch (e) {
      print('Ошибка при удалении машины: $e');
      throw Exception('Failed to delete car');
    }
  }

  // Сохранение машин в локальное хранилище
  Future<void> _saveCarsToLocal(List<Car> cars) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localKey, jsonEncode(cars.map((car) => car.toJson()).toList()));
    print('Машины сохранены в локальное хранилище');
  }
}
