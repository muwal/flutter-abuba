import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class MenuTestFitur extends StatefulWidget {
  @override
  _MenuTestFiturState createState() => _MenuTestFiturState();
}

class _MenuTestFiturState extends State<MenuTestFitur> {
  @override
  Widget build(BuildContext context) {
    final makeBody = Container(
      child: Scrollbar(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 2.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white24),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.black54))),
                    child: Icon(Icons.battery_charging_full, color: Colors.black54),
                  ),
                  title: Text(
                    "Uji Pemakaian Baterai",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                  subtitle: Row(
                    children: <Widget>[
                      Icon(Icons.linear_scale, color: AbubaPallate.yellow),
                      Text(" Intermediate", style: TextStyle(color: Colors.black54))
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colors.black54, size: 30.0),
                ),
              ),
            );
          },
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: makeBody,
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 2.5,
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
