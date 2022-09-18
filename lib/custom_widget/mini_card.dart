import 'package:flutter/material.dart';
import '../constants.dart';

class MiniCard extends StatelessWidget {
  MiniCard({required this.colour, required this.title, required this.onTap});

  final Color colour;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          Future.delayed(Duration.zero, () async {
            onTap();
          });
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: colour,
          child: Center(
            child: Text(
              title,
              style: kMinicardTStyle,
            ),
          ),
        ),
      ),
    );
  }
}
