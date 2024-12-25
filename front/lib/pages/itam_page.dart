import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
import 'package:front/pages/edit_product_page.dart';
import 'package:front/models/cart_model.dart';
import 'package:front/models/favourites_model.dart';

class ItamPage extends StatefulWidget {
  const ItamPage({
    super.key,
    required this.flavor,
  });
  final Product flavor;

  @override
  State<ItamPage> createState() => _ItamPageState();
}

class _ItamPageState extends State<ItamPage> {
  late Future<Product> flavors;
  late Future<Product> flavorsUpd;
  late List<Cart> cartItems = [];
  late List<Favourites> favoriteItems = [];

  int quantity = 0;

  @override
  void initState() {
    super.initState();
    flavors = ApiService().getProductById(widget.flavor.id);
    _fetchFavorites();
    _fetchCart();
    ApiService().getProductById(widget.flavor.id).then(
          (i) => {
            quantity = i.stock,
            //isFavourite = i.isFavourite,
            //isInCart = i.isInCart
          },
        );
  }

  void _fetchFavorites() async {
    try {
      favoriteItems = await ApiService().getFavorites(1);
      setState(() {});
    } catch (e) {
      print('Error fetching favorites: $e');
    }
  }

  void _fetchCart() async {
    try {
      cartItems = await ApiService().getCart(1);
      setState(() {});
    } catch (e) {
      print('Error fetching cart: $e');
    }
  }

  void _refreshData() {
    setState(() {
      flavors = ApiService().getProductById(widget.flavor.id);
      _fetchFavorites();
      _fetchCart();
    });
  }

  void updateItem(Product el) {
    Product newFlavors = Product(
        id: el.id,
        name: el.name,
        imageUrl: el.imageUrl,
        price: el.price,
        description: el.description,
        feature: el.feature,
        stock: quantity);
    ApiService().changeProductStatus(newFlavors);
  }

  void _navigateToEditProductScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditProductPage(flavor: widget.flavor)),
    );
    _refreshData();
    if (result != null) {
      _refreshData();
    }
  }

  void _addToFavorites(Product i) async {
    await ApiService().addToFavorites(1, i.id);
    _fetchFavorites();
    setState(() {
      /*
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isFavourite = !i.isFavourite;*/
    });
    _refreshData();
  }

  void _deleteFromFavourites(Product i) async {
    await ApiService().removeFromFavorites(1, i.id);
    _fetchFavorites();
    setState(() {
      /*
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isFavourite = !i.isFavourite;*/
    });
    _refreshData();
  }

  void addTOCart(Product i) async {
    int quantity = 1;
    await ApiService().addToCart(1, i.id, quantity);
    _fetchCart();
    setState(() {});
    _refreshData();
  }

  void _deleteFromCart(Product i) async {
    await ApiService().removeFromCart(1, i.id);
    _fetchCart();
    setState(() {
      /*
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isFavourite = !i.isFavourite;*/
    });
    _refreshData();
  }

  Future<bool?> _showConfirmedDialog(BuildContext context, Product flavor) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'Удалить продукт?',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(
                  flavor.imageUrl,
                  width: 150,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Ошибка загрузки изображения');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(flavor.name),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  "Отмена",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(99, 247, 168, 1),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  "Удалить",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(250, 17, 17, 1),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: flavors,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('позиции не добавлены'));
        }

        final items = snapshot.data!;
        return Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              title: Text(
                widget.flavor.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              padding: const EdgeInsets.all(1),
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            _addToFavorites(items);
                          },
                          icon: favoriteItems.any(
                                  (product) => product.productid == items.id)
                              ? const Icon(Icons.favorite,
                                  color: Color.fromRGBO(160, 149, 108, 1))
                              : const Icon(Icons.favorite_border,
                                  color: Color.fromRGBO(160, 149, 108, 1)),
                        ),
                        const SizedBox(width: 30.0),
                        IconButton(
                          onPressed: () {
                            if (cartItems.any(
                                (product) => product.productid == items.id)) {
                              _deleteFromCart(items);
                            } else {
                              addTOCart(items);
                            }
                          },
                          icon: cartItems.any(
                                  (product) => product.productid == items.id)
                              ? const Icon(Icons.shopping_cart,
                                  color: Color.fromRGBO(160, 149, 108, 1))
                              : const Icon(Icons.add_shopping_cart,
                                  color: Color.fromRGBO(160, 149, 108, 1)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Image.network(
                      widget.flavor.imageUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Описание",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Flexible(
                          child: Text(
                            widget.flavor.description,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Особенности",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Flexible(
                          child: Text(
                            widget.flavor.feature,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          "Цена",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        Flexible(
                          child: Text(
                            widget.flavor.price.toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                _navigateToEditProductScreen(context);
                                _refreshData();
                              },
                              style: ButtonStyle(
                                backgroundColor: const WidgetStatePropertyAll(
                                  Color.fromRGBO(99, 247, 168, 1), // Цвет фона
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Закругление углов
                                  ),
                                ),
                                padding:
                                    const WidgetStatePropertyAll<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 50.0), // Настройка padding
                                ),
                              ),
                              icon: const Icon(Icons.edit,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                            ),
                            const SizedBox(width: 10.0),
                            IconButton(
                              onPressed: () async {
                                final confirmed = await _showConfirmedDialog(
                                    context, widget.flavor);

                                if (confirmed!) {
                                  ApiService().deleteProduct(widget.flavor.id);
                                }
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor: const WidgetStatePropertyAll(
                                  Color.fromRGBO(99, 247, 168, 1), // Цвет фона
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                padding:
                                    const WidgetStatePropertyAll<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 50.0),
                                ),
                              ),
                              icon: const Icon(Icons.delete,
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
