import 'package:flutter/material.dart';
import 'package:uber_app/extensions/colors.dart';

TextStyle headerStyle() {
  return TextStyle(
    color: jcbDarkColor,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 26.0,
    height: 0.5,
    decoration: TextDecoration.none, // Tắt mọi decoration
  );
}

TextStyle bodyStyle() {
  return TextStyle(
    color: jcbDarkColor,
    fontSize: 14.0,
  );
}
