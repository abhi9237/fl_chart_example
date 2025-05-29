// bool isDarkModee =
//     SchedulerBinding.instance.platformDispatcher.platformBrightness ==
//             Brightness.dark &&
//         localStorageController.themeMode != ThemeMode.light;

import 'package:flutter/material.dart';

class AppColorConstant {
  static AppColorConstant? _instance;
  // Avoid self instance
  AppColorConstant._();
  static AppColorConstant get instance {
    _instance ??= AppColorConstant._();
    return _instance!;
  }

  // * Static COLORS
  static Color black = Colors.black;
  static Color blue = Colors.blue;

  static Color white = Colors.white;

  // static Color gray40066 = const Color.fromARGB(255, 37, 37, 37);
  static Color color000000 = fromHex('#000000');
  static Color gray40066 = fromHex('#66c2c1c0');
  static Color redColor = fromHex('#CD4338');
  static Color color646464 = fromHex('#646464');
  static Color colorACACAC = fromHex('#ACACAC');
  static Color color343434 = fromHex('#343434');
  static Color colorE86969 = fromHex('#E86969');
  static Color colorD1D5DB = fromHex('#D1D5DB');
  static Color colorF6F6F6 = fromHex('#F6F6F6');
  static Color color695C5C = fromHex('#695C5C');
  static Color colorEDEDED = fromHex('#EDEDED');
  static Color color8DB6A6 = fromHex('#8DB6A6');
  static Color colorCAB0C9 = fromHex('#CAB0C9');
  static Color colorB2C0CB = fromHex('#B2C0CB');
  static Color colorB8CAB2 = fromHex('#B8CAB2');
  static Color color9CBEB0 = fromHex('#9CBEB0');
  static Color colorC4ACD5 = fromHex('#C4ACD5');
  static Color color83D6D1 = fromHex('#83D6D1');
  static Color colorD4B18A = fromHex('#D4B18A');
  static Color color1F2937 = fromHex('#1F2937');
  static Color color4B5563 = fromHex('#4B5563');
  static Color color54A2DE = fromHex('#54A2DE');
  static Color color3E7DC4 = fromHex('#3E7DC4');
  static Color colorD2D2D2 = fromHex('#D2D2D2');
  static Color color7C94BA = fromHex('#7C94BA');
  static Color color999999 = fromHex('#999999');
  static Color color4D4D4D = fromHex('#4D4D4D');
  static Color color487DDD = fromHex('#487DDD');
  static Color color9D9D9D = fromHex('#9D9D9D');
  static Color color676767 = fromHex('#676767');
  static Color color545454 = fromHex('#545454');
  static Color color3D3A3A = fromHex('#3D3A3A');
  static Color colorF9F9F9 = fromHex('#F9F9F9');
  static Color colorE6E6E8 = fromHex('#E6E6E8');
  static Color colorA8A8A8 = fromHex('#A8A8A8');
  static Color color8EB7A7 = fromHex('#8EB7A7');
  //TODO:New Color
  static Color color44aca3 = fromHex('#44aca3');
  static Color color51b3cc = fromHex('#51b3cc');
  static Color color6691bc = fromHex('#6691bc');
  static Color color7a6f99 = fromHex('#7a6f99');
  static Color color2764BD = fromHex('#2764BD');

  // * INTRODUCTION SCREEN
  static Color introBlue = const Color.fromARGB(255, 0, 94, 255);
  // * AUTHENTICATION SCREEN
  static Color lightGrey = const Color.fromARGB(255, 118, 118, 118);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
