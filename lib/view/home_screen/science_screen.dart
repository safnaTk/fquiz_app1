import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:fquiz_app1/dummydb.dart';
import 'package:fquiz_app1/view/result_screen/scienceresult_screen.dart';

class ScienceScreen extends StatefulWidget {
  const ScienceScreen({super.key});

  @override
  State<ScienceScreen> createState() => _ScienceScreenState();
}

class _ScienceScreenState extends State<ScienceScreen> {
  int rightAnsCount = 0;
  int questinIndex = 0;
  int? clickedIndex;
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("science quiz", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularCountDownTimer(
                width: 80,
                height: 80,
                duration: 30,
                fillColor: Colors.red,
                ringColor: Colors.white,
                isReverse: true,
                controller: _controller,
                onComplete: _goToNextQuestion,
                textStyle: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                isTimerTextShown: true,
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
                    textAlign: TextAlign.center,
                    Dummydb.scienceQuestion[questinIndex].question,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Column(
                spacing: 10,
                children: List.generate(
                  4,
                  (optionIndex) => InkWell(
                    onTap: () {
                      if (clickedIndex == null) {
                        clickedIndex = optionIndex;
                        if (clickedIndex ==
                            Dummydb.scienceQuestion[questinIndex].answerIndex) {
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
                                  .scienceQuestion[questinIndex]
                                  .options[optionIndex],
                              style: TextStyle(
                                color:
                                    (clickedIndex != null &&
                                            Dummydb
                                                    .scienceQuestion[questinIndex]
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
      if (questinIndex < Dummydb.scienceQuestion.length - 1) {
        questinIndex++;
        clickedIndex = null;
        _controller.restart(duration: 30);
      } else {
        _controller.pause(); // Stop the timer when finishing questions
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => ScienceResultScreen(rightAnsCount: rightAnsCount),
          ),
        );
      }
    });
  }

  Color? _buildOptionColor(int optionIndex) {
    if (clickedIndex != null) {
      if (Dummydb.scienceQuestion[questinIndex].answerIndex == optionIndex) {
        return Colors.green;
      }
    }

    if (clickedIndex == optionIndex) {
      if (clickedIndex == Dummydb.scienceQuestion[questinIndex].answerIndex) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }
    return null;
  }
}
