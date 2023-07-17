import 'package:flutter/material.dart';
part 'state_value.dart';
part 'state_watch.dart';

extension InitState<T> on T {
  StateValue<T> get initState => StateValue<T>(this);
}



