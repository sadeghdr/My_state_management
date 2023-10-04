import 'dart:async';

import 'package:flutter/material.dart';

class MainStream{
  static Map <Value,List<CustomerStreamSubscription>> streams={

  };
  static void addListener(Value mj,CustomerStreamSubscription subscription) {
    if (streams.containsKey(mj)) {
      if(subscription!=null) {
        streams[mj]!.add(subscription);
      }
    } else{
      streams[mj]=[subscription];
    }
  }
}


class Value<T>{
  T _value;

  Value(this._value);
  T get value{
    return _value;
  }

   set value(T value){
    _value=value;
    for(var item in MainStream.streams[this]!){
      item.data?.call(value);
    }
  }
}


class BuilderItem extends StatefulWidget {
  BuilderItem({Key? key,required this.item,required this.child}) : super(key: key);
  Widget Function() child;
  Value item;
  @override
  State<BuilderItem> createState() => _BuilderItemState();
}



class _BuilderItemState extends State<BuilderItem> {
  late CustomerStreamSubscription subs;

  @override
  void initState() {
    super.initState();
    subs= CustomerStreamSubscription()..onData((data) {
      setState(() {
      });
    });
    MainStream.addListener(widget.item,subs);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child.call();
  }
  @override
  void dispose() {
    subs.cancel();
    super.dispose();
  }
}

class CustomerStreamSubscription<T> extends StreamSubscription<T> {
  CustomerStreamSubscription({this.onPause, this.onResume, this.onCancel});
  final void Function()? onPause;
  final void Function()? onResume;
  final FutureOr<void> Function()? onCancel;

  bool? cancelOnError = false;

  @override
  Future<void> cancel() {
    onCancel?.call();
    return Future.value();
  }

  void Function(T data)? data;


  bool _isPaused = false;

  @override
  void onData(void Function(T data)? handleData) => data = handleData;

  @override
  void onError(Function? handleError) =>  handleError;

  @override
  void onDone(VoidCallback? handleDone) =>  handleDone;

  @override
  void pause([Future<void>? resumeSignal]) {
    _isPaused = true;
    onPause?.call();
  }

  @override
  void resume() {
    _isPaused = false;
    onResume?.call();
  }

  @override
  bool get isPaused => _isPaused;

  @override
  Future<E> asFuture<E>([E? futureValue]) => Future.value(futureValue);
}