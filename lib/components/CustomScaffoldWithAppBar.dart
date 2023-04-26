import 'package:flutter/material.dart';

class CustomScaffoldWithAppbar extends StatelessWidget {
  const CustomScaffoldWithAppbar({Key? key,required this.title, required this.child }) : super(key: key);
  final Widget child;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            surfaceTintColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 30),
                child: child
              )
          ),
        ],
      ),
    );
  }
}
