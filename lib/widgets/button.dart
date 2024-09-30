import 'package:flutter/material.dart';

class Elevated extends StatelessWidget {
  final VoidCallback onPressed; // Callback function

  const Elevated({Key? key, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE0847D),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.2,
          vertical: height * 0.015,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.03),
        ),
      ),
      child: Text(
        'Submit',
        style: TextStyle(
          color: Colors.white,
          fontSize: width * 0.045,
        ),
      ),
    );
  }
}
