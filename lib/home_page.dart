import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pizza_app/consts.dart';
import 'package:pizza_app/models/pizza_model.dart';
import 'package:pizza_app/pizza_page.dart';
import 'package:pizza_app/widgets/bassil_leaf.dart';
import 'package:pizza_app/widgets/home_header.dart';
import 'package:pizza_app/widgets/pizza_order_screen.dart';
import 'package:pizza_app/widgets/pizza_plate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int currentPizza = 0;
  bool isSmallSelected = false;
  bool isMediumSelected = false;
  int selectedPizzaIndex = 0;
  final stt.SpeechToText speech = stt.SpeechToText();
  final FlutterTts flutterTts = FlutterTts();

  late PageController pizzaController;
  AnimationController? titleController;

  void _initializeSpeechRecognition() async {
    bool available = await speech.initialize();
    if (available) {
      speech.listen(
        onResult: (result) {
          String command = result.recognizedWords.toLowerCase();
          if (command.contains('order pizza')) {
            _navigateToPizzaOrderScreen();
            _speakResponse('Ordering the pizza...');
          }
        },
        cancelOnError: true,
      );
    } else {
      print('Speech recognition not available');
    }
  }

  void _navigateToPizzaOrderScreen() {
  PizzaModel selectedPizza = dataPizza[currentPizza];
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PizzaPage(pizza: selectedPizza),
    ),
  );
}


  Future<void> _speakResponse(String response) async {
    await flutterTts.speak(response);
  }

  @override
  void initState() {
    super.initState();
    pizzaController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    );
    titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    pizzaController.dispose();
    titleController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PizzaModel selectedPizza = dataPizza[selectedPizzaIndex];
    double scaleFactor = getScaleFactor();

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withOpacity(0.6), Colors.black],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              Text(
                dataPizza[currentPizza].name,
                style: font.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                dataPizza[currentPizza].desc,
                overflow: TextOverflow.clip,
                style: font.copyWith(
                  fontSize: 14,
                  color: Color.fromARGB(255, 228, 223, 223),
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSmallSelected = true;
                          isMediumSelected = false;
                        });
                      },
                      child: Text(
                        'SMALL',
                        style: TextStyle(
                          fontSize: 18,
                          color: isSmallSelected ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSmallSelected = false;
                          isMediumSelected = true;
                        });
                      },
                      child: Text(
                        'MEDIUM',
                        style: TextStyle(
                          fontSize: 18,
                          color: isMediumSelected ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSmallSelected = false;
                          isMediumSelected = false;
                        });
                      },
                      child: Text(
                        'LARGE',
                        style: TextStyle(
                          fontSize: 18,
                          color: !isSmallSelected && !isMediumSelected
                              ? Colors.red
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 400,
                height: 400,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: 0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const BassilLeaf(),
                          const PizzaPlate(),
                        ],
                      ),
                    ),
                    PageView.builder(
                      controller: pizzaController,
                      onPageChanged: (value) {
                        setState(() {
                          currentPizza = value % dataPizza.length;
                          titleController!.forward(from: 0);
                        });
                      },
                      itemBuilder: (context, index) {
                        double pizzaAngle = index.toDouble() * 180;
                        return Transform.rotate(
                          angle: pizzaAngle * pi / 180,
                          child: Center(
                            child: Transform.scale(
                              scale: scaleFactor,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      PizzaOrderScreen()

                                          // PizzaPage(pizza: selectedPizza),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 240,
                                  height: 240,
                                  child: Image.asset(
                                    'assets/images/${dataPizza[index % dataPizza.length].image}',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Text(
                '₹${getPrice()}',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Positioned(
                right: 20,
                top: 700,
                child: FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    _initializeSpeechRecognition();
                  },
                  child: Icon(Icons.mic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double getScaleFactor() {
    if (isSmallSelected) {
      return 1.1;
    } else if (isMediumSelected) {
      return 1.2;
    } else {
      return 1.3;
    }
  }

  double getPrice() {
    if (isSmallSelected) {
      return dataPizza[selectedPizzaIndex].price[0];
    } else if (isMediumSelected) {
      return dataPizza[selectedPizzaIndex].price[1];
    } else {
      return dataPizza[selectedPizzaIndex].price[2];
    }
  }
}
