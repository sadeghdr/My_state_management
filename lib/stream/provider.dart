import 'package:flutter/cupertino.dart';
import 'package:flutter_state_managment/stream/controller.dart';

class ProviderManager extends InheritedWidget {

  final ManagerController manager;
  final Widget child;

  ProviderManager({required this.child,required this.manager})
      : super(child: child);

  static ProviderManager? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderManager>());
  }

  @override
  bool updateShouldNotify(ProviderManager oldWidget) {
    return true;
  }
}