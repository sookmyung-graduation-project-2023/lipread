import 'dart:ui';

import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/variables.dart';

String formatTotalLearningTimeWith(int milliseconds) {
  Duration duration = Duration(milliseconds: milliseconds);
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int remainingSeconds = duration.inSeconds.remainder(60);

  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}

Color getBackgroundColorWith(RoleType roleType) {
  switch (roleType) {
    case RoleType.man:
      return AppColor.greenColor;
    case RoleType.woman:
      return AppColor.yellowColor;
    case RoleType.oldMan:
      return AppColor.cyanColor;
    case RoleType.oldWoman:
      return AppColor.pinkColor;
    default:
      throw Error();
  }
}

String getAvatarAssetNameWith(RoleType roleType) {
  switch (roleType) {
    case RoleType.man:
      return 'img_man';
    case RoleType.woman:
      return 'img_woman';
    case RoleType.oldMan:
      return 'img_old_man';
    case RoleType.oldWoman:
      return 'img_old_woman';
    default:
      throw Error();
  }
}
