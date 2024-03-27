import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image(
                image: AssetImage('assets/images/back_arrow.png'),
                color: Colors.white,
                width: 30,
                height: 30,
              )),
          Image(
            image: AssetImage('assets/images/cart.png'),
            color: Colors.white,
            width: 40,
            height: 40,
          )
        ],
      ),
    );
  }
}
