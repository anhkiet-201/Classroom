import 'package:class_room_chin/utils/Extensions.dart';
import 'package:flutter/material.dart';

class CustomScaffoldWithAppbar extends StatelessWidget {
  const CustomScaffoldWithAppbar({Key? key,required this.title, required this.child, this.tag, this.secondaryAppbar, this.leading, this.bottomNavigationBar}) : super(key: key);
  final Widget child;
  final String title;
  final String? tag;
  final Widget? secondaryAppbar;
  final Widget? leading;
  final Widget? bottomNavigationBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            leading: leading,
            surfaceTintColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: tag != null ? Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge
              ).subTag(tag!) : Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge
              ),
            ),
          ),
          secondaryAppbar ?? const SliverToBoxAdapter(),
          SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 30),
                child: child
              )
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
