import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: ListView.separated(
          controller: _controller,
          itemBuilder: (context, index) => LongPressDraggable(
              onDragStarted: () => print('started'),
              onDragCompleted: () => print('completed'),
              onDragEnd: (details) => print('end = $details'),
              onDraggableCanceled: (velocity, offset) => print('canceled'),
              onDragUpdate: (details) {
                if (details.globalPosition.dy < 150) {
                  double diff =
                      (_controller!.offset > 50.0 ? 50.0 : _controller!.offset)
                          .floorToDouble();
                  print('to = ${_controller!.offset - diff}');
                  _controller!
                      .animateTo(_controller!.offset - diff,
                          duration: Duration(milliseconds: 100),
                          curve: Curves.linear)
                      .then((value) {});
                }
                print(details.globalPosition);
              },
              child: Card(
                child: Container(
                  height: 100,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Item $index',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              feedback: Text('feedback')),
          separatorBuilder: (context, index) => Container(height: 0.0),
          itemCount: 10,
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
