import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/screens/auth/loginScreen.dart';
import 'package:uber_app/utils/constants.dart';

class JCBDrawerComponent extends StatefulWidget {
  const JCBDrawerComponent({super.key});

  @override
  State<JCBDrawerComponent> createState() => _JCBDrawerComponentState();
}

class _JCBDrawerComponentState extends State<JCBDrawerComponent> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // Hàm đăng xuất
  Future<void> _signOut() async {
    try {
      // Đăng xuất khỏi Google
      await _googleSignIn.signOut();
      // Đăng xuất khỏi Firebase
      await FirebaseAuth.instance.signOut();

      // Hiển thị thông báo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng xuất thành công!'),
          backgroundColor: Colors.green,
        ),
      );

      // Chuyển về màn hình đăng nhập
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Loginscreen()),
      );
    } catch (e) {
      // Hiển thị lỗi nếu có
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng xuất thất bại: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: jcbPrimaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset(
                      img_avatar,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(100),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: radius(100),
                    ),
                  ).center(),
                  5.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nguyễn Quân',
                              style:
                                  boldTextStyle(color: Colors.white, size: 18)),
                          Text(
                            '24-12-2003',
                            style: boldTextStyle(
                                color: jcbSecBorderColor,
                                weight: FontWeight.w400),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            finish(context);
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          )),
                    ],
                  ),
                ],
              )),
          ListTile(
            leading: Icon(
              Icons.history,
              size: 30,
            ),
            title: Text('My rides',
                style: boldTextStyle(size: 20, weight: FontWeight.w500)),
            onTap: () {
              finish(context);
            },
          ),
          ListTile(
            leading: Image.asset(ic_promotions,
                height: 25, width: 25, fit: BoxFit.cover),
            title: Text('Promotion',
                style: boldTextStyle(size: 20, weight: FontWeight.w500)),
            onTap: () {
              finish(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.star_border,
              size: 30,
            ),
            title: Text('My favorites',
                style: boldTextStyle(size: 20, weight: FontWeight.w500)),
            onTap: () {
              finish(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.payment_outlined,
              size: 30,
            ),
            title: Text('My payment',
                style: boldTextStyle(size: 20, weight: FontWeight.w500)),
            onTap: () {
              finish(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_none,
              size: 30,
            ),
            title: Text('Notification',
                style: boldTextStyle(size: 20, weight: FontWeight.w500)),
            onTap: () {
              finish(context);
            },
          ),
          ListTile(
            leading: Image.asset(ic_messenger,
                height: 25, width: 25, fit: BoxFit.cover),
            title: Text('Support',
                style: boldTextStyle(size: 20, weight: FontWeight.w500)),
            onTap: () {
              finish(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              size: 30,
            ),
            title: Text('Sign out',
                style: boldTextStyle(size: 20, weight: FontWeight.w500)),
            onTap: () {
              _signOut();
            },
          ),
        ],
      ),
    );
  }
}
