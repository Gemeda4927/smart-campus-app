import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  // Sample dummy course data
  final List<Map<String, dynamic>> courses = const [
    {
      'title': 'Mathematics 101',
      'category': 'Math',
      'progress': 0.7,
    },
    {
      'title': 'Physics Basics',
      'category': 'Science',
      'progress': 0.4,
    },
    {
      'title': 'English Grammar',
      'category': 'Language',
      'progress': 0.9,
    },
    {
      'title': 'World History',
      'category': 'History',
      'progress': 0.2,
    },
    {
      'title': 'Chemistry Essentials',
      'category': 'Science',
      'progress': 0.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Courses',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course['title'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course['category'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: course['progress'],
                    minHeight: 8,
                    color: Colors.deepPurple,
                    backgroundColor: Colors.deepPurple.shade100,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${(course['progress'] * 100).toInt()}% Completed',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
