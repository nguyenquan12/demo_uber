import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/components/jcbFormTextField.dart';
import 'package:uber_app/components/widget.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/screens/entry/getStartScreen.dart';
import 'package:uber_app/screens/main/homeScreen.dart';
import 'package:uber_app/screens/auth/signup/signupScreen.dart';
import 'package:uber_app/utils/constants.dart';

// ignore: must_be_immutable
class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  // Khởi tạo GoogleSignIn
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  void dispose() {
    emailCont.dispose();
    passwordCont.dispose();
    super.dispose();
  }

  // Hàm đăng nhập bằng email/password
  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailCont.text.trim(),
        password: passwordCont.text.trim(),
      );

      _showSnackBar('Đăng nhập thành công!', Colors.green);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = _getErrorMessage(e.code);
      });
      _showSnackBar("$_errorMessage. Chi tiet: $e", Colors.red);
      print(e.code);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Hàm đăng nhập bằng Google
  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Đăng nhập bằng Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() {
          _isLoading = false;
        });
        return; // Người dùng hủy đăng nhập
      }

      // Lấy thông tin xác thực từ Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Đăng nhập vào Firebase với thông tin xác thực từ Google
      await FirebaseAuth.instance.signInWithCredential(credential);

      _showSnackBar('Đăng nhập bằng Google thành công!', Colors.green);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Getstartscreen()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Đăng nhập bằng Google thất bại! Chi tiết: $e';
        print(e);
      });
      _showSnackBar(_errorMessage!, Colors.red);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Hàm kiểm tra tính hợp lệ của email và mật khẩu
  String _getErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return "Email không hợp lệ!";
      case 'user-not-found':
        return "Không tìm thấy tài khoản!";
      case 'wrong-password':
        return "Mật khẩu không đúng!";
      default:
        return "Đăng nhập thất bại!";
    }
  }

  // Hàm hiển thị thông báo
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }

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
              SignupScreen().launch(context);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Log in',
                style: boldTextStyle(
                    size: 35, color: jcbDarkColor, weight: FontWeight.w900),
              ).center(),
              25.height,
              Jcbformtextfield(
                autoFocus: false,
                controller: emailCont,
                focusNode: emailFocus,
                nextFocusNode: passwordFocus,
                label: 'Email',
                textFieldType: TextFieldType.EMAIL,
              ),
              10.height,
              Jcbformtextfield(
                controller: passwordCont,
                focusNode: passwordFocus,
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
              _isLoading
                  ? CircularProgressIndicator()
                  : AppButton(
                      color: jcbPrimaryColor,
                      width: context.width() - 32,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(jcbButtonRadius),
                      ),
                      onTap: () {
                        _signIn();
                        // Getstartscreen().launch(context);
                      },
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
                color: Colors.green[700],
                width: context.width() - 32,
                elevation: 0,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(jcbButtonRadius),
                ),
                onTap: () {
                  _signInWithGoogle(); // Đăng nhập bằng Google
                },
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
                color: Colors.blue[700],
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
      ),
    );
  }
}
