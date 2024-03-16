// ignore_for_file: unused_element

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pizza_app/widgets/order-header.dart';
import 'package:pizza_app/data/ingredient.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class PizzaOrderScreen extends StatefulWidget {
  const PizzaOrderScreen({Key? key}) : super(key: key);

  @override
  State<PizzaOrderScreen> createState() => _PizzaOrderScreenState();
}

class _PizzaOrderScreenState extends State<PizzaOrderScreen> {
  static const _pizzaCardSize = 48.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          bottom: 50,
          child: Card(
            elevation: 10,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                OrderHeader(),
                Expanded(
                  flex: 5,
                  child: _PizzaDetails(),
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
          bottom: 25,
          height: _pizzaCardSize,
          width: _pizzaCardSize,
          left: MediaQuery.of(context).size.width / 2 - _pizzaCardSize / 2,
          child: _PizzaCartbutton(),
        )
      ],
    ));
  }
}

class _PizzaDetails extends StatefulWidget {
  const _PizzaDetails({super.key});

  @override
  State<_PizzaDetails> createState() => __PizzaDetailsState();
}

class __PizzaDetailsState extends State<_PizzaDetails>
    with SingleTickerProviderStateMixin {
       late stt.SpeechToText _speech;
  final _listIngredients = <Ingredient>[];
  late AnimationController _animationController;
  int _total = 15;
  final _notifierFocused = ValueNotifier(false);
  List<Animation> _animationList = <Animation>[];
  late BoxConstraints _pizzaConstraints;

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
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                                      Image.asset(
                                        'assets/images/wooden_plate2.png',
                                        fit: BoxFit.cover,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          'assets/images/pizza1.png',
                                          fit: BoxFit.contain,
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
              // layoutBuilder: (Widget currentChild, List<Widget> previousChildren) {
              //   return Stack(
              //     fit: StackFit.expand,
              //     children: <Widget>[
              //       ...previousChildren,
              //       if(currentChild != null) currentChild,
              //     ],
              //     alignment: Alignment.center,
              //   );
              // },
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
              child: Text(
                '₹ $_total',
                key: UniqueKey(),
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'RozhaOne',
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(221, 47, 18, 0),
                ),
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

class _PizzaCartbutton extends StatefulWidget {
  late final VoidCallback onTap;

  @override
  State<_PizzaCartbutton> createState() => _PizzaCartbuttonState();
}

class _PizzaCartbuttonState extends State<_PizzaCartbutton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: 400));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange.withOpacity(0.5), Colors.orange])),
      child: Icon(
        Icons.shopping_cart_outlined,
        color: Colors.white,
      ),
    );
  }
}

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
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 236, 225, 182),
              shape: BoxShape.circle),
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
