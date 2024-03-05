import 'package:flutter/material.dart';
import 'package:pizza_app/widgets/home_header.dart';
import 'package:pizza_app/widgets/pizza_home_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 249, 249),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(),
            PizzaHomeContainer(),
          ],
        ),
        // ),
      ),
    );
  }
}
