import 'dart:ui';

import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/variables.dart';

String formatTotalLearningTimeWith(int milliseconds) {
  final Duration duration = _convertMillisecondsToDuration(milliseconds);
  return '${duration.inHours}:${duration.inMinutes}:${duration.inSeconds}';
}

Duration _convertMillisecondsToDuration(int milliseconds) {
  final Duration duration = Duration(microseconds: milliseconds);
  return duration;
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
