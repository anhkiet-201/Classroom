import 'package:class_room_chin/utils/Extensions.dart';
import 'package:flutter/material.dart';

class CustomScaffoldWithAppbar extends StatelessWidget {
  const CustomScaffoldWithAppbar(
      {Key? key,
      required this.title,
      required this.child,
      this.tag,
      this.secondaryAppbars,
      this.leading,
      this.bottomNavigationBar,
      this.expandedHeight = 150,
      this.background})
      : super(key: key);
  final Widget child;
  final String title;
  final String? tag;
  final List<Widget>? secondaryAppbars;
  final Widget? leading;
  final Widget? bottomNavigationBar;
  final Widget? background;
  final double expandedHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        //physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: expandedHeight,
            pinned: true,
            leading: leading,
            stretch: true,
            surfaceTintColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: tag != null
                  ? Text(title, style: Theme.of(context).textTheme.titleLarge)
                      .subTag(tag!)
                  : Text(title, style: Theme.of(context).textTheme.titleLarge),
              background: background,
            ),
          ),
          if (secondaryAppbars!=null)
            for (final widget in secondaryAppbars!)
              widget,
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 0, bottom: 30),
                  child: child)),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
