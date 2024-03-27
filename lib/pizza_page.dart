import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pizza_app/consts.dart';
import 'package:pizza_app/models/topping_model.dart';
import 'package:pizza_app/widgets/custom_clip.dart';
import 'package:pizza_app/models/pizza_model.dart';
import 'package:animated_digit/animated_digit.dart';
import 'dart:math';
import 'package:pizza_app/widgets/bassil_leaf.dart';
import 'package:pizza_app/widgets/pizza_plate.dart';
import 'package:pizza_app/widgets/topping_item.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class PizzaPage extends StatefulWidget {
  const PizzaPage({super.key, required PizzaModel pizza});

  @override
  State<PizzaPage> createState() => _PizzaPageState();
}

class _PizzaPageState extends State<PizzaPage> with TickerProviderStateMixin {
  int currentPizza = 0;
  int selectedSize = 0;
  int total = 1;
  List<String> sizeOptions = ['S', 'M', 'L'];

  PageController? toppingController;
  double viewPortFractionTopping = 0.25;
  double? pageOffsetTopping = 2;

  PageController? pizzaController;
  double viewPortFractionPizza = 0.9;
  double? pageOffsetPizza = 0;

  double plateAngle = 0.0;

  AnimationController? titleController;
  List<Topping> selectedTopping = [];
  final _notifierToping = ValueNotifier(false);
 
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
final _listIngredients = <Topping>[];
 final stt.SpeechToText _speech = stt.SpeechToText();

  @override
  void initState() {
  
    // TODO: implement initState
    toppingController = PageController(
        initialPage: 2, viewportFraction: viewPortFractionTopping)
      ..addListener(() {
        setState(() {
          pageOffsetTopping = toppingController!.page;
        });
      });
    pizzaController =
        PageController(initialPage: 0, viewportFraction: viewPortFractionPizza)
          ..addListener(() {
            setState(() {
              pageOffsetPizza = pizzaController!.page;
            });
          });
    titleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animationTopping = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
     _initializeSpeechRecognition(); 
    super.initState();
  }

  // Initialize Speech Recognition
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
      _addIngredient(toppings[0]);
      _speakResponse('Adding corn...');
    } else if (command.contains('tomato')) {
      _addIngredient(toppings[1]);
      _speakResponse('Adding tomato...');
    } else if (command.contains('mushroom')) {
      _addIngredient(toppings[2]);
      _speakResponse('Adding mushroom...');
    } else if (command.contains('basil')) {
      _addIngredient(toppings[3]);
      _speakResponse('Adding basil...');
    } else if (command.contains('cheese')) {
      _addIngredient(toppings[4]);
      _speakResponse('Adding cheese...');
    } else if (command.contains('onion')) {
      _addIngredient(toppings[5]);
      _speakResponse('Adding onion...');
    } else if (command.contains('sausage')) {
      _addIngredient(toppings[6]);
      _speakResponse('Adding sausage...');
    } else {
      print('Unrecognized command: $command');
    }
  });
}

// Add Ingredient based on Voice Command
void _addIngredient(Topping topping) {
  setState(() {
    _listIngredients.add(topping);
    _buildAddedTopping();
    _animationController.forward(from: 0.0);
  });
}

