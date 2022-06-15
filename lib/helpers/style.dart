import 'package:flutter/material.dart';

double widthC(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double heightC(BuildContext context){
  return MediaQuery.of(context).size.height;
}

Color purpleColor() {
  return Color(0xff7B6ED8);
}

Color pinkColor1() {
  return Color(0xffF64668);
}

Color pinkColor() {
  return Color(0xff36A5DB);
}

Color pinkColor3() {
  return Color(0xff8537F1);
}

Color pinkColor2() {
  return Color(0xffA763D0);
}

Color orangeColor() {
  return Color(0xffFE9677);
}

Color greyBackgroundColor() {
  return Color(0xffF2F4F8);
}

Color greyColor() {
  return Colors.grey;
}

TextStyle styleBold() {
  return TextStyle(
    color: Colors.white,
    fontFamily: 'FaktSoftBold',
    fontSize: 16
  );
}
TextStyle styleSemiBold() {
  return TextStyle(
      fontFamily: 'FaktSoftSemiBold',
      fontSize: 16
  );
}
TextStyle styleMedium() {
  return TextStyle(
      color: pinkColor(),
      fontFamily: 'FaktSoftMedium',
      fontSize: 16
  );
}
TextStyle styleNormal() {
  return TextStyle(
      color: greyColor(),
      fontFamily: 'FaktSoftNormal',
      fontSize: 16
  );
}
TextStyle styleItalic() {
  return TextStyle(
      color: greyColor(),
      fontFamily: 'FaktSoftNormalItalic',
      fontSize: 16
  );
}

BoxDecoration styleGradient = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.centerRight,
    colors: [
      Color.fromRGBO(54, 165, 219, 1),
      Color.fromRGBO(123, 110, 216, 1),
    ],
  ),
);

BoxDecoration styleGradientTop = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.topRight,
    colors: [
      Color.fromRGBO(54, 165, 219, 1),
      Color.fromRGBO(123, 110, 216, 1),
    ],
  ),
);

class StyleC {
  static inputDecoration({String? hint, IconData? iconData}) {
    return InputDecoration(
      hintText: hint,
      contentPadding: EdgeInsets.all(16),
      prefixIcon: Icon(
        iconData,
        color: pinkColor(),
      ),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
    );
  }
}