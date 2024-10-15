
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/onbording/pagedsata.dart';
class OnboardPage extends StatelessWidget {
  final PageData page;

  // ignore: use_super_parameters
  const OnboardPage({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(16.0),
        child: Image.asset(
          page.url,
          fit: BoxFit.cover, 
        ),
      ),
    );
  }
}
