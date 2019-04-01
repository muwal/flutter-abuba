import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

import 'form_notulen.dart';

class FormCheckin extends StatefulWidget {
  @override
  _FormCheckinState createState() => _FormCheckinState();
}

class _FormCheckinState extends State<FormCheckin>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Today', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('All', style: TextStyle(color: Colors.grey[400]))),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: internalAuditTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ListView(
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
                                        'Waktu',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0),
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
                                        'Lokasi',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0),
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
                                        'Agenda',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0),
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
                      padding: const EdgeInsets.only(
                          right: 20.0, left: 20.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        verticalDirection: VerticalDirection.up,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '17/09/2019 21:21:21',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Outlet 1',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Improvement Project',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, left: 20.0, bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 50.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'CHECK IN',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: AbubaPallate.greenabuba),
                              ),
                              borderSide: BorderSide(
                                  color: AbubaPallate.greenabuba, width: 1.0),
                              highlightedBorderColor: AbubaPallate.greenabuba,
                              splashColor: AbubaPallate.greenabuba,
                              onPressed: () => Navigator.push(context,
                                  MyCustomRoute(builder: (context) => MenuNotulen())),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, left: 20.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        verticalDirection: VerticalDirection.up,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '17/09/2019 21:21:21',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Outlet 1',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Improvement Project',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, left: 20.0, bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 50.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'CHECK IN',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: AbubaPallate.greenabuba),
                              ),
                              borderSide: BorderSide(
                                  color: AbubaPallate.greenabuba, width: 1.0),
                              highlightedBorderColor: AbubaPallate.greenabuba,
                              splashColor: AbubaPallate.greenabuba,
                              onPressed: () => Navigator.push(context,
                                  MyCustomRoute(builder: (context) => MenuNotulen())),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ListView(
                  children: <Widget>[],
                ),
              ],
            ),
          ),
        ),
      ),
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
        controller: _tabController,
        isScrollable: false,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: internalAuditTabs,
      ),
    );
  }
}
