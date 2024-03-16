import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Order Manually',
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'IntroHeadB',
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(221, 47, 18, 0)),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.pin_drop,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Washington Park',
                        style: TextStyle(
                            fontFamily: 'ITC Avant Garde Gothic Std',
                            color: Color.fromARGB(221, 47, 18, 0)),
                      )
                    ],
                  )
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: Image(image: AssetImage('assets/images/cart.png')))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 85,
            height: 30,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 237, 198, 83),
                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.center,
            child: Text(
              'Pizza',
              style: TextStyle(
                  fontFamily: 'Impact',
                  color: Color.fromARGB(221, 47, 18, 0),
                  fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
