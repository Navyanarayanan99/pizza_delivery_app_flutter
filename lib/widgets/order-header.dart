import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 45),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Image(image: AssetImage('assets/images/back_arrow.png'))),
         
               Text('New Orleans \n Pizza 2', style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'IntroHeadB',
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(221, 47, 18, 0)
               )),
SizedBox(width: 70,),
               Image(image: AssetImage('assets/images/cart.png'))
        ],
      ),
    );
  }
}