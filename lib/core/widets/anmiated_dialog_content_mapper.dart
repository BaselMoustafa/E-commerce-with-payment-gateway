import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AnimatedDialogContentMapper extends StatelessWidget {
  AnimatedDialogContentMapper({required this.children});
  List<Widget>children=[];
  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: children,
    );
  }
}