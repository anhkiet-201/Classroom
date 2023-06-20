import 'package:flutter/material.dart';

class SliverHeader extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent) builder;

  const SliverHeader(
      {this.minHeight = 0, this.maxHeight = 150, required this.builder});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) => builder(context, shrinkOffset, overlapsContent);

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}