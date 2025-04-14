import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/components/widget.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/extensions/styles.dart';
import 'package:uber_app/screens/auth/loginScreen.dart';
import 'package:uber_app/screens/auth/signupScreen.dart';
import 'package:uber_app/utils/constants.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: jcbSecBackGroundColor,
      body: Stack(
        children: [
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: context.statusBarHeight + 50,
                    ),
                    Image.asset(
                      img_logo,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    Vertical_small,
                    Text(
                      'JUBER',
                      style: headerStyle(),
                    ),
                    Vertical_small,
                    Image.asset(
                      img_splash_background,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              )),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              color: jcbPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: radius(jcbButtonRadius),
                      border: Border.all(color: jcbImageColor),
                    ),
                    child: Text(
                      'Sign up',
                      style: boldTextStyle(color: jcbPrimaryColor, size: 20),
                      textAlign: TextAlign.center,
                    ),
                  ).onTap(() {
                    SignupScreen().launch(context);
                  }),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: radius(jcbButtonRadius),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(
                      'Log in',
                      style: boldTextStyle(color: Colors.white, size: 20),
                      textAlign: TextAlign.center,
                    ),
                  ).onTap(() {
                    Loginscreen().launch(context); // Navigate to login screen
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
