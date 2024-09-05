// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final TextEditingController searchController = TextEditingController();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          searchController.clear();
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Please enter a search query'),
      );
    }

    // Implement search logic and display results here
    // For example, fetch data from a database or API based on the query

    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionList = [
      'Flutter',
      'Firebase',
      'OpenAI',
      'Dart',
      'Android',
      'iOS',
    ];

    final List<String> filteredList = query.isEmpty
        ? suggestionList
        : suggestionList.where((element) => element.startsWith(query)).toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredList[index]),
          onTap: () {
            searchController.text = filteredList[index];
            query = filteredList[index];
            close(context, filteredList[index]);
          },
        );
      },
    );
  }
}
