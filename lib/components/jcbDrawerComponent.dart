import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/utils/constants.dart';

class JCBDrawerComponent extends StatelessWidget {
  const JCBDrawerComponent({super.key});

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
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(100),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: radius(100),
                    ),
                  ),
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
                            style: boldTextStyle(color: jcbSecBorderColor),
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
                  )
                ],
              ))
        ],
      ),
    );
  }
}
