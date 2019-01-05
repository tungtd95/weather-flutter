import 'package:flutter/material.dart';

class PagerIndicator extends StatelessWidget {
  final int itemCount;
  final int currentSelected;
  final double indicatorSize;
  final double indicatorPadding;
  final Color indicatorSelectedColor;
  final Color indicatorNormalColor;

  PagerIndicator({
    @required this.itemCount,
    @required this.currentSelected,
    this.indicatorNormalColor = Colors.cyanAccent,
    this.indicatorSelectedColor = Colors.blueAccent,
    this.indicatorSize = 10,
    this.indicatorPadding = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (indicatorSize + indicatorPadding * 2),
      width: (itemCount * (indicatorSize + indicatorPadding * 2)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return itemIndicatorWidget(index);
        },
      ),
    );
  }

  Widget itemIndicatorWidget(int index) {
    return Container(
      width: indicatorSize,
      height: indicatorSize,
      margin: EdgeInsets.all(indicatorPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(1),
        ),
        color: index == currentSelected
            ? indicatorSelectedColor
            : indicatorNormalColor,
      ),
    );
  }
}

enum Shape { circle, square }
