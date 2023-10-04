import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_state_managment/stream/provider.dart';

class ManagerBuilder extends StatefulWidget {
  ManagerBuilder({Key? key, required this.child}) : super(key: key);
  Widget Function() child;

  @override
  State<ManagerBuilder> createState() => _ManagerBuilderState();
}

class _ManagerBuilderState extends State<ManagerBuilder> {
  late StreamSubscription subs;

  @override
  void initState() {
    super.initState();

    subs =
        ProviderManager.of(context)!.manager.controller.stream.listen((event) {
      setState(() {});
    });
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
