// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class UserTitle extends StatefulWidget {
  final String text;
  final void Function()? onTap;
  final String? profileImageUrl;
  // ignore: use_super_parameters
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
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(19),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.profileImageUrl != null
                  ? NetworkImage(widget.profileImageUrl!)
                  : const AssetImage('assets/images/akrep8.png') as ImageProvider,
            ),
            Text(widget.text)
          ],
        ),
      ),
    );
  }
}