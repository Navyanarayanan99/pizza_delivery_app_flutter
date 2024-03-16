import 'package:flutter/rendering.dart';

class Ingredient {
  const Ingredient(this.image, this.positions);
  final String image;
  final List<Offset> positions;

  bool compare(Ingredient ingredient) => ingredient.image == image;
}

final ingredients = const <Ingredient>[
  Ingredient(
    'assets/images/toppings/green_chillies_thumb.png',
    <Offset>[
      Offset(0.2, 0.2),
      Offset(0.6, 0.2),
      Offset(0.4, 0.25),
      Offset(0.5, 0.3),
      Offset(0.4, 0.65)
    ],
  ),
  Ingredient(
    'assets/images/toppings/green_peppers_thumb.png',
    <Offset>[
      Offset(0.2, 0.35),
      Offset(0.65, 0.35),
      Offset(0.3, 0.23),
      Offset(0.5, 0.2),
      Offset(0.3, 0.5)
    ],
  ),
  Ingredient(
    'assets/images/toppings/olives_thumb.png',
    <Offset>[
      Offset(0.2, 0.35),
      Offset(0.65, 0.35),
      Offset(0.3, 0.23),
      Offset(0.5, 0.2),
      Offset(0.3, 0.5)
    ],
  ),
  Ingredient(
    'assets/images/toppings/onions_thumb.png',
    <Offset>[
      Offset(0.2, 0.15),
      Offset(0.65, 0.3),
      Offset(0.25, 0.25),
      Offset(0.45, 0.25),
      Offset(0.4, 0.35)
    ],
  ),
  Ingredient(
    'assets/images/toppings/mozarella_Cheese_thumb.png',
    <Offset>[
      Offset(0.2, 0.35),
      Offset(0.65, 0.35),
      Offset(0.3, 0.23),
      Offset(0.5, 0.2),
      Offset(0.3, 0.5)
    ],
  ),
  Ingredient(
    'assets/images/toppings/mushrooms_thumb.png',
    <Offset>[
      Offset(0.2, 0.35),
      Offset(0.65, 0.35),
      Offset(0.3, 0.23),
      Offset(0.5, 0.2),
      Offset(0.3, 0.5)
    ],
  ),
  Ingredient(
    'assets/images/toppings/pineapples_thumb.png',
    <Offset>[
      Offset(0.2, 0.2),
      Offset(0.6, 0.2),
      Offset(0.4, 0.25),
      Offset(0.5, 0.3),
      Offset(0.4, 0.60)
    ],
  ),
];
