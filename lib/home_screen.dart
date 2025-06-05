import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';
import 'screens/clock_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agent X Assistant')),
      body: Column(
        children: [
          // Top content
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Welcome to Agent-X! You are logged in.',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ChatScreen(profession: 'YourProfession'),
                        ),
                      );
                    },
                    child: const Text("Open Chatbot"),
                  ),
                ],
              ),
            ),
          ),

          // Bottom buttons (Clock and Calendar)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClockScreen(),
                      ),
                    );
                  },
                  child: const Text("Clock"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add calendar navigation here
                  },
                  child: const Text("Calendar"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
