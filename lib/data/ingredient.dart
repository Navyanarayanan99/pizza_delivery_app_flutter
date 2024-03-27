import 'package:flutter/rendering.dart';

class Ingredient {
  const Ingredient(this.name, this.image, this.positions);
  final String name;
  final String image;
  final List<Offset> positions;

  bool compare(Ingredient ingredient) => ingredient.image == image;
}

final ingredients = const <Ingredient>[
  Ingredient(
    'Corn',
    'assets/corn/corn (1).png',
    <Offset>[
      Offset(0.2, 0.2),
      Offset(0.6, 0.2),
      Offset(0.4, 0.25),
      Offset(0.5, 0.3),
      Offset(0.4, 0.65)
    ],
  ),
  Ingredient(
    'Tomato',
    'assets/tomato/tomato (1).png',
    <Offset>[
      Offset(0.2, 0.35),
      Offset(0.65, 0.35),
      Offset(0.3, 0.23),
      Offset(0.5, 0.2),
      Offset(0.3, 0.5)
    ],
  ),
  Ingredient(
    'Olives',
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
    'Onion',
    'assets/onion/onion (1).png',
    <Offset>[
      Offset(0.2, 0.35),
      Offset(0.65, 0.35),
      Offset(0.3, 0.23),
      Offset(0.5, 0.2),
      Offset(0.3, 0.5)
    ],
  ),
   Ingredient(
    'Mushrooms',
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
    'Cheese',
    'assets/images/toppings/mozarella_Cheese_thumb.png',
    <Offset>[
      Offset(0.2, 0.15),
      Offset(0.65, 0.3),
      Offset(0.25, 0.25),
      Offset(0.45, 0.25),
      Offset(0.4, 0.35)
    ],
  ),
 
 
  Ingredient(
    'Pineapples',
    'assets/images/toppings/pineapples_thumb.png',
    <Offset>[
      Offset(0.2, 0.2),
      Offset(0.6, 0.2),
      Offset(0.4, 0.25),
      Offset(0.5, 0.3),
      Offset(0.4, 0.60)
    ],
  ),
  Ingredient(
    'Onions',
    'assets/sausage/sausage (1).png',
    <Offset>[
      Offset(0.2, 0.15),
      Offset(0.65, 0.3),
      Offset(0.25, 0.25),
      Offset(0.45, 0.25),
      Offset(0.4, 0.35)
    ],
  ),
  Ingredient(
    'Onions',
    'assets/bassil/bassil (4).png',
    <Offset>[
      Offset(0.2, 0.15),
      Offset(0.65, 0.3),
      Offset(0.25, 0.25),
      Offset(0.45, 0.25),
      Offset(0.4, 0.35)
    ],
  ),
];
