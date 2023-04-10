import 'package:flutter/material.dart';

class EstrelaNiveis extends StatefulWidget {
  final int maxRating;
  final Function(int) onRatingSelected;

  EstrelaNiveis({this.maxRating = 5, required this.onRatingSelected});

  @override
  _EstrelaNiveisState createState() => _EstrelaNiveisState();
}

class _EstrelaNiveisState extends State<EstrelaNiveis> {
  int _currentRating = 0;

  Widget _buildStar(int index) {
    Icon icon;
    if (index < _currentRating) {
      icon = Icon(Icons.star, color: Colors.yellow);
    } else {
      icon = Icon(Icons.star_outline, color: Colors.grey);
    }

    return GestureDetector(
      child: icon,
      onTap: () {
        setState(() {
          _currentRating = index + 1;
        });
        widget.onRatingSelected(_currentRating);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.maxRating, (index) => _buildStar(index)),
    );
  }
}