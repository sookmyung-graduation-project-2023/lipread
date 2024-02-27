import 'package:flutter/material.dart';
import 'package:lipread/utilities/functions.dart';
import 'package:lipread/utilities/variables.dart';

class RoleAvatar extends StatelessWidget {
  final RoleType roleType;
  const RoleAvatar({
    super.key,
    required this.roleType,
  });

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
