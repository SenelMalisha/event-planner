import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerWrapper extends StatelessWidget {
  final Widget child;

  ShimmerWrapper({required this.child});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(child: child, baseColor: Colors.grey.shade300, highlightColor: Colors.grey.shade200);
  }
}