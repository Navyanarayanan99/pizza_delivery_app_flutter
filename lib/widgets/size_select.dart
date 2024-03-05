import 'package:flutter/material.dart';

class ShadowTextSelector extends StatefulWidget {
  final Function(String) onSizeSelected;

  const ShadowTextSelector({required this.onSizeSelected});

  @override
  _ShadowTextSelectorState createState() => _ShadowTextSelectorState();
}

class _ShadowTextSelectorState extends State<ShadowTextSelector> {
  String selectedSize = '';

  @override
  Widget build(BuildContext context) {
    return Positioned(
       bottom: 140,
            left: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildSelectableText('S', 0.9),
          SizedBox(
            width: 25,
          ),
          buildSelectableText('M', 1.0),
          SizedBox(
            width: 25,
          ),
          buildSelectableText('L', 1.1),
        ],
      ),
    );
  }

  Widget buildSelectableText(String size, double scaleFactor) {
    bool isSelected = selectedSize == size;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
          widget.onSizeSelected(selectedSize);
        });
      },
      child: Container(
        height: 35 * scaleFactor,
        width: 35 * scaleFactor,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Color.fromARGB(255, 151, 151, 151).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(221, 47, 18, 0),
            ),
          ),
        ),
      ),
    );
  }
}


void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: ShadowTextSelector(onSizeSelected: (String ) {  },),
      ),
    ),
  );
}
