import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
<<<<<<< Updated upstream
import 'package:front/styles/edit_product_styles.dart';
=======
>>>>>>> Stashed changes

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key, required this.flavor});
  final Product flavor;
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late Future<Product> item;
  final TextEditingController _nameFlavorController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dopController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void initState() {
    super.initState();
    ApiService().getProductById(widget.flavor.id).then((i) => {
<<<<<<< Updated upstream
      _nameFlavorController.text = i.name,
      _imageController.text = i.imageUrl,
      _descController.text = i.description,
      _dopController.text = i.feature,
      _priceController.text = i.price.toString(),
    });
=======
          _nameFlavorController.text = i.name,
          _imageController.text = i.imageUrl,
          _descController.text = i.description,
          _dopController.text = i.feature,
          _priceController.text = i.price.toString(),
        });
>>>>>>> Stashed changes
  }

  void dispose() {
    _nameFlavorController.dispose();
    _imageController.dispose();
    _descController.dispose();
    _dopController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< Updated upstream
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Изменение данных автомобиля",
=======
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text(
          "Изменение данных продукта",
>>>>>>> Stashed changes
          style: TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 5),
                child: Text(
<<<<<<< Updated upstream
                  'Название модели',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.labelColor),
=======
                  'Название автомобиля',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
>>>>>>> Stashed changes
                ),
              ),
              TextField(
                controller: _nameFlavorController,
<<<<<<< Updated upstream
                decoration: AppTheme.inputDecoration('Имя модели'),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Фото автомобиля',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.labelColor),
=======
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Имя пользователя',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(160, 149, 108, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'фото автомобиля',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
>>>>>>> Stashed changes
                ),
              ),
              TextField(
                controller: _imageController,
<<<<<<< Updated upstream
                decoration: AppTheme.inputDecoration('Ссылка на фото'),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Комплектация',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.labelColor),
=======
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'ссылка на фото автомобиля',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(160, 149, 108, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Описание',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
>>>>>>> Stashed changes
                ),
              ),
              TextField(
                controller: _descController,
<<<<<<< Updated upstream
                decoration: AppTheme.inputDecoration('Комплектация'),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Характеристики',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.labelColor),
=======
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Описание',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(160, 149, 108, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Особенности',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
>>>>>>> Stashed changes
                ),
              ),
              TextField(
                controller: _dopController,
<<<<<<< Updated upstream
                decoration: AppTheme.inputDecoration('Характеристики'),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
=======
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Особенности',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(160, 149, 108, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
>>>>>>> Stashed changes
                child: Text(
                  'Цена',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
<<<<<<< Updated upstream
                      color: AppTheme.labelColor),
=======
                      color: Color.fromARGB(255, 77, 70, 0)),
>>>>>>> Stashed changes
                ),
              ),
              TextField(
                controller: _priceController,
<<<<<<< Updated upstream
                decoration: AppTheme.inputDecoration('Цена'),
              ),
              const SizedBox(height: 60),
              Center(
                child: ElevatedButton(
                  style: AppTheme.elevatedButtonStyle,
=======
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Цена',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(160, 149, 108, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                    )),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(145, 132, 85, 1),
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 35.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                            width: 2, color: Color.fromRGBO(145, 132, 85, 1))),
                  ),
>>>>>>> Stashed changes
                  onPressed: () async {
                    double price = double.parse(_priceController.text);
                    if (_nameFlavorController.text.isNotEmpty &&
                        _imageController.text.isNotEmpty &&
                        _descController.text.isNotEmpty &&
                        _dopController.text.isNotEmpty &&
                        _priceController.text.isNotEmpty) {
                      await ApiService().updateProduct(Product(
<<<<<<< Updated upstream
                        id: widget.flavor.id,
                        name: _nameFlavorController.text,
                        imageUrl: _imageController.text,
                        description: _descController.text,
                        feature: _dopController.text,
                        price: price,
                        stock: widget.flavor.stock,
                      ));
=======
                          id: widget.flavor.id,
                          name: _nameFlavorController.text,
                          imageUrl: _imageController.text,
                          description: _descController.text,
                          feature: _dopController.text,
                          price: price,
                          stock: widget.flavor.stock));
>>>>>>> Stashed changes
                      Navigator.pop(context);
                      print("Информация товара обновлена");
                    } else {
                      print("Информация товара НЕ обновлена");
                    }
                  },
                  child: const Text(
                    "Сохранить",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
