import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/widget/loginorregister/add_screen.dart';

class Mykonum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('konum'),
        ),
        body: Center(
          child: Mykonumbut(),
        ),
      ),
    );
  }
}

class Mykonumbut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
       /* Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddScreen()));*/
        print('Butona tıklandı!');
      },
      child: Text('Butona Tıkla'),
    );
  }
}
