import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;
  late ShakeDetector detector; // ShakeDetector? detector; 도 가능

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    detector = ShakeDetector.autoStart(
        // 블럭밖 전역에서 사용하기 위해, 위에서 선언
        onPhoneShake: () {
          setState(() {
            _counter++;
          });
        },
        shakeThresholdGravity: 1.5 // 민감도를 바꿈.
        );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.resumed:
        detector.startListening();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.paused:
        detector.stopListening();
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const RedBox().box.padding(EdgeInsets.all(30)).color(Colors.blue).make(),
            makeRedbox(),
            const Text(
              '흔들어서 카운트를 증가시키세요.',
            ).p(50),
            '새로운 텍스트입니다. 추가되었어요.'
                .text
                .size(20)
                .color(Colors.red)
                .bold
                .blue600
                .isIntrinsic //원래 글자크기 반영
                .makeCentered() // make()대신    ;위아래 가운데
                .box
                .rounded //디폴트15.  withRounded(value: 50)
                .color(Colors.green)
                .size(70, 70)
                .height(100)
                .width(200)
                .make()
                .pSymmetric(h: 20, v: 50),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget makeRedbox() => Container().box.color(Colors.red).size(20, 20).make();
}

class RedBox extends StatelessWidget {
  const RedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container().box.color(Colors.red).size(20, 20).make();
  }
}
