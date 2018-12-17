import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_abuba/landing/landingpage_view.dart';

class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => _LauncherPageState();

}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }

  startLaunching() async {
    var durasi = const Duration(seconds: 3);
    return Timer(durasi, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return LandingPage();
      }));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo_splash.png',
                        height: 190.0,
                        width: 390.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              ],
            )
          ],
        )
    );
  }
}
