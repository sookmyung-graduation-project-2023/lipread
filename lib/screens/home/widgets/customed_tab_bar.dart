import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class CustomedTabBar extends StatelessWidget {
  const CustomedTabBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: AppColor.grayScale.g100,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        border: Border.all(
          width: 1,
          color: AppColor.grayScale.g200,
        ),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: AppColor.grayScale.g400,
        labelStyle: TextStyle(
          fontSize: 16,
          fontFamily: FontType.pretendard.name,
          fontVariations: const [FontVariation('wght', 700)],
          height: 1,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
          fontFamily: FontType.pretendard.name,
          fontVariations: const [FontVariation('wght', 600)],
          height: 1,
        ),
        labelPadding: const EdgeInsets.symmetric(vertical: 4),
        overlayColor: MaterialStatePropertyAll(AppColor.grayScale.g300),
        dividerColor: Colors.transparent,
        splashBorderRadius: BorderRadius.circular(100),
        indicator: BoxDecoration(
          color: AppColor.grayScale.g800,
          borderRadius: BorderRadius.circular(100),
        ),
        indicatorWeight: 0,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(0),
        tabs: const [
          Tab(
            child: Text('공식'),
          ),
          Tab(
            child: Text('맞춤형'),
          ),
        ],
      ),
    );
  }
}
