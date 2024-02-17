import 'package:flutter/material.dart';

import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/variables.dart';

class RoleCard extends StatelessWidget {
  final String name;
  final String explain;
  final RoleType type;

  const RoleCard({
    super.key,
    required this.name,
    required this.explain,
    required this.type,
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
          const Text('🎢'),
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
