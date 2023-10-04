import 'package:flutter/material.dart';

class MjMainStream{
  static Map <Mj,List<VoidCallback>> streams={

  };
  static void addListener(Mj mj,VoidCallback callback) {
    if (streams.containsKey(mj)) {
      streams[mj]!.add(callback);
    } else{
      streams[mj]=[callback];
    }
  }
}


class Mj<T>{
  T _value;

  Mj(this._value);
  T get value{
    return _value;
  }

   set value(T value){
    _value=value;
    for(var item in MjMainStream.streams[this]!){
      item.call();
    }
  }
}



class Test2 extends StatelessWidget {
  Test2({Key? key}) : super(key: key);
  Mj<int> mj=Mj(5);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 35),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () =>mj.value+=5,
                    child: MjBuilder(mj:mj,child:() => Text(mj.value.toString(),style: const TextStyle(fontSize: 55),)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MjBuilder extends StatefulWidget {
  MjBuilder({Key? key,required this.mj,required this.child}) : super(key: key);
  Widget Function() child;
  Mj mj;
  @override
  State<MjBuilder> createState() => _MjBuilderState();
}



class _MjBuilderState extends State<MjBuilder> {

  @override
  void initState() {
    super.initState();
    MjMainStream.addListener(widget.mj,() =>  {
    setState(() {
    })},);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child.call();
  }
  @override
  void dispose() {
    super.dispose();
  }
}
