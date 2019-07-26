import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter/cupertino.dart';

class FormHasil extends StatefulWidget {
  FormHasil({Key key}) : super(key: key);

  _FormHasilState createState() => _FormHasilState();
}

class _FormHasilState extends State<FormHasil> {
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
              children: <Widget>[
                _buildGoodForm(),
                _buildStandardForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoodForm() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                right: 20.0, left: 20.0, bottom: 10.0, top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.grey[500]),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Hepatitis A',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'mg/liter',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              '100 of 200',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Robert',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'Departemen HRD',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'TBC',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'Col / 250 ml',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              '100 of 200',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Rectal Salmonella',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'negative',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'negative',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 15.0,
            color: AbubaPallate.green,
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 20.0, left: 20.0, bottom: 10.0, top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.grey[500]),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Hepatitis A',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'mg/liter',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              '100 of 200',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'James',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'Departemen HRD',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'TBC',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'Col / 250 ml',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              '100 of 200',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Rectal Salmonella',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'negative',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'negative',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStandardForm() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                right: 20.0, left: 20.0, bottom: 10.0, top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.grey[500]),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Hepatitis A',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'mg/liter',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              '100 of 200',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Robert',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'Departemen HRD',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'TBC',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'Col / 250 ml',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              '100 of 200',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Rectal Salmonella',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'negative',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'negative',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 15.0,
            color: AbubaPallate.green,
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 20.0, left: 20.0, bottom: 10.0, top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.grey[500]),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Hepatitis A',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'mg/liter',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              '100 of 200',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'James',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'Departemen HRD',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'TBC',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'Col / 250 ml',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              '100 of 200',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Rectal Salmonella',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'negative',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            Text(
                              'negative',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
        new Tab(
          child: Text(
            'Good',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
        new Tab(
          child: Text(
            'Off Standard',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
      ],
    ),
  );
}
