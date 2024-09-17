// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';


class Mykonum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('konum'),
//konum gelecek  sonra ilanı gör yapa biliriz
        ),
        body: Center(
          child: Mykonumbut(),
        ),
      ),
    );
  }
}

class Mykonumbut extends StatefulWidget {
  @override
  State<Mykonumbut> createState() => _MykonumbutState();
}

class _MykonumbutState extends State<Mykonumbut> {
    final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
      
        print('Butona tıklandı!');
      },
      child: const Text('Butona Tıkla'),
    );
  }
}
