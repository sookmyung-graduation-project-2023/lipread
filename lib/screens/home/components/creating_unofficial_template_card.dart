import 'package:flutter/material.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class CreatingUnOfficialTemplateCard extends StatefulWidget {
  final String id;
  final String title;
  final int percentage;
  final String parentTitle;

  const CreatingUnOfficialTemplateCard({
    Key? key,
    required this.id,
    required this.title,
    required this.percentage,
    required this.parentTitle,
  }) : super(key: key);

  @override
  _CreatingUnOfficialTemplateCardState createState() =>
      _CreatingUnOfficialTemplateCardState();
}

class _CreatingUnOfficialTemplateCardState
    extends State<CreatingUnOfficialTemplateCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Adjust duration as needed
    );

    _animation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween<Alignment>(
            begin: Alignment.bottomRight, end: Alignment.topLeft),
        weight: 1,
      ),
    ]).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AnimatedBuilder(
              animation: _controller,
              builder: (context, snapshot) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: AppColor.grayScale.g200,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        AppColor.grayScale.g100,
                        AppColor.grayScale.g200,
                      ], // Change colors as needed
                      begin: _animation.value,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 28,
                      horizontal: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.parentTitle.isNotEmpty
                              ? '${widget.parentTitle} 생성'
                              : '새로운 주제',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontType.pretendard.name,
                            fontWeight: FontWeight.w600,
                            color: AppColor.grayScale.g400,
                            height: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: FontType.pretendard.name,
                            fontWeight: FontWeight.w600,
                            color: AppColor.grayScale.g500,
                            height: 1.55,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        const SizedBox(width: 24),
        Padding(
          padding: const EdgeInsets.only(right: 12, top: 8),
          child: Column(
            children: [
              SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  value: widget.percentage / 100,
                  color: AppColor.grayScale.g600,
                  backgroundColor: AppColor.grayScale.g200,
                  strokeWidth: 24,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${widget.percentage.toString()}%',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: FontType.pretendard.name,
                  fontWeight: FontWeight.w600,
                  color: AppColor.grayScale.g600,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
