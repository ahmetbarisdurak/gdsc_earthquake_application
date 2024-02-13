import 'package:google_solution_challenge/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Image(image: AssetImage('assets/images/share.png')),
            const SizedBox(height: 10.0),
            Text(
              LocaleKeys.openingCards2Title.tr(),
              style: const TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 30.0,
                  color: Color(0xffe97d47),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              LocaleKeys.openingCards2.tr(),
              style: const TextStyle(
                fontFamily: "Source Sans Pro",
                fontSize: 18.0,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 30.0,
              width: 200.0,
              child: Divider(
                color: Colors.grey.shade200,
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
