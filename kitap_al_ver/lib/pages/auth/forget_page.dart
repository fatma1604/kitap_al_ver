import 'package:flutter/material.dart';
import 'package:kitap_al_ver/utils/color.dart';
import 'package:kitap_al_ver/pages/misc/forget.dart';
import 'package:kitap_al_ver/utils/images.dart';

class ForgetPage extends StatelessWidget {
  const ForgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? AppColor.darttBg
              : AppColor.lightBg,
        ),
        child: Column(
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(AppImage.logo), // Use AssetImage here
                  fit: BoxFit.cover, // Optionally adjust the fit
                ),
                color: theme.brightness == Brightness.dark
                    ? AppColor.screendart
                    : AppColor.screenlight,
              ),
            ),
            Expanded(
              flex: 7,
              child: Transform.translate(
                offset: const Offset(0, -140), // Adjust the value as needed
                child: const Forget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
