import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:fquiz_app1/model/questions_model/questions_model.dart';
import 'package:fquiz_app1/view/result_screen.dart';




class QuizScreen extends StatefulWidget {
  final String categoryName;
  final List<QuestionModel> questions;

  const QuizScreen({
    super.key,
    required this.categoryName,
    required this.questions,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int rightAnsCount = 0;
  int questionIndex = 0;
  int? clickedIndex;
  final CountDownController controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    double progress = (questionIndex + 1) / widget.questions.length;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          "${widget.categoryName} Quiz",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: Colors.purpleAccent,
                minHeight: 10,
              ),
              SizedBox(height: 10),
              // Timer
              CircularCountDownTimer(
                width: 80,
                height: 80,
                duration: 30,
                fillColor: Colors.red,
                ringColor: Colors.white,
                isReverse: true,
                controller: controller,
                onComplete: _goToNextQuestion,
                textStyle: const TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                isTimerTextShown: true,
              ),

              const SizedBox(height: 20),

              // Question Box
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.questions[questionIndex].question, // quest get
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Answer Options
              Column(
                children: List.generate(
                  widget.questions[questionIndex].options.length,
                  (optionIndex) => InkWell(
                    onTap: () {
                      if (clickedIndex == null) {
                        setState(() {
                          clickedIndex = optionIndex;
                          if (clickedIndex ==
                              widget.questions[questionIndex].answerIndex) {
                            rightAnsCount++;
                          }
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: _getOptionColor(optionIndex),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget
                                  .questions[questionIndex]
                                  .options[optionIndex],
                              style: TextStyle(
                                color:
                                    clickedIndex == null
                                        ? Colors.black
                                        : Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            clickedIndex != null &&
                                    widget
                                            .questions[questionIndex]
                                            .answerIndex ==
                                        optionIndex
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Next Button
              Visibility(
                visible: clickedIndex != null,
                child: InkWell(
                  onTap: _goToNextQuestion,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Move to the next question or finish the quiz
  void _goToNextQuestion() {
    setState(() {
      if (questionIndex < widget.questions.length - 1) {
        questionIndex++;
        clickedIndex = null;

        controller.restart(duration: 30);
      } else {
        controller.pause();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => ResultScreen(
                  categoryName: widget.categoryName,
                  rightAnsCount: rightAnsCount,
                  totalQuestions: widget.questions.length,
                ),
          ),
        );
      }
    });
  }

  /// Get color for selected answer
  Color? _getOptionColor(int optionIndex) {
    if (clickedIndex == null) return null;

    if (widget.questions[questionIndex].answerIndex == optionIndex) {
      return Colors.green;
    } else if (clickedIndex == optionIndex) {
      return Colors.red;
    }

    return null;
  }
}
