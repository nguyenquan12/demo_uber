import 'package:flutter/material.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/utils/constants.dart';

Widget Vertical_large = const SizedBox(
  height: 80,
);

Widget Vertical_medium = const SizedBox(
  height: 40,
);

Widget Vertical_small = const SizedBox(
  height: 20,
);

Widget Loading() {
  return Center(
    child: Image.asset(
      img_loader,
      color: jcbDarkColor,
      height: 50,
      width: 50,
    ),
  );
}
