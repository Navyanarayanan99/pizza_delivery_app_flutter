import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pizza_app/widgets/pizza_order_screen.dart';
import 'package:pizza_app/widgets/size_select.dart';

class PizzaHomeContainer extends StatefulWidget {
  const PizzaHomeContainer({Key? key});

  @override
  State<PizzaHomeContainer> createState() => _PizzaHomeContainerState();
}

class _PizzaHomeContainerState extends State<PizzaHomeContainer> {
  String selectedSize = '';
  double plateSizeFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      width: 600,
      child: Stack(children: [
        Container(
          margin: EdgeInsets.only(top: 80, left: 75),
          width: 230,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(115),
            boxShadow: [
              BoxShadow(
                offset: Offset(45, 45.0),
                blurRadius: 99,
                spreadRadius: -50,
                color: Color.fromRGBO(82, 42, 33, 0.3),
              ),
              BoxShadow(
                offset: Offset(-45, -45.0),
                blurRadius: 99,
                spreadRadius: -50,
                color: Color.fromRGBO(82, 42, 33, 0.3),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PizzaOrderScreen()));
            },
            child: Stack(
              children: [
                Positioned(
                  bottom: 220,
                  left: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'New Orleans Pizza',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'IntroHeadB',
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(221, 85, 34, 3)),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 190,
                  left: 65,
                  child: Row(
                    children: List.generate(
                        5,
                        (index) => Icon(
                              Icons.star_border,
                              size: 17,
                            )),
                  ),
                ),
                Positioned(
                  bottom: 130,
                  left: 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '₹ 1000',
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'RozhaOne',
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(221, 47, 18, 0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 15,
          top: -10,
          child: Image.asset(
            'assets/images/circle-salad.png',
            width: 350,
          ),
        ),
        Positioned(
          left: 55,
          top: 15,
          child: Transform.scale(
            scale: plateSizeFactor,
            child: Image.asset(
              'assets/images/wooden_plate2.png',
              width: 260,
            ),
          ),
        ),
        Positioned(
          left: 63,
          top: 28,
          child: Transform.scale(
            scale: plateSizeFactor,
            child: Image.asset(
              'assets/images/pizza2.png',
              width: 235,
            ),
          ),
        ),
        Positioned(
          left: -100,
          top: 320,
          child: Image.asset(
            'assets/images/pizza1.png',
            width: 150,
          ),
        ),
        Positioned(
          left: 330,
          top: 320,
          child: Image.asset(
            'assets/images/pizza3.png',
            width: 150,
          ),
        ),
        Positioned(
          bottom: 100,
          left: 110,
          child: ShadowTextSelector(
            onSizeSelected: (size) {
              setState(() {
                if (size == 'S') {
                  plateSizeFactor = 0.9;
                } else if (size == 'M') {
                  plateSizeFactor = 1.0;
                } else if (size == 'L') {
                  plateSizeFactor = 1.1;
                }
              });
            },
          ),
        ),
        Positioned(
            top: 540,
            left: 160,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 248, 155, 63),
                    Color.fromARGB(255, 221, 88, 35),
                  ],
                ),
              ),
              child: Image(
                image: AssetImage(
                  'assets/images/cart.png',
                ),
                color: Colors.white,
                height: 10,
                width: 10,
              ),
            )),
      ]),
    );
  }
}
