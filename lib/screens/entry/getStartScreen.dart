import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/screens/main/homeScreen.dart';
import 'package:uber_app/utils/constants.dart';

class Getstartscreen extends StatefulWidget {
  const Getstartscreen({super.key});

  @override
  State<Getstartscreen> createState() => _GetstartscreenState();
}

class _GetstartscreenState extends State<Getstartscreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    determinePosition();
  }

  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      // return Future.error('Location Not Available');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: jcbSecBackGroundColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: Image.asset(
                img_splash_background,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 100),
                Image.asset(ic_tick,
                    height: 100, width: 100, fit: BoxFit.cover),
                const SizedBox(height: 20),
                Text("You are ready to go !",
                    style: boldTextStyle(
                      color: jcbDarkColor,
                      size: 28,
                    )),
                const SizedBox(height: 20),
                Text(
                  "Thanks for taking your time to create account with us. Now this is the fun part, let's explore the app.",
                  style: boldTextStyle(
                      color: jcbDarkColor, size: 16, weight: FontWeight.w500),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ).center().paddingSymmetric(horizontal: 30),
                const SizedBox(height: 50),
                AppButton(
                  color: jcbDarkColor,
                  width: context.width() * 2 / 3,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(jcbButtonRadius),
                  ),
                  onTap: () {
                    // _signIn();
                    Homescreen().launch(context);
                  },
                  child: Text(
                    'GET STARTED',
                    style: boldTextStyle(color: jcbPrimaryColor),
                  ),
                ).center(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
