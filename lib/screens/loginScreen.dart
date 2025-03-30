import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/components/jcbFormTextField.dart';
import 'package:uber_app/components/widget.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/screens/signupScreen.dart';
import 'package:uber_app/utils/constants.dart';

// ignore: must_be_immutable
class Loginscreen extends StatefulWidget {
  Loginscreen({super.key});

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: jcbBackWidget(context),
        actions: [
          Text('Sign up',
                  style: boldTextStyle(color: jcbPrimaryColor, size: 20))
              .paddingSymmetric(horizontal: 16)
              .onTap(
            () {
              Signupscreen().launch(context);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log in',
              style: boldTextStyle(
                  size: 35, color: jcbDarkColor, weight: FontWeight.w900),
            ),
            25.height,
            Jcbformtextfield(
              autoFocus: false,
              controller: widget.emailCont,
              focusNode: widget.emailFocus,
              nextFocusNode: widget.passwordFocus,
              label: 'Email',
              textFieldType: TextFieldType.EMAIL,
            ),
            10.height,
            Jcbformtextfield(
              controller: widget.passwordCont,
              focusNode: widget.passwordFocus,
              textInputAction: TextInputAction.done,
              label: 'Password',
              textFieldType: TextFieldType.PASSWORD,
            ),
            12.height,
            Text(
              'Forgot Password',
              style: boldTextStyle(color: jcbPrimaryColor, size: 14),
            ),
            20.height,
            AppButton(
              color: jcbPrimaryColor,
              width: context.width() - 32,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(jcbButtonRadius),
              ),
              onTap: () {},
              child: Text(
                'LOG IN',
                style: boldTextStyle(color: Colors.white),
              ),
            ).center(),
            SizedBox(
              height: context.height() * 0.2,
            ),
            Text(
              'Or connect using social account',
              style: boldTextStyle(color: jcbDarkColor, size: 14),
            ),
            20.height,
            AppButton(
              padding: EdgeInsets.all(10),
              color: Colors.green[800],
              width: context.width() - 32,
              elevation: 0,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(jcbButtonRadius),
              ),
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    height: 35,
                    width: 35,
                    ic_google,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    'Connect with Google',
                    style: boldTextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 5)
                ],
              ),
            ),
            16.height,
            AppButton(
              padding: EdgeInsets.all(0),
              color: Colors.blue,
              width: context.width() - 32,
              elevation: 0,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(jcbButtonRadius),
              ),
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    height: 55,
                    width: 55,
                    img_fb_logo,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    'Connect with Facebook',
                    style: boldTextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 5)
                ],
              ),
            ),
            16.height,
            AppButton(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              elevation: 0,
              width: context.width() - 32,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(jcbButtonRadius),
                side: BorderSide(color: jcbPrimaryColor),
              ),
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    height: 30,
                    width: 30,
                    ic_telephone,
                    fit: BoxFit.cover,
                    color: Colors.red,
                  ).paddingLeft(6),
                  Text(
                    'Connect with Phone number',
                    style: boldTextStyle(color: jcbPrimaryColor, size: 16),
                  ),
                  SizedBox(width: 5)
                ],
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
