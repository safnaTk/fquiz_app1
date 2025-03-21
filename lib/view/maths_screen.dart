import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:fquiz_app1/dummydb.dart';
import 'package:fquiz_app1/view/result_screen/mathsresult_screen.dart';

class MathsScreen extends StatefulWidget {
  const MathsScreen({super.key});

  @override
  State<MathsScreen> createState() => _MathsScreenState();
}

class _MathsScreenState extends State<MathsScreen> {
  final CountDownController _controller = CountDownController();
  int rightAnsCount = 0;
  int questinIndex = 0;
  int? clickedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Maths Quiz", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularCountDownTimer(
                controller: _controller,
                width: 80,
                height: 80,
                duration: 30,
                fillColor: Colors.red,
                ringColor: Colors.white,
                isReverse: true,
                textStyle: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                isTimerTextShown: true,
                onComplete:
                    _goToNextQuestion, // Automatically go to next question when timer ends
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    Dummydb.mathsQuestions[questinIndex].question,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Column(
                children: List.generate(
                  4,
                  (optionIndex) => InkWell(
                    onTap: () {
                      if (clickedIndex == null) {
                        clickedIndex = optionIndex;
                        if (clickedIndex ==
                            Dummydb.mathsQuestions[questinIndex].answerIndex) {
                          rightAnsCount++;
                        }
                        setState(() {});
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _buildOptionColor(optionIndex),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              Dummydb
                                  .mathsQuestions[questinIndex]
                                  .options[optionIndex],
                              style: TextStyle(
                                color:
                                    (clickedIndex != null &&
                                            Dummydb
                                                    .mathsQuestions[questinIndex]
                                                    .answerIndex ==
                                                optionIndex)
                                        ? Colors.black
                                        : Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.circle_outlined, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: clickedIndex != null,
                child: InkWell(
                  onTap: _goToNextQuestion,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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

  void _goToNextQuestion() {
    setState(() {
      if (questinIndex < Dummydb.mathsQuestions.length - 1) {
        questinIndex++;
        clickedIndex = null;
        _controller.restart(duration: 30);
      } else {
        _controller.pause(); // Stop the timer when finishing questions
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => MathsResultScreen(rightAnsCount: rightAnsCount),
          ),
        );
      }
    });
  }

  Color? _buildOptionColor(int optionIndex) {
    if (clickedIndex != null) {
      if (Dummydb.mathsQuestions[questinIndex].answerIndex == optionIndex) {
        return Colors.green;
      }
    }
    if (clickedIndex == optionIndex) {
      return clickedIndex == Dummydb.mathsQuestions[questinIndex].answerIndex
          ? Colors.green
          : Colors.red;
    }
    return null;
  }
}
