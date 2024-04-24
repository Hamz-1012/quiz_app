// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
// import 'package:quiz_app/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:quiz_app/quiz.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswer,
  });

  final List<String> chosenAnswer;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswer.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswer[i]
        },
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((data) => (data['user_answer'] == data['correct_answer']))
        .length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'You answered correctly $numCorrectQuestions out of $numTotalQuestions questions'),
            const SizedBox(
              height: 30,
            ),
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 5.0,
              percent: numCorrectQuestions / numTotalQuestions,
              center: Text(
                "${(numCorrectQuestions / numTotalQuestions * 100).toInt()}%",
                style: GoogleFonts.tenorSans(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              progressColor: Colors.green,
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Quiz()));
                },
                style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
                icon: const Icon(Icons.restart_alt),
                label: const Text("Restart")),
          ],
        ),
      ),
    );
  }
}
