import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pizza_app/consts.dart';
import 'package:pizza_app/models/pizza_model.dart';
import 'package:pizza_app/widgets/bassil_leaf.dart';
import 'package:pizza_app/widgets/custom_clip.dart';
import 'package:pizza_app/widgets/order-header.dart';
import 'package:pizza_app/data/ingredient.dart';
import 'package:pizza_app/widgets/pizza_plate.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class PizzaOrderScreen extends StatefulWidget {
  const PizzaOrderScreen({Key? key}) : super(key: key);

  @override
  State<PizzaOrderScreen> createState() => _PizzaOrderScreenState();
}

class _PizzaOrderScreenState extends State<PizzaOrderScreen> {
  static const _pizzaCardSize = 48.0;
  final stt.SpeechToText _speech = stt.SpeechToText();
  final _listIngredients = <Ingredient>[];
  final FlutterTts flutterTts = FlutterTts();
  List<Animation> _animationList = [];
  int currentPizza = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          //bottom: 50,
          child: Card(
            elevation: 10,
            color: const Color.fromARGB(255, 82, 80, 80),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                // SizedBox(
                //   height: 60,
                // ),
                OrderHeader(),

                Text(
                  dataPizza[currentPizza].name,
                  style: font.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  dataPizza[currentPizza].desc,
                  overflow: TextOverflow.clip,
                  style: font.copyWith(
                      fontSize: 14, color: Color.fromARGB(255, 228, 223, 223)),
                ),
                SizedBox(
                  height: 30,
                ),

                Expanded(
                  flex: 5,
                  child: _PizzaDetails(
                    selectedPizza:
                        dataPizza[currentPizza], // Pass selected pizza data
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: _pizzaIngredients(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: ClipPath(
            clipper: CustomClip(),
            child: Container(
              height: 35,
              width: 350,
              color: black.withOpacity(0.35),
            ),
          ),
        ),
        // Positioned(
        //   bottom: 25,
        //   height: _pizzaCardSize,
        //   width: _pizzaCardSize,
        //   left: MediaQuery.of(context).size.width / 2 - _pizzaCardSize / 2,
        //   child: _PizzaCartbutton(),
        // ),
      ],
    ));
  }
}

class _PizzaDetails extends StatefulWidget {
  final PizzaModel selectedPizza;
  const _PizzaDetails({Key? key, required this.selectedPizza})
      : super(key: key);

  @override
  State<_PizzaDetails> createState() => __PizzaDetailsState();
}

