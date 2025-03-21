import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:fquiz_app1/dummydb.dart';
import 'package:fquiz_app1/view/result_screen/geographyresult_screen.dart';

class GeographyScreen extends StatefulWidget {
  const GeographyScreen({super.key});

  @override
  State<GeographyScreen> createState() => _GeographyScreenState();
}

class _GeographyScreenState extends State<GeographyScreen> {
  final CountDownController controller = CountDownController();
  int rightAnsCount = 0;
  int questinIndex = 0;
  int? clickedIndex;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("geography Quiz", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularCountDownTimer(
                controller: controller,
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
                    _goToNextQuestion, // Move to the next question automatically
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
                    Dummydb.geographyQuestions[questinIndex].question,
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
                            Dummydb
                                .geographyQuestions[questinIndex]
                                .answerIndex) {
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
                                  .geographyQuestions[questinIndex]
                                  .options[optionIndex],
                              style: TextStyle(
                                color:
                                    (clickedIndex != null &&
                                            Dummydb
                                                    .geographyQuestions[questinIndex]
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
    if (questinIndex < Dummydb.geographyQuestions.length - 1) {
      setState(() {
        questinIndex++;
        clickedIndex = null;
        controller.restart(
          duration: 30,
        ); // Restart the timer for the next question
      });
    } else {
      controller.pause(); // Stop the timer when quiz ends
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => GeographyResultScreen(rightAnsCount: rightAnsCount),
        ),
      );
    }
  }

  Color? _buildOptionColor(int optionIndex) {
    if (clickedIndex != null) {
      if (Dummydb.geographyQuestions[questinIndex].answerIndex == optionIndex) {
        return Colors.green;
      }
    }

    if (clickedIndex == optionIndex) {
      if (clickedIndex ==
          Dummydb.geographyQuestions[questinIndex].answerIndex) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }
    return null;
  }
}
