part of 'state.dart';

typedef Builder = Widget Function(BuildContext context);

class StateWatch extends StatefulWidget {
  const StateWatch({super.key, required this.childBuild, required this.of});
  final StateValue of;
  final Builder? childBuild;

  @override
  State<StateWatch> createState() => _StateWatchState();
}

class _StateWatchState extends State<StateWatch> {

  @override
  void initState() {
    super.initState();
    widget.of.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(StateWatch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.of != widget.of) {
      oldWidget.of.removeListener(_valueChanged);
      widget.of.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.of.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.childBuild?.call(context) ?? const SizedBox();
  }
}
