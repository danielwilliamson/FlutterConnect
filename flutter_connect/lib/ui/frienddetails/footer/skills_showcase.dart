import 'package:flutter/material.dart';

class SkillsShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new Center(
      child: new Text(
        'Flutter',
        style: textTheme.title.copyWith(color: Colors.white),
      ),
    );
  }
}
