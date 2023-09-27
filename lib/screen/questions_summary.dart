import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  final List<Map<String, Object>> summaryData;

  QuestionsSummary(this.summaryData);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quiz Summary:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          itemCount: summaryData.length,
          itemBuilder: (BuildContext context, int index) {
            final data = summaryData[index];
            final questionNumber = index + 1;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(' $questionNumber: ${data['question']}'),
                Text(
                  'Correct Answer: ${data['correct_answer']}',
                  style: TextStyle(
                    color: data['correct_answer'] == data['user_answer']
                        ? Colors.green
                        : Colors.green,
                  ),
                ),
                Text(
                  'Your Answer: ${data['user_answer']}',
                  style: TextStyle(
                    color: data['correct_answer'] == data['user_answer']
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                SizedBox(height: 10),
              ],
            );
          },
        ),
      ],
    );
  }
}
