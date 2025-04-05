import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/components/jcbFormTextField.dart';
import 'package:uber_app/components/widget.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/screens/loginScreen.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  String countryCode = '+1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: jcbBackWidget(context),
        actions: [
          Text(
            'Log in',
            style: boldTextStyle(color: jcbPrimaryColor, size: 20),
          ).paddingSymmetric(horizontal: 16).onTap(
            () {
              Loginscreen().launch(context);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: context.height() * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sign up',
                    style: boldTextStyle(
                      color: jcbDarkColor,
                      size: 35,
                      weight: FontWeight.w900,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // First Name
                      Jcbformtextfield(
                        label: 'First Name',
                        textFieldType: TextFieldType.NAME,
                        controller: firstNameCont,
                        focusNode: firstNameFocus,
                        nextFocusNode: lastNameFocus,
                        autoFocus: false,
                        width: context.width() / 2 - 24,
                        labelSpace: true,
                      ),
                      // Last name
                      Jcbformtextfield(
                        label: 'Last Name',
                        textFieldType: TextFieldType.NAME,
                        controller: lastNameCont,
                        focusNode: lastNameFocus,
                        nextFocusNode: emailFocus,
                        width: context.width() / 2 - 24,
                        labelSpace: true,
                      ),
                    ],
                  ),
                  // Email
                  Jcbformtextfield(
                    label: 'Email',
                    textFieldType: TextFieldType.EMAIL,
                    controller: emailCont,
                    focusNode: emailFocus,
                    nextFocusNode: phoneFocus,
                  ),
                  24.height,
                  SizedBox(
                    width: context.width() - 32,
                    child: IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: boldTextStyle(
                          color: jcbGreyColor,
                          size: 14,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: radius(8),
                            borderSide:
                                BorderSide(color: jcbSecBorderColor, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: radius(8),
                            borderSide:
                                BorderSide(color: jcbSecBorderColor, width: 2)),
                      ),
                      initialCountryCode: 'VN',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                  ),
                  Jcbformtextfield(
                    label: 'Password',
                    textFieldType: TextFieldType.PASSWORD,
                    controller: passwordCont,
                    focusNode: passwordFocus,
                    textInputAction: TextInputAction.done,
                  ),
                  24.height,
                  RichText(
                    text: TextSpan(
                      text: 'By clicking "Sign Up" you agree to our ',
                      style: secondaryTextStyle(color: context.iconColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'terms and conditions',
                          style: secondaryTextStyle(
                              color: context.iconColor,
                              decoration: TextDecoration.underline),
                        ),
                        TextSpan(
                          text: ' as well as our ',
                          style: secondaryTextStyle(color: context.iconColor),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: secondaryTextStyle(
                              color: context.iconColor,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  16.height,
                ],
              ),
              AppButton(
                width: context.width() - 32,
                child: Text(
                  'Sign Up',
                  style: boldTextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Handle sign up action
                },
                color: jcbPrimaryColor,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              )
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 24),
        ),
      ),
    );
  }
}
