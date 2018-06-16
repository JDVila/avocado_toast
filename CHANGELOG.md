## [0.1.0] - 06/16/2018

* Initial release. 
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