import 'package:flutter/material.dart';
import 'package:fquiz_app1/view/home_screen.dart';



class ResultScreen extends StatelessWidget {
  final String categoryName;
  final int rightAnsCount;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.categoryName,
    required this.rightAnsCount,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Star Rating
            Row(
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
            const SizedBox(height: 40),

            // Result Message
            Text(
              getResultMessage(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 20),

            // Score Display
            const Text(
              "Your Score",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              "$rightAnsCount / $totalQuestions",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 30),

           
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.replay_circle_filled_outlined),
                    SizedBox(width: 10),
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

  /// Calculates stars based on the score percentage
  int _calculatePercentage() {
    print(rightAnsCount);
    double percentage = (rightAnsCount / totalQuestions) * 100;
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

  /// Generates a result message based on performance
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
