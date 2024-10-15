import 'package:flutter/material.dart';

const kBlue = Color(0xff104c64);
const kGrey = Color(0xffc6c6d0);
const kRed = Color(0xffb6410f);
const kBlack = Color(0xff0d1d25);
const kWhite = Color(0xffdcdcdc);
const kTangerine = Color(0xffda4224);
const kTangerineLight = Color(0xffff532e);

const kIndigo = Color(0xff0d0d55);
const kNavy = Color(0xff24e0ff);
const kGreen = Color(0xffe2e603);

const kTextStyle = TextStyle(
  color: kWhite,
  fontSize: 16,
  fontWeight: FontWeight.bold
);

const orangeTextFieldDecoration = InputDecoration(
  // hintStyle: kTextStyle,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kBlack)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kBlack)
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kRed)
  ),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kRed)
  ),
);

const textFieldDecoration = InputDecoration(
  // hintStyle: kTextStyle,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kWhite)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kWhite)
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kRed)
  ),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kRed)
  ),
);