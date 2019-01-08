import 'package:flutter/material.dart';
import 'package:flutter_abuba/launcher/launcher_view.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ABUBA',
      theme: ThemeData(
//        fontFamily: 'NeoSans',
        primaryColor: AbubaPallate.greenabuba,
        accentColor: AbubaPallate.greenabuba,
      ),
      home: LauncherPage(),
    );
  }
}