class __PizzaDetailsState extends State<_PizzaDetails>
    with SingleTickerProviderStateMixin {
  final _listIngredients = <Ingredient>[];
  late AnimationController _animationController;
  int _total = 15;
  final _notifierFocused = ValueNotifier(false);
  List<Animation> _animationList = <Animation>[];
  late BoxConstraints _pizzaConstraints;
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  int currentPizza = 0;
  int selectedSize = 0;

  Widget _buildIngredientsWidget() {
    List<Widget> elements = [];

    if (_animationList != null &&
        _listIngredients != null &&
        _animationList.isNotEmpty) {
      for (int i = 0; i < _listIngredients.length; i++) {
        Ingredient ingredient = _listIngredients[i];
        final ingredientWidget = Image.asset(
          ingredient.image,
          height: 40,
        );
        if (ingredient.positions != null && ingredient.positions.isNotEmpty) {
          for (int j = 0; j < ingredient.positions.length; j++) {
            final animation = _animationList[j];
            final position = ingredient.positions[j];
            final positionX = position.dx;
            final positionY = position.dy;

            if (i == _listIngredients.length - 1) {
              double fromX = 0.0, fromY = 0.0;
              if (j < 1) {
                fromX = -_pizzaConstraints.maxWidth * (1 - animation.value);
              } else if (j < 2) {
                fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
              } else if (j < 4) {
                fromY = -_pizzaConstraints.maxHeight * (1 - animation.value);
              } else {
                fromY = _pizzaConstraints.maxHeight * (1 - animation.value);
              }

              final opacity = animation.value;

              if (animation.value > 0) {
                elements.add(
                  Opacity(
                    opacity: opacity,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(
                          fromX + _pizzaConstraints.maxWidth * positionX,
                          fromY + _pizzaConstraints.maxWidth * positionY,
                        ),
                      child: ingredientWidget,
                    ),
                  ),
                );
              }
            } else {
              elements.add(
                Transform(
                  transform: Matrix4.identity()
                    ..translate(
                      _pizzaConstraints.maxWidth * positionX,
                      _pizzaConstraints.maxWidth * positionY,
                    ),
                  child: ingredientWidget,
                ),
              );
            }
          }
        }
      }
      return Stack(
        children: elements,
      );
    }

    return SizedBox.fromSize();
  }

  void _buildIngredientsAnimation() {
    _animationList.clear();
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.8, curve: Curves.decelerate),
      ),
    );

    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.8, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 1.0, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 0.7, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 1.0, curve: Curves.decelerate),
      ),
    );
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _initializeSpeechRecognition();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initializeSpeechRecognition() async {
    bool available = await _speech.initialize();
    if (!available) {
      print('Speech recognition not available');
    }
  }

  void _startListening() {
    if (_speech.isListening) return;
    _speech.listen(onResult: (result) {
      String command = result.recognizedWords.toLowerCase();
      if (command.contains('corn')) {
        _addIngredient(ingredients[0]);
        _speakResponse('Adding corn...');
      } else if (command.contains('tomato')) {
        _addIngredient(ingredients[1]);
        _speakResponse('adding tomato...');
      } else if (command.contains('olives')) {
        _addIngredient(ingredients[2]);
        _speakResponse('Adding olives...');
         } else if (command.contains('onion')) {
        _addIngredient(ingredients[3]);
        _speakResponse('Adding onion...');
      } else if (command.contains('mushroom')) {
        _addIngredient(ingredients[4]);
        _speakResponse('Adding mushroom...');
      } else if (command.contains('cheese')) {
        _addIngredient(ingredients[5]);
        _speakResponse('Adding Cheese...');
      } else if (command.contains('pineapple')) {
        _addIngredient(ingredients[6]);
        _speakResponse('Adding pineapple...');
         } else if (command.contains('sausage')) {
        _addIngredient(ingredients[7]);
        _speakResponse('Adding sausage...');
         } else if (command.contains('bassil')) {
        _addIngredient(ingredients[8]);
        _speakResponse('Adding bassil...');
      } else {
        print('Unrecognized command: $command');
      }
    });
  }

  void _addIngredient(Ingredient ingredient) {
    _listIngredients.add(ingredient);
    _buildIngredientsAnimation();
    _animationController.forward(from: 0.0);
  }

  Future<void> _speakResponse(String response) async {
    await flutterTts.speak(response);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: _startListening,
            child: Icon(Icons.mic),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: DragTarget<Ingredient>(
                onAccept: (ingredient) {
                  print('onAcccept');
                  _notifierFocused.value = false;

                  setState(() {
                    _listIngredients.add(ingredient as Ingredient);
                    _total++;
                  });
                  _buildIngredientsAnimation();
                  _animationController.forward(from: 0.0);
                },
                onWillAccept: (ingredient) {
                  print('onwillaccept');

                  // setState(() {
                  //   _focused = true;
                  // });
                  _notifierFocused.value = true;
                  for (Ingredient i in _listIngredients) {
                    if (i.compare(ingredient as Ingredient)) {
                      return false;
                    }
                  }

                  return true;
                },
                onLeave: (ingredient) {
                  print('onLeave');
                  // setState(() {
                  //   _focused = false;
                  // });
                  _notifierFocused.value = false;
                },
                builder: (context, list, rejects) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      _pizzaConstraints = constraints;
                      return Center(
                          child: ValueListenableBuilder(
                              valueListenable: _notifierFocused,
                              builder: (context, focused, _) {
                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 400),
                                  height: focused
                                      ? constraints.maxHeight
                                      : constraints.maxHeight - 10,
                                  child: Stack(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const BassilLeaf(),
                                          const PizzaPlate(),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 55, top: 35),
                                        child: Image.asset(
                                          'assets/images/${widget.selectedPizza.image}', // Use selected pizza image
                                          fit: BoxFit.cover,
                                          width: 310,
                                          height: 310,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }));
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            AnimatedSwitcher(
              duration: Duration(microseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: animation.drive(Tween<Offset>(
                      begin: Offset(0.0, 0.0),
                      end: Offset(0.0, animation.value - 0.5),
                    )),
                    child: child,
                  ),
                );
              },
              child: AnimatedDigitWidget(
                value: dataPizza[currentPizza].price[selectedSize],
                //  prefix: '₹',
                textStyle: font.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                fractionDigits: 2,
              ),
            )
          ],
        ),
        AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return _buildIngredientsWidget();
            }),
      ],
    );
  }
}

// class _PizzaCartbutton extends StatefulWidget {
//   late final VoidCallback onTap;

//   @override
//   State<_PizzaCartbutton> createState() => _PizzaCartbuttonState();
// }

// class _PizzaCartbuttonState extends State<_PizzaCartbutton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // decoration: BoxDecoration(
//       //     borderRadius: BorderRadius.circular(5),
//       //     gradient: LinearGradient(
//       //         begin: Alignment.topCenter,
//       //         end: Alignment.bottomCenter,
//       //         colors: [Colors.orange.withOpacity(0.5), Colors.orange])),
//       child: Icon(
//         Icons.shopping_cart_outlined,
//         color: Colors.white,
//       ),
//     );
//   }
// }

class _pizzaIngredients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            final ingredient = ingredients[index];
            return _pizzaIngredientItem(ingredient: ingredient);
          }),
    );
  }
}

class _pizzaIngredientItem extends StatelessWidget {
  const _pizzaIngredientItem({Key? key, required this.ingredient})
      : super(key: key);

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    final child = Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.0),
        child: Container(
          height: 70,
          width: 70,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              ingredient.image,
              fit: BoxFit.contain,
            ),
          ),
        ));

    return Center(
      child: Draggable(
          feedback: DecoratedBox(
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.black45,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 10.0)
            ]),
            child: child,
          ),
          data: ingredient,
          child: child),
    );
  }
}
