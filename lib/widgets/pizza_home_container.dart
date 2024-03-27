import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pizza_app/models/pizza_model.dart';
import 'package:pizza_app/pizza_page.dart';
import 'package:pizza_app/widgets/pizza_order_screen.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class PizzaHomeContainer extends StatefulWidget {
  const PizzaHomeContainer({Key? key});

  @override
  State<PizzaHomeContainer> createState() => _PizzaHomeContainerState();
}

class _PizzaHomeContainerState extends State<PizzaHomeContainer> {
  final stt.SpeechToText speech = stt.SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  bool isSmallSelected = false;
  bool isMediumSelected = false;
  int selectedPizzaIndex = 0;

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
     var selectedPizza;
     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PizzaOrderScreen(
         
        ),
      ),
    );
  }

  Future<void> _speakResponse(String response) async {
    await flutterTts.speak(response);
  }

double initialX = 0.0;

  void _onHorizontalDragStart(DragStartDetails details) {
    initialX = details.globalPosition.dx;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currentX = details.globalPosition.dx;
    final deltaX = currentX - initialX;

    if (deltaX > 20) {
      _selectPreviousPizza();
      initialX = currentX;
    } else if (deltaX < -20) {
      _selectNextPizza();
      initialX = currentX;
    }
  }

void _selectNextPizza() {
  setState(() {
    selectedPizzaIndex = (selectedPizzaIndex + 1) % dataPizza.length;
    isSmallSelected = false; 
    isMediumSelected = false;
  });
}

void _selectPreviousPizza() {
  setState(() {
    selectedPizzaIndex =
        (selectedPizzaIndex - 1 + dataPizza.length) % dataPizza.length;
    isSmallSelected = false; 
    isMediumSelected = false;
  });
}

  String selectedSize = '';
  double plateSizeFactor = 1.0;

  double getScaleFactor() {
    if (isSmallSelected) {
      return 0.85;
    } else if (isMediumSelected) {
      return 0.95;
    } else {
      return 1.0;
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

  @override
Widget build(BuildContext context) {
  PizzaModel selectedPizza = dataPizza[selectedPizzaIndex];
  return Stack(
    children: [
      Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            '${selectedPizza.name}',
            style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${selectedPizza.desc}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 50,
          ),
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
                      selectedSize = 'Small';
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
                      selectedSize = 'Medium';
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
                      selectedSize = 'Large';
                      isSmallSelected = false;
                      isMediumSelected = false;
                    });
                  },
                  child: Text(
                    'LARGE',
                    style: TextStyle(
                      fontSize: 18,
                      color: selectedSize == 'Large'
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: 400,
        height: 400,
        child: Transform.scale(
          scale: getScaleFactor(),
          child: Image.asset(
            'assets/images/${selectedPizza.image}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 6, 5, 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: Size(140, 25)),
              onPressed: () {
               Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PizzaOrderScreen(
          
        )
      ),
    );
              },
              icon: Icon(Icons.shopping_cart, size: 14, color: Colors.white),
              label: Text(
                'Add to cart',
                style: TextStyle(fontSize: 14, color: Colors.white),
              )),
        ],
      ),
      Positioned(
        top: 200,
        child: Image(
          image: AssetImage('assets/images/stars.webp'),
          height: 400,
        ),
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
      Positioned(
        bottom: 450,
        left: 20,
        child: Row(
          children: [
            FloatingActionButton(
              backgroundColor: Color.fromARGB(66, 183, 180, 180),
              shape: CircleBorder(),
              onPressed: _selectPreviousPizza,
              child: Icon(Icons.arrow_left, color: Colors.white, size: 38,),
            ),
            SizedBox(width: 80),
            Text(
              '₹${getPrice()}',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            SizedBox(width: 80),
            FloatingActionButton(
              backgroundColor: Color.fromARGB(66, 183, 180, 180),
              shape: CircleBorder(),
              onPressed: _selectNextPizza,
              child: Icon(Icons.arrow_right, color: Colors.white, size: 38,),
            ),
          ],
        ),
      ),
    ],
  );
}
}  