import 'package:flutter/material.dart';

class BassilLeaf extends StatefulWidget {
  const BassilLeaf({Key? key}) : super(key: key);

  @override
  _BassilLeafState createState() => _BassilLeafState();
}

class _BassilLeafState extends State<BassilLeaf>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Adjust duration as needed
    )..repeat(); // Makes the animation repeat continuously
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildRotatingImage('assets/circle-salad.png',
            top: 40, width: 390, left: 10),
        _buildRotatingImage('assets/bassil/bassil (6).png',
            left: 100, top: 10, width: 10),
        _buildRotatingImage('assets/bassil/bassil (7).png',
            left: 40, top: 50, width: 40),
        _buildRotatingImage('assets/bassil/bassil (1).png',
            left: 40, top: 230, width: 10),
        _buildRotatingImage('assets/bassil/bassil (4).png',
            left: 65, bottom: 30, width: 30),
        _buildRotatingImage('assets/bassil/bassil (2).png',
            right: 90, bottom: 40, width: 10),
        _buildRotatingImage('assets/bassil/bassil (5).png',
            right: 40, bottom: 15, width: 30),
        _buildRotatingImage('assets/bassil/bassil (3).png',
            right: 20, bottom: 200, width: 10),
        _buildRotatingImage(
          'assets/bassil/bassil (3).png',
          right: 60,
          top: 40,
          width: 20,
        ),
      ],
    );
  }

  Widget _buildRotatingImage(String asset,
      {double? left,
      double? right,
      double? top,
      double? bottom,
      double width = 100}) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: RotationTransition(
        turns: _controller,
        child: Image.asset(asset, width: width),
      ),
    );
  }
}
