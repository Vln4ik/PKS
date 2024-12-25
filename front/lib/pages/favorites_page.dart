import 'package:flutter/material.dart';
import 'package:front/components/list_item.dart';
import 'package:front/pages/itam_page.dart';
import 'package:front/models/api_service.dart';
<<<<<<< Updated upstream
import 'package:front/models/product_model.dart';
import 'package:front/models/favourites_model.dart';
import 'package:front/models/cart_model.dart';
import 'package:front/styles/favourites_styles.dart';
=======
import 'package:front/models/favourites_model.dart';
import 'package:front/models/cart_model.dart';
>>>>>>> Stashed changes

class MyFavouritesPage extends StatefulWidget {
  const MyFavouritesPage({super.key});

  @override
  State<MyFavouritesPage> createState() => _MyFavouritesPageState();
}

class _MyFavouritesPageState extends State<MyFavouritesPage> {
  late Future<List<Favourites>> _favProducts;
  late List<Favourites> _favProductsUpd;
  late List<Cart> cartItems = [];

  @override
  void initState() {
    super.initState();
    _favProducts = ApiService().getFavorites(1);
    ApiService().getFavorites(1).then((i) => {_favProductsUpd = i});
  }

  void _setUpd() {
    setState(() {
      _favProducts = ApiService().getFavorites(1);
      ApiService().getFavorites(1).then(
            (el) => {_favProductsUpd = el},
<<<<<<< Updated upstream
      );
=======
          );
>>>>>>> Stashed changes
    });
  }

  void _fetchCart() async {
    try {
      cartItems = await ApiService().getCart(1);
      setState(() {});
    } catch (e) {
      print('Error fetching cart: $e');
    }
  }

  void _addToFavorites(int i) async {
    await ApiService().addToFavorites(1, i);
<<<<<<< Updated upstream
=======
    //_fetchFavorites();
    setState(() {
      /*
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isFavourite = !i.isFavourite;*/
    });
>>>>>>> Stashed changes
    _setUpd();
  }

  void _deleteFromFavourites(int i) async {
    await ApiService().removeFromFavorites(1, i);
<<<<<<< Updated upstream
=======
    //_fetchFavorites();
    setState(() {
      /*
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isFavourite = !i.isFavourite;*/
    });
>>>>>>> Stashed changes
    _setUpd();
  }

  void _deleteFromCart(int i) async {
    await ApiService().removeFromCart(1, i);
    _fetchCart();
<<<<<<< Updated upstream
=======
    setState(() {
      /*
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isFavourite = !i.isFavourite;*/
    });
>>>>>>> Stashed changes
    _setUpd();
  }

  void addTOCart(int i) async {
    int quantity = 1;
    await ApiService().addToCart(1, i, quantity);
    _fetchCart();
<<<<<<< Updated upstream
=======
    setState(() {
      /*
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isInCart = true;
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .quantity = 1;*/
    });
>>>>>>> Stashed changes
    _setUpd();
  }

  void _openItem(id) async {
    final product = await ApiService().getProductById(id);
    int? answer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItamPage(
          flavor: product,
<<<<<<< Updated upstream
=======
          //onAddToFavourites: (flavor) => {_deleteFromFavorites(flavor)},
          //onAddToCart: (flavor) => {_addToCart(flavor)},
>>>>>>> Stashed changes
        ),
      ),
    );
    _setUpd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< Updated upstream
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          title: const Text(
            "Избранные модели",
            style: TextStyle(
              color: Colors.white,
=======
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text(
            "Избранные товары",
            style: TextStyle(
              color: Colors.black,
>>>>>>> Stashed changes
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
<<<<<<< Updated upstream
          backgroundColor: AppTheme.appBarColor,
=======
          backgroundColor: const Color.fromRGBO(99, 247, 168, 1),
>>>>>>> Stashed changes
        ),
        body: FutureBuilder<List<Favourites>>(
            future: _favProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              } else if (!snapshot.hasData ||
                  snapshot.data!.isEmpty ||
                  snapshot.data == null) {
<<<<<<< Updated upstream
                return const Center(child: Text('Модели не добавлены'));
              }

              final items = snapshot.data!;

=======
                return const Center(child: Text('Товары не добавлены'));
              }

              final items = snapshot.data!;
              /*
              for (int i = 0; i < items.length; i++) {
                print(items);
              }*/
>>>>>>> Stashed changes
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.61,
                ),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final flavor = items[index];
                  final flId = items[index].productid;
<<<<<<< Updated upstream
=======
                  print('flavor ${flavor.id}   flId ${flId}   ${flavor.name}');
>>>>>>> Stashed changes

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListItem(
                      key: Key(flavor.productid.toString()),
                      flavor: flavor,
                      onAddToFavourites: (int flavor) =>
<<<<<<< Updated upstream
                      {_addToFavorites(flavor)},
                      onDeleteFromFavourites: (int flavor) =>
                      {_deleteFromFavourites(flavor)},
                      onAddToCart: (int flavor) => {addTOCart(flavor)},
                      onDeleteFromCart: (int flavor) =>
                      {_deleteFromCart(flavor)},
=======
                          {_addToFavorites(flavor)},
                      onDeleteFromFavourites: (int flavor) =>
                          {_deleteFromFavourites(flavor)},
                      onAddToCart: (int flavor) => {addTOCart(flavor)},
                      onDeleteFromCart: (int flavor) =>
                          {_deleteFromCart(flavor)},
>>>>>>> Stashed changes
                      NavToItemPage: (int i) => {_openItem(i)},
                    ),
                  );
                },
              );
            }));
  }
}
