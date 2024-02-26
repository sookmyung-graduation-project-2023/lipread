import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/variables.dart';

class RoleAvatar extends StatelessWidget {
  final RoleType roleType;
  const RoleAvatar({
    super.key,
    required this.roleType,
  });

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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: getBackgroundColorWith(roleType),
      ),
      padding: const EdgeInsets.all(2),
      child:
          Image.asset('assets/images/${getAvatarAssetNameWith(roleType)}.png'),
    );
  }
}
