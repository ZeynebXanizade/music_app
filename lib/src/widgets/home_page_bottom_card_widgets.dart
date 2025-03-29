import 'package:flutter/material.dart';

class HomePageBottomCardWidgets extends StatelessWidget {
  const HomePageBottomCardWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCard(
            'Pop',
            const Color.fromARGB(255, 60, 54, 244),
            170.0,
            150.0,
          ),
          // _buildCard('Rock', const Color.fromARGB(255, 244, 67, 54)),
          // _buildCard('Jazz', const Color.fromARGB(255, 33, 150, 243)),
        ],
      ),
    );
  }

  Widget _buildCard(String genre, Color color, double height, double width) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(45),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            genre,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            genre,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
