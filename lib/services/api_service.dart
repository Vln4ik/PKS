import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/car.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8080'));
  static const _localKey = 'cars';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<List<Car>> fetchCars() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final carsJson = prefs.getString(_localKey);

      if (carsJson != null) {
        final carsList = jsonDecode(carsJson) as List<dynamic>;
        return carsList.map((json) => Car.fromJson(json)).toList();
      }

      final cars = await fetchCarsFromServer();
      await _saveCarsToLocal(cars);
      return cars;
    } catch (e) {
      print('Ошибка при загрузке машин: $e');
      return [];
    }
  }

  Future<List<Car>> fetchCarsFromServer() async {
    try {
      final response = await _dio.get('/products');
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((car) => Car.fromJson(car as Map<String, dynamic>))
            .toList();
      }
      throw Exception('Ошибка сервера: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCar(Car car) async {
    if (_isLoading) {
      print('addCar: Повторный запрос заблокирован.');
      return;
    }
    _isLoading = true;

    try {
      print('addCar: Отправка данных: ${car.toJson()}');
      final response = await _dio.post(
        '/products',
        data: car.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('addCar: Машина успешно добавлена.');
        final cars = await fetchCarsFromServer();
        await _saveCarsToLocal(cars);
      } else {
        throw Exception('addCar: Ошибка сервера (${response.statusCode})');
      }
    } catch (e) {
      print('addCar: Ошибка $e');
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> deleteCar(int id) async {
    try {
      final response = await _dio.delete('/products/$id');
      if (response.statusCode == 200) {
        print('deleteCar: Успешно удалено.');
        final cars = await fetchCarsFromServer();
        await _saveCarsToLocal(cars);
      } else {
        throw Exception('deleteCar: Ошибка сервера (${response.statusCode})');
      }
    } catch (e) {
      print('deleteCar: Ошибка $e');
      rethrow;
    }
  }

  Future<void> _saveCarsToLocal(List<Car> cars) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _localKey,
      jsonEncode(cars.map((car) => car.toJson()).toList()),
    );
    print('_saveCarsToLocal: Данные сохранены локально.');
  }
}
