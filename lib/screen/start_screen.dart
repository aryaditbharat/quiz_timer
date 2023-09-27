import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});
  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Opacity(
          opacity: 0.6,
          child: Image.asset(
            "images/quiz-logo.png",
            width: 300,
            color: const Color.fromARGB(255, 155, 13, 13),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          "Quiz Time",
          style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 11, 12, 13), fontSize: 25),
        ),
        const SizedBox(height: 30),
        OutlinedButton.icon(
          onPressed: startQuiz,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
          ),
          icon: const Icon(Icons.arrow_right_alt),
          label: const Text("start quiz"),
        ),
      ],
    ));
  }
}
