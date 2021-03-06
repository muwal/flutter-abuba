import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

import 'form_mydevice.dart';
import 'menu_testfitur.dart';

class BerandaMore extends StatefulWidget {
  @override
  _BerandaMoreState createState() => _BerandaMoreState();
}

class _BerandaMoreState extends State<BerandaMore> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 20.0, top: 55.0),
            height: 370.0,
            color: AbubaPallate.greenabuba,
            child: Column(
              children: <Widget>[
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: new RaisedButton(
                    elevation: 0.0,
                    color: Colors.white.withOpacity(0.2),
                    splashColor: Colors.lightGreen,
                    shape: new CircleBorder(),
                    child: new Text(
                      "Install & Test",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'SM-J370G',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 30.0,
            color: AbubaPallate.greenabuba,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 30.0,
                  color: Colors.white.withOpacity(0.5),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Battery Temp : 33',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'CPU Temp : 53',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Details >',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: Container(
              height: 240.0,
              child: GridView.count(
                childAspectRatio: 1.5,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                        border:
                            new Border(right: BorderSide(color: Colors.grey))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Verification \n Abuba 4.0',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MyCustomRoute(builder: (context) => MyDevice())),
                    child: Container(
                      decoration: new BoxDecoration(
                          border:
                              new Border(right: BorderSide(color: Colors.grey))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.important_devices,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Last Audit',
                            style: TextStyle(color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: BorderSide(color: Colors.grey),
                            top: BorderSide(color: Colors.grey))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.select_all,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Stress Test',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MyCustomRoute(builder: (context) => MenuTestFitur())),
                    child: Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: BorderSide(color: Colors.grey),
                              top: BorderSide(color: Colors.grey))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.touch_app,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Start Audit',
                            style: TextStyle(color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'assets/images/logo2.png',
              height: 150.0,
              width: 120.0,
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red[500],
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '41 pts',
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
