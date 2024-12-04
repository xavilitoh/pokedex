import 'package:flutter/material.dart';

import '../utils/general.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
          height: getFontSize(context, 150),
          margin: EdgeInsets.symmetric(horizontal: getFontSize(context, 30), vertical: getFontSize(context, 10)),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: getFontSize(context, 18)),
          child: Card(child: child)
    );
  }
}