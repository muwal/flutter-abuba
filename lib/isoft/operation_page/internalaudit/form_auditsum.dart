import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class FormAuditSum extends StatefulWidget {
  @override
  _FormAuditSumState createState() => _FormAuditSumState();
}

class _FormAuditSumState extends State<FormAuditSum> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: _appBar(),
          body: TabBarView(
            children: <Widget>[
              new Text("You've Selected First"),
              new Text("You've Selected Second"),
              new Text("You've Selected Third"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _appBar() {
  return AppBar(
    elevation: 0.25,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    title: Row(
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
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
    bottom: new TabBar(
      isScrollable: false,
      indicatorColor: AbubaPallate.greenabuba,

      tabs: <Widget>[
        new Tab(child: Text('Approval', style: TextStyle(color: Colors.grey[400]),),), // 1st Tab
        new Tab(child: Text('Report', style: TextStyle(color: Colors.grey[400]),),), // 1st Tab
        new Tab(child: Text('History', style: TextStyle(color: Colors.grey[400]),),), // 1st Tab
      ],
    ),
  );
}
