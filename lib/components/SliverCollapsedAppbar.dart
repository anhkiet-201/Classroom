import 'package:class_room_chin/extension/DynamicColor.dart';
import 'package:flutter/material.dart';

class SliverCollapsedAppbar extends StatefulWidget {
  const SliverCollapsedAppbar({Key? key, this.expandedHeight = 250, this.background, required this.titleText, this.leading}) : super(key: key);
  final double expandedHeight;
  final Widget? background;
  final String titleText;
  final Widget? leading;
  @override
  State<SliverCollapsedAppbar> createState() => _SliverCollapsedAppbarState();
}

class _SliverCollapsedAppbarState extends State<SliverCollapsedAppbar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: widget.expandedHeight,
      pinned: true,
      stretch: true,
      automaticallyImplyLeading: true,
      leading: widget.leading,
      flexibleSpace: FlexibleSpaceBar(
        title: LayoutBuilder(
          builder: (context, constrain) {
            var progress = ((constrain.maxHeight -
                MediaQuery.of(context).padding.top - 39) /
                100);
            if (progress > 1) {
              progress = 1.0;
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color:  Color.lerp(context.getDynamicColor.onInverseSurface, context.getDynamicColor.onBackground, progress)!.withOpacity(0.6),
                borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              child: Text(
                widget.titleText,
                style: TextStyle(color: Color.lerp(context.getDynamicColor.onBackground, context.getDynamicColor.background, progress), fontSize: 20),
              ),
            );
          },
        ),
        background: widget.background,
      ),
    );
  }
}
