import 'package:class_room_chin/utils/Extensions.dart';
import 'package:flutter/material.dart';

class SliverCollapsedAppbar extends StatefulWidget {
  const SliverCollapsedAppbar({Key? key, this.expandedHeight = 250, this.background, required this.titleText}) : super(key: key);
  final double expandedHeight;
  final Widget? background;
  final String titleText;
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
      surfaceTintColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        title: LayoutBuilder(
          builder: (context, constrain) {
            var opacity = ((constrain.maxHeight -
                MediaQuery.of(context).padding.top - 39) /
                100);
            if (opacity > 1) {
              opacity = 1.0;
            }
            return Stack(
              children: [
                Text(
                  widget.titleText,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
                Text(widget.titleText,
                    style: TextStyle(color: Colors.white.withOpacity(opacity), fontSize: 20))
              ],
            );
          },
        ),
        background: widget.background,
      ),
    );
  }
}
