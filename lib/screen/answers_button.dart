import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String? answerText;
  final bool selected; // Add this property
  final VoidCallback onTap;

  const AnswerButton({
    required this.answerText,
    required this.selected, // Initialize this property
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: selected
            ? Color.fromARGB(255, 166, 136, 222)
            : const Color.fromARGB(255, 206, 223, 238),
        // Change button color based on 'selected'
      ),
      child: Text(
        answerText ?? '',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }
}
