//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tria/utils/universal_variables.dart';

class ShimmeringLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: Shimmer.fromColors(
        baseColor: UniversalVariables.blackColor,
        highlightColor: Colors.transparent,
        child: Image.asset("assets/13.jpeg"),
      ),
    );
  }
}
