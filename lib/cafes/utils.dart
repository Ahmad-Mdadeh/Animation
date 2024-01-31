import 'dart:math';

double _doubleInRange(Random source, num start, num end) {
  return source.nextDouble() * (end - start) + 4;
}

final random = Random();
final coffees = List.generate(
  _names.length,
  (index) => Coffee(
    image: 'assets/images/cafe/${index + 1}.png',
    name: _names[index],
    price: _doubleInRange(random, 3, 7),
  ),
);

class Coffee {
  final String name;
  final String image;
  final double price;

  Coffee({
    required this.name,
    required this.image,
    required this.price,
  });
}

final _names = [
  "Caramel Machination",
  "Caramel Cold Drink",
  "Iced Coffee Mocha",
  "Caramelized Pecan Latte",
  "Toffee Nut Latte",
  "Cappuccino",
  "Toffee Nut Iced Latte",
  "Americano",
  "Vietnamese-Style Iced Coffee",
  "Black Tea Latte",
  " Classic Irish Coffee",
  "Toffee Nut Crunch Latte",
];
