import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class FormAuditTeam extends StatefulWidget {
  @override
  _FormAuditTeamState createState() => _FormAuditTeamState();
}

class _FormAuditTeamState extends State<FormAuditTeam> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(),
          body: TabBarView(
            children: <Widget>[
              _buildDaftarForm(),
              new Text("You've Selected Second"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDaftarForm() {
  return ListView(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 150.0,
              height: 35.0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Auditor',
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF2F592F),
                ),
              ),
            ),
            SizedBox(
              width: 150.0,
              height: 35.0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Tgl Training',
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF2F592F),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                'Ridwan Surgawi',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
            Flexible(
              child: Text(
                '17/09/2018',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                'Yani',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
            Flexible(
              child: Text(
                '18/09/2018',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ],
        ),
      ),
    ],
  );
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
          'assets/images/logo.png',
          height: 100.0,
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
        new Tab(
          child: Text(
            'Daftar',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
        new Tab(
          child: Text(
            'Track Record',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
      ],
    ),
  );
}
