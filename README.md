# A couple of solution for managing state

I try to show different kind of approach for manging state in flutter. I gain some idea from 
different particular kind of state management like bloc and getx and after that i try to implement 
them in my own.

I hope this this repository help you to understand how you can write your own state management and also 
et some idea about what is going under the hood in comment state management.


## using stream controller and inherit widget 
In this way you create a stream controller and share this stream controller cross all ancestor widget with 
inherited widget

```
class Test extends StatelessWidget {
  Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
            child: Column(
              children: [
                ProviderManager(
                    manager: ManagerController(5),
                    child: GestureDetector(
                        onTap: () =>
                            ProviderManager.of(context)!.manager.value += 5,
                        child: ManagerBuilder(
                            child: () => Text(
                                  ProviderManager.of(context)!
                                      .manager
                                      .value
                                      .toString(),
                                  style: const TextStyle(fontSize: 55),
                                ))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```

## Creating custom subscription 
In this approach we create a subscription and manage all these subscription also you can use rx dart 
to combine these streams. This method is the exact way that getx handle state.

```
class Test extends StatelessWidget {
  Test({Key? key}) : super(key: key);
  Value<int> item=Value(5);
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
                    onTap: () =>item.value+=5,
                    child: BuilderItem(item:item,child:() => Text(item.value.toString(),style: const TextStyle(fontSize: 55),)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```