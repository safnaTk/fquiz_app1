import 'package:flutter/material.dart';
import 'package:fquiz_app1/view/geography_screen.dart';
import 'package:fquiz_app1/view/home_screen/history_screen.dart';
import 'package:fquiz_app1/view/home_screen/science_screen.dart';
import 'package:fquiz_app1/view/maths_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Science', 'icon': Icons.science, 'questions': 15},
    {'name': 'History', 'icon': Icons.menu_book, 'questions': 15},
    {'name': 'Geography', 'icon': Icons.public, 'questions': 15},
    {'name': 'maths', 'icon': Icons.calculate, 'questions': 15},
  ];
  List<Widget> typeOfscreen = [
    // store multiple widget screen
    ScienceScreen(),
    HistoryScreen(),
    GeographyScreen(),
    MathsScreen(),
  ];
  int clickableindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a Category',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.2,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return GestureDetector(
                    onTap: () {
                      clickableindex = index;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => typeOfscreen[clickableindex],
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category['icon'], size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            category['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${category['questions']} Questions',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
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
