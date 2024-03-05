import 'package:flutter/material.dart';
import 'package:pizza_app/widgets/order-header.dart';

class PizzaOrderScreen extends StatefulWidget {
  const PizzaOrderScreen({Key? key}) : super(key: key);

  @override
  State<PizzaOrderScreen> createState() => _PizzaOrderScreenState();
}

class _PizzaOrderScreenState extends State<PizzaOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          OrderHeader(),
          Expanded(
            child: _PizzaDetails(),
          ),
          Expanded(
            child: Container(
                // color: Colors.red,
                ),
          ),
        ],
      ),
    );
  }
}

class _PizzaDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
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
        ),
        Text(
          '₹ 1500',
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'RozhaOne',
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(221, 47, 18, 0),
          ),
        ),
      ],
    );
  }
}
