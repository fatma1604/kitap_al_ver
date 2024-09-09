import 'package:flutter/material.dart';
import 'package:kitap_al_ver/aramabut/my_searchWidget.dart';
import 'package:kitap_al_ver/post/post_denme.dart';
import 'package:kitap_al_ver/tabbar/screen/drawerDemo_Screen.dart';

class Mykonum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('konum'),
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>SearchWidget(searchController: searchController),));
        print('Butona tıklandı!');
      },
      child: Text('Butona Tıkla'),
    );
  }
}
