import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Device {
  // static getRatio(int value) {
  //   int uiWidth = value is int ? value : 750;
  //   return ScreenUtil.defaultSize.width / uiWidth;
  // }

  // static getRpx(double value) {
  //   return value * getRatio(750);
  // }

  // static getBottomPadding() {
  //   return mediaQueryData.padding.bottom;
  // }

  // static getTopPadding() {
  //   return ScreenUtil.defaultSize..padding.top;
  // }

  static getWidth() {
    return ScreenUtil.defaultSize.width;
  }

  static Platform platform = Platform();
}
