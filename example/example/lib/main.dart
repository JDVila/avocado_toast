import 'package:flutter/material.dart';
import 'package:avocado_toast/avocado_toast.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Avocado Toast Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Avocado Toast Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  ToastController toastController;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  
  @override
  void initState() {
    super.initState();
    toastController = new ToastController(state: this);
  }
  
  @override
  void dispose() {
    super.dispose();
    toastController = null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Toastable(
        toastController: toastController,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'You have displayed this many toasts:',
              ),
              new Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    color: Colors.lightGreenAccent,
                    onPressed: () {
                      _incrementCounter();
                      toastController.show(text: "Toast Count: $_counter", toastLength: ToastLength.SHORT);
                    },
                    child: Text("Text"),
                  ),
                  FlatButton(
                    color: Colors.lightGreenAccent,
                    onPressed: () {
                      _incrementCounter();
                      toastController.show(widget: Image.network("https://upload.wikimedia.org/wikipedia/commons/6/6c/Avocado_toast_in_Stockholm%2C_Sweden.jpg"), toastLength: ToastLength.SHORT);
                    },
                    child: Text("Widget"),
                  ),
                ],
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
