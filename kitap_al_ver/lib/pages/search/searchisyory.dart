import 'package:shared_preferences/shared_preferences.dart';

class SearchHistory {
  static const _historyKey = 'search_history';

  static Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_historyKey) ?? [];
  }

  static Future<void> addToHistory(String searchTerm) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = await getHistory();
    if (!history.contains(searchTerm)) {
      history.add(searchTerm);
      await prefs.setStringList(_historyKey, history);
    }
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}
