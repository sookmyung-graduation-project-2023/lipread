import 'package:flutter/material.dart';
import 'package:lipread/components/role_avatar.dart';
import 'package:lipread/components/sentence_checked.dart';
import 'package:lipread/models/message/message_check_model.dart';
import 'package:lipread/models/wrong_sentence_model.dart';

import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/variables.dart';

class WrongSetenceCard extends StatelessWidget {
  final WrongSetenceModel wrongSetence;

  const WrongSetenceCard({
    super.key,
    required this.wrongSetence,
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
          RoleAvatar(
            roleType: wrongSetence.type,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  wrongSetence.name,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 4,
                ),
                SentenceChecked(messageCheck: wrongSetence.sentence),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
