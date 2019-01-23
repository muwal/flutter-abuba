import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class DetailReport extends StatefulWidget {
  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _formDetail(),
      ),
    );
  }

  Widget _formDetail() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Report',
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
                    'Detail',
                    style:
                        TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Stevani Miller',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 150.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '17 January 2018',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Diinput oleh',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black38),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 150.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Department A',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Divider(
                    height: 6.0,
                  ),
                ),

                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '1. General Information',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Project Name',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Project name',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Project Sponsor',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Project Sponsor A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Project Manager',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Project Manager A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Department',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Department A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Process Impacted',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Keterangan process impacted',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Expected Start Date',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '01 January 2019',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Expected Completion Date',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '07 January 2019',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Expected Savings',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Rp. 150.000',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Estimated Cost',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Rp. 200.000',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Green Belt Assigned',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Green Belt 1',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Black Belt Assigned',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Black Belt 1',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
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
                    ),
                  ],
                ),

                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '2. Problem, Goals, Objectives and Deliverable',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Problem or Issue',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Keterangan problem atau issue',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Purpose or Project',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Keterangan purpose or project',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Business Case',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Keterangan business care',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Goals Metric',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Goals Metric A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Expected Deliverables',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Keterangan expected deliverables',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
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
                    ),
                  ],
                ),

                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '3. Project Scope',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Within Scope',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Keterangan within Scope',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Outside of Scope',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Keterangan outside of scope',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
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
                    ),
                  ],
                ),

                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '4. Tentative Schedule',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'From Project Team',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '01/01/2019 - 07/01/2019',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Premliminary Review',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '01/01/2019 - 07/01/2019',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Define Scope',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '01/01/2019 - 07/01/2019',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Measurement Phase',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '01/01/2019 - 07/01/2019',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Analysis Phase',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '01/01/2019 - 07/01/2019',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Improvement Phase',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '01/01/2019 - 07/01/2019',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Control Phase',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '01/01/2019 - 07/01/2019',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Project Summary Report',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '01/01/2019 - 07/01/2019',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Close Out',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '01/01/2019 - 07/01/2019',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
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
                    ),
                  ],
                ),

                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '5. Project Resources and Costs',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Project Team',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Project Team A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Support Resources',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Support Resources A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Special Needs',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Special Needs A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
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
                    ),
                  ],
                ),

                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '6. Costing',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Cost Type',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Cost Type A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Vendor / Labor Names',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Vendor A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Rate (IDR)',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'IDR 500.000',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Quantity',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '10',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Amount',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '5',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
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
                    ),
                  ],
                ),

                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '7. Project Benefits and Customers',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Process Owner',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Process Owner A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Key Stakeholders',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Key Stakeholders A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Final Customer',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Department A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Expected Benefits',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '10',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
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
                    ),
                  ],
                ),

                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '8. Estimated Benefit',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Type of Benefit',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Benefit A',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Describe Basis of Estimate',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Keterangan Basis of Estimate',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Estimated Benefit',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '500',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
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
                    ),
                  ],
                ),

                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '9. Risk, Constraints and Assumption',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Risks',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Keterangan Risks',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Constraints',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Keterangan Constraints',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Assumption',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Keterangan Assumption',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54),
                                          textAlign: TextAlign.end,
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
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
