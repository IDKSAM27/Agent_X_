import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/news_service.dart';
import '../models/news_model.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? profession;
  List<NewsArticle> newsArticles = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchProfessionAndNews();
  }

  Future<void> fetchProfessionAndNews() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      profession = doc['profession'] ?? 'General';

      // Capitalize first letter for better matching
      profession = profession!.substring(0, 1).toUpperCase() + profession!.substring(1).toLowerCase();

      newsArticles = await NewsService.fetchNewsForProfession(profession!);
    } catch (e) {
      debugPrint("Error fetching profession or news: $e");
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, $profession"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // You can add redirection to LoginScreen here if needed
            },
          )
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "News Feed",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: newsArticles.isEmpty
                ? const Center(child: Text("No news available for your profession."))
                : ListView.builder(
                    itemCount: newsArticles.length,
                    itemBuilder: (context, index) {
                      final article = newsArticles[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: const Icon(Icons.newspaper),
                          title: Text(article.title),
                          subtitle: Text(article.description),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(profession: profession ?? 'General'),
                  ),
                );
              },
              icon: const Icon(Icons.chat),
              label: const Text("Chat with Agent-X"),
            ),
          )
        ],
      ),
    );
  }
}
