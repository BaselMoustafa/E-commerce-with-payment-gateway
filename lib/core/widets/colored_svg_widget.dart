import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

class ColoredSvgPicture extends StatelessWidget {
  ColoredSvgPicture({required this.color,required this.path});
  Color color;
  final String path;
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter:ColorFilter.mode(color, BlendMode.srcIn),
      child: SvgPicture.asset(path),
    );
  }
}