// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/utils/color.dart';

class UserTitle extends StatefulWidget {
  final String text;
  final void Function()? onTap;
  final String? profileImageUrl;

  const UserTitle({
    Key? key,
    required this.text,
    this.onTap,
    this.profileImageUrl,
  }) : super(key: key);

  @override
  _UserTitleState createState() => _UserTitleState();
}

class _UserTitleState extends State<UserTitle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.userTitle,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        padding: const EdgeInsets.all(19),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.profileImageUrl != null
                  ? NetworkImage(widget.profileImageUrl!)
                  : const AssetImage('assets/images/indir.png')
                      as ImageProvider,
            ),
            const SizedBox(width: 16), // Boşluk ekliyoruz
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 18, // Yazı boyutunu ayarlayabilirsiniz
                fontWeight: FontWeight.bold, // Yazı kalınlığı
              ),
            ),
          ],
        ),
      ),
    );
  }
}
