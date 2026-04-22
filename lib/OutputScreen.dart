import 'package:flutter/material.dart';

class OutputScreen extends StatelessWidget {
  const OutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Output'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${args['username']}'),
            Text('Password: ${args['password']}'),
            Text('Email: ${args['email']}'),
            Text('Remember Me: ${args['rememberMe']}'),
            Text('Gender: ${args['gender']}'),
            Text('Country: ${args['country']}'),
            Text('Age: ${args['age']?.round()}'),
            Text(
              'Selected Date: ${args['selectedDate'] != null ? args['selectedDate'].toLocal().toString().split(' ')[0] : 'Not selected'}',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}