import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/functions.dart';
import 'package:lipread/utilities/variables.dart';

class RoleAvatarButton extends StatelessWidget {
  final bool isSelected;
  final RoleType roleType;
  final String label;
  const RoleAvatarButton({
    super.key,
    required this.roleType,
    required this.isSelected,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? getBackgroundColorWith(roleType)
                : AppColor.grayScale.g200,
          ),
          padding: const EdgeInsets.all(2),
          child: isSelected
              ? Image.asset(
                  'assets/images/${getAvatarAssetNameWith(roleType)}.png')
              : ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    AppColor.grayScale.g200,
                    BlendMode.saturation,
                  ),
                  child: Image.asset(
                      'assets/images/${getAvatarAssetNameWith(roleType)}.png')),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
