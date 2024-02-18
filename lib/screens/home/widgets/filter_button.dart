import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/main.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:lipread/utilities/variables.dart';

import 'category_tag.dart';

class FilterButton extends StatefulWidget {
  final Function handleCategorySelected;

  const FilterButton({
    Key? key,
    required this.handleCategorySelected,
  }) : super(key: key);

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton>
    with SingleTickerProviderStateMixin {
  late OfficialCategoryType selectedCategory;
  late AnimationController animationController;
  late String filterButtonText;

  @override
  void initState() {
    selectedCategory = OfficialCategoryType.all;
    filterButtonText = selectedCategory.value;

    animationController = BottomSheet.createAnimationController(this);
    animationController
      ..addListener(() {})
      ..duration = const Duration(milliseconds: 500)
      ..reverseDuration = const Duration(milliseconds: 500);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _showModalBottomSheet,
      style: TextButton.styleFrom(
        minimumSize: const Size(0, 0),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        foregroundColor: AppColor.grayScale.g700,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColor.grayScale.g300),
          borderRadius: BorderRadius.circular(100),
        ),
        textStyle: TextStyle(
          fontFamily: FontType.pretendard.name,
          fontSize: 14,
          height: 1,
          fontVariations: const [
            FontVariation('wght', 500),
          ],
        ),
      ),
      child: Row(
        children: [
          Text(
            filterButtonText,
          ),
          const SizedBox(
            width: 8,
          ),
          const Icon(Icons.filter_list_rounded),
        ],
      ),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      elevation: 12,
      isDismissible: true,
      barrierColor: AppColor.grayScale.g900.withOpacity(.4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      transitionAnimationController: animationController,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .65,
      ),
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter bottomState) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 44,
              horizontal: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '주제 선택',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        for (var category in OfficialCategoryType.values)
                          CagegoryTag(
                            text: category.value,
                            isSelected: selectedCategory == category,
                            onPressed: () {
                              bottomState(() {
                                setState(() {
                                  selectedCategory = category;
                                  debugPrint('버튼 누림: $category');
                                });
                              });
                            },
                          )
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    filterButtonText = selectedCategory.value;
                    widget.handleCategorySelected(selectedCategory);
                    Navigator.pop(context);
                  },
                  child: const Text('선택한 주제로 결과 보기'),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
