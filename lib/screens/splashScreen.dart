import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/components/widget.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/extensions/styles.dart';
import 'package:uber_app/screens/walkthroughScreen.dart';
import 'package:uber_app/screens/welcomeScreen.dart';
import 'package:uber_app/utils/constants.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(Colors.transparent);
    await 3.seconds.delay;
    finish(context);
    // go to Walkthrough screen
    if (getBoolAsync(IS_FIRST_TIME)) {
      Walkthroughsreen().launch(context);
    } else {
      if (getBoolAsync(IS_LOGGED_IN)) {
      } else {
        Welcomescreen().launch(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: jcbSecBackGroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Vertical_large,
              Vertical_large,
              Image.asset(img_logo, height: 100, width: 100, fit: BoxFit.cover),
              Vertical_small,
              Text("Juber", style: headerStyle()),
              const SizedBox(height: 20),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              img_splash_background,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Loading(),
        ],
      ),
    );
  }
}
