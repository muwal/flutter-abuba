import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class FormIT extends StatefulWidget {
  @override
  _FormITState createState() => _FormITState();
}

class _FormITState extends State<FormIT> {
  bool _note = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(),
          body: TabBarView(
            children: <Widget>[
              _buildApprovalForm(),
              _buildReportForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApprovalForm() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 100.0,
                height: 35.0,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Lokasi',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                            textAlign: TextAlign.center,
                          ),
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
                width: 100.0,
                height: 35.0,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Item',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
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
                width: 100.0,
                height: 35.0,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Merek',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
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
                  'Outlet A',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ),
              Flexible(
                child: Text(
                  'Computer',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ),
              Flexible(
                child: Text(
                  'Lenovo',
                  style: TextStyle(color: Colors.grey[500]),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ButtonTheme(
                minWidth: 50.0,
                height: 20.0,
                child: OutlineButton(
                  child: Text(
                    'Detail',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                  highlightedBorderColor: Colors.green,
                  onPressed: () {},
                ),
              ),
              ButtonTheme(
                minWidth: 50.0,
                height: 20.0,
                child: OutlineButton(
                  child: Text(
                    'Note',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                  highlightedBorderColor: Colors.green,
                  onPressed: () {
                    setState(() {
                      _note = !_note;
                    });
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 50.0,
                height: 20.0,
                child: OutlineButton(
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                  highlightedBorderColor: Colors.green,
                  onPressed: () {},
                ),
              ),
              ButtonTheme(
                minWidth: 50.0,
                height: 20.0,
                child: OutlineButton(
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                  highlightedBorderColor: Colors.green,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        _note
            ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          width: 300.0,
          child: TextField(
            decoration:
            InputDecoration(border: OutlineInputBorder()),
            maxLines: 3,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        )
            : Container(),
        Divider(
          height: 15.0,
        ),
      ],
    );
  }
}

Widget _buildReportForm() {
  return ListView(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 100.0,
              height: 35.0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Dept / Process',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.center,
                        ),
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
              width: 100.0,
              height: 35.0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Score / CAR',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.start,
                        ),
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
              width: 100.0,
              height: 35.0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Date',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.start,
                        ),
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
                'HRD',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
            Flexible(
              child: Text(
                '80',
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
            'Hardware',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
        new Tab(
          child: Text(
            'Software',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
      ],
    ),
  );
}
