import 'package:flutter/material.dart';
import 'package:fquiz_app1/dummydb.dart';
import 'package:fquiz_app1/view/home_screen/history_screen.dart';

class HistoryResultScreen extends StatelessWidget {
  // constructor call build call,after widget shown-stless
  const HistoryResultScreen({super.key, required this.rightAnsCount});
  final int rightAnsCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (starIndex) => Padding(
                  padding: EdgeInsets.only(bottom: starIndex == 1 ? 40 : 0),
                  child: Icon(
                    Icons.star,
                    size: starIndex == 1 ? 90 : 50,
                    color:
                        starIndex < _calculatePercentage()
                            ? Colors.amber
                            : Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              getResultMessage(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "your score",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              "${rightAnsCount}/${Dummydb.historyQuestions.length}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 200,

                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.replay_circle_filled_outlined),
                    Text(
                      "Retry",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculatePercentage() {
    print(rightAnsCount);
    double percentage = (rightAnsCount / Dummydb.historyQuestions.length) * 100;
    print(percentage);
    if (percentage >= 80) {
      return 3;
    } else if (percentage >= 50) {
      return 2;
    } else if (percentage >= 30) {
      return 1;
    } else {
      return 0;
    }
  }
  String getResultMessage() {
    int stars = _calculatePercentage();
    if (stars == 3) {
      return "Excellent!";
    } else if (stars == 2) {
      return "Very Good!";
    } else if (stars == 1) {
      return "Good!";
    } else {
      return "Better luck next time!";
    }
  }
}


