import 'package:flutter/material.dart';
import 'package:lipread/components/role_avatar.dart';

import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/variables.dart';

class RoleCard extends StatelessWidget {
  final String name;
  final String explain;
  final RoleType role;

  const RoleCard({
    super.key,
    required this.name,
    required this.explain,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(
          width: 1,
          color: AppColor.grayScale.g200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoleAvatar(roleType: role),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  explain,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
