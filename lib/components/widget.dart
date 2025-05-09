import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uber_app/extensions/colors.dart';
import 'package:uber_app/utils/constants.dart';

Widget Vertical_large = const SizedBox(
  height: 80,
);

Widget Vertical_medium = const SizedBox(
  height: 20,
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

Widget jcbBackWidget(BuildContext context) {
  return IconButton(
    icon: const Icon(
      Icons.arrow_back_ios,
      color: jcbDarkColor,
    ),
    onPressed: () {
      finish(context);
    },
  );
}

Widget jcbDottedLineComponent() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(5, (index) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 1.5),
        height: 2.5,
        width: 2.5,
        decoration: BoxDecoration(
          color: jcbDarkColor,
          shape: BoxShape.circle,
        ),
      );
    }),
  );
}
