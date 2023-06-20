
import 'package:class_room_chin/extension/DynamicColor.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomRefreshIndicator extends RefreshIndicator{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomRefreshIndicator();
  }

}

class _CustomRefreshIndicator extends RefreshIndicatorState<CustomRefreshIndicator>{

  double _offset = 0;

  @override
  void onOffsetChange(double offset) {
    if(offset<0) return;
    setState(() {
      _offset = offset;
    });
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    // TODO: implement buildContent
    return SizedBox(
      height: _offset,
      child: Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: LoadingAnimationWidget.twistingDots(
            size: 50,
            leftDotColor: context.getDynamicColor().primary,
            rightDotColor: context.getDynamicColor().secondary,
          ),
        ),
      ),
    );
  }

}