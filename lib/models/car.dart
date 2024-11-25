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
    description: 'Описание BMW X5: мощный и стильный внедорожник.',
  ),
  Car(
    name: 'Audi Q7',
    price: 72000,
    image: 'https://i.pinimg.com/236x/48/02/68/480268e6ba635f568a928182d32b4ba7.jpg',
    description: 'Описание Audi Q7: комфорт и технологии будущего.',
  ),
  Car(
    name: 'BMW X6',
    price: 85000,
    image: 'https://i.pinimg.com/236x/c6/fa/e4/c6fae4bbcab1ea46895c2bd002345449.jpg',
    description: 'Описание BMW X5: мощный и стильный внедорожник.',
  ),
  Car(
    name: 'BMW X7',
    price: 95000,
    image: 'https://i.pinimg.com/736x/a1/9f/5d/a19f5d8986225088b4ad8b82716c466c.jpg',
    description: 'Описание BMW X5: мощный и стильный внедорожник.',
  ),
  Car(
    name: 'BMW X4',
    price: 55000,
    image: 'https://i.pinimg.com/736x/45/26/29/45262976c59fec2ebaa7cdc981dd0945.jpg',
    description: 'Описание BMW X5: мощный и стильный внедорожник.',
  ),
  Car(
    name: 'BMW X3',
    price: 45000,
    image: 'https://i.pinimg.com/736x/b2/02/ca/b202ca4be821404a138b19612684c6d5.jpg',
    description: 'Описание BMW X5: мощный и стильный внедорожник.',
  ),
  Car(
    name: 'BMW X2',
    price: 35000,
    image: 'https://i.pinimg.com/736x/13/3e/b9/133eb9c48f1054ce5a69657a8efd332a.jpg',
    description: 'Описание BMW X5: мощный и стильный внедорожник.',
  ),
];
