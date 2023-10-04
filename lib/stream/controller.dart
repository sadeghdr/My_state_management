import 'dart:async';

class ManagerController<T> {
  StreamController controller=StreamController<T>();
  T _value;

  ManagerController(this._value);
  T get value{
    return _value;
  }

  set value(T value){
    _value=value;
    controller.add(value);
  }
}
