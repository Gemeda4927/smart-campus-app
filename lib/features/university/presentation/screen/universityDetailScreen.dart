import 'package:flutter/material.dart';

class UniversityDetailScreen extends StatelessWidget {
  final String universityId;

  const UniversityDetailScreen({super.key, required this.universityId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('University Details')),
      body: Center(child: Text('Fetch programs for university: $universityId')),
    );
  }
}
