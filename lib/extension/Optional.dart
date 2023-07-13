extension OptionalNull on Object? {
  bool get guard => !(this == null);
}

extension OptionalNotNull on Object {
  let<T>(Function(T it) callBack) {
    final object = this as T;
    if(object.guard) {
      callBack(object);
    }
  }

  T apply<T>(T Function(T it) callBack) {
    final object = this as T;
    return callBack(object);
  }
}