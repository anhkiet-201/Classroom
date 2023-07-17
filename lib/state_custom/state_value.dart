part of 'state.dart';

class StateValue<T> extends ValueNotifier<T> {
  StateValue(super.value);

  T operator +(dynamic other) {
    if (value is num) {
      return (_valueConvert + other) as T;
    }
    if (value is String) {
      return '$value$other' as T;
    }
    throw Exception('Can\'t compare');
  }

  T add([T? other]) {
    if (other == null) {
      if (value is num) return (_valueConvert++) as T;
    }
    if (value is num) {
      return (_valueConvert = _valueConvert + (other as num)) as T;
    }
    if (value is String) {
      return value = '$value$other' as T;
    }
    throw Exception('Can\'t compare');
  }

  T operator -(dynamic other) {
    if (value is num) {
      return (_valueConvert - other) as T;
    }
    if (value is String) {
      return (value as String).replaceFirst('$other', '') as T;
    }
    throw Exception('Can\'t compare');
  }

  T sub([T? other]) {
    if (other == null) {
      if (value is num) return (_valueConvert--) as T;
    }
    if (value is num) {
      return (_valueConvert = _valueConvert - (other as num)) as T;
    }
    if (value is String) {
      return value = (value as String).replaceFirst('$other', '') as T;
    }
    throw Exception('Can\'t compare');
  }

  num operator *(num other) {
    if (value is num) {
      return _valueConvert * other;
    }
    throw Exception('Can\'t compare');
  }

  num operator /(num other) {
    if (value is num) {
      if (other == 0) {
        throw Exception('Div by zero');
      }
      return _valueConvert / other;
    }
    throw Exception('Can\'t compare');
  }

  num operator %(num other) {
    if (value is num) {
      if (other == 0) {
        throw Exception('Div by zero');
      }
      return _valueConvert % other;
    }
    throw Exception('Can\'t compare');
  }

  num operator ~/(num other) {
    if (value is num) {
      if (other == 0) {
        throw Exception('Div by zero');
      }
      return _valueConvert ~/ other;
    }
    throw Exception('Can\'t compare');
  }

  bool operator <(num other) {
    if (value is num) {
      return _valueConvert < other;
    }
    throw Exception('Can\'t compare');
  }

  bool operator <=(num other) {
    if (value is num) {
      return _valueConvert < other;
    }
    throw Exception('Can\'t compare');
  }

  bool operator >(num other) {
    if (value is num) {
      return _valueConvert > other;
    }
    throw Exception('Can\'t compare');
  }

  bool operator >=(num other) {
    if (value is num) {
      return _valueConvert < other;
    }
    throw Exception('Can\'t compare');
  }

  num get _valueConvert => value as num;

  set _valueConvert(num newValue) => value = newValue as T;

  @override
  bool operator ==(dynamic other) => value == other;

  @override
  int get hashCode => value.hashCode;
}
