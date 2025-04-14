import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/components/jcbFormTextField.dart';
import 'package:uber_app/components/widget.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/screens/auth/login/loginScreen.dart';
import 'package:uber_app/screens/auth/signup/otpScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController confirmPasswordCont = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String phoneNumber = ''; // Lưu số điện thoại đầy đủ

  // Biến trạng thái để chuyển đổi giữa Phone Number và Email
  bool isPhoneNumber = false;
  String countryCode = '+1';

  Future<void> _signUp() async {
    setState(() {
      isLoading = true;
    });

    if (isPhoneNumber) {
      // Chuẩn hóa số điện thoại
      String normalizedPhoneNumber =
          phoneNumber.replaceAll(RegExp(r'\s+'), ''); // Loại bỏ khoảng trắng
      if (normalizedPhoneNumber.startsWith('0')) {
        // Nếu người dùng nhập số bắt đầu bằng 0 (ví dụ: 084394266770), thay bằng +84
        normalizedPhoneNumber = '+84${normalizedPhoneNumber.substring(1)}';
      }

      // Kiểm tra định dạng và độ dài
      if (normalizedPhoneNumber.isEmpty ||
          !normalizedPhoneNumber.startsWith('+')) {
        setState(() {
          isLoading = false;
        });
        _showSnackBar("Số điện thoại không hợp lệ! Vui lòng kiểm tra lại.");
        return;
      }

      // Kiểm tra độ dài (sau mã quốc gia, số điện thoại thường là 9-10 chữ số)
      String numberWithoutCountryCode =
          normalizedPhoneNumber.substring(3); // Bỏ phần +84
      if (numberWithoutCountryCode.length < 9 ||
          numberWithoutCountryCode.length > 10) {
        setState(() {
          isLoading = false;
        });
        _showSnackBar(
            "Số điện thoại không hợp lệ! Độ dài phải từ 9-10 chữ số.");
        return;
      }

      // Đăng ký bằng số điện thoại
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Tự động xác thực (trong một số trường hợp, ví dụ: trên Android)
            await _auth.signInWithCredential(credential);
            _showSnackBar("Đăng ký thành công!");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Loginscreen()));
          },
          verificationFailed: (FirebaseAuthException e) {
            setState(() {
              isLoading = false;
            });
            _showSnackBar(_getErrorMessage(e.code));
          },
          codeSent: (String verificationId, int? resendToken) {
            setState(() {
              isLoading = false;
            });
            // Chuyển đến màn hình nhập OTP
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OTPScreen(verificationId: verificationId)),
            );
          },
          codeAutoRetrievalTimeout: (String verificationID) {},
        );
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        _showSnackBar("Đã xảy ra lỗi, vui lòng thử lại!");
      }
    } else {
      // Đăng ký bằng email
      try {
        await _auth.createUserWithEmailAndPassword(
          email: emailCont.text.trim(),
          password: passwordCont.text.trim(),
        );
        _showSnackBar("Đăng ký thành công!");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Loginscreen()),
        );
      } on FirebaseAuthException catch (e) {
        _showSnackBar(_getErrorMessage(e.code));
      } catch (e) {
        _showSnackBar("Đã xảy ra lỗi, vui lòng thử lại!");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'Email này đã được sử dụng!';
      case 'weak-password':
        return 'Mật khẩu quá yếu, hãy thử mật khẩu mạnh hơn!';
      case 'invalid-email':
        return 'Email không hợp lệ!';
      case 'invalid-phone-number':
        return 'Số điện thoại không hợp lệ!';
      default:
        return 'Đã xảy ra lỗi, vui lòng thử lại!';
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        // duration: const Duration(seconds: 2),
      ),
    );
  }

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
        child: SizedBox(
          height: context.height() * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sign up title
                  Text(
                    'Sign up',
                    style: boldTextStyle(
                      color: jcbDarkColor,
                      size: 35,
                      weight: FontWeight.w900,
                    ),
                  ).center(),
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
                        nextFocusNode: isPhoneNumber ? phoneFocus : emailFocus,
                        width: context.width() / 2 - 24,
                        labelSpace: true,
                      ),
                    ],
                  ),
                  // Hiển thị Phone Number hoặc Email dựa trên isPhoneNumber
                  isPhoneNumber
                      // Hiển thị Phone Number
                      ? Container(
                          margin: const EdgeInsets.only(top: 24),
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
                                  borderSide: BorderSide(
                                      color: jcbSecBorderColor, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: radius(8),
                                  borderSide: BorderSide(
                                      color: jcbSecBorderColor, width: 2)),
                            ),
                            initialCountryCode: 'VN',
                            onChanged: (phone) {
                              setState(() {
                                phoneNumber = phone
                                    .completeNumber; // Lưu số điện thoại đầy đủ
                                print(
                                    "Phone number updated: $phoneNumber"); // Log để kiểm tra
                              });
                            },
                          ),
                        )
                      //Hiển thị Email
                      : Jcbformtextfield(
                          label: 'Email',
                          textFieldType: TextFieldType.EMAIL,
                          controller: emailCont,
                          focusNode: emailFocus,
                          nextFocusNode: passwordFocus,
                        ),
                  8.height,
                  // Chuyển đổi giữa Phone Number và Email
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPhoneNumber = !isPhoneNumber; // Chuyển đổi trạng thái
                      });
                    },
                    child: Text(
                      isPhoneNumber
                          ? 'Switch to Email'
                          : 'Switch to Phone Number',
                      style: boldTextStyle(
                        color: jcbPrimaryColor,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Password
                  Jcbformtextfield(
                    label: 'Password',
                    textFieldType: TextFieldType.PASSWORD,
                    controller: passwordCont,
                    focusNode: passwordFocus,
                    nextFocusNode: confirmPasswordFocus,
                    textInputAction: TextInputAction.done,
                  ),
                  // Confirm Password
                  Jcbformtextfield(
                    label: 'Confirm Password',
                    textFieldType: TextFieldType.PASSWORD,
                    controller: confirmPasswordCont,
                    focusNode: confirmPasswordFocus,
                    textInputAction: TextInputAction.done,
                  ),
                  24.height,
                  // Terms and Conditions (Điều khoản và điều kiện)
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
                  _signUp();
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
