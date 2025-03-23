import 'package:flutter/material.dart';
import 'package:fquiz_app1/dummydb.dart';
import 'package:fquiz_app1/model/questions_model/questions_model.dart';
import 'package:fquiz_app1/view/quiz_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Categories List
  final List<Map<String, dynamic>> categories = [
    {'name': 'Science', 'icon': Icons.science},
    {'name': 'History', 'icon': Icons.history},
    {'name': 'Geography', 'icon': Icons.public},
    {'name': 'Maths', 'icon': Icons.calculate},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Category',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.2,// adjust item size
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return GestureDetector(
                    onTap: () {
                      // Get the correct question list based on category
                      List<QuestionModel> questions = [];
                      switch (category['name']) {
                        case 'Science':
                          questions = Dummydb.scienceQuestion;
                          break;
                        case 'History':
                          questions = Dummydb.historyQuestions;
                          break;
                        case 'Geography':
                          questions = Dummydb.geographyQuestions;
                          break;
                        case 'Maths':
                          questions = Dummydb.mathsQuestions;
                          break;
                      }

                      // Navigate to QuizScreen with questions
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => QuizScreen(
                                categoryName: category['name'],
                                questions: questions,
                              ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.purpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category['icon'], size: 50, color: Colors.white),
                          const SizedBox(height: 10),
                          Text(
                            category['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
