import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

import 'detail_report.dart';

class FormReport extends StatefulWidget {
  @override
  _FormReportState createState() => _FormReportState();
}

class _FormReportState extends State<FormReport> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildReport(),
      ),
    );
  }

  Widget _buildReport() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Performance',
                style: TextStyle(color: Colors.black12, fontSize: 12.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  '|',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Report',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '17 January 2018',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Shift A',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: ButtonTheme(
                        padding: EdgeInsets.all(0.0),
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Report',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MyCustomRoute(
                                    builder: (context) => DetailReport()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '17 January 2018',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Shift A',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: ButtonTheme(
                        padding: EdgeInsets.all(0.0),
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Report',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
