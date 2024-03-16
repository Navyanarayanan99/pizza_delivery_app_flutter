class Ingredient {
  const Ingredient(this.image);
  final String image;

  get positions => null;

  bool compare(Ingredient ingredient) => ingredient.image == image;
}

final ingredients = const <Ingredient>[
  Ingredient('assets/images/toppings/green_chillies_thumb.png'),
  Ingredient('assets/images/toppings/green_peppers_thumb.png'),
  Ingredient('assets/images/toppings/halloumi_thumb.png'),
  Ingredient('assets/images/toppings/mozarella_Cheese_thumb.png'),
  Ingredient('assets/images/toppings/mushrooms_thumb.png'),
  Ingredient('assets/images/toppings/olives_thumb.png'),
  Ingredient('assets/images/toppings/onions_thumb.png'),
  Ingredient('assets/images/toppings/pineapples_thumb.png'),
  Ingredient('assets/images/toppings/sweetcorn_thumb.png'),
  Ingredient('assets/images/toppings/tomatos_thumb.png'),
];
