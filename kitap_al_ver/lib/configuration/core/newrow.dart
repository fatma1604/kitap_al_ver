
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitap_al_ver/configuration/costant/theme/text_them.dart';



class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed; // Butona tıklandığında gerçekleştirilecek işlem

  // ignore: use_key_in_widget_constructors
  const NewRow({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:
          onPressed, // Butona tıklandığında belirlenen işlemi gerçekleştir
      style: TextButton.styleFrom(
        // Buton metin rengini belirleyin
        padding: EdgeInsets.zero, // Butonun iç boşluğunu sıfırlayın
        alignment: Alignment.centerLeft, // İçeriği sola hizalayın
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: const Color.fromARGB(255, 133, 78, 78),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style:
                GoogleFonts.aBeeZee(textStyle: AppTextTheme.myDrwer(context)),
          )
        ],
      ),
    );
  }
}
