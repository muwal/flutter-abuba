import 'package:flutter/material.dart';

class AbubaPallate {
  static Color green        = Color.fromARGB(255, 69, 170, 74);
  static Color grey         = Color.fromARGB(255, 242, 242, 242);
  static Color grey200      = Color.fromARGB(200, 242, 242, 242);
  static Color greensatu    = Color(0xff2f592f);
  static Color greendua     = Color(0xff376d37);
  static Color greenabuba   = Color(0xff5b8b41);
  static Color yellow       = Color(0xfffbce4f);

  static Color menuRide     = Color(0xffe99e1e);
  static Color menuCar      = Color(0xff14639e);
  static Color menuBluebird = Color(0xff2da5d9);
  static Color menuFood     = Color(0xffec1d27);
  static Color menuSend     = Color(0xff8dc53e);
  static Color menuDeals    = Color(0xfff43f24);
  static Color menuPulsa    = Color(0xff72d2a2);
  static Color menuOther    = Color(0xffa6a6a6);
  static Color menuShop     = Color(0xff0b945e);
  static Color menuMart     = Color(0xff68a9e3);
  static Color menuTix      = Color(0xffe86f16);
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (settings.isInitialRoute)
      return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}