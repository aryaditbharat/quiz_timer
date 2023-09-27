import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/screen/quiz.dart';
import 'package:quiz_app/screen/results_screen.dart';

import 'answers_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    Key? key,
    required this.onSelectAnswer,
  });

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;
  List<String?> selectedAnswers = List.generate(questions.length, (_) => null);
  int attemptsLeft = 10;
  int currentAttempt = 0;
  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;

  int maxAnswerOptions = 0;

  @override
  void initState() {
    super.initState();

    // Calculate the max answer options
    for (final question in questions) {
      if (question.answers.length > maxAnswerOptions) {
        maxAnswerOptions = question.answers.length;
      }
    }
  }

  void loadQuestion(int questionIndex) {
    setState(() {
      currentQuestionIndex = questionIndex;
      attemptsLeft = 10;
      currentAttempt = 0;
    });
  }

  void answerQuestion(String? answer) {
    setState(() {
      if (attemptsLeft > 0) {
        selectedAnswers[currentQuestionIndex] = answer;
        attemptsLeft--;
        currentAttempt++;
        if (currentAttempt == 10) {
          if (currentQuestionIndex < questions.length - 1) {
            loadQuestion(currentQuestionIndex + 1);
          } else {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ResultsScreen(
                  chosenAnswers: selectedAnswers
                      .where((answer) => answer != null)
                      .cast<String>()
                      .toList(),
                  onRestart: () {},
                ),
              ),
            );
          }
        }
      }
    });
  }

  void next() {
    if (currentQuestionIndex < questions.length - 1) {
      loadQuestion(currentQuestionIndex + 1);
    } else {
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ResultsScreen(
            chosenAnswers: selectedAnswers
                .where((answer) => answer != null)
                .cast<String>()
                .toList(),
            onRestart: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => Quiz(),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  void previous() {
    if (currentQuestionIndex > 0) {
      loadQuestion(currentQuestionIndex - 1);
    } else {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const Quiz(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final currentAnswers = currentQuestion.answers;

    // Calculate the padding needed to align all answer buttons vertically
    final answerPadding = EdgeInsets.symmetric(
      vertical: (maxAnswerOptions - currentAnswers.length) *
          10.0, // Adjust the factor as needed
    );

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 70,
              child: Center(
                child: Text(
                  currentQuestion.text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 30),
            ...currentQuestion.answers.map((answer) {
              final isSelected =
                  selectedAnswers[currentQuestionIndex] == answer;
              return Padding(
                padding: answerPadding,
                child: AnswerButton(
                  answerText: answer,
                  selected: isSelected,
                  onTap: () {
                    answerQuestion(answer);
                  },
                ),
              );
            }),
            SizedBox(
              height: 190,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 88, 142, 196),
                    ),
                    onPressed: () {
                      previous();
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 15,
                        ),
                        Text('Previous'),
                      ],
                    ),
                  ),
                  Text(
                    "${currentQuestionIndex + 1}/${questions.length}",
                    style: TextStyle(fontSize: 18),
                  ),
                  if (isLastQuestion)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 218, 132, 98),
                      ),
                      onPressed: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => ResultsScreen(
                              chosenAnswers: selectedAnswers
                                  .where((answer) => answer != null)
                                  .cast<String>()
                                  .toList(),
                              onRestart: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => Quiz(),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      child: const Text('Submit'),
                    )
                  else
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 27, 95, 178),
                      ),
                      onPressed: () {
                        next();
                      },
                      child: const Row(
                        children: [
                          Text('Next'),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
