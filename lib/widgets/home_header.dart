import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage('assets/images/dominos.png'),
                    height: 40,
                    width: 40,
                  ),
                  Text(
                    'Dominos',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'IntroHeadB',
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(247, 255, 255, 255)),
                  ),
                ],
              ),
              Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
