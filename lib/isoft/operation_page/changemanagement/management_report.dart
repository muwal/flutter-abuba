import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/changemanagement/management_report_detail.dart';

class ManagementReport extends StatefulWidget {
  @override
  _ManagementReportState createState() => _ManagementReportState();
}

class _ManagementReportState extends State<ManagementReport> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _buildFormRisk(width),
      ),
    );
  }

  Widget _buildFormRisk(double width) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Change Management',
                  style: TextStyle(color: Colors.black12, fontSize: 12.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    '|',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Report',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            width: width,
            height: MediaQuery.of(context).size.height / 1.2,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          index == 0
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: width / 5,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Tanggal',
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width / 5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Kategori',
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width / 5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Change #',
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width / 5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              '',
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: width / 5,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '17/09/2018',
                                          style: TextStyle(
                                              fontSize: 12.0, color: Colors.black38),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width / 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Food Safety',
                                          style: TextStyle(
                                              fontSize: 12.0, color: Colors.black38),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width / 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '000${index + 1}',
                                          style: TextStyle(
                                              fontSize: 12.0, color: Colors.black38),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width / 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 30.0,
                                          splashColor: AbubaPallate.menuBluebird,
                                          child: OutlineButton(
                                            borderSide: BorderSide(
                                                color: AbubaPallate.menuBluebird),
                                            child: Text(
                                              'Report',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: AbubaPallate.menuBluebird),
                                              textAlign: TextAlign.center,
                                            ),
                                            onPressed: () {
                                              Navigator.push(context,
                                                MyCustomRoute(
                                                  builder: (context) => ManagementReportDetail()
                                                )
                                              );
                                            },
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
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      actions: <Widget>[
        IconButton(
          tooltip: 'Search',
          icon: Icon(Icons.search),
          onPressed: () {}
        )
      ],
      title: Image.asset(
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
    );
  }
}