// Speak Response
Future<void> _speakResponse(String response) async {
  await flutterTts.speak(response);
}

  late final Animation<Offset> _offsetTitle = Tween<Offset>(
          begin: const Offset(0, 0.5), end: const Offset(0, 0))
      .animate(CurvedAnimation(parent: titleController!, curve: Curves.linear));


  @override
  void dispose() {
    super.dispose();
    toppingController!.dispose();
    pizzaController!.dispose();
    titleController!.dispose();
    animationTopping!.dispose();
  }

  final List<Animation> _listAnimation = [];
  AnimationController? animationTopping;
  _buildToppingAnimation() {
    _listAnimation.clear();
    for (var i = 0; i < 12; i++) {
      var begin = 0.0;
      var end = 0.0;
      begin = Random().nextDouble();
      end = Random().nextDouble();
      while (begin > end) {
        begin = Random().nextDouble();
        end = Random().nextDouble();
      }
      _listAnimation.add(CurvedAnimation(
          parent: animationTopping!,
          curve: Interval(begin, end, curve: Curves.decelerate)));
    }
  }

  BoxConstraints? pizzaContraints;
  Widget _buildAddedTopping() {
    List<Widget> toppingWidget = [];
    if (selectedTopping.isNotEmpty) {
      for (var i = 0; i < selectedTopping.length; i++) {
        Topping topping = selectedTopping[i];
        final image = Image.asset(topping.onPizza, width: 30, height: 30);
        for (var j = 0; j < topping.offset.length; j++) {
          final animation = _listAnimation[j];
          final position = topping.offset[j];
          final positionX = position.dx;
          final positionY = position.dy;
          if (selectedTopping.length - 1 == i) {
            double fromX = 0.0, fromY = 0.0;
            if (j < 1) {
              fromX = -pizzaContraints!.maxWidth * (1 - animation.value);
            } else if (j < 2) {
              fromX = pizzaContraints!.maxWidth * (1 - animation.value);
            } else if (j < 4) {
              fromY = -pizzaContraints!.maxHeight * (1 - animation.value);
            } else {
              fromY = pizzaContraints!.maxHeight * (1 - animation.value);
            }
            var opaity = animation.value;
            if (animation.value > 0) {
              toppingWidget.add(Opacity(
                opacity: opaity,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(
                        fromX + pizzaContraints!.maxWidth / 2 * positionX,
                        fromY + pizzaContraints!.maxWidth / 2 * positionY),
                  child: image,
                ),
              ));
            }
          }
          toppingWidget.add(Transform(
            transform: Matrix4.identity()
              ..translate(pizzaContraints!.maxWidth / 2 * positionX,
                  pizzaContraints!.maxWidth / 2 * positionY),
            child: image,
          ));
        }
      }
      return Stack(children: toppingWidget);
    } else {
      return SizedBox.fromSize();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
 backgroundColor: const Color.fromARGB(255, 82, 80, 80),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60,),
            // HomeHeader(),
              Text(
        
                    dataPizza[currentPizza].name,
                    style: font.copyWith(
                        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    dataPizza[currentPizza].desc,
                    overflow: TextOverflow.clip,
                    style:
                        font.copyWith(fontSize: 14, color: Color.fromARGB(255, 228, 223, 223)),
                  ),
            SizedBox(
              width: size.width,
              height: 400,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: plateAngle * pi / 180,
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
  physics: NeverScrollableScrollPhysics(), // Disable scrolling
  onPageChanged: (value) {
    setState(() {
      currentPizza = value % dataPizza.length;
      titleController!.forward(from: 0);
      selectedTopping = [];
      total = 1;
    });
  },
  itemCount: dataPizza.length,
  itemBuilder: (context, index) {
    double pizzaAngle = index.toDouble();
    pizzaAngle = (pizzaAngle * 180).clamp(-360, 360);
    plateAngle = (pizzaAngle / 6) - 30;
    return Transform.rotate(
      angle: pizzaAngle * pi / 180,
      child: Center(
        child: Transform.scale(
          scale: 0.9,
          child: DragTarget<Topping>(
            onAccept: (data) {
              if (selectedTopping.length < 3) {
                setState(() {
                  selectedTopping.add(data);
                });
                _notifierToping.value = false;
                _buildToppingAnimation();
                animationTopping!.forward(from: 0.0);
              }
            },
            onLeave: (data) {
              _notifierToping.value = false;
            },
            onWillAccept: (data) {
              _notifierToping.value = false;
              for (Topping element in selectedTopping) {
                if (element.compare(data!)) {
                  return false;
                }
              }
              return true;
            },
            builder: (context, candidateData, rejectedData) {
              return AnimatedContainer(
                width: 350,
                height: 350,
                duration: const Duration(milliseconds: 100),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    pizzaContraints = constraints;
                    return Image.asset(
                      'assets/images/${dataPizza[index % dataPizza.length].image}',
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  },
),

                  AnimatedBuilder(
                    animation: animationTopping!,
                    builder: (context, child) {
                      return _buildAddedTopping();
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            AnimatedDigitWidget(
              value: dataPizza[currentPizza].price[selectedSize],
            //  prefix: '₹',
              textStyle: font.copyWith(
                  fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              fractionDigits: 2,
            ),
            const SizedBox(height: 30),
           
            //  Text(
            //   '₹${getPrice()}',
            //   style: TextStyle(color: Colors.white, fontSize: 25),
            // ),
           
            SizedBox(
              height: 200,
              width: size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: toppingController,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: (pageOffsetTopping! - index).abs() * 40),
                        child: ToppingItem(
                            topping: toppings[index % toppings.length]),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 20,
                    child: ClipPath(
                      clipper: CustomClip(),
                      child: Container(
                        height: 35,
                        width: 350,
                        color: black.withOpacity(0.35),
                      ),
                    ),
                  ),
                   Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: _startListening,
            child: Icon(Icons.mic),
          ),
        ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: brown,
                      ),
                      child: GestureDetector(
                      onTap: _startListening,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.mic, color: white),
                            const SizedBox(width: 10),
                            Text(
                              'Voice',
                              style: font.copyWith(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
