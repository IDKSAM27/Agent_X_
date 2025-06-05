import '../models/news_model.dart';

class NewsService {
  static Future<List<NewsArticle>> fetchNewsForProfession(String profession) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    switch (profession.toLowerCase()) {
      case 'student':
        return [
          NewsArticle(title: "Exam Tips", description: "How to prepare for exams effectively."),
          NewsArticle(title: "Career Paths", description: "Best career options after graduation."),
        ];
      case 'teacher':
        return [
          NewsArticle(title: "Classroom Tech", description: "Top apps for engaging students."),
          NewsArticle(title: "Assessment Methods", description: "Modern ways to evaluate students."),
        ];
      case 'developer':
        return [
          NewsArticle(title: "Flutter 3.22 Released", description: "New features in Flutter."),
          NewsArticle(title: "AI in Coding", description: "How LLMs are changing software development."),
        ];
      default:
        return [
          NewsArticle(title: "Daily News", description: "Catch up on today’s headlines."),
          NewsArticle(title: "Trending Now", description: "What’s buzzing across the world."),
        ];
    }
  }
}
