import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/screen/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    Key? key,
    required this.chosenAnswers,
    required this.onRestart,
  });
  final void Function() onRestart;
  final List<String> chosenAnswers;

  List<Map<String, Object>> get SummaryData {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      final question = questions[i];
      final isCorrect = chosenAnswers[i] == question.correctAnswer;
      summary.add({
        'question_index': i,
        'question': question.text,
        'correct_answer': question.correctAnswer,
        'user_answer': chosenAnswers[i],
        'is_correct': isCorrect,
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions =
        SummaryData.where((data) => data['is_correct'] == true).length;

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              QuestionsSummary(SummaryData),
              const SizedBox(
                height: 30,
              ),
              TextButton.icon(
                  onPressed: onRestart,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Restart Quiz')),
            ],
          ),
        ),
      ),
    );
  }
}
