library avocado_toast;

import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'dart:async';

class Toastable extends StatelessWidget {
  Toastable({@required this.toastController, @required this.child});

  final ToastController toastController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget toastWidget;
    if (toastController.currentToast.runtimeType == String) {
      toastWidget = Center(
        child: AnimatedOpacity(
          opacity: toastController.isRunning == false ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 800),
          child: Opacity(
            opacity: 0.7,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100.0),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 30.0,
                ),
                child: Text(
                  toastController.isRunning == false
                      ? toastController.lastToast
                      : toastController.currentToast,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'RobotoCondensed',
                      fontSize: 16.0),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      toastWidget = Center(
        child: AnimatedOpacity(
            opacity: !toastController.isRunning ? 0.0 : 1.0,
            duration: Duration(milliseconds: 800),
            child: toastController.currentToast),
      );
    }

    var bottomMargin = MediaQuery.of(context).size.height / 5.5;
    return Stack(
      children: <Widget>[
        child,
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: bottomMargin),
                child: toastWidget,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class ToastController {
  State state;
  dynamic lastToast = '';
  dynamic currentToast;
  var toastQueue = [];
  bool isRunning = false;

  ToastController({@required this.state}) {
    assert(
        Platform.isAndroid,
        "Oh no! 'Toasts' are for Android devices only! "
        "Please consider using another cross-platform "
        "alert widget :/");
    Timer.periodic(Duration(milliseconds: 2750), (Timer t) => _checkQueue());
  }

  void _checkQueue() {
    if (!isRunning && toastQueue.isNotEmpty) {
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      state.setState(() {
        isRunning = !isRunning;
        currentToast = toastQueue[0][0];
        Timer(Duration(milliseconds: toastQueue[0][1]), () => _hide());
        toastQueue.removeAt(0);
      });
    }
  }

  void show({String text, Widget widget, int toastLength: 0}) {
    assert(
        toastLength == ToastLength.SHORT || toastLength == ToastLength.LONG,
        "The parameter 'toastLength' is required, and must "
        "have a value of either 'ToastLength.SHORT', or "
        "'ToastLength.LONG'");
    if (text != null && widget == null) {
      toastQueue.add([text, toastLength]);
    } else if (text == null && widget != null) {
      toastQueue.add([widget, toastLength]);
    } else
      assert(
          (text != null && widget == null) || (text == null && widget != null),
          "For the '.show()' method, please pass "
          "either a String to parameter 'text', "
          "or a Widget to parameter 'widget', "
          "but not both at the same time!");
  }

  void _hide() {
    // ignore: INVALID_USE_OF_PROTECTED_MEMBER
    state.setState(() {
      isRunning = !isRunning;
      lastToast = currentToast;
    });
  }
}

class ToastLength {
  static const int SHORT = 2000;
  static const int LONG = 3500;
}
