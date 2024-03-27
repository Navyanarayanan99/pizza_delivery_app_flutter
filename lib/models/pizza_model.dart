class PizzaModel {
  final String image, name, desc;
  final List<double> price;

  PizzaModel({
    required this.desc,
    required this.image,
    required this.name,
    required this.price,
  });
}

List<PizzaModel> dataPizza = [
  PizzaModel(
      desc: 'crust topped with our homemade pizza souce',
      image: 'pizza3.png',
      name: 'Tomato & cheese Pizza',
      price: [500.00, 650.85, 785.98]),
  PizzaModel(
      desc: 'crust topped with our homemade pizza souce',
      image: 'pizza4.png',
      name: 'Italian Pizza',
      price: [590.00, 750.85, 885.98]),
  PizzaModel(
      desc: 'crust topped with our homemade pizza souce',
      image: 'pizza5.png',
      name: 'Margherita Pizza',
      price: [550.00, 650.85, 795.98]),
  PizzaModel(
      desc: 'crust topped with our homemade pizza souce',
      image: 'pizza6.png',
      name: 'Tomato & cheese Pizza',
      price: [600.00, 750.85, 885.98]),
  PizzaModel(
      desc: 'crust topped with our homemade pizza souce',
      image: 'pizza7.png',
      name: 'Tomato & cheese Pizza',
      price: [500.00, 650.85, 785.98]),
  PizzaModel(
      desc: 'crust topped with our homemade pizza souce',
      image: 'pizza8.png',
      name: 'Italian Pizza',
      price: [590.00, 750.85, 885.98]),
  PizzaModel(
      desc: 'crust topped with our homemade pizza souce',
      image: 'pizza9.png',
      name: 'Margherita Pizza',
      price: [550.00, 650.85, 795.98]),
  PizzaModel(
      desc: 'crust topped with our homemade pizza souce',
      image: 'pizza10.png',
      name: 'Tomato & cheese Pizza',
      price: [600.00, 750.85, 885.98]),
];
