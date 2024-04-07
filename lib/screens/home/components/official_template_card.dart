import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';

class OfficialTemplateCard extends StatelessWidget {
  final String id;
  final String title;
  final String emoji;

  const OfficialTemplateCard({
    super.key,
    required this.id,
    required this.title,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                emoji,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 52,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
