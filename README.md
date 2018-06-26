# avocado_toast

A Flutter Plugin for generating custom Android Toasts, completely in Dart code (no channels).

## Getting Started

### Why Avocado Toast?

It seemed clever at the time.

### What is Avocado Toast?

Avocado Toast is a Dart plugin for Flutter apps, allowing developers the opportunity to add traditional and custom toasts to their Flutter-made Android apps, using either strings or widgets. Currently, Flutter has not included a traditional toast widget to their material package.

### Snackbars are Toasts in Material Design, why not just use a material snackbar?

![fiddler on the roof - tradition](http://www.peacechristianchurch.org/wp-content/uploads/2017/11/Tradition.jpg)

Tradition!

### Why not make a channel, and use Android's native toasts?

That's actually a really good idea. There's nothing wrong with creating a channel, especially when the widget is meant to emulate functionality only found on Android devices. However, I wanted to create something that would have a limited connection to the native layer, add nothing to the dex method count, and exist in a single `.dart` file.

### What constructors / methods / constants are in the API?

* Current features:
    * `Toastable()` Widget (as a `body` argument for a `Scaffold` widget), for wrapping Material child widgets, and accepts two arguments:
        * `toastController` parameter (mandatory), which accepts a `ToastController` instance (see below)
        * `child` parameter (mandatory), the child of the `Scaffold` widget, and the widget upon which one wishes to fire off a Toast
    * `ToastController()` constructor, which accepts a `State` argument as a parameter (mandatory)
    * `show()` method, to fire off a Toast:
        * `text` parameter, for passing Strings (do not use if you only want to create a custom widget)
        * `widget` parameter, for passing Widgets (do not use if you only want to make a classic toast)
        * `toastLength` parameter (mandatory), which accepts one of only two constants for duration:
            * `ToastLength.SHORT` - duration of 2.0 seconds
            * `ToastLength.LONG` - duration of 3.5 seconds
* Current limitations:
    * Should only be used with Android apps (no alert option for iOS)
    * Widget position is anchored close to the bottom of the screen (great for classic toasts, but limits placement of custom widgets, i.e. images, buttons, videos, gifs, etc.)
    * Currently queued toasts do not survive moving between routes
* Improvements planned for next release:
    * Sustain toasts between state/route changes
    * allow more positional composition for custom widgets

### How do I use Avocado Toast?

First, incorporate this plugin into your Flutter project, and import the package into your app.

Next, in your `PageState` class for whichever page you'd like to have toasts displayed, declare and initialize your `ToastController` with a `State` instance by overriding `initState()`, and clean up resources by overriding `dispose()`:

```dart
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
    toastController = ToastController(state: this);
    }

  @override
  void dispose() {
    super.dispose();
    toastController = null;
  }
  ....
}
```

Then, add a `Toastable()` widget to the `body` parameter of your `Scaffold()` widget of your overridden `build()` method, passing in the `ToastController` to the `toastController` parameter, and the rest of the layout widgets to the `child` parmeter:

```dart
....

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Toastable(
        toastController: toastController,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
      ),
      ....
 ```
 
 Finally, call the `show()` method on your `ToastController` instance as needed, and pass in your text as a string, and the duration of the toast as either `ToastLength.SHORT` or `ToastLength.LONG`:
 
 ```dart
      ....
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
          toastController.show(
              text: 'Button Clicked this many times: $_counter', 
              toastLength: ToastLength.LONG);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
 ....
```

And that's it! The toast should look a little something like this:

<img src="https://github.com/JDVila/avocado_toast/blob/master/readme_images/traditional_toast.png" width="200">

And now for something completely meta:

<img src="https://github.com/JDVila/avocado_toast/blob/master/readme_images/avocado_toast_toast.png" width="200">


A widget with an image of Avocado Toast inside an  Avocado Toast `Toastable()` widget. You're welcome. 

### License

The MIT License. Now go forth and make Toasts like it's 2008!

Please see the attached LICENSE file for more information.

You can find the plugin by searching for `avocado_toast` at https://pub.dartlang.org, or you can [download the Flutter plugin here!](https://pub.dartlang.org/packages/avocado_toast)
